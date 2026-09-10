__METADATA__
{
  "v3Meta": {
    "objectGuid": "aec296ec-bcf4-4e9f-80a7-09f01b0d048d",
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
PROGRAM E_Nobreak
VAR
	TonNobreak: TON;
	TonNobreakIn: BOOL;
	TonNobreakQ: BOOL;
	TpSonAlmNbk: TP;
END_VAR
__IMPLEMENTATION__
xStatusNobreak:=xSaidaNobreakOk;

TonNobreakIn:= NOT xSaidaNobreakOk;
TonNobreak(IN:=TonNobreakIn , PT:=T#500MS , Q=>TonNobreakQ , ET=> );
IF TonNobreakQ THEN
	xAlmNobreak:=TRUE;
END_IF

TpSonAlmNbk(IN:=xAlmNobreak , PT:=T#500MS , Q=> , ET=> );

IF TpSonAlmNbk.Q THEN
	xAlmNobreakSom:=TRUE;
END_IF

IF	bResetAlmGeral THEN
	xAlmNobreak:=FALSE;
	xAlmNobreakSom:=FALSE;
END_IF

xNobreakDesabilitado:= NOT xNobreakHabilitado;

