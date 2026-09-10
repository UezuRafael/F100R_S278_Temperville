# Índice de contexto e continuidade do estudo

Este diretório concentra o conhecimento produzido sobre a aplicação **F100R S278 Temperville**. Use este arquivo como ponto de entrada ao iniciar um novo chat ou uma nova etapa da análise. A revisão consolidada é de **06/09/2026**.

## Contexto mínimo

- **Ambiente:** EcoStruxure Machine Expert Logic Builder 2.6.
- **Domínio:** automação de um forno de têmpera de vidros controlado por PLC.
- **Linguagens:** majoritariamente Structured Text, com partes em CFC, conforme IEC 61131-3.
- **Objetivo do estudo:** compreender e registrar o comportamento existente antes de propor uma reconstrução com processos e limites de software mais claros.
- **Forma atual do código:** coordenação cíclica, muitos estados implementados com `CASE`, compartilhamento amplo por GVLs e variantes habilitadas por vetores, condições e trechos comentados.
- **Regra central:** os agrupamentos documentais são uma classificação analítica. Eles ainda não são módulos encapsulados nem classes existentes no programa.

## Ordem de leitura para um novo chat

1. Leia [o estado consolidado e as regras de continuidade](02-estado-do-estudo.md).
2. Leia [os módulos físicos e as responsabilidades funcionais](00-modulos-responsabilidades.md).
3. Use [o diagrama geral de pertencimento e dependências](01-dependencias-geral.md) para entender a estrutura real do código.
4. Consulte [o catálogo de FCs, FBs e PRGs](pous/README.md) quando a análise envolver um objeto específico.
5. Abra o [visualizador interativo](../diagramas/02-dependencias-geral.html) para navegar pelas relações diretas e pelas evidências.

Essa ordem separa três perguntas diferentes:

| Pergunta | Artefato principal |
| --- | --- |
| O que existe fisicamente e qual é a responsabilidade de cada parte? | `00-modulos-responsabilidades.md` e diagrama 01 |
| Onde cada objeto está e de quais objetos ou dados ele depende? | `01-dependencias-geral.md` e diagrama 02 |
| O que uma FC, FB ou PRG faz internamente? | Catálogo em `pous/` |

## Decisões já estabelecidas

1. **Passagem/têmpera pertence ao módulo físico de resfriamento.** Nesta máquina ela não é uma mesa física independente. Os programas `H_MesaPassagem` e `H_MesaResfriador` permanecem separados no código, mas ambos são estudados dentro de M03.
2. **PlantUML é a fonte editável dos mapas.** O desenho é semelhante a um diagrama de classes apenas como recurso de organização visual; a aplicação não segue um modelo orientado a objetos que permita classificá-la assim com rigor.
3. **O diagrama 01 é funcional e físico.** Suas setas azuis mostram o percurso da carga e as tracejadas mostram relações agregadas.
4. **O diagrama 02 é estrutural e estático.** Sua seta vai do dependente para a dependência. Ele registra chamadas, tipos, GVLs, tarefas e evidências encontradas nos arquivos.
5. **Presença no código não comprova uso na máquina.** Uma rotina pode estar condicionada, comentada, sem corpo ativo ou associada a uma variante não instalada.
6. **O código da aplicação permaneceu inalterado.** O trabalho realizado até esta revisão está restrito a `docs/` e aos arquivos reproduzíveis de geração.

## Cobertura atual

| Item | Quantidade |
| --- | ---: |
| PRGs | 121 |
| FBs | 44 |
| FC funcional | 1 |
| FCs implícitas de verificação | 8 |
| Ações | 4 |
| Tarefas | 5 |
| GVLs | 23 |
| Lista persistente | 1 |
| DUT | 1 |
| Objetos representados no diagrama geral | 208 |
| Relações estruturais representadas | 730 |

As **174 POUs** são 121 PRGs, 44 FBs e 9 FCs. As quatro ações pertencem a `SR_ControleTemperatura` e não são PRGs adicionais.

## Fontes de verdade

Use a seguinte precedência quando houver divergência:

1. Os arquivos da aplicação sob `MyController.device.xml.v3^` são a evidência do código existente.
2. Informações físicas confirmadas pelo usuário são registradas em `00-modulos-responsabilidades.md`.
3. O catálogo em `pous/` interpreta cada POU por leitura estática e aponta para seu arquivo de origem.
4. `02-dependencias-geral.json` contém o inventário e as evidências estruturadas usados pelo diagrama 02.
5. Os SVGs, PNGs e o HTML são visualizações geradas. Suas fontes são os arquivos PlantUML, o JSON e o template em `docs/ferramentas/`.

Uma inferência deve continuar marcada como **A confirmar** enquanto não houver código suficiente, confirmação física ou validação online que a sustente.

## Artefatos existentes

- [Mapa funcional em PlantUML](../diagramas/01-modulos-responsabilidades.puml), com [SVG](../diagramas/01-modulos-responsabilidades.svg) e [PNG](../diagramas/01-modulos-responsabilidades.png).
- [Diagrama estrutural interativo](../diagramas/02-dependencias-geral.html), com [PlantUML](../diagramas/02-dependencias-geral.puml), [SVG](../diagramas/02-dependencias-geral.svg) e [JSON](../diagramas/02-dependencias-geral.json).
- [Ferramentas de reprodução](../ferramentas/README.md), todas armazenadas no projeto. A geração não depende de cópias em `%APPDATA%` ou `%TEMP%`.

## Regra para continuar o estudo

Ao acrescentar uma interpretação, registre se ela vem de **Código**, **Relato** ou se está **A confirmar**. Preserve os nomes originais dos POUs, inclusive erros de grafia. Não transforme o mapa funcional em afirmação de encapsulamento e não transforme uma relação estática em garantia de execução. Atualize primeiro o contexto textual e a fonte PlantUML ou JSON correspondente; depois regenere e verifique as visualizações.

[Voltar à documentação](../README.md)
