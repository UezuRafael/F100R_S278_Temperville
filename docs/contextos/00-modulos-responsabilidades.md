# Módulos e responsabilidades — contexto geral

Projeto: **F100R S278 Temperville**. Revisão inicial: **05/09/2026**; coerência revisada em **06/09/2026**.

## Objetivo e alcance

Relacionar os módulos físicos descritos pelo usuário às responsabilidades encontradas no código da aplicação. Esta é a primeira visão do funcionamento existente. Os agrupamentos não significam que o código já possui esses limites de encapsulamento.

O estudo considera o projeto em arquivos do Machine Expert Logic Builder 2.6, com lógica em Structured Text e CFC. O arquivo `.fbs` contém informações do ambiente; as declarações, implementações e configurações estão distribuídas pela árvore do projeto.

Diagrama: [fonte PlantUML](../diagramas/01-modulos-responsabilidades.puml), [SVG](../diagramas/01-modulos-responsabilidades.svg) e [PNG](../diagramas/01-modulos-responsabilidades.png).

Detalhamento do código: [catálogo de FCs, FBs e PRGs](pous/README.md), com finalidade, responsabilidades e referências de cada objeto.

Este documento sustenta o **diagrama 01**, que responde onde estão as responsabilidades físicas e funcionais. O [diagrama 02](01-dependencias-geral.md) responde onde estão os objetos de software e quais relações estáticas existem entre eles. Os dois mapas são complementares e não devem ser sobrepostos: relações entre POUs pertencem ao diagrama 02.

## Critério de evidência

- **Código:** informação observada nos programas, declarações ou configurações lidos.
- **Relato:** informação fornecida pelo usuário sobre a máquina e suas variantes.
- **A confirmar:** informação que ainda exige rastreamento adicional ou esclarecimento físico.

Uma rotina chamada pelo programa principal pode ter execução condicional, ter o corpo comentado ou depender de parâmetros. A presença de um objeto não demonstra a presença ou a operação do dispositivo físico.

Os nomes originais dos programas foram preservados nas referências, inclusive diferenças de grafia. Os identificadores M01–M06 e T01–T08 são somente identificadores desta documentação.

## Percurso da carga

Percurso físico informado: **entrada → aquecimento → resfriamento, com passagem/têmpera integrada → saída**.

A entrada, o forno, o resfriador e a saída possuem programas de movimentação correspondentes. Há também uma rotina chamada `H_MesaPassagem`. O usuário confirmou nesta revisão que **passagem/têmpera integra a mesa de resfriamento e não constitui uma mesa física separada**. As duas responsabilidades aparecem dentro de M03. A correspondência entre as rotinas, os acionamentos e os ventiladores ainda exige rastreamento. As setas do desenho representam transferências entre módulos físicos; não representam a ordem de chamada dos programas.

O usuário descreve configurações com pré-aquecimento e até três etapas físicas no conjunto de resfriamento. Essas variantes são contexto da família de máquinas; sua presença nesta configuração não foi estabelecida.

## M01 — Módulo de entrada

**Responsabilidade:** posicionar a carga e coordenar sua transferência para o forno.

- **Relato:** mesa larga de roletes, botão de inserir/agendar, sensores de entrada, chave de jog e pedaleira. Uma ocupação da mesa pode conter várias peças de vidro com vãos entre elas.
- **Código:** `D_SensoresEntrada` combina dez sinais lógicos de sensores com `OR`. `E_MesaEntrada` trata jog, recuo para liberar o sensor, habilitação/agendamento de carregamento e sequência de transferência, coordenada com a mesa do forno.
- **Fronteira compartilhada:** o cálculo do comprimento e do posicionamento utiliza o encoder e a lógica do forno. O retorno de carga envolve os dois módulos; não deve ser atribuído integralmente à entrada.
- **A confirmar:** significado exato de “carga” no código em relação ao conjunto de peças; quantidade física e ligação dos sensores; sinal que corresponde à pedaleira nesta configuração.

**Referências:** [E_MesaEntrada][entrada], [D_SensoresEntrada][sensores], [F_MesaForno][forno], [ComprimentoCarga][comprimento], [N_Grades][grades].

## M02 — Módulo de aquecimento

**Responsabilidade:** receber a carga, manter sua movimentação conforme a receita, controlar o aquecimento e coordenar a descarga.

- **Movimentação:** seleção de parâmetros por espessura, cálculos de posicionamento, conversão entre medidas e pulsos, estados de entrada/oscilação/saída e temporizações.
- **Aquecimento superior e inferior:** parâmetros de temperatura e percentual, leitura de termopares, habilitação das resistências, comando e diagnóstico de SSRs. A nomenclatura da pasta `04_PID` não basta para determinar o algoritmo aplicado em cada caminho.
- **Portas:** comandos automáticos e forçados aparecem em `O_Portas`; a coordenação com a transferência também está nas rotinas das mesas.
- **Elevação:** `S_ElevacaoForno` contém comandos de abertura/fechamento e elementos de acionamento hidráulico e motorizado. A configuração física precisa ser confirmada.
- **Convecção:** a chamada de `Q_Conveccao` está comentada em `A_PrincipalOperacao`; `D_ConvecVentEnt` e `D_ConvecVentSai` são chamados em `A_PrincipalPid`. Portanto, a convecção como um todo não foi classificada como desativada.
- **Diagnóstico térmico adicional:** há programas de pirômetro e termocâmera; sua função física detalhada fica pendente.

**Relato:** a proteção independente de sobretemperatura corta a alimentação de comando dos SSRs e não depende do controle do PLC. Ela aparece fora da aplicação no desenho. Esta leitura não verificou o circuito elétrico.

**A confirmar:** quantidade efetiva de setores por lado, correspondência resistência/termopar, significado operacional do percentual chamado de “potência”, configuração da convecção e presença de pré-aquecimento.

**Referências:** [F_MesaForno][forno], [F_BufferForno][buffer-forno], [O_Portas][portas], [S_ElevacaoForno][elevacao], [A_PrincipalPid][pid], [A_PincipalRampa][rampa], [A_PincipalTemperatura][temperatura], [PidPwm_ONOFF][controle-termico], [A_PrincipalGeral][geral].

## M03 — Módulo de resfriamento, com passagem/têmpera integrada

**Configuração física confirmada pelo usuário:** a passagem/têmpera integra a mesa de resfriamento. A existência de programas separados para passagem e resfriador não implica duas mesas.

### Funções de passagem / têmpera

**Responsabilidade inicial:** agrupar as funções de passagem/têmpera que atuam dentro do conjunto de resfriamento. O papel exato dos comandos de movimentação de `H_MesaPassagem` na mesa compartilhada precisa de rastreamento.

- **Código:** `H_MesaPassagem` é chamado e controla uma sequência de movimentação com sinais de início e fim. Escreve comandos na estrutura `InversorMesaPass`.
- `G_BufferTemperaPass` é chamado e transfere parâmetros de velocidade relacionados ao ventilador 02. A chamada de `M_Ventilador02` está comentada no principal de operação; esse desencontro de caminhos precisa de rastreamento, não foi classificado como defeito nesta etapa.
- `T_VenezianaDutPass` possui lógica chamada para comandos de abertura/fechamento da veneziana.
- `T_VenezianaVentInfPass` é chamado, mas sua implementação está inteiramente comentada.
- `M_Ventilador01` utiliza sinais como `xVentPassHabilitado`, associados à passagem. Isso é evidência de relação funcional, não confirmação da montagem física.

**A confirmar:** como `InversorMesaPass` se relaciona ao acionamento da mesa física e como ventilador 01, ventilador 02 e venezianas atendem às funções de passagem e resfriamento.

**Referências:** [A_PrincipalOperacao][principal], [H_MesaPassagem][passagem], [G_BufferTemperaPass][buffer-passagem], [T_VenezianaDutPass][veneziana], [T_VenezianaVentInfPass][veneziana-vent], [M_Ventilador01][vent01].

### Mesa, estágios e posicionamento

**Responsabilidade:** receber a carga aquecida, movimentá-la durante o resfriamento e coordenar os estágios de ar e posicionamento.

- **Mesa:** `H_MesaResfriador` calcula posições, movimenta a carga com referência de encoder e coordena recebimento, oscilação e descarga.
- **Estágios:** `L_EstagiosResfriador` controla três estágios de processo e sinaliza alterações a outros programas. Estágio de processo e módulo físico são conceitos diferentes.
- **Ventilação:** `M_Ventilador03` é chamado e possui relação com o ciclo e o posicionamento dos dutos. A associação física de todos os ventiladores permanece pendente.
- **Dutos e guilhotina:** `J_DuctosResfriadorSup02` e `K_Guilhotina02` são chamados dentro de condições no principal de operação, apesar de existirem chamadas comentadas para eles no início do mesmo programa.
- **Oscilação dos dutos:** `H1_Dutos_Oscilantes` possui comandos e alarmes para os motores de oscilação superior e inferior 02.
- **Instrumentação:** `R_ManometroDifusor` trata leituras de pressão dos difusores; o posicionamento e os limites exigem detalhamento posterior.

**A confirmar:** vínculo mecânico entre dutos superior/inferior, número de ventiladores instalados, associação dos sufixos 01/02 aos módulos físicos e presença de pós-resfriamento/pré-saída.

**Referências:** [H_MesaResfriador][resfriador], [G_BufferResfriamento][buffer-resfriamento], [L_EstagiosResfriador][estagios], [M_Ventilador03][vent03], [J_DuctosResfriadorSup02][dutos02], [K_Guilhotina02][guilhotina02], [H1_Dutos_Oscilantes][dutos-oscilantes], [R_ManometroDifusor][manometro].

## M04 — Módulo de saída

**Responsabilidade:** receber a carga processada e movimentá-la para retirada.

- **Código:** `I_MesaSaida` trata jog, recebimento da descarga do resfriador, sinais de início/fim e caminhos de pausa/falha.
- `N_Grades` também contém o controle da grade de saída e vínculos com a movimentação da mesa.
- **A confirmar:** montagem e finalidade das grades, dispositivos físicos de retirada e eventual módulo de pré-saída.

**Referências:** [I_MesaSaida][saida], [N_Grades][grades].

## M05 — Mesa de controle e supervisório

**Responsabilidade física informada:** concentrar a operação da máquina, seleção de modo, reset, comandos manuais, ajustes e apresentação das condições da máquina.

No PLC, essa responsabilidade aparece distribuída entre modos de operação, receitas, comandos/eventos, imagens, alarmes, estados e GVLs de troca com o supervisório. `ComunicacaoOpc` implementa uma troca de sinais temporizada; a configuração completa da interface OPC e o software do supervisório não foram analisados.

A torre de sinalização, seu sinalizador acústico e os comandos físicos são parte do relato. O vínculo entre cada sinal e cada borne/saída será objeto de uma visão posterior de I/O.

**Referências:** [C_ComandosOperacao][modos], [B_Receita][receita], [P_ComandosEventos][eventos], [A_PrincipalGeral][geral], [ComunicacaoOpc][opc], `GVL_WriteComandos`, `GVL_ReadStatusOnline`, `GVL_ClpSuper`, `GVL_SuperClp`.

## M06 — Painel elétrico e interface de campo

**Responsabilidade física informada:** alojar os dispositivos de controle e alimentação e disponibilizar monitoramento de condições elétricas/pneumáticas e sinalização.

No código, relaciona-se aos espelhos de I/O, acionamentos, diagnósticos de rede, pressão, ventilação do painel e energia. Os sensores e atuadores distribuídos na máquina são incluídos no mesmo bloco externo do desenho apenas para simplificar a fronteira PLC/campo; não estão todos fisicamente dentro do painel.

**Referências:** [A_Principal_IO][io], [A_PirncipalRede][rede], [A_PrincipalEnergia][energia], [R_Pressostato][pressostato], [R_PressostatoAnal][pressostato-anal], [V_VentilacaoPainel][vent-painel].

## Funções que atendem vários módulos

| ID | Agrupamento | Responsabilidade observada | Referências principais |
|---|---|---|---|
| T01 | Modos, inicialização e coordenação | Seleção manual/automático, comandos do ciclo, pausa/retomada e condições de operação. A inicialização está distribuída; `A_Inicializacao` apenas calcula `iNumResistencias` a partir do total configurado. | [A_PrincipalOperacao][principal], [C_ComandosOperacao][modos], [A_Inicializacao][inicializacao], [B_Emergencia][emergencia] |
| T02 | Receitas e parâmetros | Receber os parâmetros enviados, administrar buffers e transferi-los para forno, passagem e resfriamento segundo condições do processo. Persistência e edição externa da receita não foram estabelecidas. | [B_Receita][receita], [F_BufferForno][buffer-forno], [G_BufferResfriamento][buffer-resfriamento], [G_BufferTemperaPass][buffer-passagem], `GVL_Receita`, `GVL_SuperClp`, `ParametrosPermanentes` |
| T03 | Alarmes, diagnóstico e sinalização | Consolidar falhas, monitorar motores/encoders, preparar estados e animações. Parte dos alarmes é produzida nas próprias rotinas de equipamentos e nos FBs. | [A_PrincipalGeral][geral], `C_Alarmes`, `Q_MonitoraEncoder`, `R_MonitoraMotores`, `StatusCanOpenDevice`, `StatusRemotasModTcpIP`, `GVL_Alarmes` |
| T04 | Energia | Nobreak, falta de fase, disjuntores, circuito CC, medidor PM5300, consumo/fatura e acumuladores por data. | [A_PrincipalEnergia][energia], [A_PricipalGestao][gestao] |
| T05 | Relógio e programação | Data/hora, programação horária e programação por tempo. | [A_PrincipalRelogio][relogio] |
| T06 | Testes | Rotinas de resistências, I/O, nobreak e STOP. As condições de entrada e o efeito de cada teste ficam para o detalhamento. | [A_PrincipalTeste][testes] |
| T07 | I/O, acionamentos e comunicação | Espelhar entradas/saídas, tratar acionamentos e diagnósticos de rede e manter troca de sinais com o supervisório. | [A_Principal_IO][io], [A_PirncipalRede][rede], [ComunicacaoOpc][opc], configurações dos dispositivos |
| T08 | Blocos e dados comuns | Temporizadores, pulsos, conversões, cálculos de posição/medida e blocos de diagnóstico; dados compartilhados em GVLs e parâmetros persistentes. | Pasta `00_FB`, GVLs e `ParametrosPermanentes` |

T08 é um agrupamento de recursos usados pelo código, não um serviço executado separadamente. Da mesma forma, o desenho não pressupõe que T01 seja o único ponto de escrita dos comandos, nem que T03 concentre todos os intertravamentos.

## Particularidades já verificadas nesta configuração

1. `A_PrincipalOperacao` chama os programas das mesas de entrada, forno, passagem, resfriador e saída.
2. `M_Ventilador01` e `M_Ventilador03` têm chamadas diretas. As chamadas de `M_Ventilador02` e `M_Ventilador04` estão comentadas nesse principal.
3. `J_DuctosResfriadorSup02` e `K_Guilhotina02` possuem chamadas condicionais sob `IF NOT ...Enable`. É necessário preservar a condição tal como escrita, sem inferir sua semântica apenas pelo nome.
4. `T_VenezianaVentInfPass` é chamado, mas o corpo está comentado.
5. As duas rotinas de controle das resistências, superior e inferior, são chamadas por `A_PrincipalPid`. `A_SecundariaPid` tem implementação comentada. Portanto, os nomes das tarefas não bastam para separar as responsabilidades térmicas.
6. `Q_Conveccao` tem chamada comentada no principal de operação, enquanto rotinas `D_ConvecVentEnt`/`D_ConvecVentSai` são chamadas no principal térmico.
7. `SR_Main`, da pasta `HEAT`, tem chamada comentada em `A_PrincipalPid`; sua presença no projeto não demonstra que esse caminho térmico esteja em uso.
8. O compartilhamento de estados e parâmetros ocorre extensamente por GVLs. Os módulos do mapa são fronteiras funcionais para orientar o estudo, não fronteiras comprovadas de acesso aos dados.
9. O usuário confirmou que passagem/têmpera e resfriamento pertencem à mesma mesa física. O mapa mantém as funções de passagem identificadas dentro de M03, sem criar um módulo físico adicional.

## Coerência do diagrama 01 com o estudo detalhado

O mapa foi confrontado com o catálogo das 174 POUs e com as 730 relações do diagrama geral. Ele permanece coerente como **visão macro funcional**:

- M01–M04 acompanham o percurso físico da carga e possuem rotinas de movimentação correspondentes.
- M03 agrupa corretamente passagem/têmpera e resfriamento na mesma mesa física; os três estágios mostrados são etapas do processo.
- M05 representa a estação de operação e a fronteira com o supervisório, cuja implementação externa ainda não foi analisada.
- M06 representa de forma simplificada o painel e a interface com o campo. Sensores e atuadores não devem ser interpretados como fisicamente instalados dentro do painel.
- T01–T08 representam responsabilidades que atravessam módulos. O compartilhamento real por GVLs e chamadas é mais distribuído do que essas caixas sugerem e está detalhado no diagrama 02.
- As setas azuis continuam restritas à transferência física da carga. As setas tracejadas não representam ordem de chamada nem todas as dependências individuais.

A revisão não encontrou incompatibilidade estrutural que exija reorganizar as caixas do mapa. Foram refinados os textos de M03, M06 e da legenda para impedir que estágios de processo sejam confundidos com módulos físicos ou que o mapa macro seja lido como grafo de código.

## Dúvidas para a próxima revisão

| ID | Ponto a esclarecer | Por que afeta o mapa |
|---|---|---|
| D01 | Como as rotinas `H_MesaPassagem` e `H_MesaResfriador` compartilham os acionamentos da única mesa física? | Relaciona os comandos de software ao módulo M03 já confirmado. |
| D02 | Quais ventiladores estão instalados e a que módulo/duto cada um atende? | Confirma a associação dos programas 01–04 aos equipamentos. |
| D03 | Os dutos superior/inferior são conjugados? O que significam os sufixos 01/02? | Define equipamentos e responsabilidades de posicionamento. |
| D04 | Há convecção, pré-aquecimento ou pós-resfriamento nesta configuração? | Diferencia configuração atual de variantes da família. |
| D05 | “Carga” significa cada peça ou toda a ocupação transferida? Qual sinal é a pedaleira? | Define o domínio de entrada, medição e rastreamento. |
| D06 | Quais configurações e operações ficam no supervisório? | Define a fronteira externa de receitas, ajustes e comando. |
| D07 | Qual o significado desejado do percentual de “potência” e quantos setores existem por lado? | Define os dados e a capacidade do módulo térmico. |

Não é necessário resolver todas as dúvidas para utilizar esta primeira visão. Elas devem permanecer identificadas até haver evidência ou esclarecimento.

## Limites desta revisão

Foi feita leitura estática das fontes, das POUs, das tarefas e das relações nominais. O levantamento estrutural completo desta etapa está no [diagrama geral de dependências](01-dependencias-geral.md), mas não substitui o compilador nem a execução online. Esta revisão não inclui alterações no controle, validação elétrica ou proposta de refatoração. O próximo detalhamento pode ampliar um módulo mantendo estes identificadores.

<!-- Referências relativas à raiz da aplicação, para manter o estudo transportável. -->
[principal]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/A_PrincipalOperacao.prg.st>
[entrada]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/E_MesaEntrada.prg.st>
[sensores]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/D_SensoresEntrada.prg.st>
[forno]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/F_MesaForno.prg.st>
[comprimento]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/00_FB/ComprimentoCarga.fb.st>
[grades]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/N_Grades.prg.st>
[portas]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/O_Portas.prg.st>
[elevacao]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/S_ElevacaoForno.prg.st>
[buffer-forno]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/F_BufferForno.prg.st>
[pid]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/04_PID/A_PrincipalPid.prg.st>
[rampa]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/04_PID/A_PincipalRampa.prg.st>
[temperatura]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/05_TEMPERATURA/A_PincipalTemperatura.prg.st>
[controle-termico]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/00_FB/PidPwm_ONOFF.fb.st>
[passagem]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/H_MesaPassagem.prg.st>
[buffer-passagem]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/G_BufferTemperaPass.prg.st>
[veneziana]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/T_VenezianaDutPass.prg.st>
[veneziana-vent]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/T_VenezianaVentInfPass.prg.st>
[vent01]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/M_Ventilador01.prg.st>
[resfriador]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/H_MesaResfriador.prg.st>
[buffer-resfriamento]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/G_BufferResfriamento.prg.st>
[estagios]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/L_EstagiosResfriador.prg.st>
[vent03]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/M_Ventilador03.prg.st>
[dutos02]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/J_DuctosResfriadorSup02.prg.st>
[guilhotina02]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/K_Guilhotina02.prg.st>
[dutos-oscilantes]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/H1_Dutos_Oscilantes.prg.st>
[manometro]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/R_ManometroDifusor.prg.st>
[saida]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/I_MesaSaida.prg.st>
[modos]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/C_ComandosOperacao.prg.st>
[receita]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/B_Receita.prg.st>
[eventos]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/P_ComandosEventos.prg.st>
[geral]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/03_Geral/A_PrincipalGeral.prg.st>
[opc]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/01_Inicialização/ComunicacaoOpc.prg.st>
[io]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/10_EntradasSaidas/A_Principal_IO.prg.st>
[rede]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/09_RedeCanOpen/A_PirncipalRede.prg.st>
[energia]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/07_Energia/A_PrincipalEnergia.prg.st>
[pressostato]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/R_Pressostato.prg.st>
[pressostato-anal]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/R_PressostatoAnal.prg.st>
[vent-painel]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/02_Operação/V_VentilacaoPainel.prg.st>
[inicializacao]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/01_Inicialização/A_Inicializacao.prg.st>
[emergencia]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/01_Inicialização/B_Emergencia.prg.st>
[gestao]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/11_GestaoEnergetica/A_PricipalGestao.prg.st>
[relogio]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/06_Relógio/A_PrincipalRelogio.prg.st>
[testes]: <../../MyController.device.xml.v3^/Plc Logic.plclogic.xml.v3^/Application.application.xml.v3^/08_Testes/A_PrincipalTeste.prg.st>
