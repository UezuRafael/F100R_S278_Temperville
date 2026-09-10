# Diagrama geral de pertencimento e dependências

Projeto **F100R S278 Temperville**, revisão técnica de **05/09/2026** e contexto consolidado em **06/09/2026**.

Foi criado **um único diagrama geral**, com todos os objetos locais identificados. Os pacotes mostram a organização atual dos arquivos, preservando os nomes das áreas do projeto. Não representam uma nova arquitetura nem classes orientadas a objetos.

- [Explorar o diagrama com busca, zoom e destaque de relações](../diagramas/02-dependencias-geral.html).
- [Diagrama em SVG](../diagramas/02-dependencias-geral.svg).
- [Fonte editável em PlantUML](../diagramas/02-dependencias-geral.puml).
- [Dados e evidências das relações](../diagramas/02-dependencias-geral.json).
- [Descrição de cada FC, FB e PRG](pous/README.md).
- [Estado consolidado e orientação para continuar o estudo](02-estado-do-estudo.md).

O visualizador contém o mesmo SVG gerado do PlantUML. Cada um dos 208 blocos inclui uma descrição. Para POUs e ações, o texto vem do catálogo de responsabilidades; tarefas e objetos de dados recebem resumos de suas funções. As opções de navegação e filtros alteram apenas sua apresentação; não criam diagramas separados.

Após a renderização, o SVG é organizado em **três faixas horizontais**, com os objetos em grade dentro de cada pacote. O desenho mede aproximadamente 8233 × 3982 unidades. A organização visual mantém os 208 objetos e as 730 relações; a posição dos blocos não indica ordem de execução. Os corredores entre blocos e pacotes foram ampliados, e as linhas são recalculadas nesses espaços sem atravessar o interior dos blocos.

## Abrir fora do app

No Explorador de Arquivos do Windows, abra **docs/diagramas/02-dependencias-geral.html** com Edge ou Chrome. O diagrama e os dados estão incorporados nesse HTML: a visualização funciona localmente, sem internet, servidor, Node.js ou Java.

O arquivo **docs/ferramentas/visualizador-template.html** é o modelo de geração. Ao ser aberto diretamente, ele agora encaminha para o HTML completo. Para copiar o visualizador para outro local ou computador, copie **02-dependencias-geral.html**; os links para código, catálogo e arquivos auxiliares exigem também os respectivos arquivos do projeto.

## Cobertura

| Tipo | Quantidade |
| --- | ---: |
| PRG | 121 |
| FB | 44 |
| FC funcional | 1 |
| FCs implícitas de verificação | 8 |
| Ações de SR_ControleTemperatura | 4 |
| Tarefas | 5 |
| GVLs | 23 |
| Lista de persistência | 1 |
| DUT Inversor | 1 |
| **Total de objetos** | **208** |

As 174 POUs incluem variantes com chamadas comentadas e corpos sem instruções ativas. As quatro ações são partes de SR_ControleTemperatura, não quatro PRGs adicionais.

**Correspondência física:** passagem/têmpera integra a mesma mesa de resfriamento nesta máquina. A existência de nomes como H_MesaPassagem não altera essa informação. O [mapa dos módulos físicos e responsabilidades](00-modulos-responsabilidades.md) complementa o pertencimento por pasta apresentado aqui.

## Como ler as setas

A direção é **dependente → dependência**. Uma seta é agrupada por par de objetos e tipo de relação; não é desenhada uma linha para cada ocorrência ou instância.

| Relação | Representação | Quantidade |
| --- | --- | ---: |
| Chamada de PRG, FC ou ação fora de comentário | Azul contínua | 87 |
| Chamada de instância de FB, apontando para seu tipo | Verde contínua | 115 |
| Referência a variáveis de GVL ou lista persistente | Ocre tracejada | 463 |
| Declaração de instância/tipo local, quando não há chamada equivalente no mesmo objeto | Roxa tracejada | 16 |
| Chamada comentada, quando não há chamada ativa equivalente no mesmo objeto | Cinza tracejada | 32 |
| Tarefa → programa | Azul escura, com ordem na tarefa | 17 |
| **Total de relações desenhadas** | | **730** |

Exemplo: D_CtrlResistInferiores chama cinquenta instâncias de PidPwm_ONOFF. O diagrama usa uma seta até o tipo PidPwm_ONOFF; o visualizador informa as cinquenta referências. A declaração dessas instâncias em GVL_InterfacePid também é preservada nos dados de evidência.

Uma relação com GVL significa que foram encontradas referências às suas variáveis, considerando o escopo das declarações. **Não informa se a variável foi lida, escrita ou passada por referência**, nem representa uma transferência de dados entre duas POUs. A lista de variáveis identificadas aparece no painel de evidências.

“Fora de comentário” significa presença de instrução no corpo analisado. Ela pode estar condicionada por IF/CASE, e seu programa pode não ser alcançado a partir de uma tarefa. Portanto, não significa execução garantida em todos os ciclos.

Os dados JSON conservam também as declarações e chamadas comentadas que foram suprimidas visualmente por já existir uma chamada ativa entre o mesmo par. Isso evita linhas duplicadas sem apagar a evidência.

## Navegação no diagrama

1. Use **Visão geral** para enquadrar o desenho completo. O visualizador começa com todas as 730 relações visíveis. A espessura das linhas permanece constante na tela ao reduzir o zoom.
2. Busque um nome, como A_PrincipalOperacao ou D_CtrlResistInferiores, e pressione Enter ou **Localizar**.
3. Clique em um objeto para destacar suas relações e consultar **Depende de** e **Usado por**. A descrição aparece no bloco e no painel; as responsabilidades do catálogo podem ser expandidas no painel.
4. Clique em um nome dessas listas para navegar até o objeto correspondente.
5. Arraste o desenho para mover e use a roda do mouse ou os botões de zoom para ampliar.
6. Em **Modo de exibição**, escolha **Todas as relações** (padrão), **Foco no bloco selecionado** ou **Ocultar linhas**. O modo de foco mantém visíveis somente o bloco escolhido, suas dependências diretas, os blocos que dependem dele e as linhas entre o foco e esses blocos. A área do bloco selecionado permanece identificada no desenho; os demais contornos de área são ocultados. O enquadramento é ajustado e as linhas são abertas em leque, usando faixas separadas para facilitar sua distinção.
7. O campo de busca abre uma lista própria com todos os objetos ao receber foco, mesmo quando um componente já está selecionado. Digitar substitui a seleção atual e filtra por nome, tipo ou área; não é necessário apagar manualmente o conteúdo anterior.
8. Os filtros de chamadas, FBs, globais, declarações, comentários e tarefas também definem quais vizinhos pertencem ao foco. Todos começam habilitados. **Limpar seleção** encerra o foco e restaura o enquadramento geral.

O painel **Evidências das dependências** relaciona nomes de variáveis, instâncias e chamadas. O link **Abrir código** aponta para a implementação local. No SVG independente, os objetos de aplicação apontam para suas descrições no catálogo. O SVG estático conserva todas as linhas; a exibição por seleção e os filtros estão no HTML.

## Entradas de execução

| Tarefa | Intervalo configurado | Prioridade | Programas diretos |
| --- | --- | ---: | --- |
| MAST | 20 ms | 15 | 11 programas, na ordem numerada no diagrama |
| Rampa | 30 ms | 6 | ComunicacaoOpc → A_Principal_IO → A_PincipalRampa |
| PidInferior | 101 ms | 16 | A_PrincipalPid |
| PidSuperior | 110 ms | 17 | A_SecundariaPid |
| GestaoEnergetica | 1000 ms | 18 | A_PricipalGestao |

Os intervalos e prioridades foram lidos dos arquivos de tarefa. A ordem numerada vale dentro da lista de cada tarefa; o desenho não simula escalonamento, preempção ou sincronização entre tarefas.

## Situações representadas explicitamente

- A_SecundariaPid, U_Encoder, T_VenezianaVentInfPass e a ação _10_Alarmes têm fundo cinza porque não apresentam instruções ST fora de comentários.
- O caminho A_PrincipalPid → SR_Main está comentado. As relações internas de HEAT continuam visíveis porque sua implementação existe, sem presumir que esse caminho esteja em execução.
- O tipo chamado pelos controles inferiores e superiores é PidPwm_ONOFF. PidPwm também pertence ao projeto, mas não deve ser confundido com essas instâncias.
- As funções Check... permanecem no grupo de verificações implícitas. Não foram inventadas setas de chamadas que seriam inseridas pelo compilador.
- Os FBs e funções externos encontrados, como TON, HSCMain_TM3, FB_PWM, SE_CTBX.FB_HeatingControl e funções SysTimeRtc, não são apresentados como definições locais. Seus nomes aparecem no painel do objeto que os utiliza e no JSON.

## Método e limites

A extração é estática e nominal: lê declarações, corpos ST fora de comentários, chamadas comentadas, blocos e expressões serializados em CFC, além das listas de POUs das tarefas. Resolve instâncias locais e globais para os tipos encontrados e evita tratar nomes de parâmetros formais como acesso a GVL.

A análise não substitui o compilador IEC 61131-3. Não resolve aliases por endereço AT, acessos indiretos por ponteiros, implementação interna de bibliotecas, comunicação externa, condições completas de execução ou conflitos entre escritas de tarefas. O desenho documenta as relações encontradas nessa configuração, sem comprovar dispositivos instalados nem funcionamento do processo.

No JSON, os números de linha das chamadas ST se referem à seção de implementação extraída, e não à linha física do arquivo com metadados. Elementos CFC são identificados pelo ID serializado. Cada objeto conserva o caminho e o SHA-256 do arquivo lido.

A verificação desta revisão confirmou os 208 objetos descritos e as 730 relações no SVG e no visualizador, sem sobreposição de blocos ou linhas atravessando seus interiores. No modo de foco, cada uma das 20 relações de F_MesaForno, usado como caso de teste, recebeu uma faixa e um traçado distintos. Busca, localização por área, filtros e modos de exibição foram verificados no Edge e no Chrome sem internet. Os arquivos do programa permaneceram inalterados.

## Atualização dos arquivos

Os geradores, o template e o JAR do PlantUML estão na pasta do projeto. Os intermediários são recriados em `docs/.geracao/`, sem depender de arquivos antigos em `%TEMP%` ou `%APPDATA%`. Execute a partir da raiz do projeto:

~~~powershell
& .\docs\ferramentas\gerar-diagramas.ps1
~~~

Esse comando executa a extração, a análise, a geração do PlantUML, a renderização, a organização horizontal, a montagem do HTML e a verificação estrutural. Ele pode ser chamado também pelo caminho absoluto a partir de outra pasta. Os pré-requisitos são PowerShell, Node.js e Java 17; consulte as [instruções de geração](../ferramentas/README.md).

Esta revisão foi renderizada com PlantUML 1.2026.6, mecanismo Smetana e Java 17. O script organizar-diagrama.ps1 aplica a disposição horizontal ao SVG e conserva os nomes, descrições, links e relações. A renderização direta do PlantUML, sem essa etapa, usa a distribuição automática do mecanismo. O HTML usa o arquivo visualizador-template.html como modelo. Mudanças no inventário exigem revisar os totais e as interpretações desta documentação.

[Voltar ao estudo](../README.md)
