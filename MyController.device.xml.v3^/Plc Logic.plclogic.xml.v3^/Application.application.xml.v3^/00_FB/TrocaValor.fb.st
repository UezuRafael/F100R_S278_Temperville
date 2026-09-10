__METADATA__
{
  "v3Meta": {
    "objectGuid": "b4503dda-476b-4c01-8f2f-cc1b12e45119",
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
FUNCTION_BLOCK TrocaValor
VAR_INPUT
	ValorNovo: REAL;
END_VAR
VAR_OUTPUT
	Saida: BOOL;
	ValorAtual: REAL;
END_VAR
__IMPLEMENTATION__
IF ValorAtual<>ValorNovo THEN
	ValorAtual:=ValorNovo;
	Saida:=TRUE;
ELSE
	Saida:=FALSE;
END_IF
