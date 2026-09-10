# Estado consolidado do estudo

Projeto **F100R S278 Temperville**. Estado registrado em **06/09/2026** para permitir a continuidade da análise em outros chats.

## Objetivo original

O trabalho atual é uma etapa de arqueologia de software. Primeiro se documenta o funcionamento físico, o comportamento das POUs, a localização dos dados e as dependências reais. A reconstrução futura deverá usar esse conhecimento para definir requisitos, limites de módulos, interfaces, testes e um processo de desenvolvimento mais controlado. Nenhum desenho atual deve ser tratado como a arquitetura final da nova aplicação.

## Trabalho concluído

### 1. Mapa funcional da máquina

O diagrama `01-modulos-responsabilidades` organiza o sistema em seis áreas físicas e oito responsabilidades compartilhadas:

- M01 Entrada;
- M02 Aquecimento;
- M03 Resfriamento, incluindo passagem/têmpera;
- M04 Saída;
- M05 Mesa de controle e supervisório;
- M06 Painel elétrico e interface com os dispositivos de campo;
- T01–T08 para coordenação, receitas, alarmes, energia, relógio, testes, I/O/comunicação e recursos comuns.

As setas entre M01, M02, M03 e M04 representam o percurso físico da carga. As demais setas são relações funcionais agregadas. Esse mapa responde **qual responsabilidade pertence a qual parte do sistema**, sem tentar reproduzir cada chamada de programa.

### 2. Catálogo das POUs

Todas as 174 POUs locais receberam uma descrição de finalidade, responsabilidades observadas, observações e link para o código. O catálogo cobre 121 PRGs, 44 FBs e 9 FCs, sendo 8 FCs de verificação implícita. Quatro ações de `SR_ControleTemperatura` também foram documentadas.

Os capítulos seguem as pastas atuais da aplicação. Essa organização registra onde o código está hoje; não recomenda manter as mesmas pastas na reconstrução.

### 3. Grafo geral de dependências

O diagrama 02 reúne 208 objetos: POUs, ações, tarefas, GVLs, lista persistente e DUT. Foram representadas 730 relações. A direção é **dependente → dependência**.

As relações se dividem em chamadas ativas, instâncias de FB, referências a dados globais, declarações de tipos locais, chamadas comentadas e vínculos entre tarefas e programas. O JSON preserva as evidências encontradas, inclusive nomes de variáveis, instâncias, expressões CFC e posições nas implementações ST.

O grafo é uma análise estática. Ele não determina automaticamente leitura versus escrita de uma variável global, frequência real de um caminho condicionado, comunicação externa, aliases por endereço, chamadas internas de bibliotecas ou comportamento online do PLC.

### 4. Visualizador do diagrama 02

O HTML funciona localmente no Edge e no Chrome e contém o SVG e os dados necessários. Ele oferece:

- busca por nome, tipo ou área;
- lista de opções que reabre mesmo quando já existe um bloco selecionado;
- localização de uma área do projeto;
- zoom e deslocamento;
- filtros por tipo de relação;
- painel com descrição, responsabilidades e evidências;
- modos com todas as linhas, sem linhas ou foco no bloco;
- foco que conserva somente o componente, seus vizinhos diretos e as respectivas relações;
- identificação visível da área do componente em foco;
- linhas em faixas distintas para reduzir ambiguidades visuais.

O arquivo que deve ser aberto é `docs/diagramas/02-dependencias-geral.html`. `docs/ferramentas/visualizador-template.html` é apenas o modelo usado pela geração.

### 5. Reprodução

Geradores, template e PlantUML estão em `docs/ferramentas/`. Arquivos intermediários são recriados em `docs/.geracao/` e ignorados pelo controle de versão. A geração completa parte da raiz do projeto:

```powershell
& .\docs\ferramentas\gerar-diagramas.ps1
```

Ela extrai o grafo, resolve relações, gera PlantUML e JSON, renderiza, reorganiza o SVG, monta o HTML e executa verificações estruturais. Não usa arquivos de trabalho em `%APPDATA%`.

## Revisão de coerência do diagrama 01

O mapa 01 foi comparado com o catálogo das POUs e com o grafo de dependências. Ele está coerente **no seu nível de abstração funcional**, com os seguintes cuidados:

| Elemento | Resultado da revisão |
| --- | --- |
| M01 Entrada | Coerente com `D_SensoresEntrada`, `E_MesaEntrada`, medição da carga e coordenação com o forno. |
| M02 Aquecimento | Coerente com a mesa do forno, portas, elevação, resistências, termopares, rampa e convecção. A proteção térmica independente continua identificada como relato externo ao PLC. |
| M03 Resfriamento | Coerente após a confirmação de que passagem/têmpera integra a mesma mesa física. Os três estágios indicados são estágios do processo, não três módulos físicos obrigatórios. |
| M04 Saída | Coerente com `I_MesaSaida` e a grade de saída. |
| M05 Controle/supervisório | Coerente como contexto físico e interface externa. A divisão exata de responsabilidades entre PLC e supervisório ainda depende do estudo da aplicação supervisória. |
| M06 Painel/campo | Coerente como fronteira simplificada. PLC, remotas e acionamentos podem estar no painel; sensores e atuadores estão distribuídos pela máquina. |
| T01–T08 | Coerentes como responsabilidades transversais. Não representam serviços isolados nem proprietários exclusivos dos dados. |
| Setas | Coerentes: azuis para percurso da carga; tracejadas para relações macro. Dependências individuais pertencem ao diagrama 02. |

Foram ajustadas no próprio mapa as duas formulações com maior risco de interpretação incorreta: os três estágios de M03 passaram a ser chamados explicitamente de **estágios de processo**, e M06 passou a distinguir equipamentos do painel dos sensores e atuadores distribuídos. A legenda também aponta diretamente para o diagrama 02 quando forem necessárias dependências entre objetos.

## Características arquiteturais observadas

- O programa coordena o processo por varredura cíclica, condições e máquinas de estados com `CASE`.
- Muitos programas compartilham comandos, estados e parâmetros por GVLs.
- Há mais de uma tarefa com intervalos e prioridades diferentes; a presença de uma chamada no código não descreve sozinha a ordem temporal global.
- Existem variantes ativas, condicionais, comentadas e implementações inteiramente comentadas no mesmo projeto.
- Escalabilidade aparece principalmente em vetores e quantidades configuradas, especialmente para setores térmicos. Outras variantes dependem de chamadas ou trechos comentados.
- Nomes de pastas e prefixos ajudam a localizar objetos, mas não garantem fronteiras de domínio ou execução.

Essas características devem orientar a reconstrução futura, mas ainda não constituem uma lista de defeitos nem uma proposta de solução.

## Fatos confirmados e pendências

O principal fato físico confirmado durante o estudo é que **passagem/têmpera e resfriamento usam o mesmo módulo de mesa**. Permanecem pendentes a correspondência exata dos acionamentos dessa mesa, ventiladores instalados, associação dos dutos e guilhotinas 01/02, variantes presentes, semântica física de carga, fronteira do supervisório e significado do percentual chamado de potência.

A lista detalhada e numerada está em [Módulos e responsabilidades](00-modulos-responsabilidades.md#dúvidas-para-a-próxima-revisão). Novos fatos devem ser registrados ali antes de alterar o mapa.

## Próxima direção recomendada

O próximo estudo pode escolher um módulo físico por vez e produzir uma visão que una: sequência de estados, entradas, saídas, parâmetros, alarmes, intertravamentos, POUs envolvidas e dados globais. M03 tende a exigir atenção primeiro porque concentra passagem/têmpera, resfriamento, dutos, guilhotinas e ventiladores cuja correspondência física ainda não está totalmente estabelecida.

Antes da reconstrução, ainda serão necessários ao menos: requisitos funcionais, modelo de estados do processo, matriz de I/O, contratos entre módulos, estratégia de falhas e segurança, persistência de receitas, concorrência entre tarefas e testes de aceitação.

[Índice de contexto](README.md) · [Documentação principal](../README.md)
