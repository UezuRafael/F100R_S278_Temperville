__METADATA__
{
  "v3Meta": {
    "objectGuid": "f7cbb281-f8e0-4f25-9468-dd25260e1513",
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
PROGRAM Q_Conveccao
VAR
	TemporizadorConveccao: TON;
	TemporizadorConveccaoIn: BOOL;
	TemporizadorConveccaoEt: TIME;
	TempoConveccaoOnOff: TimerGeneration;
	TempoConveccaoOnOffEnable: BOOL;
	TempoConveccaoOnOffTimeLow: TIME;
	TempoConveccaoOnOffTimeHigh: TIME;
	TempoConveccaoOnOffOut: BOOL;
	ForceConveccao: HabilitaDesabilita;
	xAcionaConveccaoAuto: BOOL;
END_VAR
__IMPLEMENTATION__
(*----------- SISTEMA DE CONVECÇÃO --------------------*)

// Funcionamento em Automático

//Habilita/Desabilita 
xConveccaoHabilitado:= iTempoConveccao<>0 and iTempoConveccaoAberta<>0;

//Liga
IF xConveccaoHabilitado AND xLigaConveccaoForno THEN
	xAcionaConveccaoAuto:=TRUE;
	xLigaConveccaoForno:=FALSE;
END_IF

//Temporiza
TemporizadorConveccaoIn:=xAcionaConveccaoAuto;
TemporizadorConveccao(IN:=TemporizadorConveccaoIn , PT:=t#999s , Q=> , ET=>TemporizadorConveccaoEt );

//Tempo de Convecção decorrido 
iTempoConveccaoDecorrido:=DINT_TO_INT(TIME_TO_DINT(TemporizadorConveccaoEt)/1000);

//Compara
IF (iTempoConveccaoDecorrido>=iTempoConveccao) OR NOT xConveccaoHabilitado OR xOperacaoManual THEN
	xAcionaConveccaoAuto:=FALSE;
END_IF

// Force em Manual

ForceConveccao(	
	Entrada:= xBtForceConveccao, 
	Entrada02:= , 
	Entrada03:= xOperacaoManual, 
	Alarme01:= , 
	Alarme02:= , 
	Alarme03:= , 
	StatusSaida=> xForceConveccao);

IF xBtForceConveccao THEN
	xBtForceConveccao:=FALSE;
END_IF

TempoConveccaoOnOffTimeLow:= DINT_TO_TIME(INT_TO_DINT(iTempoConveccaoAberta)*1000);
TempoConveccaoOnOffTimeHigh:= DINT_TO_TIME(INT_TO_DINT(iTempoConveccaoFechada)*1000);
TempoConveccaoOnOffEnable:=xAcionaConveccaoAuto OR xForceConveccao;
TempoConveccaoOnOff(ENABLE:=TempoConveccaoOnOffEnable , TIMELOW:=TempoConveccaoOnOffTimeLow , TIMEHIGH:=TempoConveccaoOnOffTimeHigh , OUT=>TempoConveccaoOnOffOut );

xValvulaConveccao:=TempoConveccaoOnOffOut;
xValvulaConveccaoLigada:=xValvulaConveccao OR xForceConveccao;

IF xOperacaoManual THEN
	xLigaConveccaoForno:=FALSE;
	xAcionaConveccaoAuto:=FALSE;
END_IF

