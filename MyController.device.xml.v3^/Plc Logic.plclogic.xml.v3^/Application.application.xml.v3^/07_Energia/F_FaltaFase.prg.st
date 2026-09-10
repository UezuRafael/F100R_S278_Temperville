__METADATA__
{
  "v3Meta": {
    "objectGuid": "d9d64ccf-a8ad-49f9-93bc-8da7b9a01aef",
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
PROGRAM F_FaltaFase
VAR
	xFaltaFaseA: BOOL;
	xFaltaFaseB: BOOL;
	xFaltaFaseC: BOOL;
	TpSemEnergia: TP;
	TonSemEnergia: TON;
	TonSemEnergiaIn: BOOL;
	TonSemEnergiaQ: BOOL;
	Tp02SemEnergia: TP;
END_VAR
__IMPLEMENTATION__
IF rTensaoFaseAN_V<=190 THEN
	xFaltaFaseA:=TRUE;
ELSE
	xFaltaFaseA:=FALSE;
END_IF
IF rTensaoFaseBN_V<=190 THEN
	xFaltaFaseB:=TRUE;
ELSE
	xFaltaFaseB:=FALSE;
END_IF
IF rTensaoFaseCN_V<=190 THEN
	xFaltaFaseC:=TRUE;
ELSE
	xFaltaFaseC:=FALSE;
END_IF

IF xFaltaFaseA or xFaltaFaseB or xFaltaFaseC THEN
	TonSemEnergiaIn:=TRUE;
ELSE
	TonSemEnergiaIn:=FALSE;
END_IF

TonSemEnergia(IN:=TonSemEnergiaIn , PT:=T#1S , Q=>TonSemEnergiaQ , ET=> );

IF TonSemEnergiaQ THEN
	xSemEnergia:=TRUE;
	xEnergiaOk:=FALSE;
ELSE
	xSemEnergia:=FALSE;
	xEnergiaOk:=TRUE;
END_IF	

TpSemEnergia(IN:=xSemEnergia , PT:=T#500MS , Q=> , ET=> );

IF TpSemEnergia.Q THEN
	xAlmSomSemEnergia:=TRUE;
END_IF

IF bResetAlmGeral THEN
	xAlmSomSemEnergia:=FALSE;
END_IF


TpSemEnergia(IN:=xSemEnergia , PT:=T#30S , Q=>xSomSemEnergia , ET=> );


