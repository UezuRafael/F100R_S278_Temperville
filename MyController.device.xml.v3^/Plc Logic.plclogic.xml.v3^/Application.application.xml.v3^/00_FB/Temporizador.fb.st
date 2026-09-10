__METADATA__
{
  "v3Meta": {
    "objectGuid": "de86666e-2108-4dc9-b0a2-6efd61bfcb17",
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
FUNCTION_BLOCK Temporizador
VAR_INPUT
	IniciaTempo: BOOL;
	AbortaTempo: BOOL;
	SetPointTempo: INT;
END_VAR
VAR_OUTPUT
	TempoDecorrido: INT;
	TempoRestante: INT;
END_VAR
VAR_IN_OUT
	FimTempo: BOOL;
END_VAR
VAR
	Ton01: TON;
	Ton01In: BOOL;
	Ton01Et: TIME;
	FimTempoAux: BOOL;
	TempoDecorridoAux: INT;
END_VAR
__IMPLEMENTATION__
IF IniciaTempo AND NOT FimTempo THEN
	Ton01In:=TRUE;
END_IF

Ton01 (IN := Ton01In, PT := T#9999S, ET => Ton01Et);

IF  (DINT_TO_INT((TIME_TO_DINT(Ton01Et))/1000)>= SetPointTempo) AND Ton01In THEN
	FimTempoAux:=TRUE;
ELSE
	FimTempoAux:=FALSE;
END_IF

TempoDecorridoAux:= DINT_TO_INT((TIME_TO_DINT(Ton01Et))/1000);
	
IF NOT FimTempo THEN
	TempoDecorrido:=TempoDecorridoAux;
	TempoRestante:=SetPointTempo-TempoDecorrido;
END_IF

IF (FimTempoAux OR AbortaTempo) AND Ton01In THEN
	FimTempo:=TRUE;
	Ton01In:=FALSE;
END_IF


