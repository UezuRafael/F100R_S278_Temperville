# FBs e FC de apoio

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Blocos reutilizados pelos programas e a função de conversão de dados do medidor.

## Objetos

- [AlarmeEncoder](#alarmeencoder) — FB · ST
- [AlarmeMotor](#alarmemotor) — FB · ST
- [AlarmeMotorParado](#alarmemotorparado) — FB · ST
- [AlarmeRelesSsr](#alarmerelesssr) — FB · ST
- [AlarmeResistencia](#alarmeresistencia) — FB · ST
- [AlarmeTemperatura](#alarmetemperatura) — FB · ST
- [AlarmeTermopar](#alarmetermopar) — FB · ST
- [AlarmeTM3TI8T](#alarmetm3ti8t) — FB · ST
- [AlarmeTM5SAI6TH](#alarmetm5sai6th) — FB · ST
- [AlarmeValvula1v](#alarmevalvula1v) — FB · ST
- [AlarmeValvula1vNeg](#alarmevalvula1vneg) — FB · ST
- [BlocoSelecaoEspessura](#blocoselecaoespessura) — FB · ST
- [CalculosForno](#calculosforno) — FB · ST
- [CalculosResfriador](#calculosresfriador) — FB · ST
- [ComprimentoCarga](#comprimentocarga) — FB · ST
- [ContadorUpDown](#contadorupdown) — FB · ST
- [ConverLintReal](#converlintreal) — FB · CFC
- [EncoderBlocoExpert](#encoderblocoexpert) — FB · ST
- [EquacaoDaReta](#equacaodareta) — FB · ST
- [GetDateAndTime](#getdateandtime) — FB · CFC
- [Grade](#grade) — FB · ST
- [HabilitaDesabilita](#habilitadesabilita) — FB · ST
- [HabilitaDesabilitaSB](#habilitadesabilitasb) — FB · ST
- [MmConversorPulso](#mmconversorpulso) — FB · ST
- [MonitoraEncoder](#monitoraencoder) — FB · ST
- [Patamar](#patamar) — FB · ST
- [PidPwm_ONOFF](#pidpwm_onoff) — FB · ST
- [PidPwm](#pidpwm) — FB · ST
- [PulsoConversorMm](#pulsoconversormm) — FB · ST
- [PulsoNegativo](#pulsonegativo) — FB · ST
- [PulsoPositivo](#pulsopositivo) — FB · ST
- [Rampa](#rampa) — FB · ST
- [RampaCiclo](#rampaciclo) — FB · ST
- [Registrador](#registrador) — FB · ST
- [RegistradorMedia](#registradormedia) — FB · ST
- [SelecaoEspessura](#selecaoespessura) — FB · ST
- [SetDateAndTime](#setdateandtime) — FB · CFC
- [Sr10](#sr10) — FB · ST
- [StatCircuitoResist](#statcircuitoresist) — FB · ST
- [Temporizador](#temporizador) — FB · ST
- [TimerGeneration](#timergeneration) — FB · ST
- [TimerGenerationPorc](#timergenerationporc) — FB · ST
- [TrocaValor](#trocavalor) — FB · ST
- [Valor_Float](#valor_float) — FC · ST
- [WordBit](#wordbit) — FB · ST

## AlarmeEncoder

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeEncoder.fb.st>).

**O que faz:** Detecta ausência de alternância nos canais digitais A e B de um encoder.

**Responsabilidades observadas:**

- Aguardar 1,5 s após habilitação e temporizar canais presos em 0 ou 1.
- Memorizar alarmes por canal, alarme geral e solicitação sonora até reset.

## AlarmeMotor

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeMotor.fb.st>).

**O que faz:** Compara comando de motor com retorno de funcionamento.

**Responsabilidades observadas:**

- Sinalizar falha quando KmMotor permanece ativo sem KaMotor por 100 ms.
- Reter alarme e solicitação sonora e apagá-los no reset.

## AlarmeMotorParado

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeMotorParado.fb.st>).

**O que faz:** Temporiza uma condição externa que representa motor parado indevidamente.

**Responsabilidades observadas:**

- Gerar alarme após KaMotor permanecer verdadeiro por 3 s.
- Gerenciar memória sonora e reset temporizado.

**Observações:** KaMotor é a condição de falha recebida; o bloco não compara comando e retorno por conta própria.

## AlarmeRelesSsr

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeRelesSsr.fb.st>).

**O que faz:** Detecta divergências entre o comando e o retorno de um SSR.

**Responsabilidades observadas:**

- Temporizar falta de retorno com comando ligado e retorno presente com comando desligado.
- Gerar estados de SSR aberto/fechado, considerar o sinal de resistência rompida e reter alarmes até reset.

## AlarmeResistencia

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeResistencia.fb.st>).

**O que faz:** Trata o sinal de resistência rompida recebido de outro ponto da aplicação.

**Responsabilidades observadas:**

- Confirmar o sinal após 250 ms.
- Memorizar alarme e solicitação sonora até reset.

## AlarmeTemperatura

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeTemperatura.fb.st>).

**O que faz:** Monitora uma leitura em relação ao limite máximo de temperatura.

**Responsabilidades observadas:**

- Confirmar leitura maior ou igual ao limite por 1 s.
- Reter indicação de excesso e solicitação sonora até reset.

## AlarmeTermopar

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeTermopar.fb.st>).

**O que faz:** Converte um sinal de falha de termopar em alarme memorizado.

**Responsabilidades observadas:**

- Aplicar confirmação de 1 s ao sinal booleano recebido.
- Manter alarme de termopar aberto e solicitação sonora até reset.

## AlarmeTM3TI8T

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeTM3TI8T.fb.st>).

**O que faz:** Decodifica os bytes de diagnóstico de oito canais de temperatura.

**Responsabilidades observadas:**

- Classificar os códigos 4, 5 ou 6 de cada entrada como falha.
- Publicar oito saídas booleanas por meio de TON com tempo zero.

**Observações:** A classificação descrita é a implementada no bloco; as saídas acompanham os códigos, sem retenção por reset.

## AlarmeTM5SAI6TH

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeTM5SAI6TH.fb.st>).

**O que faz:** Decodifica dois bytes de diagnóstico em estados de seis termopares.

**Responsabilidades observadas:**

- Separar os pares de bits por canal.
- Publicar estados normal, abaixo do mínimo, acima do máximo e aberto.

**Observações:** O parâmetro ResetAlarm está declarado, mas não é usado na implementação lida.

## AlarmeValvula1v

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeValvula1v.fb.st>).

**O que faz:** Supervisiona a chegada de uma válvula às posições aberta e fechada.

**Responsabilidades observadas:**

- Comparar comando ativo com sensor aberto e comando inativo com sensor fechado.
- Aplicar tempos independentes para cada movimento e memorizar falha e som até reset.

## AlarmeValvula1vNeg

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/AlarmeValvula1vNeg.fb.st>).

**O que faz:** Supervisiona uma válvula cuja lógica de comando é invertida.

**Responsabilidades observadas:**

- Esperar abertura com comando falso e fechamento com comando verdadeiro.
- Temporizar ausência dos sensores correspondentes e reter alarmes até reset.

## BlocoSelecaoEspessura

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/BlocoSelecaoEspessura.fb.st>).

**O que faz:** Seleciona simultaneamente dez parâmetros entre dois conjuntos.

**Responsabilidades observadas:**

- Encaminhar a mesma seleção booleana a dez instâncias de SelecaoEspessura.
- Produzir dez valores escolhidos para a condição de espessura definida pelo chamador.

## CalculosForno

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/CalculosForno.fb.st>).

**O que faz:** Calcula posições de referência para o transporte da carga no forno.

**Responsabilidades observadas:**

- Produzir posições de redução de velocidade, carga, descarga e limites de oscilação.
- Relacionar distância de carga, área útil e tamanho da carga, disponibilizando também os limites configurados.

**Observações:** O cálculo de recuo lê TamanhoAreaUtilForno antes de atualizá-lo na mesma chamada.

## CalculosResfriador

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/CalculosResfriador.fb.st>).

**O que faz:** Calcula posições de referência para a mesa de resfriamento.

**Responsabilidades observadas:**

- Determinar ponto de redução de velocidade, posição de carga e limites de oscilação.
- Encaminhar a distância configurada de descarga e considerar a área útil e o tamanho da carga.

**Observações:** DistanciaOscilacaoResfriador está declarada, mas não participa das expressões ativas.

## ComprimentoCarga

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/ComprimentoCarga.fb.st>).

**O que faz:** Registra a contagem do encoder associada às mudanças do sensor durante uma medição.

**Responsabilidades observadas:**

- Zerar o registro auxiliar na subida de Habilita e atualizá-lo nas bordas do sensor.
- Publicar a última contagem registrada e sinalizar FimMedicao na descida de Habilita.

**Observações:** O resultado depende da referência do encoder e da janela de medição definida pelo chamador; o bloco não soma comprimentos individuais de peças.

## ContadorUpDown

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/ContadorUpDown.fb.st>).

**O que faz:** Mantém um contador inteiro bidirecional acionado por bordas.

**Responsabilidades observadas:**

- Incrementar na subida de CU e decrementar na subida de CD.
- Zerar CV quando RESET estiver ativo.

## ConverLintReal

**Tipo:** FB · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/ConverLintReal.pou.xml.v3>).

**O que faz:** Combina duas entradas DINT por conversão e máscaras de bits, expondo resultados LINT e REAL.

**Responsabilidades observadas:**

- Converter as entradas para LINT e aplicar máscaras às partes baixa e alta.
- Combinar os resultados com OR e converter o valor combinado para REAL.

**Observações:** O CFC lido não contém um deslocamento explícito de 32 bits da entrada alta; a correção dessa composição para os registradores do medidor exige validação específica.

## EncoderBlocoExpert

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/EncoderBlocoExpert.fb.st>).

**O que faz:** Produz uma posição relativa a partir de uma contagem absoluta.

**Responsabilidades observadas:**

- Memorizar o valor de referência enquanto Zera estiver ativo.
- Subtrair a referência da entrada e inverter o sinal quando solicitado.

## EquacaoDaReta

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/EquacaoDaReta.fb.st>).

**O que faz:** Transforma um valor Y em X pela reta definida por dois pontos.

**Responsabilidades observadas:**

- Aplicar a expressão de interpolação/extrapolação linear usada pela aplicação.
- Expor termos auxiliares do cálculo para acompanhamento.

## GetDateAndTime

**Tipo:** FB · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/GetDateAndTime.pou.xml.v3>).

**O que faz:** Lê o relógio do controlador e decompõe a data e a hora.

**Responsabilidades observadas:**

- Obter o timestamp por SysTimeRtcGet e convertê-lo com SysTimeRtcConvertUtcToDate.
- Publicar ano, mês, dia, hora, minuto, segundo e campos adicionais da estrutura de data.

**Observações:** q_UIntTotalMs está declarado, mas não foi encontrado como saída conectada no CFC.

## Grade

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/Grade.fb.st>).

**O que faz:** Mantém o estado de comando de uma grade com alternância e comandos diretos.

**Responsabilidades observadas:**

- Alternar estado na borda de LigaDesl e considerar Liga, Desl e Libera.
- Derrubar o estado quando Alarme01 estiver ativo.

## HabilitaDesabilita

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/HabilitaDesabilita.fb.st>).

**O que faz:** Implementa uma memória de habilitação com alternância por pulso.

**Responsabilidades observadas:**

- Alternar o estado na subida de Entrada e permitir ligação por Entrada02.
- Desligar por Entrada03 ou por qualquer um dos três alarmes.

## HabilitaDesabilitaSB

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/HabilitaDesabilitaSB.fb.st>).

**O que faz:** Implementa a mesma memória de habilitação com consumo do comando de entrada.

**Responsabilidades observadas:**

- Alternar/ligar/desligar o estado usando comandos e alarmes.
- Escrever FALSE em Entrada ao final da chamada, além de publicar StatusSaida.

## MmConversorPulso

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/MmConversorPulso.fb.st>).

**O que faz:** Converte até vinte distâncias em milímetros para contagens de encoder.

**Responsabilidades observadas:**

- Aplicar a relação de calibração dPulso/dMilimetro a cada entrada.
- Expor resultados DINT para os comparadores de posicionamento.

**Observações:** O canal 03 possui cálculo intermediário em REAL; os demais usam predominantemente aritmética inteira.

## MonitoraEncoder

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/MonitoraEncoder.fb.st>).

**O que faz:** Detecta movimento insuficiente pela comparação periódica da contagem de encoder.

**Responsabilidades observadas:**

- Comparar a contagem atual com uma referência e uma faixa de ±10 pulsos.
- Gerar estado EncoderOk, confirmar parada por temporização e reter alarme/solicitação sonora até reset.

## Patamar

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/Patamar.fb.st>).

**O que faz:** Executa uma etapa temporizada de manutenção de temperatura.

**Responsabilidades observadas:**

- Habilitar controle de dois pontos com histerese durante o patamar.
- Publicar saída de aquecimento, status, tempos decorrido/restante e conclusão; tratar zona desabilitada e reset.

## PidPwm_ONOFF

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/PidPwm_ONOFF.fb.st>).

**O que faz:** Aciona a resistência por comparação de temperatura combinada com temporização percentual.

**Responsabilidades observadas:**

- Permitir pulsos enquanto o setpoint for maior ou igual à temperatura de controle.
- Gerar tempos ligado/desligado com TimerGenerationPorc e aplicar habilitações, alarme, excesso e forçamento.
- Registrar temperatura e indicação de setpoint atingido.

**Observações:** Os ganhos Kp/Ki/Kd e os parâmetros de PID permanecem na interface, mas não são usados para calcular a saída ativa.

## PidPwm

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/PidPwm.fb.st>).

**O que faz:** Converte uma demanda de controle PID em acionamento temporal de resistência.

**Responsabilidades observadas:**

- Executar FB_PID, limitar sua saída a 0–100 e multiplicá-la pelo percentual recebido antes do FB_PWM.
- Aplicar habilitações, alarme, excesso de temperatura e forçamento; registrar temperatura e indicação de setpoint atingido.

## PulsoConversorMm

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/PulsoConversorMm.fb.st>).

**O que faz:** Converte até vinte contagens de encoder para milímetros.

**Responsabilidades observadas:**

- Aplicar a relação dMilimetro/dPulso a cada entrada.
- Converter os resultados para INT, sem controlar diretamente os movimentos.

## PulsoNegativo

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/PulsoNegativo.fb.st>).

**O que faz:** Detecta a transição de verdadeiro para falso de uma entrada.

**Responsabilidades observadas:**

- Comparar a entrada com a memória da chamada anterior.
- Emitir SaidaPulsoNe por uma chamada e atualizar a memória.

**Observações:** Com a memória inicialmente falsa, uma primeira chamada com Entrada falsa também pode produzir pulso.

## PulsoPositivo

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/PulsoPositivo.fb.st>).

**O que faz:** Detecta a transição de falso para verdadeiro de uma entrada.

**Responsabilidades observadas:**

- Comparar a entrada com a memória da chamada anterior.
- Emitir SaidaPulsoPo por uma chamada e atualizar a memória.

## Rampa

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/Rampa.fb.st>).

**O que faz:** Executa uma aproximação progressiva da temperatura até um patamar.

**Responsabilidades observadas:**

- Calcular incremento de setpoint e temporização a partir da temperatura inicial e do tempo de rampa.
- Comandar aquecimento por comparações, publicar setpoint progressivo, tempos e status.
- Tratar conclusão local, fim global de rampa, zona desabilitada e reset.

## RampaCiclo

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/RampaCiclo.fb.st>).

**O que faz:** Gera uma referência térmica progressiva vinculada ao ciclo de uma carga.

**Responsabilidades observadas:**

- Detectar tendência de subida da temperatura e aguardar forno cheio por 15 s.
- Calcular gradiente até o setpoint no tempo disponível, descontando estabilização.
- Publicar referência intermediária, estado de rampa e tempos de atingimento.

**Observações:** Lê variáveis globais do ciclo do forno; não é um bloco isolado da aplicação. xReset está declarado, mas não aparece na implementação ativa.

## Registrador

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/Registrador.fb.st>).

**O que faz:** Captura e mantém um valor inteiro por comando de registro.

**Responsabilidades observadas:**

- Copiar iDadoEntrada para a saída na borda de subida do pedido.
- Apagar o valor registrado quando xReset estiver ativo.

## RegistradorMedia

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/RegistradorMedia.fb.st>).

**O que faz:** Filtra uma leitura REAL por média móvel de dez amostras.

**Responsabilidades observadas:**

- Gerar uma cadência interna de amostragem e deslocar o histórico.
- Calcular a média das dez posições, inclusive as inicialmente zeradas.

## SelecaoEspessura

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/SelecaoEspessura.fb.st>).

**O que faz:** Seleciona um valor inteiro entre duas alternativas.

**Responsabilidades observadas:**

- Retornar Entrada01 quando Selecao for verdadeira e Entrada02 quando for falsa.

**Observações:** A identificação de vidro fino/grosso é responsabilidade do chamador.

## SetDateAndTime

**Tipo:** FB · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/SetDateAndTime.pou.xml.v3>).

**O que faz:** Ajusta o relógio do controlador a partir de campos de data e hora.

**Responsabilidades observadas:**

- Montar SYSTIMEDATE, converter a data para timestamp e condicionar SysTimeRtcSet ao pedido e à condição do diagrama.
- Publicar diagnósticos da conversão e da escrita e devolver i_xSetDateTime a falso no fluxo gráfico.

**Observações:** A condição e o consumo do comando devem ser lidos pelas conexões do CFC; não há detector de borda explícito equivalente a PulsoPositivo.

## Sr10

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/Sr10.fb.st>).

**O que faz:** Agrupa dez registradores inteiros com comandos comuns.

**Responsabilidades observadas:**

- Capturar simultaneamente dez entradas por meio de instâncias de Registrador.
- Distribuir o mesmo pedido de reset para os dez valores.

## StatCircuitoResist

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/StatCircuitoResist.fb.st>).

**O que faz:** Classifica o estado de um circuito de resistência por corrente, comando e retorno.

**Responsabilidades observadas:**

- Determinar ligado/desligado comparando corrente medida com um limiar.
- Distinguir combinações associadas a SSR aberto, SSR em curto e resistência aberta.

**Observações:** Publica estados combinacionais; não inclui temporização nem retenção de alarmes.

## Temporizador

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/Temporizador.fb.st>).

**O que faz:** Gerencia uma contagem de tempo de processo em segundos.

**Responsabilidades observadas:**

- Manter a contagem após o comando inicial e publicar tempo decorrido e restante.
- Sinalizar FimTempo ao atingir o setpoint ou receber aborto, interrompendo a contagem.

**Observações:** FimTempo é VAR_IN_OUT: o chamador participa do rearme. Não há pausa com preservação de tempo implementada como entrada dedicada.

## TimerGeneration

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/TimerGeneration.fb.st>).

**O que faz:** Gera um sinal booleano periódico com dois TON encadeados.

**Responsabilidades observadas:**

- Alternar a saída enquanto ENABLE estiver ativo.
- Usar TIMEHIGH como espera com saída falsa e TIMELOW como intervalo com saída verdadeira.

**Observações:** Os nomes TIMEHIGH/TIMELOW não correspondem diretamente ao nível da saída na implementação.

## TimerGenerationPorc

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/TimerGenerationPorc.fb.st>).

**O que faz:** Gera pulsos temporizados com tratamentos especiais do percentual.

**Responsabilidades observadas:**

- Aplicar o mesmo encadeamento de TON de TimerGeneration.
- Forçar saída falsa em 0% e saída verdadeira quando o percentual for pelo menos 95% e ENABLE estiver ativo.

## TrocaValor

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/TrocaValor.fb.st>).

**O que faz:** Detecta mudança de um valor REAL.

**Responsabilidades observadas:**

- Comparar ValorNovo com ValorAtual e atualizar o valor memorizado.
- Publicar Saida verdadeira apenas na chamada em que a diferença é detectada.

## Valor_Float

**Tipo:** FC · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/Valor_Float.fn.st>).

**O que faz:** Interpreta dois WORD como sinal, expoente e mantissa de um valor de ponto flutuante.

**Responsabilidades observadas:**

- Compor um DWORD, extrair os campos e aplicar a fórmula numérica para produzir REAL.
- Servir à conversão de registradores usados em PM5300.

**Observações:** A implementação não contém tratamento explícito para zero, subnormais, infinito ou NaN; a descrição não pressupõe uma conversão completa para todos os padrões de bits.

## WordBit

**Tipo:** FB · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/00_FB/WordBit.fb.st>).

**O que faz:** Expõe individualmente os dezesseis bits de uma entrada UINT.

**Responsabilidades observadas:**

- Copiar os bits 0–15 para saídas booleanas correspondentes.

[Voltar ao catálogo](README.md)
