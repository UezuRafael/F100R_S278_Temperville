# Funções implícitas de verificação

[Voltar ao catálogo](README.md) · [Contexto geral](../00-modulos-responsabilidades.md)

Revisão: **05/09/2026**. Base: leitura estática da configuração F100R S278 Temperville.

Funções de verificação presentes na aplicação, separadas da FC funcional Valor_Float. As descrições correspondem ao corpo encontrado, sem presumir verificações adicionais do ambiente.

## Objetos

- [CheckBounds](#checkbounds) — FC · ST
- [CheckDivDInt](#checkdivdint) — FC · ST
- [CheckDivLInt](#checkdivlint) — FC · ST
- [CheckDivLReal](#checkdivlreal) — FC · ST
- [CheckDivReal](#checkdivreal) — FC · ST
- [CheckPointer](#checkpointer) — FC · ST
- [CheckRangeSigned](#checkrangesigned) — FC · ST
- [CheckRangeUnsigned](#checkrangeunsigned) — FC · ST

## CheckBounds

**Tipo:** FC · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/CheckBounds.poucheckfunction.xml.v3>).

**O que faz:** Limita um índice aos limites inferior e superior informados.

**Responsabilidades observadas:**

- Retorna lower se o índice estiver abaixo do intervalo e upper se estiver acima.
- Retorna o índice original quando ele estiver no intervalo.

**Observações:** Função de verificação implícita. A implementação corrige o índice; não registra alarme.

## CheckDivDInt

**Tipo:** FC · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/CheckDivDInt.poucheckfunction.xml.v3>).

**O que faz:** Ajusta o divisor do tipo DINT usado na verificação implícita de divisão.

**Responsabilidades observadas:**

- Substitui divisor zero por um.
- Preserva qualquer divisor diferente de zero.

**Observações:** A substituição evita a divisão por zero nesse ponto, mas não valida o significado do resultado do cálculo.

## CheckDivLInt

**Tipo:** FC · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/CheckDivLInt.poucheckfunction.xml.v3>).

**O que faz:** Ajusta o divisor do tipo LINT usado na verificação implícita de divisão.

**Responsabilidades observadas:**

- Substitui divisor zero por um.
- Preserva qualquer divisor diferente de zero.

**Observações:** A substituição evita a divisão por zero nesse ponto, mas não valida o significado do resultado do cálculo.

## CheckDivLReal

**Tipo:** FC · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/CheckDivLReal.poucheckfunction.xml.v3>).

**O que faz:** Ajusta o divisor do tipo LREAL usado na verificação implícita de divisão.

**Responsabilidades observadas:**

- Substitui divisor zero por um.
- Preserva qualquer divisor diferente de zero.

**Observações:** A substituição evita a divisão por zero nesse ponto, mas não valida o significado do resultado do cálculo.

## CheckDivReal

**Tipo:** FC · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/CheckDivReal.poucheckfunction.xml.v3>).

**O que faz:** Ajusta o divisor do tipo REAL usado na verificação implícita de divisão.

**Responsabilidades observadas:**

- Substitui divisor zero por um.
- Preserva qualquer divisor diferente de zero.

**Observações:** A substituição evita a divisão por zero nesse ponto, mas não valida o significado do resultado do cálculo.

## CheckPointer

**Tipo:** FC · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/CheckPointer.poucheckfunction.xml.v3>).

**O que faz:** Devolve o ponteiro recebido pela função de verificação implícita.

**Responsabilidades observadas:**

- Retorna ptToTest sem alteração.

**Observações:** O corpo não verifica endereço, tamanho, permissão ou validade do ponteiro.

## CheckRangeSigned

**Tipo:** FC · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/CheckRangeSigned.poucheckfunction.xml.v3>).

**O que faz:** Limita um valor com sinal ao intervalo informado.

**Responsabilidades observadas:**

- Retorna o limite correspondente quando o valor está fora da faixa.
- Preserva o valor quando ele está dentro da faixa.

**Observações:** Função de verificação implícita, sem registro de alarme nesta implementação.

## CheckRangeUnsigned

**Tipo:** FC · **Linguagem:** ST · **Fonte:** [abrir código](<../../../MyController.device.xml.v3%5E/Plc%20Logic.plclogic.xml.v3%5E/Application.application.xml.v3%5E/CheckRangeUnsigned.poucheckfunction.xml.v3>).

**O que faz:** Limita um valor sem sinal ao intervalo informado.

**Responsabilidades observadas:**

- Retorna o limite correspondente quando o valor está fora da faixa.
- Preserva o valor quando ele está dentro da faixa.

**Observações:** Função de verificação implícita, sem registro de alarme nesta implementação.

[Voltar ao catálogo](README.md)
