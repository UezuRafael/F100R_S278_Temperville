# Conjunto HEAT e suas ações

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Caminho de controle com FB_HeatingControl, parâmetros e autotuning. A chamada SR_Main em A_PrincipalPid está comentada. As quatro ações são partes de SR_ControleTemperatura e não entram na contagem de PRGs.

## Objetos

- [SR_Main](#sr_main) — PRG · ST
- [SR_ControleTemperatura](#sr_controletemperatura) — PRG · ST
- [_00_EntradasHc](#_00_entradashc) — Ação · ST
- [_10_Alarmes](#_10_alarmes) — Ação · ST
- [_20_Parametros](#_20_parametros) — Ação · ST
- [_30_AutoTunning](#_30_autotunning) — Ação · ST

## SR_Main

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/HEAT/00_Main/SR_Main.prg.st>).

**O que faz:** Integra o conjunto HEAT às variáveis de aquecimento do restante da aplicação.

**Responsabilidades observadas:**

- Chama SR_ControleTemperatura.
- Copia leituras para os vetores de temperaturas dos setores e distribui as saídas PWM para os vetores de SSR.

**Observações:** Sua chamada em A_PrincipalPid está comentada. O mapeamento explícito contém associações irregulares, como a leitura inferior 30 atribuída à posição 20; não foi corrigido nesta documentação.

## SR_ControleTemperatura

**Tipo:** PRG · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/HEAT/10_Temperatura/SR_ControleTemperatura.prg.st>).

**O que faz:** Coordena cem malhas de aquecimento com FB_HeatingControl e modulação PWM.

**Responsabilidades observadas:**

- Atualiza as entradas e os conjuntos de parâmetros pelas ações associadas.
- Executa controle de temperatura e autotuning por canal, disponibilizando estado, erro e saída analógica.
- Multiplica a saída pelo percentual configurado e a aplica aos blocos PWM.
- Processa os resultados do autotuning por meio de _30_AutoTunning.

**Observações:** Pertence ao caminho HEAT cuja chamada de entrada está comentada em A_PrincipalPid. Os blocos SE_CTBX.FB_HeatingControl e FB_PWM são dependências, não novos FBs definidos na pasta 00_FB.

## _00_EntradasHc

**Tipo:** Ação · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/HEAT/10_Temperatura/SR_ControleTemperatura.prg.st%5E/_00_EntradasHc.act.st>).

**O que faz:** Copia as leituras dos setores para as entradas do conjunto HEAT.

**Responsabilidades observadas:**

- Preenche I_rTemperatura1 até I_rTemperatura100 a partir das leituras inferiores e superiores.

**Observações:** Ação de SR_ControleTemperatura; não é um PRG independente.

## _10_Alarmes

**Tipo:** Ação · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/HEAT/10_Temperatura/SR_ControleTemperatura.prg.st%5E/_10_Alarmes.act.st>).

**O que faz:** Reserva uma ação de alarmes do conjunto HEAT, sem instruções ativas.

**Responsabilidades observadas:**

- Não executa tratamento de alarme no corpo analisado.

**Observações:** Ação de SR_ControleTemperatura; não é um PRG independente.

## _20_Parametros

**Tipo:** Ação · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/HEAT/10_Temperatura/SR_ControleTemperatura.prg.st%5E/_20_Parametros.act.st>).

**O que faz:** Atualiza os parâmetros padrão de PID usados pelas malhas HEAT.

**Responsabilidades observadas:**

- Copia P_stPid de cada canal para stParameterSetsPID quando a condição de habilitação é satisfeita.

**Observações:** Ação de SR_ControleTemperatura. Há índices divergentes: o parâmetro 30 é escrito na posição 20 e o 90 na posição 80. Diversas condições usam a habilitação inferior também nos canais superiores.

## _30_AutoTunning

**Tipo:** Ação · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/04_PID/HEAT/10_Temperatura/SR_ControleTemperatura.prg.st%5E/_30_AutoTunning.act.st>).

**O que faz:** Seleciona e conserva o conjunto de parâmetros obtido pelo autotuning de cada malha HEAT.

**Responsabilidades observadas:**

- Escolhe stMedium, stSlow ou stOffensive conforme o status 2, 3 ou 4.
- Copia o conjunto escolhido para os parâmetros padrão e encerra o comando de autotuning.
- Também desativa o autotuning quando o controle informa erro.

**Observações:** Ação de SR_ControleTemperatura. O ensaio de autotuning é executado pelo FB de biblioteca; esta ação trata seus resultados.

[Voltar ao catálogo](README.md)
