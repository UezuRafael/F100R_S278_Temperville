# Integração dos acionamentos

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Publicação de estados e distribuição de referências e resets aos inversores.

## Objetos

- [A_PirncipalRede](#a_pirncipalrede) — PRG · ST
- [O_Motores](#o_motores) — PRG · ST

## A_PirncipalRede

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/09_RedeCanOpen/A_PirncipalRede.prg.st>).

**O que faz:** Chama a rotina de integração dos acionamentos.

**Responsabilidades observadas:**

- Executa O_Motores.

## O_Motores

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/09_RedeCanOpen/O_Motores.prg.st>).

**O que faz:** Integra os estados dos inversores às variáveis de operação da máquina.

**Responsabilidades observadas:**

- Copia falha, operação, corrente e frequência de mesas, dutos, guilhotinas, ventiladores e convecção.
- Distribui pedidos de reset e acompanha falhas de comunicação dos acionamentos previstos.
- Atualiza referências de velocidade SP5 conforme calibrações selecionadas e ajustes dos eixos.

[Voltar ao catálogo](README.md)
