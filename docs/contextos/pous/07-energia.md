# Medição e supervisão de energia

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Grandezas elétricas, composição dos acumulados, comandos ao medidor e diagnóstico da alimentação.

## Objetos

- [A_PrincipalEnergia](#a_principalenergia) — PRG · ST
- [C_ComposicaoFatura](#c_composicaofatura) — PRG · ST
- [D_ZeramentoMedidor](#d_zeramentomedidor) — PRG · ST
- [E_Nobreak](#e_nobreak) — PRG · ST
- [Energia](#energia) — PRG · ST
- [F_FaltaFase](#f_faltafase) — PRG · ST
- [G_Disjuntores](#g_disjuntores) — PRG · ST
- [H_CircuitoCC](#h_circuitocc) — PRG · ST
- [PM5300](#pm5300) — PRG · ST
- [TesteEnergia](#testeenergia) — PRG · ST

## A_PrincipalEnergia

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/A_PrincipalEnergia.prg.st>).

**O que faz:** Organiza a leitura, o tratamento e os diagnósticos de energia.

**Responsabilidades observadas:**

- Chama processamento do medidor, composição de consumo e zeramento.
- Chama supervisão de nobreak, fases, disjuntores e circuito CC.

## C_ComposicaoFatura

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/C_ComposicaoFatura.prg.st>).

**O que faz:** Separa e acumula consumo e demanda segundo horários e períodos de leitura.

**Responsabilidades observadas:**

- Controla intervalos de ponta e fora de ponta e calcula diferenças de consumo e máximos de demanda.
- Trata fechamento por dia de leitura, publicação dos acumulados e pedidos de zeramento.
- Gera condições de registro diário e atualização das referências de consumo.

**Observações:** Organiza grandezas para faturamento; não foi identificado aqui um cálculo completo de valor monetário da fatura.

## D_ZeramentoMedidor

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/D_ZeramentoMedidor.prg.st>).

**O que faz:** Sequencia os comandos de zeramento do medidor e dos acumuladores internos.

**Responsabilidades observadas:**

- Emite códigos de reset em etapas e comanda a transmissão correspondente.
- Limpa referências, acumulados e estados relacionados ao período de medição.

## E_Nobreak

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/E_Nobreak.prg.st>).

**O que faz:** Supervisiona a indicação de funcionamento do nobreak.

**Responsabilidades observadas:**

- Espelha o estado recebido e temporiza a confirmação da falha.
- Memoriza o alarme, solicita sinalização sonora e trata o reconhecimento.

## Energia

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/Energia.prg.st>).

**O que faz:** Publica grandezas elétricas e de consumo usadas pela aplicação.

**Responsabilidades observadas:**

- Copia e normaliza energias ativa, reativa e aparente.
- Disponibiliza tensões, correntes, potências, fator de potência, frequência, demanda e outros indicadores do medidor.

**Observações:** Os valores dependem do mapeamento e das conversões de aquisição; esta rotina não verifica a exatidão física da medição.

## F_FaltaFase

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/F_FaltaFase.prg.st>).

**O que faz:** Detecta condição de tensão insuficiente nas fases monitoradas.

**Responsabilidades observadas:**

- Compara as três tensões fase-neutro com o limite de 190.
- Temporiza a condição por um segundo e atualiza os sinais de energia disponível e de falha.
- Solicita sinalização de alarme quando aplicável.

## G_Disjuntores

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/G_Disjuntores.prg.st>).

**O que faz:** Supervisiona os retornos dos disjuntores geral e de aquecimento.

**Responsabilidades observadas:**

- Verifica o retorno do disjuntor geral e o dos circuitos de resistência quando há solicitação de aquecimento.
- Temporiza e memoriza falhas, solicita sinalização e trata reset.

## H_CircuitoCC

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/H_CircuitoCC.prg.st>).

**O que faz:** Interpreta as chaves do circuito de corrente contínua.

**Responsabilidades observadas:**

- Combina as duas indicações de chave.
- Gera aviso de posição conforme a condição de espera da máquina.

## PM5300

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/PM5300.prg.st>).

**O que faz:** Converte o conteúdo dos registradores do medidor para os tipos usados no programa.

**Responsabilidades observadas:**

- Transfere WORDs recebidas para variáveis de representação sobreposta.
- Converte acumuladores inteiros e valores de ponto flutuante, inclusive registros de máximos.

**Observações:** O corpo trata os dados recebidos; não implementa por si só as transações de rede com o medidor.

## TesteEnergia

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/07_Energia/TesteEnergia.prg.st>).

**O que faz:** Simula a evolução de grandezas e acumuladores de energia.

**Responsabilidades observadas:**

- Usa contagem temporal para variar consumos simulados.
- Trata seleção de ponta/fora de ponta, demanda máxima e zeramento dos acumuladores.

**Observações:** A chamada em A_PrincipalEnergia está comentada; não deve ser confundido com a aquisição real do PM5300.

[Voltar ao catálogo](README.md)
