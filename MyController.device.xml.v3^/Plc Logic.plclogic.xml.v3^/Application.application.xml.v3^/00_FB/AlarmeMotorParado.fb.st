__METADATA__
{
  "v3Meta": {
    "objectGuid": "fc670ef3-b845-4212-8f6b-41340734eba7",
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
FUNCTION_BLOCK AlarmeMotorParado
VAR_INPUT
	KaMotor: BOOL;
	ResetAlarm: BOOL;
END_VAR
VAR_OUTPUT
	AlarmeMotor: BOOL;
	AlarmeSonoro: BOOL;
END_VAR
VAR
	TonAlarme: TON;
	TpSom: TP;
	TpReset: TP;
END_VAR
__IMPLEMENTATION__
TonAlarme.IN:= KaMotor;

TonAlarme(PT:=T#3000MS );

IF TonAlarme.Q THEN
	AlarmeMotor:= TRUE;
END_IF

TpSom(IN:= AlarmeMotor , PT:= T#500MS );

IF TpSom.Q THEN
	AlarmeSonoro:=TRUE;
END_IF

TpReset(IN:= ResetAlarm , PT:= T#1000MS );

IF	TpReset.Q THEN
	AlarmeMotor:=FALSE;
	AlarmeSonoro:=FALSE;
END_IF
