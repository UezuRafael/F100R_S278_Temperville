# Mapeamento de entradas e saídas

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Fronteira entre nomes funcionais e canais físicos.

## Objetos

- [A_Principal_IO](#a_principal_io) — PRG · ST
- [B_EspelhoEntradas](#b_espelhoentradas) — PRG · ST
- [C_EspelhoSaida](#c_espelhosaida) — PRG · ST

## A_Principal_IO

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/10_EntradasSaidas/A_Principal_IO.prg.st>).

**O que faz:** Seleciona o espelhamento normal das entradas e saídas.

**Responsabilidades observadas:**

- Chama B_EspelhoEntradas e C_EspelhoSaida enquanto o teste de I/O está desabilitado.

**Observações:** Durante o teste de I/O, essas duas chamadas são suspensas.

## B_EspelhoEntradas

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/10_EntradasSaidas/B_EspelhoEntradas.prg.st>).

**O que faz:** Associa canais físicos de entrada aos nomes funcionais da aplicação.

**Responsabilidades observadas:**

- Mapeia chaves, sensores, retornos, emergência, pressão e correntes dos circuitos de aquecimento.
- Atualiza simultaneamente as imagens de teste e o vetor de valores dos encoders.

**Observações:** Contém também a atribuição fixa TRUE para xInvVentilador01Habilitado; nem toda variável preenchida provém de uma leitura física.

## C_EspelhoSaida

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/10_EntradasSaidas/C_EspelhoSaida.prg.st>).

**O que faz:** Transfere os comandos lógicos para as saídas digitais mapeadas.

**Responsabilidades observadas:**

- Distribui sinalização, ventilação, válvulas, grades, portas e oscilação dos dutos.
- Combina por OR os comandos de controle e de rampa de cada setor para acionar as saídas de aquecimento.
- Define valores fixos para canais específicos ou não utilizados.

[Voltar ao catálogo](README.md)
