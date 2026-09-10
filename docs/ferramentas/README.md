# Geração dos diagramas

Os geradores, o template HTML e o PlantUML ficam nesta pasta do projeto. Os arquivos intermediários ficam em `docs/.geracao/`; não há leitura de arquivos de trabalho em `%TEMP%` ou `%APPDATA%`.

## Executar

Com PowerShell, Node.js e Java 17 disponíveis, execute a partir da raiz do projeto:

```powershell
& .\docs\ferramentas\gerar-diagramas.ps1
```

O script também funciona quando chamado pelo caminho absoluto, a partir de outra pasta. Ele extrai novamente os dados do código, recria o diagrama geral, renderiza o mapa de módulos, organiza o SVG, monta o HTML e verifica a correspondência dos objetos, relações e arquivos de origem.

Node.js é localizado pelo `PATH`. Java é localizado pelo `PATH`, por `JAVA_HOME` ou pelo runtime já instalado do Prosys OPC UA Monitor nesta estação. É possível indicar outros executáveis:

```powershell
& .\docs\ferramentas\gerar-diagramas.ps1 -NodePath 'C:\ferramentas\node\node.exe' -JavaPath 'C:\ferramentas\java\bin\java.exe'
```

Node.js, Java e PowerShell são programas do ambiente e não estão incorporados ao projeto. A geração usa o JAR local, sem baixar pacotes ou depender do Codex. Para **abrir o HTML pronto**, basta um navegador; esses programas não são necessários.

## Arquivos

| Caminho | Função |
| --- | --- |
| `gerar-diagramas.ps1` | Executa todas as etapas e verifica os resultados. |
| `extrair-grafo.ps1` | Lê os objetos exportados da aplicação e grava `../.geracao/grafo-entrada.json`. |
| `analisar-grafo.cjs` | Resolve as relações e grava `../.geracao/grafo-dependencias.json`. |
| `gerar-plantuml-geral.cjs` | Combina o grafo com as descrições do catálogo e gera o PlantUML e o JSON finais. |
| `organizar-diagrama.ps1` | Distribui os blocos em três faixas e recalcula as linhas do SVG. |
| `montar-visualizador.cjs` | Incorpora SVG e dados ao template HTML. |
| `visualizador-template.html` | Define a aparência, os filtros, a busca, o foco e o zoom do visualizador. |
| `verificar-diagrama.cjs` | Verifica hashes do código, descrições, relações, links locais e estrutura do HTML. |
| `vendor/` | Contém PlantUML 1.2026.6, identificação da versão e licenças. |

Os resultados ficam em [docs/diagramas](../diagramas/02-dependencias-geral.html). As descrições usadas nos blocos vêm do [catálogo](../contextos/pous/README.md). O mapa físico tem fonte em [01-modulos-responsabilidades.puml](../diagramas/01-modulos-responsabilidades.puml).

A pasta `docs/.geracao/` é recriada automaticamente e está no `.gitignore`. Os JSONs intermediários e eventuais temporários do Java permanecem nessa pasta do projeto. As antigas cópias de testes e experiências em `AppData\Local\Temp` não são usadas pela geração atual.

## Atualizar somente o HTML

Após alterar apenas o template, usando o SVG e o JSON já existentes:

```powershell
node .\docs\ferramentas\montar-visualizador.cjs
node .\docs\ferramentas\verificar-diagrama.cjs
```

Essa verificação é estrutural e não substitui uma conferência visual no navegador. Alterações no catálogo, no código ou no posicionamento exigem a geração completa.
