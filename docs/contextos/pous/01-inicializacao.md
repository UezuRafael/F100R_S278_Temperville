# Inicialização e comunicação

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Inicialização local, sinais de emergência e acompanhamento das comunicações.

## Objetos

- [A_Inicializacao](#a_inicializacao) — PRG · ST
- [B_Emergencia](#b_emergencia) — PRG · ST
- [ComunicacaoOpc](#comunicacaoopc) — PRG · ST
- [StatusCanOpenDevice](#statuscanopendevice) — PRG · CFC
- [StatusRemotasModTcpIP](#statusremotasmodtcpip) — PRG · ST

## A_Inicializacao

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/01_Inicializa%C3%A7%C3%A3o/A_Inicializacao.prg.st>).

**O que faz:** Define a quantidade de resistências por metade do forno.

**Responsabilidades observadas:**

- Divide iNumeroResistencias por dois e atribui iNumResistencias.

**Observações:** O corpo contém somente essa atribuição; não representa toda a inicialização da máquina.

## B_Emergencia

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/01_Inicializa%C3%A7%C3%A3o/B_Emergencia.prg.st>).

**O que faz:** Consolida os sinais físicos de emergência e de reconhecimento sonoro.

**Responsabilidades observadas:**

- Combina dez entradas de emergência em um sinal geral.
- Combina os dois comandos de cala-alarme.

**Observações:** Esta lógica de PLC não descreve nem comprova o funcionamento do circuito independente de segurança.

## ComunicacaoOpc

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/01_Inicializa%C3%A7%C3%A3o/ComunicacaoOpc.prg.st>).

**O que faz:** Executa a troca de sinais usada como indicação de comunicação entre supervisório e PLC.

**Responsabilidades observadas:**

- Reconhece e limpa o sinal recebido do supervisório.
- Após temporização, ativa o sinal de retorno para o supervisório.

**Observações:** É uma lógica de handshake; a implementação não contém a pilha de comunicação OPC.

## StatusCanOpenDevice

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/01_Inicializa%C3%A7%C3%A3o/StatusCanOpenDevice.pou.xml.v3>).

**O que faz:** Consulta os estados de comunicação dos acionamentos representados no CFC.

**Responsabilidades observadas:**

- Executa GET_STATE para mesas de entrada, forno, resfriamento e saída, duto superior 02, guilhotina 02, caixa do forno, convecção de entrada e ventilador 03.
- Copia estados para variáveis de diagnóstico e os compara para gerar os indicadores StateOk.
- No ventilador 03, também usa o estado disponibilizado pela configuração de I/O.

**Observações:** A declaração contém outras instâncias sem a mesma implementação no diagrama. A quantidade de nomes declarados não equivale ao número de nós efetivamente consultados.

## StatusRemotasModTcpIP

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/01_Inicializa%C3%A7%C3%A3o/StatusRemotasModTcpIP.prg.st>).

**O que faz:** Monitora o estado do scanner e dos canais das remotas.

**Responsabilidades observadas:**

- Avalia o estado de comunicação, registra ocorrências e horários das falhas.
- Mantém contadores de diagnóstico do scanner e de oito canais, com comando de zeramento.

**Observações:** Os nomes dos canais devem ser associados à configuração de hardware antes de concluir qual dispositivo físico falhou.

[Voltar ao catálogo](README.md)
