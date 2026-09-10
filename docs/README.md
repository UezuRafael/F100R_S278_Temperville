# Estudo da aplicação — F100R S278 Temperville

Documentação do funcionamento existente, iniciada em 05/09/2026 e consolidada em 06/09/2026. Os agrupamentos representam responsabilidades identificadas na máquina e no código; não constituem uma proposta de nova arquitetura.

## Comece por aqui

- [Índice de contexto para novos chats](contextos/README.md): ordem de leitura, decisões estabelecidas, fontes de verdade e cobertura atual.
- [Estado consolidado do estudo](contextos/02-estado-do-estudo.md): trabalho concluído, revisão do mapa 01, limitações e próximos passos.

## Catálogo de código

- [Diagrama geral de pertencimento e dependências](diagramas/02-dependencias-geral.html): um único desenho, com busca, zoom e foco no componente e suas relações diretas.
- [SVG](diagramas/02-dependencias-geral.svg), [PlantUML](diagramas/02-dependencias-geral.puml) e [critérios de leitura](contextos/01-dependencias-geral.md).

- [Descrição de cada FC, FB e PRG](contextos/pous/README.md): índice alfabético, capítulos por área e referências para as implementações.
- [Operação da máquina](contextos/pous/02-operacao.md): receitas, mesas, encoders, dutos, guilhotinas e auxiliares.
- [FBs e FC de apoio](contextos/pous/00-fbs-fcs.md): finalidade e responsabilidades dos blocos reutilizados.

O catálogo cobre as 174 POUs presentes na aplicação (166 objetos funcionais e 8 funções implícitas) e as 4 ações de `SR_ControleTemperatura`. As descrições registram o comportamento encontrado por leitura estática, incluindo variantes e trechos comentados.

## Mapa funcional

- [Contexto geral e referências ao código](contextos/00-modulos-responsabilidades.md).
- [Fonte editável em PlantUML](diagramas/01-modulos-responsabilidades.puml).
- [Diagrama em SVG](diagramas/01-modulos-responsabilidades.svg).
- [Diagrama em PNG](diagramas/01-modulos-responsabilidades.png).

O arquivo `.puml` é a fonte do desenho. SVG e PNG são visualizações geradas dele. As referências aos programas e as dúvidas ficam no contexto geral, para manter o mapa legível.

## Convenções do estudo

- **Código:** comportamento ou vínculo observado nos arquivos desta configuração.
- **Relato:** informação física ou operacional fornecida pelo usuário.
- **A confirmar:** correspondência física, intenção ou comportamento ainda não demonstrado.

Uma chamada presente no código indica um caminho de execução possível. Não comprova que o equipamento está instalado, habilitado ou operando. Chamadas comentadas, chamadas condicionais e corpos inteiramente comentados devem ser identificados separadamente.

## Reprodução dos diagramas

Os scripts e o template ficam em **docs/ferramentas/**. O PlantUML 1.2026.6 está em **docs/ferramentas/vendor/**, os intermediários em **docs/.geracao/** e os resultados em **docs/diagramas/**. A geração não depende dos antigos arquivos em AppData ou na pasta temporária do sistema.

Com PowerShell, Node.js e Java 17 disponíveis, execute:

```powershell
& .\docs\ferramentas\gerar-diagramas.ps1
```

O comando recria o mapa em SVG/PNG e o diagrama geral em PlantUML, JSON, SVG e HTML. Consulte as [instruções de geração](ferramentas/README.md) para os pré-requisitos e a função de cada arquivo.

Para abrir o HTML pronto, basta um navegador. Referência da ferramenta de desenho: [documentação oficial do PlantUML](https://plantuml.com/).
