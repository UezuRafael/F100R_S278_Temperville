# Aquisição e diagnóstico térmico

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Termopares, habilitação e diagnóstico dos circuitos, associação de canais e pirômetros.

## Objetos

- [A_PincipalTemperatura](#a_pincipaltemperatura) — PRG · ST
- [B_Termopares](#b_termopares) — PRG · ST
- [C_HabDesabResistencias](#c_habdesabresistencias) — PRG · ST
- [D_Resistencias](#d_resistencias) — PRG · ST
- [E_RelesEstadoSolido](#e_relesestadosolido) — PRG · ST
- [F_PosicaoTermopares](#f_posicaotermopares) — PRG · ST
- [G_CircuitoResistencia](#g_circuitoresistencia) — PRG · ST
- [H_Pirometro](#h_pirometro) — PRG · ST

## A_PincipalTemperatura

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/05_TEMPERATURA/A_PincipalTemperatura.prg.st>).

**O que faz:** Organiza a aquisição e os diagnósticos dos circuitos de temperatura.

**Responsabilidades observadas:**

- Chama leitura de termopares, habilitação de resistências, diagnóstico de resistências e SSRs.
- Chama associação de termopares, atualização de retornos e processamento de pirômetros.

## B_Termopares

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/05_TEMPERATURA/B_Termopares.prg.st>).

**O que faz:** Adquire, organiza e supervisiona os sinais de termopares.

**Responsabilidades observadas:**

- Interpreta diagnósticos de módulos e distribui canais físicos aos vetores de temperatura.
- Detecta termopares abertos e temperatura acima do limite e consolida alarmes.
- Calcula médias inferiores, superiores e gerais e trata canais de convecção.

**Observações:** O mapeamento é específico desta configuração; a sequência dos canais não deve ser presumida a partir da posição física.

## C_HabDesabResistencias

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/05_TEMPERATURA/C_HabDesabResistencias.prg.st>).

**O que faz:** Gerencia a habilitação dos setores de aquecimento.

**Responsabilidades observadas:**

- Trata comandos individuais e gerais de habilitar ou desabilitar.
- Desabilita setores por condições de alarme e trata reabilitação por comandos previstos.
- Atualiza as condições de temperatura média elevada e limpa os comandos consumidos.

## D_Resistencias

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/05_TEMPERATURA/D_Resistencias.prg.st>).

**O que faz:** Diagnostica ruptura dos circuitos de resistência.

**Responsabilidades observadas:**

- Executa os blocos de alarme de resistência para os setores inferiores e superiores.
- Consolida os resultados nos vetores e sinais de alarme.

**Observações:** Esta rotina diagnostica os circuitos; o cálculo e o comando de aquecimento ficam em outros programas.

## E_RelesEstadoSolido

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/05_TEMPERATURA/E_RelesEstadoSolido.prg.st>).

**O que faz:** Diagnostica inconsistências entre o comando de aquecimento e o retorno dos circuitos.

**Responsabilidades observadas:**

- Compara o comando do SSR ou da rampa com retorno de corrente e indicação de ruptura.
- Executa diagnósticos por setor inferior e superior e consolida os alarmes de SSR.

## F_PosicaoTermopares

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/05_TEMPERATURA/F_PosicaoTermopares.prg.st>).

**O que faz:** Associa cada setor lógico de aquecimento ao termopar físico configurado.

**Responsabilidades observadas:**

- Percorre a tabela PosicaoTermoparSetor.
- Copia temperatura e diagnóstico de circuito aberto para o setor correspondente.

## G_CircuitoResistencia

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/05_TEMPERATURA/G_CircuitoResistencia.prg.st>).

**O que faz:** Atualiza os estados dos circuitos de resistência com os retornos dos SSRs.

**Responsabilidades observadas:**

- Copia os retornos inferiores para os estados das resistências inferiores.
- Faz a mesma cópia para os setores superiores.

**Observações:** Apesar do nome, o corpo ativo é somente esse espelhamento.

## H_Pirometro

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/05_TEMPERATURA/H_Pirometro.prg.st>).

**O que faz:** Processa os pirômetros e uma lógica específica de rampa térmica.

**Responsabilidades observadas:**

- Escala duas leituras de pirômetro dividindo os valores recebidos por dez.
- Após condição de forno carregado e temporização, acompanha a temperatura do canal superior 24 e calcula a evolução da rampa.
- Atualiza variáveis e saída de aquecimento associadas à rampa identificada como 74.

**Observações:** Reúne aquisição de pirômetros e controle particular de um setor; a intenção física dessa segunda função precisa ser confirmada.

[Voltar ao catálogo](README.md)
