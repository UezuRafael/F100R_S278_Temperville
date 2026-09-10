__METADATA__
{
  "v3Meta": {
    "objectGuid": "45e89498-a9d9-46d2-8c57-35386e7acfc8",
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
PROGRAM R_MonitoraMotores
VAR
	AlarmeMotorMeFornoStop: AlarmeMotorParado;
	AlarmeMotorMeResfrStop: AlarmeMotorParado;
	AlarmeMotorFornoParadoEncoder: MonitoraEncoder;
	PulsoLedMotFornoStop: TimerGeneration;
	xMotorMeFornoStop: BOOL;
	xMotorMeResfrStop: BOOL;
	xAlarmeMeFornoParadoEncoder: BOOL;
	xAlarmeParadoMotorMesaForno: BOOL;
END_VAR
__IMPLEMENTATION__

AlarmeMotorFornoParadoEncoder(
	xEncoHabilitado:= xFornoEmCicloComCarga AND NOT xTempoPausaRoletesOn,
	bResetAlmGeral:= bResetAlmGeral, 
	tTempoCheck:=T#1000MS,
	dValorEncoder:= dValorEncoderFornoEntrada, 
	xAlarmeEncoder=> xAlarmeMeFornoParadoEncoder, 
	xAlarmeSonoro=> , 
	xEncoderOk=> 	);

	
xAlarmeParadoMotorMesaForno:= NOT xMotorFornoLigado AND NOT xOperacaoManual AND NOT xTempoPausaRoletesOn AND NOT xDesligaMotorFornoTempBaixa AND xEnergiaOk AND NOT xPause;
xMotorMeFornoStop:= xAlarmeParadoMotorMesaForno OR xAlarmeMeFornoParadoEncoder;
AlarmeMotorMeFornoStop(KaMotor:=xMotorMeFornoStop , ResetAlarm:=bResetAlmGeral , AlarmeMotor=> xAlarmeMeFornoParado, AlarmeSonoro=>xAlarmeMeFornoParadoSom );

PulsoLedMotFornoStop(ENABLE:= xMotorMeFornoStop, TIMELOW:=T#500MS , TIMEHIGH:=T#500MS , OUT=>xLedMotFornoStop );


xMotorMeResfrStop:= xMesaResfriadorOn AND NOT xMotorResfriadorLigado AND NOT xOperacaoManual AND xEnergiaOk AND NOT xPausaEmergencia  AND NOT xPausaResfrChAbreSupAcionanda;
AlarmeMotorMeResfrStop(KaMotor:=xMotorMeResfrStop , ResetAlarm:=bResetAlmGeral , AlarmeMotor=> xAlarmeMeResfrParado, AlarmeSonoro=>xAlarmeMeResfrParadoSom );
