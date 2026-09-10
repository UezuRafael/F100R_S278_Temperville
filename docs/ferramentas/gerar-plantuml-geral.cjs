const fs=require('fs'),path=require('path');
const root=path.resolve(__dirname,'..','..');
const graph=JSON.parse(fs.readFileSync(path.join(root,'docs','.geracao','grafo-dependencias.json'),'utf8'));
const descriptions={};
const catalogDir=path.join(root,'docs','contextos','pous');
for(const file of fs.readdirSync(catalogDir).filter(f=>f.endsWith('.md'))){
  const content=fs.readFileSync(path.join(catalogDir,file),'utf8');
  for(const match of content.matchAll(/^## (\w+)\r?\n([\s\S]*?)(?=^## |$(?![\s\S]))/gm)){
    const what=match[2].match(/\*\*O que faz:\*\* ([^\r\n]+)/);
    const responsibilities=match[2].match(/\*\*Responsabilidades observadas:\*\*([\s\S]*?)(?=\n\*\*|$)/);
    if(what)descriptions[match[1]]={what:what[1],responsibilities:responsibilities?[...responsibilities[1].matchAll(/^- (.+)$/gm)].map(m=>m[1].trim()):[]};
  }
}
const byId=new Map(graph.nodes.map(n=>[n.id,n]));
const dest=path.join(root,'docs','diagramas');fs.mkdirSync(dest,{recursive:true});
const activePairs=new Set(graph.edges.filter(e=>['call','fb-call'].includes(e.kind)).map(e=>e.from+'|'+e.to));
graph.visibleEdges=graph.edges.filter(e=>!(e.kind==='declares'&&activePairs.has(e.from+'|'+e.to))&&!(e.kind==='comment'&&activePairs.has(e.from+'|'+e.to)));
const groupNames={
'Task Configuration.taskconfig.xml.v3^':'Tarefas de execução',
'00_FB':'00_FB · Blocos e funções de apoio','01_Inicialização':'01_Inicialização · Inicialização e comunicação',
'02_Operação':'02_Operação · Processo e equipamentos','03_Geral':'03_Geral · Diagnóstico e apresentação',
'04_PID':'04_PID · Controle térmico, rampa e convecção','04_PID/HEAT/00_Main':'HEAT / 00_Main · Integração',
'04_PID/HEAT/10_Temperatura':'HEAT / 10_Temperatura · Controle e ações','04_PID/HEAT':'HEAT · Dados',
'05_TEMPERATURA':'05_TEMPERATURA · Aquisição e diagnóstico','06_Relógio':'06_Relógio · Programação temporal',
'07_Energia':'07_Energia · Medição e alimentação','08_Testes':'08_Testes · Testes',
'09_RedeCanOpen':'09_RedeCanOpen · Acionamentos','10_EntradasSaidas':'10_EntradasSaidas · I/O',
'11_GestaoEnergetica':'11_GestaoEnergetica · Acumuladores'};
const chapterFile=n=>n.group.startsWith('04_PID/HEAT')?'04-heat':({'00_FB':'00-fbs-fcs','01_Inicialização':'01-inicializacao','02_Operação':'02-operacao','03_Geral':'03-geral','04_PID':'04-controle-termico','05_TEMPERATURA':'05-temperatura','06_Relógio':'06-relogio','07_Energia':'07-energia','08_Testes':'08-testes','09_RedeCanOpen':'09-acionamentos','10_EntradasSaidas':'10-entradas-saidas','11_GestaoEnergetica':'11-gestao-energetica','Verificações implícitas':'12-funcoes-implicitas'}[n.group]);
const colors={PRG:'#EDF4FC',FB:'#E8F6EF',FC:'#FFF3D6',ACTION:'#F2ECFA',GVL:'#FDEEE4',PERSIST:'#FCE7D8',DUT:'#FDEEE4',TASK:'#DBEAFE'};
const safe=s=>s.replace(/"/g,"'").replace(/[{}]/g,'').replace(/[\r\n]+/g,' ');
const dataDescriptions={
  GVL_Alarmes:'Reúne os estados de alarme de motores, válvulas, encoders e condições gerais.',
  GVL_ClpSuper:'Reúne dados do processo disponibilizados pelo PLC ao supervisório.',
  GVL_Encoder:'Compartilha contagens e referências dos encoders da máquina.',
  GVL_Energia:'Reúne grandezas elétricas e valores de consumo de energia.',
  GVL_EntradasSaidas:'Declara sinais de entradas e saídas usados pelos equipamentos e controles.',
  GVL_Eventos:'Reúne sinais de eventos e mudanças de estado da operação.',
  GVL_Imagens:'Agrupa estados de equipamentos e retornos para representação visual.',
  GVL_Interface:'Compartilha sinais de coordenação, estados e parâmetros entre rotinas do processo.',
  GVL_InterfaceEnergia:'Reúne os registros de comunicação usados na aquisição das grandezas elétricas.',
  GVL_InterfacePid:'Compartilha instâncias e variáveis dos controles térmicos por setor.',
  GVL_Inversores:'Declara as estruturas de comando e retorno dos inversores da máquina.',
  GVL_Motores:'Reúne indicações de corrente e frequência dos acionamentos.',
  GVL_ReadStatusOnline:'Disponibiliza estados de operação, habilitação e emergência da máquina.',
  GVL_Receita:'Reúne parâmetros e sinais de solicitação, confirmação e falha de escrita de receitas.',
  GVL_Relogio:'Compartilha os campos de data, hora e ajuste do relógio.',
  GVL_StatCanOpenDevice:'Reúne estados e indicações de disponibilidade dos dispositivos CANopen.',
  GVL_StatModTcpDevice:'Reúne estados do scanner e dos dispositivos de comunicação Modbus TCP.',
  GVL_SuperClp:'Reúne comandos e parâmetros enviados pelo supervisório ao PLC.',
  GVL_Velocidades:'Compartilha valores de velocidade utilizados no transporte das cargas.',
  GVL_WriteComandos:'Reúne comandos de operação, ciclo e movimentação solicitados pela interface.',
  Inversor:'Define os campos de comando, referência, corrente, frequência e estado de um inversor.',
  ParametrosPermanentes:'Mantém parâmetros persistentes de configuração, calibração e operação.',
  IOs:'Reúne entradas de temperatura e sinais de saída utilizados pelo controle HEAT.',
  InterfaceHeat:'Compartilha sinais de habilitação e reset dos controles de temperatura HEAT.',
  TEMP:'Reúne estados, erros, saídas e comandos de ajuste dos controles térmicos HEAT.'
};
for(const n of graph.nodes){
  if(n.type==='TASK'){
    const count=n.task.programs.length;
    n.description='Executa '+count+' programa'+(count===1?'':'s')+' na sequência configurada para esta tarefa.';
    n.responsibilities=[];
  }else if(['GVL','DUT','PERSIST'].includes(n.type)){
    n.description=dataDescriptions[n.name];n.responsibilities=[];
  }else{
    n.description=descriptions[n.name]?.what;n.responsibilities=descriptions[n.name]?.responsibilities||[];
  }
  if(!n.description)throw new Error('Descrição ausente: '+n.type+' '+n.name);
}
function wrapDescription(text,width=46){
  const rows=[''];
  for(const word of text.replace(/`/g,'').split(/\s+/)){
    const last=rows.length-1;
    if(rows[last]&&rows[last].length+word.length+1>width)rows.push(word);
    else rows[last]+=(rows[last]?' ':'')+word;
  }
  return rows.map(row=>'<size:11><color:#465C70>'+safe(row).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;')+'</color></size>').join('\\n');
}
const lines=['@startuml',"' Gerado a partir dos arquivos da aplicação. Este é um único diagrama geral.","' Relações resumidas por par de objetos; evidências e nomes de instâncias no JSON acompanhante.",'!pragma layout smetana','left to right direction','skinparam backgroundColor #FFFFFF','skinparam defaultFontName SansSerif','skinparam defaultFontSize 12','skinparam shadowing false','skinparam roundcorner 6','skinparam nodesep 22','skinparam ranksep 90','skinparam packageStyle rectangle','skinparam ArrowFontSize 9','skinparam ArrowThickness 0.7','skinparam linetype polyline','skinparam svgLinkTarget _top','skinparam package {','  BackgroundColor #FBFCFE','  BorderColor #B8C5D3','  FontColor #17324D','}','skinparam rectangle {','  BorderColor #62758A','  FontColor #182C40','}','title F100R S278 Temperville · Pertencimento e dependências\\n174 POUs + 4 ações · 5 tarefas · 23 GVLs + persistência + DUT','caption Leitura estática · 05/09/2026 · seta: dependente → dependência · pacotes: localização no projeto','legend left','|= Cor / traço |= Relação |','| <color:#2762A6>━━▶</color> | Chamada de PRG, FC ou ação fora de comentário |','| <color:#19816A>━━▶</color> | Chamada de instância de FB → tipo do FB |','| <color:#A87732>┄┄▶</color> | Referência a variáveis globais (uso; não indica leitura/escrita) |','| <color:#9973AF>┄┄▶</color> | Declara instância ou variável de um tipo local |','| <color:#AAAAAA>┄┄▶</color> | Chamada comentada, sem chamada ativa equivalente no mesmo objeto |','| <color:#243E68>━━▶</color> | Tarefa → programa (número indica a ordem na tarefa) |','| Fundo cinza | Implementação ST sem instruções fora de comentários |','endlegend',''];
const groups=[...new Set(graph.nodes.map(n=>n.group))].sort((a,b)=>a.localeCompare(b,'pt-BR'));
for(let gi=0;gi<groups.length;gi++){
const g=groups[gi];lines.push('package "'+safe(groupNames[g]||g)+'" as PK'+gi+' {');
for(const n of graph.nodes.filter(n=>n.group===g).sort((a,b)=>a.name.localeCompare(b.name))){
const desc=descriptions[n.name];let label='<b>'+safe(n.name)+'</b>\\n'+({ACTION:'AÇÃO',PERSIST:'PERSISTÊNCIA',TASK:'TAREFA'}[n.type]||n.type)+(n.lang==='TASK'?'':' · '+n.lang);
if(n.task)label+='\\n'+n.task.interval+' · prioridade '+n.task.priority;
label+='\\n\\n'+wrapDescription(n.description);
if(n.empty)label+='\\n<color:#777777>corpo comentado</color>';
let link='';
if(desc&&n.type!=='TASK'){link=' [[../contextos/pous/'+chapterFile(n)+'.md#'+n.name.toLowerCase()+'{'+safe(desc.what)+'}]]';}
else{const source=path.relative(dest,path.join(root,n.path)).split(path.sep).map(encodeURIComponent).join('/');link=' [['+source+'{Abrir '+safe(n.name)+'}]]';}
lines.push('rectangle "'+label+'" as '+n.id+link+' '+(n.empty?'#EEEEEE':colors[n.type]));
}
lines.push('}','');
}
const styles={call:'-[#2762A6]->','fb-call':'-[#19816A]->',global:'.[#A87732].>',declares:'.[#9973AF].>',comment:'.[#AAAAAA].>',task:'-[#243E68,thickness=2]->',state:'.[#D35E7D].>'};
for(const e of graph.visibleEdges){let suffix=e.kind==='task'?' : '+e.evidence[0].order:'';lines.push(e.from+' '+styles[e.kind]+' '+e.to+suffix);}
lines.push('','note "Os pacotes representam a organização atual dos arquivos.\\nPassagem/têmpera integra fisicamente a mesa de resfriamento.\\nChamadas fora de comentários podem depender de IF/CASE; não comprovam execução.\\nCheck... são pontos de verificação implícita: não foram inventadas chamadas do compilador.\\nDependências externas de biblioteca/hardware estão relacionadas no JSON;\\no desenho expande os objetos definidos nesta aplicação." as NOTAS','#FFFFFF','@enduml');
const text=lines.join('\n').replace('\n#FFFFFF\n','\n');
fs.writeFileSync(path.join(dest,'02-dependencias-geral.puml'),text,'utf8');
graph.summary={applicationPOUs:166,implicitFCs:8,actions:4,tasks:5,gvls:23,persistentLists:1,DUTs:1,visibleRelations:graph.visibleEdges.length,externalDependencyPairs:graph.externalDependencies.length};
fs.writeFileSync(path.join(dest,'02-dependencias-geral.json'),JSON.stringify(graph,null,2),'utf8');
console.log(JSON.stringify(graph.summary,null,2));
