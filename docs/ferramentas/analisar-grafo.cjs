const fs=require('fs'),path=require('path');
const buildDirectory=path.resolve(__dirname,'..','.geracao');
const input=JSON.parse(fs.readFileSync(path.join(buildDirectory,'grafo-entrada.json'),'utf8'));
function clean(s,wantComments=false){let out='',depth=0,line=false,q=null;for(let i=0;i<s.length;i++){let c=s[i],n=s[i+1];if(line){if(c==='\n'){line=false;out+='\n';}else out+=wantComments?c:' ';continue;}if(depth){if(c==='('&&n==='*'){depth++;out+='  ';i++;}else if(c==='*'&&n===')'){depth--;out+='  ';i++;}else out+=c==='\n'?'\n':wantComments?c:' ';continue;}if(q){out+=c==='\n'?'\n':' ';if(c==='$'&&n){out+=' ';i++;}else if(c===q)q=null;continue;}if(c==='/'&&n==='/'){line=true;out+='  ';i++;continue;}if(c==='('&&n==='*'){depth=1;out+='  ';i++;continue;}if(c==="'"||c==='"'){q=c;out+=' ';continue;}out+=wantComments?(c==='\n'?'\n':' '):c;}return out;}
function declarations(s){s=clean(s);const list=[];const re=/(?:^|[;\n])\s*([A-Za-z_]\w*(?:\s*,\s*[A-Za-z_]\w*)*)(?:\s+AT\s+[^:;\n]+)?\s*:\s*(?![=])((?:ARRAY\s*\[[^\]]+\]\s*OF\s*)?(?:POINTER\s+TO\s+|REFERENCE\s+TO\s+)?[A-Za-z_][\w.]*)/gi;for(const m of s.matchAll(re)){let type=m[2].replace(/^ARRAY\s*\[[^\]]+\]\s*OF\s*/i,'').replace(/^(?:POINTER|REFERENCE)\s+TO\s+/i,'');for(const name of m[1].split(/\s*,\s*/))list.push({name,type});}return list;}
const nodes=input.map((r,i)=>{let m=clean(r.decl).match(/\b(PROGRAM|FUNCTION_BLOCK|FUNCTION)\s+(\w+)/);const type=r.task?'TASK':m?{PROGRAM:'PRG',FUNCTION_BLOCK:'FB',FUNCTION:'FC'}[m[1]]:r.file.endsWith('.act.st')?'ACTION':r.file.endsWith('.gvl')?'GVL':r.file.endsWith('.struct')?'DUT':'PERSIST';const name=r.task?r.task.name:m?m[2]:r.file.replace(/\.(act\.st|varpersistent\.xml\.v3|gvl|struct)$/,'');let group=r.path.split('\\').slice(3,-1).join('/');if(type==='ACTION')group=group.replace(/\/[^/]+\.prg\.st\^$/,'');if(!group)group=['GVL','PERSIST','DUT'].includes(type)?'Dados globais e tipos':'Verificações implícitas';return {...r,id:'N'+i,name,type,group,vars:declarations(r.decl),active:clean(r.impl),comments:clean(r.impl,true),empty:['FC','FB','PRG','ACTION'].includes(type)&&r.lang==='ST'&&!clean(r.impl).trim()};});
const byName=new Map(nodes.filter(n=>n.type!=='TASK').map(n=>[n.name.toLowerCase(),n]));
const globals=new Map();for(const n of nodes.filter(n=>['GVL','PERSIST'].includes(n.type)))for(const v of n.vars){const key=v.name.toLowerCase();if(!globals.has(key))globals.set(key,[]);globals.get(key).push({...v,owner:n});}
const knownTypes=new Map(nodes.filter(n=>['FB','DUT'].includes(n.type)).map(n=>[n.name.toLowerCase(),n]));
const edges=new Map(),unresolved=[],ambiguous=[],externals=new Map();
const primitives=new Set('BOOL BYTE WORD DWORD LWORD SINT USINT INT UINT DINT UDINT LINT ULINT REAL LREAL TIME LTIME DATE LDATE TOD DT DATE_AND_TIME TIME_OF_DAY STRING WSTRING'.toLowerCase().split(' '));
const builtin=/^(?:[A-Z]+_TO_[A-Z]+|MAX|MIN|ABS|SEL|LIMIT|MUX|MOVE|EXPT|SHL|SHR|ROL|ROR|SIZEOF|ADR|INDEXOF|LEN|CONCAT|LEFT|RIGHT|MID|INSERT|DELETE|REPLACE|FIND|TRUNC|SQRT|EXP|LN|LOG|SIN|COS|TAN|ACOS|ASIN|ATAN|TO_\w+)$/i;
const keywords=new Set('IF ELSIF WHILE UNTIL FOR CASE NOT AND OR XOR RETURN EXIT REPEAT THEN ELSE'.toLowerCase().split(' '));
function edge(from,to,kind,evidence){if(from.id===to.id)return;let key=[from.id,to.id,kind].join('|');if(!edges.has(key))edges.set(key,{from:from.id,to:to.id,kind,evidence:[]});let arr=edges.get(key).evidence;if(!arr.some(e=>JSON.stringify(e)===JSON.stringify(evidence)))arr.push(evidence);}
function external(n,type,kind){let key=n.id+'|'+type.toLowerCase();if(!externals.has(key))externals.set(key,{from:n.id,type,kind});}
function local(n,name){let owner=n.type==='ACTION'?byName.get('sr_controletemperatura'):n;let v=owner?.vars.find(v=>v.name.toLowerCase()===name.toLowerCase());return v?{...v,owner,scope:'local'}:null;}
function resolve(n,expr){let parts=expr.replace(/\[[^\]]*\]/g,'').replace(/\s/g,'').split('.'),first=parts[0].toLowerCase();if(parts.length===1){const v=local(n,first);if(v)return {variable:v};const ps=byName.get(first);if(ps)return {node:ps};const vs=globals.get(first);if(vs?.length===1)return {variable:{...vs[0],scope:'global'}};if(vs?.length>1)return {ambiguous:vs};return {};}
const owner=byName.get(first);
if(owner){let v=owner.vars.find(v=>v.name.toLowerCase()===parts[1].toLowerCase());if(v)return {variable:{...v,owner,scope:['GVL','PERSIST'].includes(owner.type)?'global':'other-pou'}};const act=byName.get(parts[1].toLowerCase());if(act?.type==='ACTION')return{node:act};return {node:owner,field:true};}
let v=local(n,first);if(v)return{variable:v,field:true};
let vs=globals.get(first);if(vs?.length===1)return {variable:{...vs[0],scope:'global'},field:true};if(vs?.length>1)return {ambiguous:vs};return {};
}
function scanCalls(n,text,comment=false){const re=/\b([A-Za-z_]\w*(?:\s*\[[^\]\r\n]*\])?(?:\s*\.\s*[A-Za-z_]\w*(?:\s*\[[^\]\r\n]*\])?)*)\s*\(/g;
for(const m of text.matchAll(re)){const expr=m[1];if(keywords.has(expr.toLowerCase())||builtin.test(expr))continue;const r=resolve(n,expr), ev={expression:expr,line:text.slice(0,m.index).split('\n').length,section:comment?'comment':'implementation'};
if(r.node&&['PRG','FC','ACTION'].includes(r.node.type)&&!r.field)edge(n,r.node,comment?'comment':'call',ev);
else if(r.variable&&!r.field){const t=knownTypes.get(r.variable.type.toLowerCase());if(t?.type==='FB')edge(n,t,comment?'comment':'fb-call',{...ev,instanceOwner:r.variable.owner.name});else if(!comment&&!primitives.has(r.variable.type.toLowerCase()))external(n,r.variable.type,'FB');}
else if(!comment&&!r.variable&&!r.node){if(expr.includes('.')||/^(Sys|Syst|CODESYS|IsFirstMast)/i.test(expr))external(n,expr,'FC');else unresolved.push({pou:n.name,...ev});}
}}
for(const n of nodes){
if(n.type==='TASK'){n.task.programs.forEach((name,i)=>{let t=byName.get(name.toLowerCase());if(!t)throw Error('Task program missing: '+name);edge(n,t,'task',{order:i+1});});continue;}
for(const v of n.vars){const t=knownTypes.get(v.type.toLowerCase());if(t)edge(n,t,'declares',{variable:v.name,type:v.type});}
if(n.lang==='CFC'){
for(const c of n.calls){if(c.kind==='Operator')continue;let t=byName.get(c.type.toLowerCase());if(t)edge(n,t,t.type==='FB'?'fb-call':'call',{cfcId:c.id,instance:c.instance,type:c.type});else external(n,c.type,c.kind);}
}
else{scanCalls(n,n.active);scanCalls(n,n.comments,true);}
const content=n.lang==='CFC'?n.texts.map(x=>x.text).join('\n'):n.active;
// Identifiers used as actual arguments and values are resolved against local/global scopes.
// Formal parameter labels are skipped; field names are consumed with their owner.
const re=/\b[A-Za-z_]\w*(?:\s*\.\s*[A-Za-z_]\w*)*/g;
for(const m of content.matchAll(re)){
const expr=m[0],tail=content.slice(m.index+expr.length);if(/^\s*(?::=|=>)/.test(tail)&&/[,(]\s*$/.test(content.slice(0,m.index)))continue;
const r=resolve(n,expr);
if(r.variable?.scope==='global')edge(n,r.variable.owner,'global',{variable:r.variable.name});
else if(r.variable?.scope==='other-pou')edge(n,r.variable.owner,'state',{variable:r.variable.name});
else if(r.node&&r.field&&['PRG','FB'].includes(r.node.type))edge(n,r.node,'state',{expression:expr});
else if(r.ambiguous)ambiguous.push({pou:n.name,expression:expr,owners:r.ambiguous.map(v=>v.owner.name)});
}
}
// A declaration and a call to the same FB are one visible use; the evidence remains separate in JSON.
const graph={nodes:nodes.map(({decl,impl,active,comments,texts,calls,...r})=>r),edges:[...edges.values()],externalDependencies:[...externals.values()],unresolvedCalls:unresolved,ambiguousGlobals:[...new Map(ambiguous.map(x=>[JSON.stringify(x),x])).values()]};
fs.writeFileSync(path.join(buildDirectory,'grafo-dependencias.json'),JSON.stringify(graph,null,2));
console.log(JSON.stringify({nodes:nodes.length,types:Object.fromEntries([...new Set(nodes.map(n=>n.type))].map(t=>[t,nodes.filter(n=>n.type===t).length])),edgeKinds:Object.fromEntries([...new Set(graph.edges.map(e=>e.kind))].map(t=>[t,graph.edges.filter(e=>e.kind===t).length])),externalPairs:graph.externalDependencies.length,unresolved,ambiguous:graph.ambiguousGlobals.slice(0,20)},null,2));
