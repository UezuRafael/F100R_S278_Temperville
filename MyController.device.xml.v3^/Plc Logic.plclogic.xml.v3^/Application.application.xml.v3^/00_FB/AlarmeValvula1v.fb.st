__METADATA__
{
  "v3Meta": {
    "objectGuid": "460e1db2-154a-4e96-ac40-200090c547e5",
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
FUNCTION_BLOCK AlarmeValvula1v
VAR_INPUT
	SensorValvAberta: BOOL;
	SensorValvFechad: BOOL;
	AcionamentoValvula: BOOL;
	ResetAlarm: BOOL;
	TempoAberto: TIME;
	TempoFechad: TIME;
END_VAR
VAR_OUTPUT
	AlarmeValvAberta: BOOL;
	AlarmeValvFechada: BOOL;
	AlarmeSonoro: BOOL;
END_VAR
VAR
	TonAberto: TON;
	TonFechado: TON;
	TpSom: TP;
END_VAR
__IMPLEMENTATION__
TonAberto.IN:= AcionamentoValvula AND NOT SensorValvAberta;
TonFechado.IN:= NOT AcionamentoValvula AND NOT SensorValvFechad;

TonAberto(PT:= TempoAberto);
TonFechado(PT:=TempoFechad );

IF TonAberto.Q THEN
	AlarmeValvAberta:= TRUE;
END_IF

IF TonFechado.Q THEN
	AlarmeValvFechada:=TRUE;
END_IF

TpSom(IN:= AlarmeValvAberta OR AlarmeValvFechada, PT:= T#500MS );

IF TpSom.Q THEN
	AlarmeSonoro:=TRUE;
END_IF

IF	ResetAlarm THEN
	AlarmeValvAberta:=FALSE;
	AlarmeValvFechada:=FALSE;
	AlarmeSonoro:=FALSE;
END_IF
