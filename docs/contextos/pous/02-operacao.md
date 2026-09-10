# Operação da máquina

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Receitas, transporte da carga, encoders, dutos, guilhotinas, ventilação e auxiliares. Passagem/têmpera integra fisicamente a mesa de resfriamento nesta máquina, conforme esclarecido pelo usuário.

## Objetos

- [A_EncoderCpu](#a_encodercpu) — PRG · ST
- [A_PrincipalOperacao](#a_principaloperacao) — PRG · ST
- [B_Receita](#b_receita) — PRG · ST
- [B_Velocidades](#b_velocidades) — PRG · ST
- [C_ComandosOperacao](#c_comandosoperacao) — PRG · ST
- [D_SensoresEntrada](#d_sensoresentrada) — PRG · ST
- [E_MesaEntrada](#e_mesaentrada) — PRG · ST
- [EncoderMForno](#encodermforno) — PRG · CFC
- [EncoderModulo01](#encodermodulo01) — PRG · CFC
- [EncoderModulo02](#encodermodulo02) — PRG · CFC
- [EncoderModulo03](#encodermodulo03) — PRG · CFC
- [EncoderMResfr](#encodermresfr) — PRG · CFC
- [EncoderResfriInf01](#encoderresfriinf01) — PRG · CFC
- [EncoderResfriInf02](#encoderresfriinf02) — PRG · CFC
- [EncoderResfriSup01](#encoderresfrisup01) — PRG · CFC
- [EncoderResfriSup02](#encoderresfrisup02) — PRG · CFC
- [F_BufferForno](#f_bufferforno) — PRG · ST
- [F_MesaForno](#f_mesaforno) — PRG · ST
- [G_BufferResfriamento](#g_bufferresfriamento) — PRG · ST
- [G_BufferTemperaPass](#g_buffertemperapass) — PRG · ST
- [H_MesaPassagem](#h_mesapassagem) — PRG · ST
- [H_MesaResfriador](#h_mesaresfriador) — PRG · ST
- [H1_Dutos_Oscilantes](#h1_dutos_oscilantes) — PRG · ST
- [I_MesaSaida](#i_mesasaida) — PRG · ST
- [J_DuctosResfriadorInf01](#j_ductosresfriadorinf01) — PRG · ST
- [J_DuctosResfriadorInf02](#j_ductosresfriadorinf02) — PRG · ST
- [J_DuctosResfriadorSup01](#j_ductosresfriadorsup01) — PRG · ST
- [J_DuctosResfriadorSup02](#j_ductosresfriadorsup02) — PRG · ST
- [K_Guilhotina01](#k_guilhotina01) — PRG · ST
- [K_Guilhotina01Inf](#k_guilhotina01inf) — PRG · ST
- [K_Guilhotina01Sup](#k_guilhotina01sup) — PRG · ST
- [K_Guilhotina02](#k_guilhotina02) — PRG · ST
- [L_EstagiosResfriador](#l_estagiosresfriador) — PRG · ST
- [M_Ventilador01](#m_ventilador01) — PRG · ST
- [M_Ventilador02](#m_ventilador02) — PRG · ST
- [M_Ventilador03](#m_ventilador03) — PRG · ST
- [M_Ventilador04](#m_ventilador04) — PRG · ST
- [N_Grades](#n_grades) — PRG · ST
- [N_MesaBasculante](#n_mesabasculante) — PRG · ST
- [O_Portas](#o_portas) — PRG · ST
- [P_ComandosEventos](#p_comandoseventos) — PRG · ST
- [Q_Conveccao](#q_conveccao) — PRG · ST
- [R_ManometroDifusor](#r_manometrodifusor) — PRG · ST
- [R_Pressostato](#r_pressostato) — PRG · ST
- [R_PressostatoAnal](#r_pressostatoanal) — PRG · ST
- [R_SensorVibracao](#r_sensorvibracao) — PRG · ST
- [S_ElevacaoForno](#s_elevacaoforno) — PRG · ST
- [T_Damper](#t_damper) — PRG · ST
- [T_VenezianaDutPass](#t_venezianadutpass) — PRG · ST
- [T_VenezianaVentInfPass](#t_venezianaventinfpass) — PRG · ST
- [U_Encoder](#u_encoder) — PRG · ST
- [V_VentilacaoPainel](#v_ventilacaopainel) — PRG · ST
- [X_LimpaResfriador02](#x_limparesfriador02) — PRG · ST

## A_EncoderCpu

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/A_EncoderCpu.prg.st>).

**O que faz:** Ajusta as contagens dos encoders principais para uso nas coordenadas da aplicação.

**Responsabilidades observadas:**

- Gera pedidos de preset quando o contador está parado ou há solicitação de referência.
- Copia as contagens de forno, resfriamento, duto superior 02 e guilhotina 02, aplicando os sinais de direção previstos.

## A_PrincipalOperacao

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/A_PrincipalOperacao.prg.st>).

**O que faz:** Organiza a sequência cíclica das rotinas de operação da máquina.

**Responsabilidades observadas:**

- Chama aquisição de encoders, receitas, comandos, mesas e buffers de processo.
- Chama estágios, ventiladores, portas, grades e serviços auxiliares.
- Trata os comandos que permitem dispensar a execução de duto superior 02 e guilhotina 02 e consolida sua condição de referência.

**Observações:** As chamadas de J_DuctosResfriadorSup02 e K_Guilhotina02 ocorrem quando seus sinais Enable estão FALSE; TRUE também satisfaz o respectivo CheckOk. Outras variantes têm chamadas comentadas.

## B_Receita

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/B_Receita.prg.st>).

**O que faz:** Recebe os parâmetros de receita e prepara os buffers usados pelos módulos.

**Responsabilidades observadas:**

- Reconhece o pedido de escrita, bloqueia o carregamento durante a transferência e identifica reenvio da receita.
- Copia parâmetros térmicos, tempos, velocidades, alturas, correções e espessura para buffers.
- Confirma a escrita, libera o bloqueio e sinaliza o evento de receita recebida.
- Classifica a espessura para sinais de vidro fino/grosso e ajuste de damper.

**Observações:** Há cálculos de somas, mas parte da conferência de integridade está comentada; não equivale a uma validação completa da receita.

## B_Velocidades

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/B_Velocidades.prg.st>).

**O que faz:** Converte as referências de receita em velocidades coordenadas entre mesas.

**Responsabilidades observadas:**

- Ajusta escalas das referências de carga e descarga.
- Usa interpolação linear e corretores para calcular as velocidades de entrada, passagem, resfriamento e saída.

**Observações:** Os nomes de passagem são mantidos como aparecem no software; nesta máquina a têmpera integra fisicamente a mesa de resfriamento.

## C_ComandosOperacao

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/C_ComandosOperacao.prg.st>).

**O que faz:** Gerencia os modos de operação e a autorização e finalização do ciclo.

**Responsabilidades observadas:**

- Interpreta a chave manual/automático e gera transições temporizadas.
- Trata pausa, emergência, reconhecimento e reinício conforme os sinais do programa.
- Sequencia as pré-condições de início do forno, finalização e estados gerais da máquina.
- Emite pedidos de ajuste e referência dos eixos e limpa comandos ao retornar ao modo manual.

## D_SensoresEntrada

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/D_SensoresEntrada.prg.st>).

**O que faz:** Consolida a detecção de vidro na entrada do forno.

**Responsabilidades observadas:**

- Combina por OR dez sinais lógicos de sensores em xSensorEntrada.

**Observações:** A quantidade de termos lógicos não comprova que dez sensores estejam instalados ou ligados a canais independentes.

## E_MesaEntrada

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/E_MesaEntrada.prg.st>).

**O que faz:** Controla o posicionamento da carga na entrada e sua entrega ao forno.

**Responsabilidades observadas:**

- Executa avanço/recuo de jog e recuo para liberar os sensores de entrada.
- Avalia pré-condições, agendamento e atraso para autorizar o carregamento.
- Sequencia a carga, a coordenação com a porta e com o forno e o retorno da mesa.
- Trata pausa, falha do motor, aborto por tempo e comandos de direção e velocidade do inversor.

**Observações:** O cálculo de comprimento e a decisão de rejeição da carga também dependem de F_MesaForno; não estão encapsulados exclusivamente nesta mesa.

## EncoderMForno

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/EncoderMForno.pou.xml.v3>).

**O que faz:** Aplica uma referência relativa à contagem do encoder da mesa do forno.

**Responsabilidades observadas:**

- Chama EncoderBlocoExpert com a contagem recebida.
- Memoriza a referência pelo pedido de home e publica a contagem relativa.

**Observações:** Sua chamada no principal está comentada. A versão ativa usa EncoderModulo01 e A_EncoderCpu; esta variante não apresenta a mesma inversão explícita de sinal.

## EncoderModulo01

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/EncoderModulo01.pou.xml.v3>).

**O que faz:** Faz a interface CFC com os contadores rápidos do forno e da mesa de resfriamento.

**Responsabilidades observadas:**

- Executa duas instâncias HSCMain_TM3 vinculadas aos respectivos canais.
- Aplica os pedidos de preset e publica Run e CurrentValue nas variáveis da aplicação.

**Observações:** O tratamento posterior de polaridade e dos pedidos de referência é feito por A_EncoderCpu.

## EncoderModulo02

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/EncoderModulo02.pou.xml.v3>).

**O que faz:** Faz a interface CFC com os contadores rápidos do duto superior 02 e da guilhotina 02.

**Responsabilidades observadas:**

- Executa as instâncias HSCMain_TM3 com as referências de hardware correspondentes.
- Aplica preset e disponibiliza contagens e indicações Run para A_EncoderCpu.

## EncoderModulo03

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/EncoderModulo03.pou.xml.v3>).

**O que faz:** Contém uma variante de aquisição dos encoders das guilhotinas 01 e 02.

**Responsabilidades observadas:**

- Executa duas instâncias HSCMain_TM3 e distribui as contagens e indicações Run.
- Aplica os pedidos individuais de preset.

**Observações:** A chamada no principal está comentada. Os dois vínculos HSC_REF_TM3 aparecem associados a EncoderGuilhotina02 no CFC; não se deve presumir aquisição independente dos dois eixos sem revisar essa configuração.

## EncoderMResfr

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/EncoderMResfr.pou.xml.v3>).

**O que faz:** Aplica uma referência relativa ao encoder da mesa de resfriamento.

**Responsabilidades observadas:**

- Chama EncoderBlocoExpert com o pedido de home.
- Publica a contagem relativa sem inversão de sinal.

**Observações:** A chamada em A_PrincipalOperacao está comentada.

## EncoderResfriInf01

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/EncoderResfriInf01.pou.xml.v3>).

**O que faz:** Aplica a referência relativa ao encoder do duto inferior 01.

**Responsabilidades observadas:**

- Chama EncoderBlocoExpert com o valor recebido e o pedido de home.
- Publica a contagem relativa sem inversão de sinal.

**Observações:** A chamada em A_PrincipalOperacao está comentada.

## EncoderResfriInf02

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/EncoderResfriInf02.pou.xml.v3>).

**O que faz:** Aplica a referência relativa ao encoder do duto inferior 02.

**Responsabilidades observadas:**

- Chama EncoderBlocoExpert com o valor recebido e o pedido de home.
- Publica a contagem relativa com inversão de sinal.

**Observações:** A chamada em A_PrincipalOperacao está comentada.

## EncoderResfriSup01

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/EncoderResfriSup01.pou.xml.v3>).

**O que faz:** Aplica a referência relativa ao encoder do duto superior 01.

**Responsabilidades observadas:**

- Chama EncoderBlocoExpert com o valor recebido e o pedido de home.
- Publica a contagem relativa com inversão de sinal.

**Observações:** A chamada em A_PrincipalOperacao está comentada.

## EncoderResfriSup02

**Tipo:** PRG · **Linguagem:** CFC · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/EncoderResfriSup02.pou.xml.v3>).

**O que faz:** Aplica a referência relativa ao encoder do duto superior 02.

**Responsabilidades observadas:**

- Chama EncoderBlocoExpert com o valor recebido e o pedido de home.
- Publica a contagem relativa sem inversão de sinal.

**Observações:** A chamada em A_PrincipalOperacao está comentada.

## F_BufferForno

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/F_BufferForno.prg.st>).

**O que faz:** Aplica ao forno a receita recebida e prepara os dados da próxima etapa.

**Responsabilidades observadas:**

- Solicita a atualização quando há troca ou reenvio de receita com forno vazio.
- Copia setpoints, percentuais, pausas, tempos e velocidades para as variáveis usadas pelo aquecimento e pela mesa do forno.
- Transfere os parâmetros posteriores para Buffer02 e atualiza nome, espessura e sinais de reenvio.

**Observações:** O código de espessura fina nesta rotina considera o valor 4; outras rotinas usam critérios diferentes. O buffer representa parâmetros, não uma fila completa de objetos de carga.

## F_MesaForno

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/F_MesaForno.prg.st>).

**O que faz:** Controla a movimentação do vidro durante carga, permanência e descarga do forno.

**Responsabilidades observadas:**

- Seleciona parâmetros por espessura e calcula limites de posição e conversões de distância para pulsos.
- Mede o comprimento usando sensores de entrada e encoder do forno e coordena a rejeição de carga fora do tamanho permitido.
- Sequencia movimentação em espera, carregamento, pausa dos roletes, oscilação, mudanças de posição/velocidade e descarga.
- Coordena portas, entrada, resfriamento, convecção e pausas térmicas por sinais compartilhados.
- Trata falta de energia, pausa, falhas, retirada forçada, comando do inversor e dados de tempo, consumo e relatório por carga.

## G_BufferResfriamento

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/G_BufferResfriamento.prg.st>).

**O que faz:** Aplica os parâmetros do forno ao resfriamento quando este pode recebê-los.

**Responsabilidades observadas:**

- Solicita atualização por troca/reenvio de receita fora do ciclo de resfriamento.
- Copia espessura, emissividade, tempos, velocidades, alturas e correções.
- Emite pedidos de ajuste de dutos e guilhotinas e atualiza a seleção de veneziana e espessura.

## G_BufferTemperaPass

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/G_BufferTemperaPass.prg.st>).

**O que faz:** Atualiza os parâmetros de ventilação associados à lógica de passagem/têmpera.

**Responsabilidades observadas:**

- Verifica troca ou reenvio de receita quando xPassandoTempera está desativado.
- Copia as três velocidades do ventilador 02 a partir do Buffer02 e reconhece a escrita.

**Observações:** A têmpera integra a mesa física de resfriamento. A rotina M_Ventilador02 tem sua chamada comentada em A_PrincipalOperacao.

## H_MesaPassagem

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/H_MesaPassagem.prg.st>).

**O que faz:** Sequencia os comandos da mesa lógica chamada Passagem durante a transferência.

**Responsabilidades observadas:**

- Seleciona velocidade, liga o avanço e aguarda os sinais de início e fim da transferência.
- Atualiza comandos de avanço, recuo e frequência de InversorMesaPass.
- Limpa a sequência no modo manual.

**Observações:** O usuário confirmou que a têmpera integra a mesa de resfriamento, portanto este nome não representa outra mesa física. O CASE ativo desvia para os estados 300/400 em pausa/falha, mas não contém os tratamentos desses estados.

## H_MesaResfriador

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/H_MesaResfriador.prg.st>).

**O que faz:** Controla a recepção, oscilação e descarga da carga no conjunto físico de têmpera/resfriamento.

**Responsabilidades observadas:**

- Seleciona parâmetros por espessura, calcula posições e converte distâncias para pulsos.
- Recebe a carga do forno, inicia o resfriamento e a troca de estágios e executa a oscilação.
- Coordena ventiladores, alturas dos dutos, veneziana e entrega para a saída.
- Trata pausa, falha, retirada antecipada, temporização do processo e comandos do inversor.
- Atualiza ocupação, tamanho da carga, contagem diária e diagnóstico do início do motor de saída.

## H1_Dutos_Oscilantes

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/H1_Dutos_Oscilantes.prg.st>).

**O que faz:** Comanda os motores de oscilação dos dutos superior e inferior 02.

**Responsabilidades observadas:**

- Habilita a oscilação com a mesa de resfriamento em operação ou por comando forçado.
- Inibe a oscilação durante movimento de altura e por três segundos após o comando local de abertura.
- Compara comando e retorno de cada motor para gerar alarme.

## I_MesaSaida

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/I_MesaSaida.prg.st>).

**O que faz:** Controla a recepção da carga resfriada e sua movimentação para retirada.

**Responsabilidades observadas:**

- Executa jog de avanço/recuo considerando o sensor de parada e os bloqueios de descarga.
- Sequencia a transferência em coordenação com a mesa de resfriamento.
- Trata pausa, falhas e reinício e escreve direção e referência de velocidade do inversor.

## J_DuctosResfriadorInf01

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/J_DuctosResfriadorInf01.prg.st>).

**O que faz:** Sequencia a referência e o ajuste de altura do duto inferior 01.

**Responsabilidades observadas:**

- Compensa a altura por offset e converte posições e tolerâncias para pulsos.
- Executa referência, ajuste por receita/estágio e abertura por chave.
- Trata pausa e falha, atualiza a altura indicada e gera pedidos de movimento e parada.

**Observações:** A chamada em A_PrincipalOperacao e os blocos MC de execução do movimento dentro desta variante estão comentados.

## J_DuctosResfriadorInf02

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/J_DuctosResfriadorInf02.prg.st>).

**O que faz:** Controla a referência e o ajuste de altura do duto inferior 02.

**Responsabilidades observadas:**

- Converte as alturas corrigidas e os limites de aproximação para coordenadas do encoder.
- Sequencia home, ajuste por receita e estágios e comando local de abertura.
- Trata pausa/falha e distribui direção, velocidade e indicação de altura.

**Observações:** A chamada em A_PrincipalOperacao está comentada.

## J_DuctosResfriadorSup01

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/J_DuctosResfriadorSup01.prg.st>).

**O que faz:** Controla a referência e o ajuste de altura do duto superior 01.

**Responsabilidades observadas:**

- Aplica offset e converte as alturas de receita para pulsos.
- Sequencia home e ajuste de posição, incluindo condições de pausa e falha.
- Escreve os comandos do inversor e converte a posição atual para indicação de altura.

**Observações:** A chamada em A_PrincipalOperacao está comentada. O trecho de sequência de abertura por chave também está comentado nesta variante.

## J_DuctosResfriadorSup02

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/J_DuctosResfriadorSup02.prg.st>).

**O que faz:** Controla a referência, a altura e a abertura local do duto superior 02.

**Responsabilidades observadas:**

- Aplica offset, converte posições e limites e executa a busca de referência.
- Ajusta a altura conforme receita e estágios, incluindo redução de velocidade na aproximação.
- Coordena a chave de abertura com a pausa da mesa de resfriamento e trata pausa/falha do eixo.
- Atualiza direção, velocidade e posição indicada.

**Observações:** É chamado em A_PrincipalOperacao quando xDuctosSup02Enable está FALSE.

## K_Guilhotina01

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/K_Guilhotina01.prg.st>).

**O que faz:** Controla a referência e a posição da guilhotina 01.

**Responsabilidades observadas:**

- Conserva o setpoint solicitado e converte posição, tolerância e distância de aproximação em pulsos.
- Executa a busca da referência e o ajuste de posição, tratando pausa e falha.
- Combina movimento automático com jog limitado pelos sensores e escreve direção e velocidade do inversor.
- Converte a contagem para a indicação de posição.

**Observações:** A chamada em A_PrincipalOperacao está comentada.

## K_Guilhotina01Inf

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/K_Guilhotina01Inf.prg.st>).

**O que faz:** Controla a variante de guilhotina 01 inferior.

**Responsabilidades observadas:**

- Conserva a posição solicitada e converte as referências para pulsos com calibração própria.
- Sequencia home e ajuste, com tratamento de pausa e falha.
- Combina os pedidos automáticos e de jog nos comandos do inversor e publica a posição atual.

**Observações:** A chamada em A_PrincipalOperacao está comentada. A existência desta variante não comprova guilhotinas independentes instaladas.

## K_Guilhotina01Sup

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/K_Guilhotina01Sup.prg.st>).

**O que faz:** Controla a variante de guilhotina 01 superior.

**Responsabilidades observadas:**

- Conserva a posição solicitada e converte as referências para pulsos com calibração própria.
- Sequencia home e ajuste, com tratamento de pausa e falha.
- Combina os pedidos automáticos e de jog nos comandos do inversor e publica a posição atual.

**Observações:** A chamada em A_PrincipalOperacao está comentada. A existência desta variante não comprova guilhotinas independentes instaladas.

## K_Guilhotina02

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/K_Guilhotina02.prg.st>).

**O que faz:** Controla a referência e a posição da guilhotina 02.

**Responsabilidades observadas:**

- Conserva o setpoint solicitado e converte posição, tolerância e distância de aproximação em pulsos.
- Executa a busca da referência e o ajuste de posição, tratando pausa e falha.
- Combina movimento automático com jog limitado pelos sensores e escreve direção e velocidade do inversor.
- Converte a contagem para a indicação de posição.

**Observações:** É chamado em A_PrincipalOperacao quando xGuilhotina02Enable está FALSE.

## L_EstagiosResfriador

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/L_EstagiosResfriador.prg.st>).

**O que faz:** Sequencia os três estágios do resfriamento.

**Responsabilidades observadas:**

- Controla os tempos de transição do primeiro para o segundo e do segundo para o terceiro estágio.
- Emite sinais de mudança de altura dos dutos e de velocidade dos ventiladores previstos.
- Encerra e limpa os estados na finalização do processo ou em modo manual.

**Observações:** O controle dos atuadores permanece nos respectivos programas; esta rotina coordena as transições.

## M_Ventilador01

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/M_Ventilador01.prg.st>).

**O que faz:** Sequencia a ventilação 01 associada à passagem/têmpera integrada ao resfriamento.

**Responsabilidades observadas:**

- Antecipadamente liga a ventilação conforme tempo restante do forno, espessura e pedidos de saída da carga.
- Coordena pedidos de veneziana, estados de velocidade, parada, pausa e falha.
- Calcula referências e atualiza o comando do motor e a referência analógica.
- Publica a condição de velocidade atingida no primeiro estágio.

**Observações:** As referências dos estágios 02 e 03 são igualadas à do estágio 01. Há uma chamada PID, mas a atribuição final de iAnaFreqRefVentilador01 usa iRefFreqVent01Pid; não se deve atribuir à saída PID o comando final sem verificar essa ligação.

## M_Ventilador02

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/M_Ventilador02.prg.st>).

**O que faz:** Sequencia a variante de ventilação 02 da passagem/têmpera.

**Responsabilidades observadas:**

- Gera início antecipado conforme espessura e tempo do forno e coordena pedidos de veneziana.
- Mantém estados de velocidade, parada, pausa e falha e sinaliza velocidade atingida.
- Gera solicitações de movimento e parada do ventilador.

**Observações:** A chamada no principal e os blocos MC que executariam movimento e parada estão comentados. As velocidades 02 e 03 são igualadas à velocidade 01.

## M_Ventilador03

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/M_Ventilador03.prg.st>).

**O que faz:** Controla a ventilação 03 do processo de resfriamento.

**Responsabilidades observadas:**

- Gera a partida antecipada e solicita o ajuste de altura dos dutos.
- Sequencia as velocidades dos estágios e trata fim do processo, espera, pausa e falha.
- Converte a referência para frequência e escreve os comandos do inversor.
- Sinaliza quando a velocidade do primeiro estágio foi atingida.

## M_Ventilador04

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/M_Ventilador04.prg.st>).

**O que faz:** Sequencia a variante de ventilação 04 do resfriamento.

**Responsabilidades observadas:**

- Gera a solicitação antecipada de partida conforme tempo do forno e espessura.
- Controla a sequência de velocidades e solicita movimento e parada conforme os estágios.
- Trata pausa, falha, finalização e indicação de velocidade atingida.

**Observações:** A chamada no principal e os blocos MC de execução do movimento e parada estão comentados.

## N_Grades

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/N_Grades.prg.st>).

**O que faz:** Gerencia o acionamento das grades de entrada e saída.

**Responsabilidades observadas:**

- Alterna os comandos pelos botões e aplica condições de desligamento durante transferências.
- Desativa a grade de entrada no carregamento/retorno e a de saída por pedido de descida, movimento da saída ou condição de emergência prevista.
- Reconhece o pedido automático de descida da grade de saída.

## N_MesaBasculante

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/N_MesaBasculante.prg.st>).

**O que faz:** Sequencia os atuadores da mesa basculante de entrada.

**Responsabilidades observadas:**

- Condiciona a sequência à grade e aos pedidos de levantar/abaixar.
- Coordena abertura e fechamento do braço e movimentos pneumáticos e hidráulicos usando sensores e temporizações.
- Publica posição e estado de avanço/recuo da mesa.

**Observações:** A chamada em A_PrincipalOperacao está comentada; a existência da rotina não confirma esse mecanismo nesta máquina.

## O_Portas

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/O_Portas.prg.st>).

**O que faz:** Combina os pedidos automáticos e de abertura forçada das portas do forno.

**Responsabilidades observadas:**

- Trata e reconhece os comandos de abertura das portas de entrada e saída.
- Combina pedidos de ciclo, força e modo manual para escrever as saídas das válvulas com a polaridade invertida prevista no código.

**Observações:** O diagnóstico dos sensores e o sequenciamento da passagem da carga estão distribuídos em outras rotinas.

## P_ComandosEventos

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/P_ComandosEventos.prg.st>).

**O que faz:** Transforma transições de sinais em indicadores de eventos para registro externo.

**Responsabilidades observadas:**

- Detecta mudanças de disjuntores, modos, botões, emergência, grades, portas e movimentos.
- Marca eventos de receita, aquecimento, testes e referência de eixos.
- Aplica uma condição temporizada de habilitação do registro e reconhece comandos auxiliares consumidos.

**Observações:** Define flags de evento; não contém armazenamento em arquivo ou banco de dados.

## Q_Conveccao

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/Q_Conveccao.prg.st>).

**O que faz:** Controla a variante de convecção por abertura e fechamento temporizado de válvula.

**Responsabilidades observadas:**

- Inicia a atuação automática por pedido do forno e limita sua duração.
- Trata o comando forçado e produz a alternância entre tempos aberta e fechada.
- Atualiza o comando da válvula e o estado usado por outras rotinas.

**Observações:** A chamada em A_PrincipalOperacao está comentada. É diferente dos programas D_ConvecVentEnt/Sai, que incluem ventilador e aquecimento.

## R_ManometroDifusor

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/R_ManometroDifusor.prg.st>).

**O que faz:** Filtra e converte duas leituras de pressão dos difusores.

**Responsabilidades observadas:**

- Calcula médias e zera valores abaixo do limiar bruto previsto.
- Converte as leituras para mbar, bar, psi, unidades de coluna de mercúrio e coluna d’água.

**Observações:** As escalas são as implementadas; a calibração física dos transmissores precisa ser confrontada com o hardware.

## R_Pressostato

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/R_Pressostato.prg.st>).

**O que faz:** Classifica e supervisiona a pressão da rede a partir de dois sinais digitais.

**Responsabilidades observadas:**

- Interpreta as combinações previstas como pressão baixa, intermediária ou alta.
- Temporiza e memoriza os alarmes de pressão, considerando a indicação de convecção na detecção de pressão baixa.
- Gera solicitação sonora durante ciclo e trata reset.

## R_PressostatoAnal

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/R_PressostatoAnal.prg.st>).

**O que faz:** Filtra e converte as leituras analógicas de pressão da rede e da máquina.

**Responsabilidades observadas:**

- Obtém a média de cada sinal bruto.
- Converte os valores para MPa, bar, psi e unidades de coluna de mercúrio e d’água.

**Observações:** O corpo realiza aquisição e conversão; não contém os alarmes digitais tratados por R_Pressostato.

## R_SensorVibracao

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/R_SensorVibracao.prg.st>).

**O que faz:** Filtra e escala dois sinais de vibração associados aos ventiladores.

**Responsabilidades observadas:**

- Calcula a média das leituras e aplica um limiar bruto para zeramento.
- Converte os valores para a escala de 0 a 25 usada pela aplicação.

**Observações:** A unidade física dessa escala não está demonstrada pelo corpo; também não há comparação de alarme nesta rotina.

## S_ElevacaoForno

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/S_ElevacaoForno.prg.st>).

**O que faz:** Trata os comandos de elevação e descida da caixa do forno.

**Responsabilidades observadas:**

- Limita o comando de subida por temporização de dez segundos e atualiza sinais de abrir/fechar.
- Combina pedidos para a bomba hidráulica e gera aviso sonoro de movimentação.
- Atualiza xBloqAbertCxFornoTemper a partir da temperatura média.

**Observações:** O sinal com nome de bloqueio térmico é calculado, mas não é aplicado aos comandos de subida/descida neste corpo; sua atuação depende de outros vínculos.

## T_Damper

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/T_Damper.prg.st>).

**O que faz:** Aplica a seleção de damper quando o resfriamento não está em ciclo.

**Responsabilidades observadas:**

- Detecta diferença entre seleção em buffer e comando atual.
- Atualiza o comando por pulso e conserva a posição lógica selecionada.

**Observações:** A chamada em A_PrincipalOperacao está comentada.

## T_VenezianaDutPass

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/T_VenezianaDutPass.prg.st>).

**O que faz:** Reconhece os comandos de abertura e fechamento da veneziana do duto.

**Responsabilidades observadas:**

- Atribui FALSE ao comando de válvula ao abrir e TRUE ao fechar.
- Limpa cada botão após consumir o pedido.

**Observações:** O corpo não executa controle contínuo de posição nem confirmação por sensor.

## T_VenezianaVentInfPass

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/T_VenezianaVentInfPass.prg.st>).

**O que faz:** Mantém uma rotina de veneziana da ventilação inferior de passagem com implementação comentada.

**Responsabilidades observadas:**

- Não executa instruções de implementação na versão analisada.

**Observações:** Há uma chamada no principal, mas o corpo está comentado.

## U_Encoder

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/U_Encoder.prg.st>).

**O que faz:** Mantém uma rotina de encoder com implementação inteiramente comentada.

**Responsabilidades observadas:**

- Não executa instruções de implementação na versão analisada.

## V_VentilacaoPainel

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/V_VentilacaoPainel.prg.st>).

**O que faz:** Controla a ventilação do painel e a ventilação dos SSRs.

**Responsabilidades observadas:**

- Combina acionamento manual com controle por temperatura usando histerese.
- Publica a temperatura do painel e reconhece o comando manual.
- Mantém a ventilação dos SSRs por dez minutos após o desligamento das resistências.

## X_LimpaResfriador02

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/02_Opera%C3%A7%C3%A3o/X_LimpaResfriador02.prg.st>).

**O que faz:** Trata os comandos e o diagnóstico de posição do mecanismo de limpeza do resfriador 02.

**Responsabilidades observadas:**

- Autoriza avanço/recuo por chave quando o resfriador está aberto e os limites permitem.
- Detecta permanência fora da posição de recolhimento com motor parado.
- Memoriza alarme, solicita sinalização sonora e trata reset.

**Observações:** A chamada em A_PrincipalOperacao está comentada; o corpo produz os sinais lógicos de movimento.

[Voltar ao catálogo](README.md)
