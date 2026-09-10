# Diagnóstico e apresentação

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Consolidação de alarmes, imagens, estados e acompanhamento geral.

## Objetos

- [A_PrincipalGeral](#a_principalgeral) — PRG · ST
- [B_Imagens](#b_imagens) — PRG · ST
- [C_Alarmes](#c_alarmes) — PRG · ST
- [D_AnimaGeralResistencias](#d_animageralresistencias) — PRG · ST
- [E_AnimaTesteGeralResistencias](#e_animatestegeralresistencias) — PRG · ST
- [F_AnimaAlmMotValv](#f_animaalmmotvalv) — PRG · ST
- [F_MensagemErroMotor](#f_mensagemerromotor) — PRG · ST
- [F_SerialNumber](#f_serialnumber) — PRG · ST
- [O_VelocidadesMotores](#o_velocidadesmotores) — PRG · ST
- [P_StatusOnline](#p_statusonline) — PRG · ST
- [Q_MonitoraEncoder](#q_monitoraencoder) — PRG · ST
- [R_MonitoraMotores](#r_monitoramotores) — PRG · ST
- [S_Termocamera](#s_termocamera) — PRG · ST

## A_PrincipalGeral

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/A_PrincipalGeral.prg.st>).

**O que faz:** Organiza a execução das rotinas gerais de diagnóstico e apresentação.

**Responsabilidades observadas:**

- Chama a consolidação de alarmes, imagens e animações.
- Chama a leitura de identificação, cálculo de velocidades, estados para o supervisório e monitoramento de encoders e motores.

## B_Imagens

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/B_Imagens.prg.st>).

**O que faz:** Reúne sinais de campo e de controle em conjuntos usados na representação visual da máquina.

**Responsabilidades observadas:**

- Preenche imagens de motores, válvulas, resistências e SSRs.
- Disponibiliza estados gerais e habilitações para outras rotinas e para o supervisório.

## C_Alarmes

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/C_Alarmes.prg.st>).

**O que faz:** Consolida alarmes da aplicação e comanda a sinalização geral.

**Responsabilidades observadas:**

- Agrupa falhas térmicas, de motores, válvulas, grades e condições gerais.
- Trata o reconhecimento e o pulso de reset, incluindo comandos de reset de acionamentos.
- Define sinalização luminosa e acústica conforme emergência, falhas e estado do ciclo.

**Observações:** Combina diagnóstico, reconhecimento de falhas e sinalização; não é apenas uma lista de alarmes.

## D_AnimaGeralResistencias

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/D_AnimaGeralResistencias.prg.st>).

**O que faz:** Converte os estados dos setores de aquecimento em códigos de apresentação.

**Responsabilidades observadas:**

- Distingue setor desabilitado, desligado, ligado, com falha e com falha de termopar.
- Representa também o acionamento forçado com retorno de corrente.

**Observações:** Os IFs sucessivos estabelecem a prioridade do código exibido.

## E_AnimaTesteGeralResistencias

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/E_AnimaTesteGeralResistencias.prg.st>).

**O que faz:** Prepara os estados visuais dos setores durante o teste de resistências.

**Responsabilidades observadas:**

- Converte habilitação, acionamento forçado e teste em andamento em códigos.
- Indica o resultado de aprovação ou falha de cada circuito testado.

## F_AnimaAlmMotValv

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/F_AnimaAlmMotValv.prg.st>).

**O que faz:** Prepara os códigos de apresentação de motores e válvulas.

**Responsabilidades observadas:**

- Percorre os equipamentos previstos e classifica desligado/fechado, ligado/aberto ou em alarme.
- Disponibiliza os códigos de animação ao supervisório.

## F_MensagemErroMotor

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/F_MensagemErroMotor.prg.st>).

**O que faz:** Traduz códigos conhecidos de falha dos acionamentos em textos curtos.

**Responsabilidades observadas:**

- Percorre os códigos de erro de vinte motores.
- Associa valores previstos a mensagens como OLF e OCF.

**Observações:** A tabela é fixa; o corpo não garante uma mensagem específica nem a limpeza da mensagem para todo código não reconhecido.

## F_SerialNumber

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/F_SerialNumber.prg.st>).

**O que faz:** Publica dados de identificação e manutenção do controlador.

**Responsabilidades observadas:**

- Copia o número de série e a identificação do produto.
- Copia o estado da bateria para variáveis da aplicação.

## O_VelocidadesMotores

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/O_VelocidadesMotores.prg.st>).

**O que faz:** Calcula referências de velocidade relacionadas à espessura e à calibração das mesas.

**Responsabilidades observadas:**

- Interpola referências para vidro fino e grosso a partir dos parâmetros configurados.
- Aplica relações e correções entre entrada, forno, resfriamento e saída.

**Observações:** O programa calcula referências; não contém toda a transmissão dos comandos aos motores. Há saídas de blocos de seleção não conectadas nas chamadas.

## P_StatusOnline

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/P_StatusOnline.prg.st>).

**O que faz:** Codifica os estados de operação para acompanhamento pelo supervisório.

**Responsabilidades observadas:**

- Representa espera, ciclo, finalização, carga, oscilação, descarga e rejeição conforme os estados internos.
- Representa também ajuste e referência dos dutos e das guilhotinas.

**Observações:** Alguns estados têm implementação parcial ou comentada; o status da mesa de entrada é atribuído a zero no trecho ativo.

## Q_MonitoraEncoder

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/Q_MonitoraEncoder.prg.st>).

**O que faz:** Instancia a supervisão de movimento dos encoders usados nesta configuração.

**Responsabilidades observadas:**

- Monitora forno, resfriamento, duto superior 02 e guilhotina 02.
- Habilita cada diagnóstico conforme a condição de movimento e usa tempos de detecção específicos.

## R_MonitoraMotores

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/R_MonitoraMotores.prg.st>).

**O que faz:** Detecta parada inesperada dos movimentos do forno e do resfriamento.

**Responsabilidades observadas:**

- Combina condições de comando, disponibilidade do motor e acompanhamento do encoder.
- Considera exceções de pausa e operação e disponibiliza alarme e indicação piscante.

## S_Termocamera

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/03_Geral/S_Termocamera.prg.st>).

**O que faz:** Filtra e calcula relações numéricas a partir de um valor bruto associado à termocâmera.

**Responsabilidades observadas:**

- Calcula uma média do valor recebido.
- Calcula razões entre esse valor e 32767.

**Observações:** Não há processamento de imagem térmica nem conversão demonstrada para uma temperatura física.

[Voltar ao catálogo](README.md)
