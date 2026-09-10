__METADATA__
{
  "v3Meta": {
    "objectGuid": "b38280fc-d3b0-406e-902f-1cee1bab962e",
    "objectTypeGuid": "6f9dac99-8de1-4efc-8465-68ac443b7d08",
    "embeddedObjectTypeGuids": [
      "a9ed5b7e-75c5-4651-af16-d2c27e98cb94",
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {
      "_3S.CoDeSys.LanguageModelManager.BuildProperty": "<?xml version=\"1.0\" encoding=\"utf-8\"?><Single xml:space=\"preserve\" Type=\"{24568a24-c491-472c-a21f-ee5d33859fab}\" Method=\"IArchivable\"><Single Name=\"MemoryReserveForOnlineChange\" Type=\"int\">0</Single><Single Name=\"ExcludeFromBuild\" Type=\"bool\">False</Single><Single Name=\"External\" Type=\"bool\">False</Single><Single Name=\"EnableSystemCall\" Type=\"bool\">False</Single><Single Name=\"CompilerDefines\" Type=\"string\"></Single><Single Name=\"LinkAlways\" Type=\"bool\">False</Single><Array Name=\"Undefines\" Type=\"string\" /></Single>"
    },
    "subObjects": {}
  }
}
__DECLARATION__
FUNCTION_BLOCK StatCircuitoResist
VAR_INPUT
	/// Valor acima do qual considera Resistência Ligada
	iAmpLigada: UINT;
	/// Valor da Leitura de Corrente Diretamente pelo Sensor
	iAmperagem: UINT;
	/// Acionamento do Rele de Estado Sólido
	xSaidaRele: BOOL;
	/// Retorno do Rele de Estado Sólido
	xRetorRele: BOOL;
END_VAR
VAR_OUTPUT
	/// Resistencia Ligada
	xLigada: BOOL;
	/// Resistência Desligada
	xDeslig: BOOL;
	/// Rele com Defeito Aberto ou Disjuntor Desligado
	xReleAb: BOOL;
	/// Rele com Defeito Fechado em Curto Circuito 
	xReleCc: BOOL;
	/// Resistência Quebrada ou Fusível Aberto
	xResAbe: BOOL;
END_VAR
__IMPLEMENTATION__
// Bloco de Identificação de Status dos Reles e Resistências

IF iAmperagem>=	iAmpLigada THEN
	xLigada:=TRUE;
	xDeslig:=FALSE;
ELSE
	xLigada:=FALSE;
	xDeslig:=TRUE;
END_IF

IF xDeslig AND xSaidaRele AND NOT xRetorRele THEN
	xReleAb:=TRUE;
ELSE
	xReleAb:=FALSE;
END_IF

IF xDeslig AND xSaidaRele AND xRetorRele THEN
	xResAbe:=TRUE;
ELSE
	xResAbe:=FALSE;
END_IF

IF xLigada AND NOT xSaidaRele THEN
	xReleCc:=TRUE;
ELSE
	xReleCc:=FALSE;
END_IF

