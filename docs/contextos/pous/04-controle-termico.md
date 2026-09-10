# Controle térmico, rampa e convecção

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Rotinas térmicas da pasta 04_PID. O nome da pasta não determina o algoritmo: as instâncias ControleInferiorSetor e ControleSuperiorSetor estão declaradas como PidPwm_ONOFF em GVL_InterfacePid.

## Objetos

- [A_PincipalRampa](#a_pincipalrampa) — PRG · ST
- [A_PrincipalPid](#a_principalpid) — PRG · ST
- [A_SecundariaPid](#a_secundariapid) — PRG · ST
- [A_TemperaturaGeral](#a_temperaturageral) — PRG · ST
- [B_RampaPatamar](#b_rampapatamar) — PRG · ST
- [C_AquecimentoReceita](#c_aquecimentoreceita) — PRG · ST
- [C_StandByTemperaturas](#c_standbytemperaturas) — PRG · ST
- [D_ConvecVentEnt](#d_convecventent) — PRG · ST
- [D_ConvecVentSai](#d_convecventsai) — PRG · ST
- [D_CtrlResist](#d_ctrlresist) — PRG · ST
- [D_CtrlResistInferiores](#d_ctrlresistinferiores) — PRG · ST
- [D_CtrlResistSuperiores](#d_ctrlresistsuperiores) — PRG · ST
- [E_Termperaturas](#e_termperaturas) — PRG · ST

## A_PincipalRampa

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/A_PincipalRampa.prg.st>).

**O que faz:** Organiza a execução do aquecimento por rampa/patamar e por receita.

**Responsabilidades observadas:**

- Chama B_RampaPatamar e C_AquecimentoReceita fora dos testes de resistência e I/O.
- Durante esses testes, chama apenas a atualização de temperaturas E_Termperaturas.

## A_PrincipalPid

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/A_PrincipalPid.prg.st>).

**O que faz:** Organiza o controle dos setores de aquecimento e das convecções.

**Responsabilidades observadas:**

- Chama os controles inferiores e superiores fora dos testes; durante testes, atualiza temperaturas.
- Chama as habilitações e pausas de resistências, os setpoints de espera e os ajustes gerais.
- Chama os controles de convecção de entrada e saída.

**Observações:** A chamada SR_Main, que integraria o conjunto HEAT, está comentada neste programa.

## A_SecundariaPid

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/A_SecundariaPid.prg.st>).

**O que faz:** Contém uma estrutura de chamada secundária de PID inteiramente comentada.

**Responsabilidades observadas:**

- Não executa instruções de implementação na versão analisada.

**Observações:** A existência deste PRG na organização de tarefas não atribui efeito a um corpo comentado.

## A_TemperaturaGeral

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/A_TemperaturaGeral.prg.st>).

**O que faz:** Distribui ajustes térmicos gerais entre os setores.

**Responsabilidades observadas:**

- Propaga mudanças nos setpoints gerais de temperatura e percentual para os vetores inferiores e superiores, respeitando o bloqueio de envio de receita.
- Aplica incrementos de temperatura e percentual aos setores e reconhece o comando de incremento.

## B_RampaPatamar

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/B_RampaPatamar.prg.st>).

**O que faz:** Sequencia o aquecimento do forno por rampa e manutenção em patamar.

**Responsabilidades observadas:**

- Trata seleção do modo, início por comando ou programação horária, parada e finalização.
- Executa os FBs de rampa e patamar por setor e reúne seus sinais de término.
- Registra tempos, consumo e sinais para relatório e distribui as saídas de aquecimento com alternância de setores.
- Reconhece a transferência dos parâmetros da receita de aquecimento.

**Observações:** O fluxo ativo passa pela rampa 01 e pelo patamar 01 e segue à finalização. Há nomes e variáveis de etapas 02/03, mas trechos dessas etapas estão comentados.

## C_AquecimentoReceita

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/C_AquecimentoReceita.prg.st>).

**O que faz:** Gerencia o aquecimento inicial até as temperaturas definidas pela receita.

**Responsabilidades observadas:**

- Habilita os grupos inferior e superior e verifica se todos os setores atingiram a condição térmica requerida.
- Atualiza estado de aquecimento e sinais de início e fim do relatório.
- Desliga o aquecimento nas condições previstas de comando, modo manual, emergência, falta de energia e parada temporizada do motor do forno.

**Observações:** O corpo ativo fixa xAqueceRapido em TRUE e xAqueceLento em FALSE; a seleção lenta não fica efetiva apenas por existir nas variáveis.

## C_StandByTemperaturas

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/C_StandByTemperaturas.prg.st>).

**O que faz:** Reduz os setpoints para a condição de espera após o intervalo configurado.

**Responsabilidades observadas:**

- Inicia a contagem após descarga ou comando de espera, disponibilizando o tempo decorrido.
- Cancela ou aborta a espera nas condições de operação previstas.
- Seleciona, por setor, o setpoint de espera ou o setpoint normal da receita.

## D_ConvecVentEnt

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/D_ConvecVentEnt.prg.st>).

**O que faz:** Controla a ventilação e o aquecimento da convecção identificada como entrada.

**Responsabilidades observadas:**

- Sequencia velocidade de espera, funcionamento, pausa, parada e tratamento de falha do ventilador.
- Atualiza os comandos do inversor e o controle de temperatura da convecção.
- Monitora os retornos de três circuitos SSR e prepara seus alarmes e estados visuais.

**Observações:** A presença da rotina e de sua chamada não confirma, isoladamente, a instalação física dessa convecção.

## D_ConvecVentSai

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/D_ConvecVentSai.prg.st>).

**O que faz:** Controla a ventilação e o aquecimento da convecção identificada como saída.

**Responsabilidades observadas:**

- Sequencia velocidade de espera, funcionamento, pausa, parada e tratamento de falha do ventilador.
- Atualiza os comandos do inversor e o controle de temperatura da convecção.
- Monitora os retornos de três circuitos SSR e prepara seus alarmes e estados visuais.

**Observações:** A presença da rotina e de sua chamada não confirma, isoladamente, a instalação física dessa convecção.

## D_CtrlResist

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/D_CtrlResist.prg.st>).

**O que faz:** Coordena habilitações, pausas e dados comuns do controle das resistências.

**Responsabilidades observadas:**

- Combina pedidos de aquecimento por receita e por rampa para os conjuntos inferior e superior.
- Executa uma pausa inferior e duas pausas superiores, com atraso para a segunda.
- Converte as temperaturas lógicas para leitura e controle e gera habilitações e alternância dos grupos.

## D_CtrlResistInferiores

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/D_CtrlResistInferiores.prg.st>).

**O que faz:** Executa os controles dos cinquenta setores inferiores previstos no código.

**Responsabilidades observadas:**

- Entrega temperatura, setpoint, percentual, habilitação e parâmetros a cada instância de controle.
- Recolhe o comando de SSR, a temperatura publicada e a indicação de temperatura atingida.

**Observações:** As cinquenta chamadas são explícitas e usam habilitações distintas em alguns setores; não são geradas por um laço baseado em iNumResistencias. As instâncias são do tipo PidPwm_ONOFF, embora a interface aceite ganhos de PID.

## D_CtrlResistSuperiores

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/D_CtrlResistSuperiores.prg.st>).

**O que faz:** Executa os controles dos cinquenta setores superiores previstos no código.

**Responsabilidades observadas:**

- Entrega temperatura, setpoint, percentual, habilitação e parâmetros a cada instância de controle.
- Recolhe os comandos de SSR e os estados térmicos e limpa o pedido xResetPid após as chamadas.

**Observações:** As cinquenta chamadas são explícitas. As instâncias são do tipo PidPwm_ONOFF; seus parâmetros de ganho não significam que esse FB execute um PID.

## E_Termperaturas

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/E_Termperaturas.prg.st>).

**O que faz:** Atualiza os valores apresentados de temperatura sem executar o controle por setor.

**Responsabilidades observadas:**

- Percorre os vetores inferior e superior de termopares.
- Converte as leituras inteiras para REAL dividindo por dez.

[Voltar ao catálogo](README.md)
