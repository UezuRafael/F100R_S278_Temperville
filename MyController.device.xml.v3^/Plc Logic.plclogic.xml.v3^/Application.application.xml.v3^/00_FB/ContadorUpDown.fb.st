__METADATA__
{
  "v3Meta": {
    "objectGuid": "7e7fd549-a63c-4ab4-b9e2-b6bc816bd2c9",
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
FUNCTION_BLOCK ContadorUpDown
VAR_INPUT
	CU: BOOL;
	CD: BOOL;
	RESET: BOOL;
END_VAR
VAR_OUTPUT
	CV: INT;
END_VAR
VAR
	PulsoSobe: PulsoPositivo;
	PulsoDesc: PulsoPositivo;
	PulsoSobeSaida: BOOL;
	PulsoDescSaida: BOOL;
END_VAR
__IMPLEMENTATION__
PulsoSobe(Entrada:=CU , SaidaPulsoPo=>PulsoSobeSaida );
PulsoDesc(Entrada:=CD , SaidaPulsoPo=>PulsoDescSaida );

IF PulsoSobeSaida THEN
	CV:=CV+1;
END_IF
IF PulsoDescSaida THEN
	CV:=CV-1;
END_IF
IF RESET THEN
	CV:=0;
END_IF
