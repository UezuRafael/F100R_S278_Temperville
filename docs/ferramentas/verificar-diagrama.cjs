const fs=require('fs'),path=require('path'),crypto=require('crypto'),vm=require('vm');
const root=path.resolve(__dirname,'..','..');
const graph=JSON.parse(fs.readFileSync(path.join(root,'docs/diagramas/02-dependencias-geral.json'),'utf8'));
const issues=[],ids=new Set(graph.nodes.map(n=>n.id));
for(const n of graph.nodes){
  const file=path.join(root,n.path);
  if(!fs.existsSync(file))issues.push('Arquivo ausente: '+n.path);
  else if(crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex')!==n.sha256)issues.push('Código alterado desde a extração: '+n.path);
  if(!n.description)issues.push('Descrição ausente: '+n.name);
}
for(const e of graph.visibleEdges)if(!ids.has(e.from)||!ids.has(e.to))issues.push('Relação sem objeto: '+e.from+' → '+e.to);
if(graph.unresolvedCalls.length||graph.ambiguousGlobals.length)issues.push('Há chamadas não resolvidas ou globais ambíguas.');
const svg=fs.readFileSync(path.join(root,'docs/diagramas/02-dependencias-geral.svg'),'utf8');
if(/Syntax Error|An error has occured/.test(svg))issues.push('Erro de renderização do SVG.');
const svgIds=[...svg.matchAll(/data-qualified-name="[^"]*\.(N\d+)"/g)].map(m=>m[1]);
if(svgIds.length!==ids.size)issues.push('Quantidade de objetos do SVG difere do grafo.');
for(const n of graph.nodes)if(!svgIds.includes(n.id))issues.push('Objeto ausente no SVG: '+n.name);
const attrs=s=>Object.fromEntries([...s.matchAll(/([\w-]+)="([^"]*)"/g)].map(m=>[m[1],m[2]]));
const svgLinks=[...svg.matchAll(/<g\b([^>]*\bclass="link"[^>]*)>([\s\S]*?)<\/g>/g)];
const relationKeys=new Set(graph.visibleEdges.map(e=>[e.from,e.to,e.kind].join('|'))),foundKeys=[];
if(svgLinks.length!==graph.visibleEdges.length)issues.push('Quantidade de relações do SVG difere do grafo.');
for(const [,attributes,body]of svgLinks){
  const a=attrs(attributes),key=[a['data-from'],a['data-to'],a['data-kind']].join('|');foundKeys.push(key);
  if(!relationKeys.has(key))issues.push('Relação desconhecida no SVG: '+key);
  const p=attrs(body.match(/<path\b([^>]*)/)?.[1]||'');
  if(p['vector-effect']!=='non-scaling-stroke')issues.push('Linha sem espessura constante: '+key);
  if(!p.d||/NaN|undefined/.test(p.d))issues.push('Trajeto inválido: '+key);
}
if(new Set(foundKeys).size!==relationKeys.size)issues.push('As relações não têm correspondência única com o SVG.');
let checkedLinks=0;
for(const m of svg.matchAll(/(?:xlink:)?href="([^"]+)"/g)){
  const dest=m[1].replaceAll('&amp;','&').split('#')[0];
  if(!dest||/^\w+:\/\//.test(dest))continue;
  checkedLinks++;
  if(!fs.existsSync(path.resolve(root,'docs/diagramas',decodeURIComponent(dest))))issues.push('Destino ausente no SVG: '+dest);
}
const html=fs.readFileSync(path.join(root,'docs/diagramas/02-dependencias-geral.html'),'utf8');
if(/__SVG__|__DATA__/.test(html))issues.push('O HTML ainda contém marcadores do template.');
if(!/<select id="relationMode"><option value="all">/.test(html))issues.push('O HTML não inicia no modo de todas as relações.');
try{
  const data=JSON.parse(html.match(/<script type="application\/json" id="data">([\s\S]*?)<\/script>/)[1]);
  if(data.nodes.length!==graph.nodes.length||data.edges.length!==graph.visibleEdges.length)issues.push('Inventário do HTML difere do grafo.');
  new vm.Script(html.match(/<script>\s*([\s\S]*?)<\/script>/)[1]);
}catch(error){issues.push('Dados ou JavaScript inválidos no HTML: '+error.message);}
console.log(JSON.stringify({objects:graph.nodes.length,relations:graph.visibleEdges.length,sourceHashesVerified:graph.nodes.length,linksChecked:checkedLinks,issues},null,2));
if(issues.length)process.exitCode=1;
