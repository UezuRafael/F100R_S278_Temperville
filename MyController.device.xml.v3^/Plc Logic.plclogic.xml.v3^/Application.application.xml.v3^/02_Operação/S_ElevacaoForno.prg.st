__METADATA__
{
  "v3Meta": {
    "objectGuid": "3030cb65-7911-4df4-9b0f-31e27a5d7f9b",
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
PROGRAM S_ElevacaoForno
VAR
	TonSobeForno: TON;
	TonDesceForno: TON;
	AlertaSomCxForno: TimerGeneration;
	AlertaSomCxFornoIn: BOOL;
	AlertaSomCxFornoQ: BOOL;
END_VAR
__IMPLEMENTATION__
(*-------------------- Hidraulica -------------------*)
TonSobeForno(IN:=xBtSobeForno , PT:=T#10S , Q=> , ET=> );

xDescendoForno		:=xBtDesceForno;
xSubindoForno		:=xBtSobeForno AND NOT TonSobeForno.Q;

xFechaCaixaForno:=xDescendoForno;
xAbreCaixaForno:=xSubindoForno;
xMotorBombaHidraulica:=xSubindoForno OR xValvulaAvancHidra OR xValvulaRecuoHidra;

IF TonSobeForno.Q THEN
	xBtSobeForno:=FALSE;
END_IF
(*---------------------------------------------------*)

(*------------------- Motorizado --------------------*)

AlertaSomCxFornoIn:=xMotorCaixaFornoLigado;
AlertaSomCxForno(ENABLE:=AlertaSomCxFornoIn , TIMELOW:=T#500mS , TIMEHIGH:=T#500mS , OUT=>AlertaSomCxFornoQ );
xAlertaSomCxForno:=AlertaSomCxFornoQ;



IF rMediaLogicaTemperaturaTotal<=700 THEN
	xBloqAbertCxFornoTemper:=TRUE;
ELSE
	xBloqAbertCxFornoTemper:=FALSE;
END_IF
