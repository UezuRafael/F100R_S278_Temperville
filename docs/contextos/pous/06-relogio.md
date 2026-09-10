# Relógio e programação temporal

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Leitura/ajuste do relógio, programação de aquecimento e bloqueio por data.

## Objetos

- [A_PrincipalRelogio](#a_principalrelogio) — PRG · ST
- [B_DataHora](#b_datahora) — PRG · ST
- [C_ProgramacaoHoraria](#c_programacaohoraria) — PRG · ST
- [D_ProgramacaoTempo](#d_programacaotempo) — PRG · ST

## A_PrincipalRelogio

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/06_Rel%C3%B3gio/A_PrincipalRelogio.prg.st>).

**O que faz:** Organiza as rotinas de data, hora e programação temporal.

**Responsabilidades observadas:**

- Chama B_DataHora, C_ProgramacaoHoraria e D_ProgramacaoTempo.

## B_DataHora

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/06_Rel%C3%B3gio/B_DataHora.prg.st>).

**O que faz:** Faz a interface entre o relógio do controlador e os comandos de ajuste da aplicação.

**Responsabilidades observadas:**

- Lê os campos de data e hora e os publica para uso do programa.
- Solicita atualização periódica e executa o ajuste quando o comando correspondente chega.
- Trata reconhecimento e limpeza dos comandos de ajuste.

## C_ProgramacaoHoraria

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/06_Rel%C3%B3gio/C_ProgramacaoHoraria.prg.st>).

**O que faz:** Gera o acionamento da programação de aquecimento por dia da semana.

**Responsabilidades observadas:**

- Compara dia, hora, minuto e segundo com as programações habilitadas.
- Seleciona o tempo de rampa configurado para o dia e produz o sinal de disparo.

## D_ProgramacaoTempo

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/06_Rel%C3%B3gio/D_ProgramacaoTempo.prg.st>).

**O que faz:** Gerencia um bloqueio programado por data e horário.

**Responsabilidades observadas:**

- Habilita ou desabilita a programação de bloqueio.
- Compara os campos temporais, ativa xSeguranca quando a condição coincide e trata o comando de desbloqueio.

**Observações:** O nome xSeguranca não demonstra uma função de segurança certificada. Esta rotina também não é o temporizador dos estágios de têmpera.

[Voltar ao catálogo](README.md)
