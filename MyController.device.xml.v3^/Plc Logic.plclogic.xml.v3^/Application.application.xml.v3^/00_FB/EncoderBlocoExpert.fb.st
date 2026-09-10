__METADATA__
{
  "v3Meta": {
    "objectGuid": "e459cd8d-228a-4468-b6d9-7ce7ae8efa79",
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
FUNCTION_BLOCK EncoderBlocoExpert
VAR_INPUT
	Entrada: DINT;
	Zera: BOOL;
	InversaoSinal: BOOL;
END_VAR
VAR_OUTPUT
	Contagem: DINT;
END_VAR
VAR
	ValorZera: DINT := 0;
	Valor: DINT;
END_VAR
__IMPLEMENTATION__
IF Zera THEN
	ValorZera:=Entrada;
END_IF

Valor:=Entrada-ValorZera;

IF InversaoSinal THEN
	Contagem:=-1*Valor;
ELSE
	Contagem:=Valor;
END_IF
