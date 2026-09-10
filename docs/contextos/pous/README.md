# Catálogo de FCs, FBs e PRGs

Descrição individual do código existente da aplicação **F100R S278 Temperville**, revisada em **05/09/2026**. Cada entrada apresenta finalidade, responsabilidades observadas, observações relevantes e link para o arquivo de implementação.

Relações entre os objetos: [diagrama geral com busca e zoom](../../diagramas/02-dependencias-geral.html), [fonte PlantUML](../../diagramas/02-dependencias-geral.puml) e [critérios de interpretação](../01-dependencias-geral.md).

## Cobertura

| Escopo | FC | FB | PRG | Total |
| --- | ---: | ---: | ---: | ---: |
| Objetos funcionais da aplicação | 1 | 44 | 121 | 166 |
| Funções implícitas de verificação | 8 | 0 | 0 | 8 |
| Total de POUs documentadas | 9 | 44 | 121 | 174 |

Também estão descritas as **4 ações de SR_ControleTemperatura**, totalizando **178 entradas**. As ações não foram contadas como PRGs. Das 174 POUs, 161 são ST e 13 são CFC (3 FBs e 10 PRGs).

A contagem cobre definições presentes na aplicação, incluindo variantes com chamadas comentadas e implementações comentadas. Não conta cada instância de um FB nem redefine os blocos de bibliotecas, como TON, HSCMain_TM3, FB_PWM e SE_CTBX.FB_HeatingControl. GVLs, DUTs e configuração de tarefas são outros tipos de objeto e não fazem parte deste catálogo.

## Como interpretar

- **FC:** função declarada com FUNCTION. A FC funcional encontrada é Valor_Float; as oito Check... são verificações implícitas.
- **FB:** tipo declarado com FUNCTION_BLOCK, instanciado pelos programas; uma instância pode conservar estado entre chamadas.
- **PRG:** unidade declarada com PROGRAM; sua execução depende da configuração de tarefas ou de chamadas de outros programas.
- **Responsabilidades observadas:** comportamento do código lido, sem indicar que já existe encapsulamento adequado. Muitos PRGs leem e escrevem GVLs e coordenam outras rotinas por flags.
- **Observações:** diferenças entre nome e comportamento, trechos comentados, condições de chamada e questões que exigem validação posterior. Uma chamada identificada é evidência de um caminho possível, não de equipamento instalado ou em funcionamento.

A leitura considerou declarações, instruções ST fora de comentários e blocos/conexões serializados em CFC. Não houve compilação, simulação, acionamento de testes nem execução em PLC. Este é um catálogo funcional; ainda não é uma especificação completa de estados, intertravamentos, entradas/saídas ou dependências.

**Correspondência física confirmada:** passagem/têmpera integra a mesa de resfriamento desta máquina. Nomes como H_MesaPassagem e G_BufferTemperaPass foram preservados para rastreabilidade, sem inferir outra mesa física.

## Capítulos

| Área do código | FC | FB | PRG | Ações | Descrições |
| --- | ---: | ---: | ---: | ---: | --- |
| 00_FB | 1 | 44 | 0 | 0 | [FBs e FC de apoio](00-fbs-fcs.md) |
| 01_Inicialização | 0 | 0 | 5 | 0 | [Inicialização e comunicação](01-inicializacao.md) |
| 02_Operação | 0 | 0 | 53 | 0 | [Operação da máquina](02-operacao.md) |
| 03_Geral | 0 | 0 | 13 | 0 | [Diagnóstico e apresentação](03-geral.md) |
| 04_PID | 0 | 0 | 13 | 0 | [Controle térmico, rampa e convecção](04-controle-termico.md) |
| 04_PID/HEAT | 0 | 0 | 2 | 4 | [Conjunto HEAT e suas ações](04-heat.md) |
| 05_TEMPERATURA | 0 | 0 | 8 | 0 | [Aquisição e diagnóstico térmico](05-temperatura.md) |
| 06_Relógio | 0 | 0 | 4 | 0 | [Relógio e programação temporal](06-relogio.md) |
| 07_Energia | 0 | 0 | 10 | 0 | [Medição e supervisão de energia](07-energia.md) |
| 08_Testes | 0 | 0 | 5 | 0 | [Testes e diagnóstico de parada](08-testes.md) |
| 09_RedeCanOpen | 0 | 0 | 2 | 0 | [Integração dos acionamentos](09-acionamentos.md) |
| 10_EntradasSaidas | 0 | 0 | 3 | 0 | [Mapeamento de entradas e saídas](10-entradas-saidas.md) |
| 11_GestaoEnergetica | 0 | 0 | 3 | 0 | [Gestão dos acumulados de energia](11-gestao-energetica.md) |
| Verificações implícitas | 8 | 0 | 0 | 0 | [Funções implícitas de verificação](12-funcoes-implicitas.md) |

## Pontos que afetam a leitura da arquitetura

- As instâncias do controle térmico por setor usam PidPwm_ONOFF. A existência de PidPwm e de ganhos Kp/Ki/Kd não significa que o caminho ativo use esse algoritmo.
- O conjunto HEAT contém outra estrutura térmica; sua chamada de entrada está comentada em A_PrincipalPid.
- A_SecundariaPid, U_Encoder e T_VenezianaVentInfPass têm implementação comentada. A ação _10_Alarmes também não contém instruções ativas.
- Há variantes de dutos, guilhotinas e ventiladores com chamadas comentadas. As entradas individuais identificam os casos observados.
- O mapa físico e este catálogo se complementam: [módulos e responsabilidades](../00-modulos-responsabilidades.md).

## Índice alfabético de POUs

| Objeto | Tipo | O que faz |
| --- | --- | --- |
| [A_EncoderCpu](02-operacao.md#a_encodercpu) | PRG | Ajusta as contagens dos encoders principais para uso nas coordenadas da aplicação. |
| [A_Inicializacao](01-inicializacao.md#a_inicializacao) | PRG | Define a quantidade de resistências por metade do forno. |
| [A_PincipalRampa](04-controle-termico.md#a_pincipalrampa) | PRG | Organiza a execução do aquecimento por rampa/patamar e por receita. |
| [A_PincipalTemperatura](05-temperatura.md#a_pincipaltemperatura) | PRG | Organiza a aquisição e os diagnósticos dos circuitos de temperatura. |
| [A_PirncipalRede](09-acionamentos.md#a_pirncipalrede) | PRG | Chama a rotina de integração dos acionamentos. |
| [A_PricipalGestao](11-gestao-energetica.md#a_pricipalgestao) | PRG | Organiza a contabilização de energia por condição de funcionamento e por data. |
| [A_Principal_IO](10-entradas-saidas.md#a_principal_io) | PRG | Seleciona o espelhamento normal das entradas e saídas. |
| [A_PrincipalEnergia](07-energia.md#a_principalenergia) | PRG | Organiza a leitura, o tratamento e os diagnósticos de energia. |
| [A_PrincipalGeral](03-geral.md#a_principalgeral) | PRG | Organiza a execução das rotinas gerais de diagnóstico e apresentação. |
| [A_PrincipalOperacao](02-operacao.md#a_principaloperacao) | PRG | Organiza a sequência cíclica das rotinas de operação da máquina. |
| [A_PrincipalPid](04-controle-termico.md#a_principalpid) | PRG | Organiza o controle dos setores de aquecimento e das convecções. |
| [A_PrincipalRelogio](06-relogio.md#a_principalrelogio) | PRG | Organiza as rotinas de data, hora e programação temporal. |
| [A_PrincipalTeste](08-testes.md#a_principalteste) | PRG | Seleciona e chama as rotinas de teste e diagnóstico de parada. |
| [A_SecundariaPid](04-controle-termico.md#a_secundariapid) | PRG | Contém uma estrutura de chamada secundária de PID inteiramente comentada. |
| [A_TemperaturaGeral](04-controle-termico.md#a_temperaturageral) | PRG | Distribui ajustes térmicos gerais entre os setores. |
| [AlarmeEncoder](00-fbs-fcs.md#alarmeencoder) | FB | Detecta ausência de alternância nos canais digitais A e B de um encoder. |
| [AlarmeMotor](00-fbs-fcs.md#alarmemotor) | FB | Compara comando de motor com retorno de funcionamento. |
| [AlarmeMotorParado](00-fbs-fcs.md#alarmemotorparado) | FB | Temporiza uma condição externa que representa motor parado indevidamente. |
| [AlarmeRelesSsr](00-fbs-fcs.md#alarmerelesssr) | FB | Detecta divergências entre o comando e o retorno de um SSR. |
| [AlarmeResistencia](00-fbs-fcs.md#alarmeresistencia) | FB | Trata o sinal de resistência rompida recebido de outro ponto da aplicação. |
| [AlarmeTemperatura](00-fbs-fcs.md#alarmetemperatura) | FB | Monitora uma leitura em relação ao limite máximo de temperatura. |
| [AlarmeTermopar](00-fbs-fcs.md#alarmetermopar) | FB | Converte um sinal de falha de termopar em alarme memorizado. |
| [AlarmeTM3TI8T](00-fbs-fcs.md#alarmetm3ti8t) | FB | Decodifica os bytes de diagnóstico de oito canais de temperatura. |
| [AlarmeTM5SAI6TH](00-fbs-fcs.md#alarmetm5sai6th) | FB | Decodifica dois bytes de diagnóstico em estados de seis termopares. |
| [AlarmeValvula1v](00-fbs-fcs.md#alarmevalvula1v) | FB | Supervisiona a chegada de uma válvula às posições aberta e fechada. |
| [AlarmeValvula1vNeg](00-fbs-fcs.md#alarmevalvula1vneg) | FB | Supervisiona uma válvula cuja lógica de comando é invertida. |
| [B_Acumuladores](11-gestao-energetica.md#b_acumuladores) | PRG | Atualiza acumuladores de consumo associados aos estados da máquina. |
| [B_DataHora](06-relogio.md#b_datahora) | PRG | Faz a interface entre o relógio do controlador e os comandos de ajuste da aplicação. |
| [B_Emergencia](01-inicializacao.md#b_emergencia) | PRG | Consolida os sinais físicos de emergência e de reconhecimento sonoro. |
| [B_EspelhoEntradas](10-entradas-saidas.md#b_espelhoentradas) | PRG | Associa canais físicos de entrada aos nomes funcionais da aplicação. |
| [B_Imagens](03-geral.md#b_imagens) | PRG | Reúne sinais de campo e de controle em conjuntos usados na representação visual da máquina. |
| [B_RampaPatamar](04-controle-termico.md#b_rampapatamar) | PRG | Sequencia o aquecimento do forno por rampa e manutenção em patamar. |
| [B_Receita](02-operacao.md#b_receita) | PRG | Recebe os parâmetros de receita e prepara os buffers usados pelos módulos. |
| [B_Termopares](05-temperatura.md#b_termopares) | PRG | Adquire, organiza e supervisiona os sinais de termopares. |
| [B_TesteResistencias](08-testes.md#b_testeresistencias) | PRG | Executa a verificação automática ou o acionamento manual dos circuitos de aquecimento. |
| [B_Velocidades](02-operacao.md#b_velocidades) | PRG | Converte as referências de receita em velocidades coordenadas entre mesas. |
| [BlocoSelecaoEspessura](00-fbs-fcs.md#blocoselecaoespessura) | FB | Seleciona simultaneamente dez parâmetros entre dois conjuntos. |
| [C_Alarmes](03-geral.md#c_alarmes) | PRG | Consolida alarmes da aplicação e comanda a sinalização geral. |
| [C_AquecimentoReceita](04-controle-termico.md#c_aquecimentoreceita) | PRG | Gerencia o aquecimento inicial até as temperaturas definidas pela receita. |
| [C_ComandosOperacao](02-operacao.md#c_comandosoperacao) | PRG | Gerencia os modos de operação e a autorização e finalização do ciclo. |
| [C_ComposicaoFatura](07-energia.md#c_composicaofatura) | PRG | Separa e acumula consumo e demanda segundo horários e períodos de leitura. |
| [C_EspelhoSaida](10-entradas-saidas.md#c_espelhosaida) | PRG | Transfere os comandos lógicos para as saídas digitais mapeadas. |
| [C_GerenciadorDatas](11-gestao-energetica.md#c_gerenciadordatas) | PRG | Trata a troca de dia e de mês para os acumuladores de energia. |
| [C_HabDesabResistencias](05-temperatura.md#c_habdesabresistencias) | PRG | Gerencia a habilitação dos setores de aquecimento. |
| [C_ProgramacaoHoraria](06-relogio.md#c_programacaohoraria) | PRG | Gera o acionamento da programação de aquecimento por dia da semana. |
| [C_StandByTemperaturas](04-controle-termico.md#c_standbytemperaturas) | PRG | Reduz os setpoints para a condição de espera após o intervalo configurado. |
| [C_Teste_Entradas_Saidas](08-testes.md#c_teste_entradas_saidas) | PRG | Oferece a imagem das entradas e aplica os comandos de teste às saídas físicas. |
| [CalculosForno](00-fbs-fcs.md#calculosforno) | FB | Calcula posições de referência para o transporte da carga no forno. |
| [CalculosResfriador](00-fbs-fcs.md#calculosresfriador) | FB | Calcula posições de referência para a mesa de resfriamento. |
| [CheckBounds](12-funcoes-implicitas.md#checkbounds) | FC | Limita um índice aos limites inferior e superior informados. |
| [CheckDivDInt](12-funcoes-implicitas.md#checkdivdint) | FC | Ajusta o divisor do tipo DINT usado na verificação implícita de divisão. |
| [CheckDivLInt](12-funcoes-implicitas.md#checkdivlint) | FC | Ajusta o divisor do tipo LINT usado na verificação implícita de divisão. |
| [CheckDivLReal](12-funcoes-implicitas.md#checkdivlreal) | FC | Ajusta o divisor do tipo LREAL usado na verificação implícita de divisão. |
| [CheckDivReal](12-funcoes-implicitas.md#checkdivreal) | FC | Ajusta o divisor do tipo REAL usado na verificação implícita de divisão. |
| [CheckPointer](12-funcoes-implicitas.md#checkpointer) | FC | Devolve o ponteiro recebido pela função de verificação implícita. |
| [CheckRangeSigned](12-funcoes-implicitas.md#checkrangesigned) | FC | Limita um valor com sinal ao intervalo informado. |
| [CheckRangeUnsigned](12-funcoes-implicitas.md#checkrangeunsigned) | FC | Limita um valor sem sinal ao intervalo informado. |
| [ComprimentoCarga](00-fbs-fcs.md#comprimentocarga) | FB | Registra a contagem do encoder associada às mudanças do sensor durante uma medição. |
| [ComunicacaoOpc](01-inicializacao.md#comunicacaoopc) | PRG | Executa a troca de sinais usada como indicação de comunicação entre supervisório e PLC. |
| [ContadorUpDown](00-fbs-fcs.md#contadorupdown) | FB | Mantém um contador inteiro bidirecional acionado por bordas. |
| [ConverLintReal](00-fbs-fcs.md#converlintreal) | FB | Combina duas entradas DINT por conversão e máscaras de bits, expondo resultados LINT e REAL. |
| [D_AnimaGeralResistencias](03-geral.md#d_animageralresistencias) | PRG | Converte os estados dos setores de aquecimento em códigos de apresentação. |
| [D_ConvecVentEnt](04-controle-termico.md#d_convecventent) | PRG | Controla a ventilação e o aquecimento da convecção identificada como entrada. |
| [D_ConvecVentSai](04-controle-termico.md#d_convecventsai) | PRG | Controla a ventilação e o aquecimento da convecção identificada como saída. |
| [D_CtrlResist](04-controle-termico.md#d_ctrlresist) | PRG | Coordena habilitações, pausas e dados comuns do controle das resistências. |
| [D_CtrlResistInferiores](04-controle-termico.md#d_ctrlresistinferiores) | PRG | Executa os controles dos cinquenta setores inferiores previstos no código. |
| [D_CtrlResistSuperiores](04-controle-termico.md#d_ctrlresistsuperiores) | PRG | Executa os controles dos cinquenta setores superiores previstos no código. |
| [D_ProgramacaoTempo](06-relogio.md#d_programacaotempo) | PRG | Gerencia um bloqueio programado por data e horário. |
| [D_Resistencias](05-temperatura.md#d_resistencias) | PRG | Diagnostica ruptura dos circuitos de resistência. |
| [D_SensoresEntrada](02-operacao.md#d_sensoresentrada) | PRG | Consolida a detecção de vidro na entrada do forno. |
| [D_Teste_Nobreak](08-testes.md#d_teste_nobreak) | PRG | Acompanha um teste de sustentação da máquina pelo nobreak. |
| [D_ZeramentoMedidor](07-energia.md#d_zeramentomedidor) | PRG | Sequencia os comandos de zeramento do medidor e dos acumuladores internos. |
| [E_AnimaTesteGeralResistencias](03-geral.md#e_animatestegeralresistencias) | PRG | Prepara os estados visuais dos setores durante o teste de resistências. |
| [E_MesaEntrada](02-operacao.md#e_mesaentrada) | PRG | Controla o posicionamento da carga na entrada e sua entrega ao forno. |
| [E_Nobreak](07-energia.md#e_nobreak) | PRG | Supervisiona a indicação de funcionamento do nobreak. |
| [E_RelesEstadoSolido](05-temperatura.md#e_relesestadosolido) | PRG | Diagnostica inconsistências entre o comando de aquecimento e o retorno dos circuitos. |
| [E_Termperaturas](04-controle-termico.md#e_termperaturas) | PRG | Atualiza os valores apresentados de temperatura sem executar o controle por setor. |
| [EncoderBlocoExpert](00-fbs-fcs.md#encoderblocoexpert) | FB | Produz uma posição relativa a partir de uma contagem absoluta. |
| [EncoderMForno](02-operacao.md#encodermforno) | PRG | Aplica uma referência relativa à contagem do encoder da mesa do forno. |
| [EncoderModulo01](02-operacao.md#encodermodulo01) | PRG | Faz a interface CFC com os contadores rápidos do forno e da mesa de resfriamento. |
| [EncoderModulo02](02-operacao.md#encodermodulo02) | PRG | Faz a interface CFC com os contadores rápidos do duto superior 02 e da guilhotina 02. |
| [EncoderModulo03](02-operacao.md#encodermodulo03) | PRG | Contém uma variante de aquisição dos encoders das guilhotinas 01 e 02. |
| [EncoderMResfr](02-operacao.md#encodermresfr) | PRG | Aplica uma referência relativa ao encoder da mesa de resfriamento. |
| [EncoderResfriInf01](02-operacao.md#encoderresfriinf01) | PRG | Aplica a referência relativa ao encoder do duto inferior 01. |
| [EncoderResfriInf02](02-operacao.md#encoderresfriinf02) | PRG | Aplica a referência relativa ao encoder do duto inferior 02. |
| [EncoderResfriSup01](02-operacao.md#encoderresfrisup01) | PRG | Aplica a referência relativa ao encoder do duto superior 01. |
| [EncoderResfriSup02](02-operacao.md#encoderresfrisup02) | PRG | Aplica a referência relativa ao encoder do duto superior 02. |
| [Energia](07-energia.md#energia) | PRG | Publica grandezas elétricas e de consumo usadas pela aplicação. |
| [EquacaoDaReta](00-fbs-fcs.md#equacaodareta) | FB | Transforma um valor Y em X pela reta definida por dois pontos. |
| [F_AnimaAlmMotValv](03-geral.md#f_animaalmmotvalv) | PRG | Prepara os códigos de apresentação de motores e válvulas. |
| [F_BufferForno](02-operacao.md#f_bufferforno) | PRG | Aplica ao forno a receita recebida e prepara os dados da próxima etapa. |
| [F_FaltaFase](07-energia.md#f_faltafase) | PRG | Detecta condição de tensão insuficiente nas fases monitoradas. |
| [F_MensagemErroMotor](03-geral.md#f_mensagemerromotor) | PRG | Traduz códigos conhecidos de falha dos acionamentos em textos curtos. |
| [F_MesaForno](02-operacao.md#f_mesaforno) | PRG | Controla a movimentação do vidro durante carga, permanência e descarga do forno. |
| [F_PosicaoTermopares](05-temperatura.md#f_posicaotermopares) | PRG | Associa cada setor lógico de aquecimento ao termopar físico configurado. |
| [F_SerialNumber](03-geral.md#f_serialnumber) | PRG | Publica dados de identificação e manutenção do controlador. |
| [G_BufferResfriamento](02-operacao.md#g_bufferresfriamento) | PRG | Aplica os parâmetros do forno ao resfriamento quando este pode recebê-los. |
| [G_BufferTemperaPass](02-operacao.md#g_buffertemperapass) | PRG | Atualiza os parâmetros de ventilação associados à lógica de passagem/têmpera. |
| [G_CircuitoResistencia](05-temperatura.md#g_circuitoresistencia) | PRG | Atualiza os estados dos circuitos de resistência com os retornos dos SSRs. |
| [G_Disjuntores](07-energia.md#g_disjuntores) | PRG | Supervisiona os retornos dos disjuntores geral e de aquecimento. |
| [GetDateAndTime](00-fbs-fcs.md#getdateandtime) | FB | Lê o relógio do controlador e decompõe a data e a hora. |
| [Grade](00-fbs-fcs.md#grade) | FB | Mantém o estado de comando de uma grade com alternância e comandos diretos. |
| [H_CircuitoCC](07-energia.md#h_circuitocc) | PRG | Interpreta as chaves do circuito de corrente contínua. |
| [H_MesaPassagem](02-operacao.md#h_mesapassagem) | PRG | Sequencia os comandos da mesa lógica chamada Passagem durante a transferência. |
| [H_MesaResfriador](02-operacao.md#h_mesaresfriador) | PRG | Controla a recepção, oscilação e descarga da carga no conjunto físico de têmpera/resfriamento. |
| [H_Pirometro](05-temperatura.md#h_pirometro) | PRG | Processa os pirômetros e uma lógica específica de rampa térmica. |
| [H1_Dutos_Oscilantes](02-operacao.md#h1_dutos_oscilantes) | PRG | Comanda os motores de oscilação dos dutos superior e inferior 02. |
| [HabilitaDesabilita](00-fbs-fcs.md#habilitadesabilita) | FB | Implementa uma memória de habilitação com alternância por pulso. |
| [HabilitaDesabilitaSB](00-fbs-fcs.md#habilitadesabilitasb) | FB | Implementa a mesma memória de habilitação com consumo do comando de entrada. |
| [I_MesaSaida](02-operacao.md#i_mesasaida) | PRG | Controla a recepção da carga resfriada e sua movimentação para retirada. |
| [J_DuctosResfriadorInf01](02-operacao.md#j_ductosresfriadorinf01) | PRG | Sequencia a referência e o ajuste de altura do duto inferior 01. |
| [J_DuctosResfriadorInf02](02-operacao.md#j_ductosresfriadorinf02) | PRG | Controla a referência e o ajuste de altura do duto inferior 02. |
| [J_DuctosResfriadorSup01](02-operacao.md#j_ductosresfriadorsup01) | PRG | Controla a referência e o ajuste de altura do duto superior 01. |
| [J_DuctosResfriadorSup02](02-operacao.md#j_ductosresfriadorsup02) | PRG | Controla a referência, a altura e a abertura local do duto superior 02. |
| [K_Guilhotina01](02-operacao.md#k_guilhotina01) | PRG | Controla a referência e a posição da guilhotina 01. |
| [K_Guilhotina01Inf](02-operacao.md#k_guilhotina01inf) | PRG | Controla a variante de guilhotina 01 inferior. |
| [K_Guilhotina01Sup](02-operacao.md#k_guilhotina01sup) | PRG | Controla a variante de guilhotina 01 superior. |
| [K_Guilhotina02](02-operacao.md#k_guilhotina02) | PRG | Controla a referência e a posição da guilhotina 02. |
| [L_EstagiosResfriador](02-operacao.md#l_estagiosresfriador) | PRG | Sequencia os três estágios do resfriamento. |
| [M_Ventilador01](02-operacao.md#m_ventilador01) | PRG | Sequencia a ventilação 01 associada à passagem/têmpera integrada ao resfriamento. |
| [M_Ventilador02](02-operacao.md#m_ventilador02) | PRG | Sequencia a variante de ventilação 02 da passagem/têmpera. |
| [M_Ventilador03](02-operacao.md#m_ventilador03) | PRG | Controla a ventilação 03 do processo de resfriamento. |
| [M_Ventilador04](02-operacao.md#m_ventilador04) | PRG | Sequencia a variante de ventilação 04 do resfriamento. |
| [MmConversorPulso](00-fbs-fcs.md#mmconversorpulso) | FB | Converte até vinte distâncias em milímetros para contagens de encoder. |
| [MonitoraEncoder](00-fbs-fcs.md#monitoraencoder) | FB | Detecta movimento insuficiente pela comparação periódica da contagem de encoder. |
| [N_Grades](02-operacao.md#n_grades) | PRG | Gerencia o acionamento das grades de entrada e saída. |
| [N_MesaBasculante](02-operacao.md#n_mesabasculante) | PRG | Sequencia os atuadores da mesa basculante de entrada. |
| [O_Motores](09-acionamentos.md#o_motores) | PRG | Integra os estados dos inversores às variáveis de operação da máquina. |
| [O_Portas](02-operacao.md#o_portas) | PRG | Combina os pedidos automáticos e de abertura forçada das portas do forno. |
| [O_VelocidadesMotores](03-geral.md#o_velocidadesmotores) | PRG | Calcula referências de velocidade relacionadas à espessura e à calibração das mesas. |
| [P_ComandosEventos](02-operacao.md#p_comandoseventos) | PRG | Transforma transições de sinais em indicadores de eventos para registro externo. |
| [P_StatusOnline](03-geral.md#p_statusonline) | PRG | Codifica os estados de operação para acompanhamento pelo supervisório. |
| [Patamar](00-fbs-fcs.md#patamar) | FB | Executa uma etapa temporizada de manutenção de temperatura. |
| [PidPwm](00-fbs-fcs.md#pidpwm) | FB | Converte uma demanda de controle PID em acionamento temporal de resistência. |
| [PidPwm_ONOFF](00-fbs-fcs.md#pidpwm_onoff) | FB | Aciona a resistência por comparação de temperatura combinada com temporização percentual. |
| [PM5300](07-energia.md#pm5300) | PRG | Converte o conteúdo dos registradores do medidor para os tipos usados no programa. |
| [PulsoConversorMm](00-fbs-fcs.md#pulsoconversormm) | FB | Converte até vinte contagens de encoder para milímetros. |
| [PulsoNegativo](00-fbs-fcs.md#pulsonegativo) | FB | Detecta a transição de verdadeiro para falso de uma entrada. |
| [PulsoPositivo](00-fbs-fcs.md#pulsopositivo) | FB | Detecta a transição de falso para verdadeiro de uma entrada. |
| [Q_Conveccao](02-operacao.md#q_conveccao) | PRG | Controla a variante de convecção por abertura e fechamento temporizado de válvula. |
| [Q_MonitoraEncoder](03-geral.md#q_monitoraencoder) | PRG | Instancia a supervisão de movimento dos encoders usados nesta configuração. |
| [R_ManometroDifusor](02-operacao.md#r_manometrodifusor) | PRG | Filtra e converte duas leituras de pressão dos difusores. |
| [R_MonitoraMotores](03-geral.md#r_monitoramotores) | PRG | Detecta parada inesperada dos movimentos do forno e do resfriamento. |
| [R_Pressostato](02-operacao.md#r_pressostato) | PRG | Classifica e supervisiona a pressão da rede a partir de dois sinais digitais. |
| [R_PressostatoAnal](02-operacao.md#r_pressostatoanal) | PRG | Filtra e converte as leituras analógicas de pressão da rede e da máquina. |
| [R_SensorVibracao](02-operacao.md#r_sensorvibracao) | PRG | Filtra e escala dois sinais de vibração associados aos ventiladores. |
| [Rampa](00-fbs-fcs.md#rampa) | FB | Executa uma aproximação progressiva da temperatura até um patamar. |
| [RampaCiclo](00-fbs-fcs.md#rampaciclo) | FB | Gera uma referência térmica progressiva vinculada ao ciclo de uma carga. |
| [Registrador](00-fbs-fcs.md#registrador) | FB | Captura e mantém um valor inteiro por comando de registro. |
| [RegistradorMedia](00-fbs-fcs.md#registradormedia) | FB | Filtra uma leitura REAL por média móvel de dez amostras. |
| [S_ElevacaoForno](02-operacao.md#s_elevacaoforno) | PRG | Trata os comandos de elevação e descida da caixa do forno. |
| [S_Termocamera](03-geral.md#s_termocamera) | PRG | Filtra e calcula relações numéricas a partir de um valor bruto associado à termocâmera. |
| [SelecaoEspessura](00-fbs-fcs.md#selecaoespessura) | FB | Seleciona um valor inteiro entre duas alternativas. |
| [SetDateAndTime](00-fbs-fcs.md#setdateandtime) | FB | Ajusta o relógio do controlador a partir de campos de data e hora. |
| [SR_ControleTemperatura](04-heat.md#sr_controletemperatura) | PRG | Coordena cem malhas de aquecimento com FB_HeatingControl e modulação PWM. |
| [SR_Main](04-heat.md#sr_main) | PRG | Integra o conjunto HEAT às variáveis de aquecimento do restante da aplicação. |
| [Sr10](00-fbs-fcs.md#sr10) | FB | Agrupa dez registradores inteiros com comandos comuns. |
| [StatCircuitoResist](00-fbs-fcs.md#statcircuitoresist) | FB | Classifica o estado de um circuito de resistência por corrente, comando e retorno. |
| [StatusCanOpenDevice](01-inicializacao.md#statuscanopendevice) | PRG | Consulta os estados de comunicação dos acionamentos representados no CFC. |
| [StatusRemotasModTcpIP](01-inicializacao.md#statusremotasmodtcpip) | PRG | Monitora o estado do scanner e dos canais das remotas. |
| [T_Damper](02-operacao.md#t_damper) | PRG | Aplica a seleção de damper quando o resfriamento não está em ciclo. |
| [T_VenezianaDutPass](02-operacao.md#t_venezianadutpass) | PRG | Reconhece os comandos de abertura e fechamento da veneziana do duto. |
| [T_VenezianaVentInfPass](02-operacao.md#t_venezianaventinfpass) | PRG | Mantém uma rotina de veneziana da ventilação inferior de passagem com implementação comentada. |
| [Temporizador](00-fbs-fcs.md#temporizador) | FB | Gerencia uma contagem de tempo de processo em segundos. |
| [TesteEnergia](07-energia.md#testeenergia) | PRG | Simula a evolução de grandezas e acumuladores de energia. |
| [TesteSTOP](08-testes.md#testestop) | PRG | Disponibiliza o motivo da última parada do controlador. |
| [TimerGeneration](00-fbs-fcs.md#timergeneration) | FB | Gera um sinal booleano periódico com dois TON encadeados. |
| [TimerGenerationPorc](00-fbs-fcs.md#timergenerationporc) | FB | Gera pulsos temporizados com tratamentos especiais do percentual. |
| [TrocaValor](00-fbs-fcs.md#trocavalor) | FB | Detecta mudança de um valor REAL. |
| [U_Encoder](02-operacao.md#u_encoder) | PRG | Mantém uma rotina de encoder com implementação inteiramente comentada. |
| [V_VentilacaoPainel](02-operacao.md#v_ventilacaopainel) | PRG | Controla a ventilação do painel e a ventilação dos SSRs. |
| [Valor_Float](00-fbs-fcs.md#valor_float) | FC | Interpreta dois WORD como sinal, expoente e mantissa de um valor de ponto flutuante. |
| [WordBit](00-fbs-fcs.md#wordbit) | FB | Expõe individualmente os dezesseis bits de uma entrada UINT. |
| [X_LimpaResfriador02](02-operacao.md#x_limparesfriador02) | PRG | Trata os comandos e o diagnóstico de posição do mecanismo de limpeza do resfriador 02. |

As quatro ações estão no capítulo [HEAT](04-heat.md).

[Voltar ao estudo](../../README.md)
