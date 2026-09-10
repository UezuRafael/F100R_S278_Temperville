# Testes e diagnóstico de parada

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Testes de resistências, I/O e nobreak, além da causa da última parada. A documentação foi produzida por leitura dos arquivos; os testes não foram executados.

## Objetos

- [A_PrincipalTeste](#a_principalteste) — PRG · ST
- [B_TesteResistencias](#b_testeresistencias) — PRG · ST
- [C_Teste_Entradas_Saidas](#c_teste_entradas_saidas) — PRG · ST
- [D_Teste_Nobreak](#d_teste_nobreak) — PRG · ST
- [TesteSTOP](#testestop) — PRG · ST

## A_PrincipalTeste

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/08_Testes/A_PrincipalTeste.prg.st>).

**O que faz:** Seleciona e chama as rotinas de teste e diagnóstico de parada.

**Responsabilidades observadas:**

- Executa o teste de resistências e o teste de entradas/saídas quando seus modos estão habilitados.
- Atualiza a seleção automático/manual do teste de resistências e chama o teste do nobreak e a leitura da última parada.

## B_TesteResistencias

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/08_Testes/B_TesteResistencias.prg.st>).

**O que faz:** Executa a verificação automática ou o acionamento manual dos circuitos de aquecimento.

**Responsabilidades observadas:**

- Sequencia o acionamento dos setores inferiores e superiores, mede corrente e registra aprovação ou falha.
- Identifica as fases associadas às correntes medidas e trata início, fim, reset e aborto do teste.
- No modo manual, gerencia o acionamento forçado e os alarmes temporizados de ausência de retorno ou falha.

## C_Teste_Entradas_Saidas

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/08_Testes/C_Teste_Entradas_Saidas.prg.st>).

**O que faz:** Oferece a imagem das entradas e aplica os comandos de teste às saídas físicas.

**Responsabilidades observadas:**

- Copia entradas digitais e valores de encoder para os vetores de teste.
- Transfere ForceTesteSaidas para os canais digitais mapeados.

**Observações:** As atribuições escrevem nas saídas físicas quando esta rotina é executada; não se trata de uma simulação.

## D_Teste_Nobreak

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/08_Testes/D_Teste_Nobreak.prg.st>).

**O que faz:** Acompanha um teste de sustentação da máquina pelo nobreak.

**Responsabilidades observadas:**

- Reabre a necessidade de teste conforme dia da semana e estado do nobreak.
- Verifica a operação manual das quatro mesas durante falta de energia e conta sessenta segundos.
- Registra aprovação e tempo restante quando as condições se mantêm.

**Observações:** O corpo verifica as condições do teste; não realiza automaticamente o corte da rede elétrica.

## TesteSTOP

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/08_Testes/TesteSTOP.prg.st>).

**O que faz:** Disponibiliza o motivo da última parada do controlador.

**Responsabilidades observadas:**

- Copia PLC_R.i_wLastStopCause para wLastStopCause.

**Observações:** Não comanda STOP; apenas lê a causa registrada.

[Voltar ao catálogo](README.md)
