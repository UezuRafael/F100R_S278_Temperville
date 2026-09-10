__METADATA__
{
  "v3Meta": {
    "objectGuid": "b96fa9ab-b0f0-4791-8229-6147d6d2d526",
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
FUNCTION_BLOCK AlarmeResistencia
VAR_INPUT
	ResistRompida: BOOL;
	ResetAlarm: BOOL;
END_VAR
VAR_OUTPUT
	AlarmeResistRompida: BOOL;
	AlarmeSonoro: BOOL;
END_VAR
VAR
	TonRompida: TON;
	TpSom: TP;
END_VAR
__IMPLEMENTATION__
TonRompida.IN:=ResistRompida;

TonRompida(PT:=T#250ms);

IF TonRompida.Q THEN
	AlarmeResistRompida:=TRUE;
END_IF

TpSom(IN:= AlarmeResistRompida, PT:= T#500MS);

IF TpSom.Q THEN
	AlarmeSonoro:=TRUE;
END_IF

IF	ResetAlarm THEN
	AlarmeResistRompida:=FALSE;
	AlarmeSonoro:=FALSE;
END_IF
