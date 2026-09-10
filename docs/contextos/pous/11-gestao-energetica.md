# Gestão dos acumulados de energia

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Contabilização por condição de funcionamento e mudança de período.

## Objetos

- [A_PricipalGestao](#a_pricipalgestao) — PRG · ST
- [B_Acumuladores](#b_acumuladores) — PRG · ST
- [C_GerenciadorDatas](#c_gerenciadordatas) — PRG · ST

## A_PricipalGestao

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/11_GestaoEnergetica/A_PricipalGestao.prg.st>).

**O que faz:** Organiza a contabilização de energia por condição de funcionamento e por data.

**Responsabilidades observadas:**

- Chama B_Acumuladores e C_GerenciadorDatas.

## B_Acumuladores

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/11_GestaoEnergetica/B_Acumuladores.prg.st>).

**O que faz:** Atualiza acumuladores de consumo associados aos estados da máquina.

**Responsabilidades observadas:**

- Calcula diferenças a partir da referência do medidor.
- Atualiza buffers diários de aquecimento, desligado, espera, trabalho e teste conforme os sinais de estado.

**Observações:** As condições são IFs independentes; não se deve presumir exclusividade entre categorias nem exatidão contábil sem validar sua evolução.

## C_GerenciadorDatas

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/11_GestaoEnergetica/C_GerenciadorDatas.prg.st>).

**O que faz:** Trata a troca de dia e de mês para os acumuladores de energia.

**Responsabilidades observadas:**

- Transfere e reinicia buffers e referências quando detecta mudança de período.
- Gera comandos de zeramento e a solicitação bGravaBancoE3.

**Observações:** Solicita gravação ao E3 por sinal; não contém a implementação de acesso ao banco de dados.

[Voltar ao catálogo](README.md)
