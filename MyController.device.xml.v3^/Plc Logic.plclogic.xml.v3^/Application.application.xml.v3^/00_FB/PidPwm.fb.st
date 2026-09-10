__METADATA__
{
  "v3Meta": {
    "objectGuid": "e05ebfed-9bde-4f4b-aaa2-937680286c66",
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
FUNCTION_BLOCK PidPwm
VAR_INPUT
	xLigaDesliga: BOOL;
	xHabilitaControle: BOOL;
	xForceResistencia: BOOL;
	xHabilitaResistencia: BOOL;
	AlarmeResistencia: BOOL;
	xRstTemperaturaOk: BOOL;
	xFornoComCarga: BOOL;
	rTermoparLeitura: REAL;
	rTermoparControle: REAL;
	rSetTemperatura: REAL;
	rProcentagem: REAL;
	rGanhoPorporcionaKp: REAL;
	rGanhoIntegralKi: REAL;
	rGanhoDerivativoKd: REAL;
	rTempoCiclo: REAL;
	xresetPidBlk:BOOL;
END_VAR
VAR_OUTPUT
	SaidaPwm: BOOL;
	xTemperaturaOk: BOOL;
	rTemperatura: REAL;
END_VAR
VAR
	PID: FB_PID;
	PWM: FB_PWM;
	rPidSaida: REAL;
	rPwmEntrada: REAL;
	xPwmSaida: BOOL;
	xTemperaturaExcesso: BOOL;
	tTempoCiclo: TIME;
END_VAR
__IMPLEMENTATION__
PID.i_stPid.rLowLim:=0;
PID.i_stPid.rHighLim:=100;
PID.i_stPid.rTargCyclTime:=rTempoCiclo;
PID(
	i_xEn:= 		xHabilitaControle, 
	i_rSp:= 		rSetTemperatura, 
	i_rPv1:= 		rTermoparControle, 
	i_iPv2:= 		, 
	i_xHold:= 		, 
	i_rKp:= 		rGanhoPorporcionaKp, 
	i_rTn:= 		rGanhoIntegralKi, 
	i_rTv:= 		rGanhoDerivativoKd, 
	i_rTd:= 		210, 
	i_xManMode:= 	, 
	i_rManVal:= 	, 
	i_stPid:= 		, 
	i_xErrRst:= 	xresetPidBlk, 
	q_xEn=> 		, 
	q_xBusy=> 		, 
	q_rPidOput=> 	rPidSaida, 
	q_xMinLimActv=> , 
	q_xMaxLimActv=> , 
	q_xARWActv=> 	, 
	q_xErr=> 		, 
	q_uiErrId=> 	, 
	q_sErrMsge=> 	, 
	q_sFBstat=> 	);
	
rPwmEntrada:= rPidSaida*(rProcentagem/100);	

tTempoCiclo:= REAL_TO_TIME (rTempoCiclo);
PWM.i_stPara.tCyclTime:=tTempoCiclo;
PWM.i_stPara.tPwmPeriod:=T#1000MS;	
PWM(
	i_xEn:= 	xHabilitaControle, 
	i_rIput:= 	rPwmEntrada, 
	i_stPara:= 	, 
	i_xErrRst:= xresetPidBlk, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	xPwmSaida, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	
	
// Temperatura Atingiu Limite de 750 graus

IF (rTemperatura>=rSetTemperatura+50) AND xFornoComCarga THEN
	xTemperaturaExcesso:=TRUE;
ELSE
	xTemperaturaExcesso:=FALSE;
END_IF

	
SaidaPwm:= (xLigaDesliga AND xHabilitaResistencia AND NOT AlarmeResistencia  AND NOT xTemperaturaExcesso AND xPwmSaida) OR xForceResistencia;
rTemperatura:=rTermoparLeitura;	

// Temeratura atingiu Set Point
IF (rTemperatura>=rSetTemperatura) AND xFornoComCarga THEN
	xTemperaturaOk:=TRUE;
END_IF
IF xRstTemperaturaOk OR NOT xFornoComCarga THEN
	xTemperaturaOk:=FALSE;
END_IF

