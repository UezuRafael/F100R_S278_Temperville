__METADATA__
{
  "v3Meta": {
    "objectGuid": "4c42ddfc-7bd8-481a-b878-c55253fac86e",
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
PROGRAM G_Disjuntores
VAR
	TonDisjGeral: TON;
	TonDisjGeralIn: BOOL;
	TonDisjGeralQ: BOOL;
	TpSonAlmDisjGeral: TP;
	TonDisjResist: TON;
	TonDisjResistIn: BOOL;
	TonDisjResistQ: BOOL;
	TpSonAlmTonDisjResist: TP;
END_VAR
__IMPLEMENTATION__
// MOITORAMENTO DO DISJUNTOR GERAL DO PAINEL
xDisjGeralOff:= NOT xDisjGeralOn;

TonDisjGeralIn:= xDisjGeralOff;
TonDisjGeral(IN:=TonDisjGeralIn , PT:=T#1000MS , Q=>TonDisjGeralQ , ET=> );
IF TonDisjGeralQ THEN
	xAlmDisjGeral:=TRUE;
END_IF

TpSonAlmDisjGeral(IN:=xAlmDisjGeral , PT:=T#500MS , Q=> , ET=> );

IF TpSonAlmDisjGeral.Q THEN
	xAlmDisjGeralSom:=TRUE;
END_IF

IF	bResetAlmGeral THEN
	xAlmDisjGeral:=FALSE;
	xAlmDisjGeralSom:=FALSE;
END_IF


// MONITORAMENTO DO DISJUNTOR GERAL DAS RESISTÊNCIAS
TonDisjResistIn:= xDisjResistOff AND xResistenciasLigadas;
TonDisjGeral(IN:=TonDisjResistIn , PT:=T#1000MS , Q=>TonDisjResistQ , ET=> );
IF TonDisjResistQ THEN
	xAlmDisjResist:=TRUE;
END_IF

TpSonAlmTonDisjResist(IN:=xAlmDisjResist , PT:=T#500MS , Q=> , ET=> );

IF TpSonAlmTonDisjResist.Q THEN
	xAlmDisjResistSom:=TRUE;
END_IF

IF	bResetAlmGeral THEN
	xAlmDisjResist:=FALSE;
	xAlmDisjResistSom:=FALSE;
END_IF
