__METADATA__
{
  "v3Meta": {
    "objectGuid": "996b858a-9528-4fee-96aa-15bf02b46b15",
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
FUNCTION_BLOCK PidPwm_ONOFF
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
	///PID: FB_PID;
	///PWM: FB_PWM;
	rPidSaida: REAL;
	rPwmEntrada: REAL;
	xPwmSaida: BOOL;
	xTemperaturaExcesso: BOOL;
	TgPorcent: TimerGenerationPorc;
	rPorcentagemOn: REAL;
	rPorcentagemOff: REAL;
	tTimeOn: TIME;
	tTimeOff: TIME;
	TgPorcentOut: BOOL;
	xPwmSaidaOnOff: BOOL;
END_VAR
__IMPLEMENTATION__
IF rSetTemperatura>=rTermoparControle AND xHabilitaControle THEN
	xPwmSaidaOnOff:=TRUE;
ELSE
	xPwmSaidaOnOff:=FALSE;
END_IF

rPorcentagemOn:=rProcentagem;
rPorcentagemOff:=100-rProcentagem;

tTimeOn:=REAL_TO_TIME (rPorcentagemOn)*10;
tTimeOff:=REAL_TO_TIME (rPorcentagemOff)*10;

TgPorcent(ENABLE:=xPwmSaidaOnOff , TIMELOW:= tTimeOn, TIMEHIGH:= tTimeOff, rPorceta:= rProcentagem, OUT=>TgPorcentOut );

xPwmSaida:=(TgPorcentOut);

SaidaPwm:= (xLigaDesliga AND xHabilitaResistencia AND NOT AlarmeResistencia  AND NOT xTemperaturaExcesso AND xPwmSaida) OR xForceResistencia;
rTemperatura:=rTermoparLeitura;	

	
// Temperatura Atingiu Limite de 750 graus

IF (rTemperatura>=rSetTemperatura+50) AND xFornoComCarga THEN
	xTemperaturaExcesso:=TRUE;
ELSE
	xTemperaturaExcesso:=FALSE;
END_IF


// Temeratura atingiu Set Point
IF (rTemperatura>=rSetTemperatura) AND xFornoComCarga THEN
	xTemperaturaOk:=TRUE;
END_IF
IF xRstTemperaturaOk OR NOT xFornoComCarga THEN
	xTemperaturaOk:=FALSE;
END_IF

