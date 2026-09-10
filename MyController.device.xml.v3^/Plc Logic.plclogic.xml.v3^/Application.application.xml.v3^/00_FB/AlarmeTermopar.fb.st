__METADATA__
{
  "v3Meta": {
    "objectGuid": "d2d4e9d9-8cd9-442e-bab2-a7f8d066cdbd",
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
FUNCTION_BLOCK AlarmeTermopar
VAR_INPUT
	Termopar: BOOL;
	ResetAlarm: BOOL;
END_VAR
VAR_OUTPUT
	TermoparAberto: BOOL;
	AlarmeSonTermopar: BOOL;
END_VAR
VAR
	TonTh: TON;
	TpSom: TP;
END_VAR
__IMPLEMENTATION__
TonTh.IN:=Termopar;

TonTh(PT:=T#1S);

IF TonTh.Q THEN
	TermoparAberto:=TRUE;
END_IF

TpSom(IN:=TermoparAberto,PT:=T#1S);

IF TpSom.Q THEN
	AlarmeSonTermopar:=TRUE;
END_IF

IF	ResetAlarm THEN
	TermoparAberto:=FALSE;
	AlarmeSonTermopar:=FALSE;
END_IF
