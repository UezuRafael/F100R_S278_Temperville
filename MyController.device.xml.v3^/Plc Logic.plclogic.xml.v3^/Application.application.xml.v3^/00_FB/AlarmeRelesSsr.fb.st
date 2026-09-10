__METADATA__
{
  "v3Meta": {
    "objectGuid": "593e59ed-752c-4af5-aa8c-8c66bc47f0c9",
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
FUNCTION_BLOCK AlarmeRelesSsr
VAR_INPUT
	RetornoReleSsr: BOOL;
	ResistRompida: BOOL;
	ReleSsr: BOOL;
	ResetAlarm: BOOL;
END_VAR
VAR_OUTPUT
	AlarmeSsrAberto: BOOL;
	AlarmeSsrFechado: BOOL;
	AlarmeSonoro: BOOL;
END_VAR
VAR
	TonAberto: TON;
	TonFechado: TON;
	TpSom: TP;
END_VAR
__IMPLEMENTATION__
TonAberto.IN:= ReleSsr AND NOT RetornoReleSsr;
TonFechado.IN:= RetornoReleSsr AND NOT ResistRompida AND NOT ReleSsr;

TonAberto(PT:=T#400MS );
TonFechado(PT:=T#400MS );

IF TonAberto.Q THEN
	AlarmeSsrAberto:= TRUE;
END_IF

IF TonFechado.Q THEN
	AlarmeSsrFechado:=TRUE;
END_IF

TpSom(IN:= AlarmeSsrAberto OR AlarmeSsrFechado, PT:= T#200MS );

IF TpSom.Q THEN
	AlarmeSonoro:=TRUE;
END_IF

IF	ResetAlarm THEN
	AlarmeSsrAberto:=FALSE;
	AlarmeSsrFechado:=FALSE;
	AlarmeSonoro:=FALSE;
END_IF
