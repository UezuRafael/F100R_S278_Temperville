const fs=require('fs'),path=require('path');
const dest=path.resolve(__dirname,'..','diagramas');
const graph=JSON.parse(fs.readFileSync(path.join(dest,'02-dependencias-geral.json'),'utf8'));
let svg=fs.readFileSync(path.join(dest,'02-dependencias-geral.svg'),'utf8');
svg=svg.slice(svg.indexOf('<svg')).replace(/<!--[\s\S]*?-->/g,'');
const viewbox=svg.match(/viewBox="([^"]+)"/)[1].split(' ').map(Number);
svg=svg.replace('<svg ','<svg id="graph" aria-label="Diagrama geral de pertencimento e dependências" ');
const compact={nodes:graph.nodes.map(n=>({id:n.id,name:n.name,type:n.type,group:n.group,empty:n.empty,path:n.path,task:n.task,description:n.description,responsibilities:n.responsibilities})),edges:graph.visibleEdges,external:graph.externalDependencies,summary:graph.summary,viewbox};
const data=JSON.stringify(compact).replace(/</g,'\\u003c');

const html=fs.readFileSync(path.join(__dirname,'visualizador-template.html'),'utf8');
fs.writeFileSync(path.join(dest,'02-dependencias-geral.html'),html.replace('__SVG__',()=>svg).replace('__DATA__',()=>data),'utf8');
console.log('Visualizador do diagrama geral criado.');
