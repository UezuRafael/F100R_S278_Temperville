__METADATA__
{
  "v3Meta": {
    "objectGuid": "9e6ae371-6883-408e-af17-0a64248708ee",
    "objectTypeGuid": "6f9dac99-8de1-4efc-8465-68ac443b7d08",
    "embeddedObjectTypeGuids": [
      "a9ed5b7e-75c5-4651-af16-d2c27e98cb94",
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {},
    "subObjects": {}
  }
}
__DECLARATION__
PROGRAM SR_ControleTemperatura
VAR
	// Bloco de funcao de controle de temperatura FB_HeatingControl da biblioteca CommonToolbox - SE_CTBX
	FbCrtlAquecimento : ARRAY[1..100] OF SE_CTBX.FB_HeatingControl;
	PWM: ARRAY[1..100] OF FB_PWM;
	rPwmEntrada: ARRAY[1..100] OF REAL;

	FbAqueceRampa : ARRAY[1..100] OF RampaCiclo;
	xRampaAqAtiva: ARRAY[1..100] OF BOOL ;
	rSetTemperaturaRampaAq:ARRAY[1..100] OF REAL ;
	
	iTempoEstabRampa	: INT ;
	
	//conjunto de variaveis que configuram o controle de temperatura
	stTemperatureControl:  ARRAY[1..100] OF SE_CTBX.ST_TemperatureControl := [
										(	// 1 = Sonda 1 - Temp 1
											rSetPointHighLimit:= 730.0,
											rSetPointLowLimit:= 0.0, 
											rPidHighLimit:= 100.0, 
											rPidLowLimit:= 0.0, 
											rPwmTimePeriod:= 10.0, 
											rDigitalFilterTime:= 0.0, 
											rDeadBand:= 0.0, 
											rAutoTuneHysteresis:= 0.2
										), 
										(	// 2 = Sonda 2  Temp 2 
											rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	// 3 = Sonda 3 Temp 3
											rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	// 4 = Sonda 4 Temp 4
											rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 
										(	rSetPointHighLimit:= 730.0,	rSetPointLowLimit:= 0.0, rPidHighLimit:= 100.0, rPidLowLimit:= 0.0,rPwmTimePeriod:= 10.0,rDigitalFilterTime:= 0.0,rDeadBand:= 0.0, rAutoTuneHysteresis:= 0.2), 

										(	// 100 = Sonda 5 Temp5 
											rSetPointHighLimit:= 730.0,
											rSetPointLowLimit:= 0.0, 
											rPidHighLimit:= 100.0, 
											rPidLowLimit:= 0.0, 
											rPwmTimePeriod:= 10.0, 
											rDigitalFilterTime:= 0.0, 
											rDeadBand:= 0.0, 
											rAutoTuneHysteresis:= 0.2
										)];
	
	//seletor do conjunto de parametros do PID = valor inicial defindio como o conjunto "Padrão"
	etSelectParameterSetPID : ARRAY[1..100] OF SE_CTBX.ET_ParameterSetPID	:= [SE_CTBX.ET_ParameterSetPId.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default,
																			SE_CTBX.ET_ParameterSetPID.Default];
	
	//conjunto de parametros PID 
	//o bloco FB_HeatingControl usa 5 conjuntos de parametros PID selecionaveis
	//na aplicacao aqui estamos usando o conjunto padrao = default																			
	//Kp ganho proporcional (0...10000)
	//Tn tempo integral (0...60000)
	//Tv tempo derivada (0...60000)
	//Td damping time derivada  (min tempo de ciclo da tarefa...60000)  																				
	stParameterSetsPID : ARRAY[1..100] OF SE_CTBX.ST_ParameterSetsPID := [(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0)),
																		(stDefault := (rKp:= 2.0, rTn:= 200.0, rTv:= 0.0, rTd:= 0.0))];
	
																		
	iTemp : INT:=0;
	rLimiteTempSuperior : ARRAY[1..100] OF REAL;
	rLimiteTempTemp3 : ARRAY[1..100] OF REAL;
	xHabilitaTemp : ARRAY[1..100] OF BOOL;
																		
END_VAR

__IMPLEMENTATION__
_00_EntradasHc();
_20_Parametros();

// Controle Resistencia 01

SR_ControleTemperatura.FbCrtlAquecimento[1](
	i_xEnable:= InterfaceHeat.P_xHabTemp1 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[1], 
	i_rProcessValue:= I_rTemperatura1, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp1 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[1], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[1], 
	iq_stParameterSetsPID:= stParameterSetsPID[1], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[1], 
	q_etResult=> TEMP.iCrtlTempStsTemp1, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp1, 
	q_xPwmOutput=> Q_xAquecimento1, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp1, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp1);
		
rPwmEntrada[1]:= TEMP.rCrtlTempPotTemp1*(rSetPorcentagemInferior[1]/100);	

PWM[1].i_stPara.tCyclTime:=T#10MS;
PWM[1].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[1](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[1], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm1, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 02

SR_ControleTemperatura.FbCrtlAquecimento[2](
	i_xEnable:= InterfaceHeat.P_xHabTemp2 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[2], 
	i_rProcessValue:= I_rTemperatura2, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp2 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[2], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[2], 
	iq_stParameterSetsPID:= stParameterSetsPID[2], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[2], 
	q_etResult=> TEMP.iCrtlTempStsTemp2, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp2, 
	q_xPwmOutput=> Q_xAquecimento2, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp2, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp2);

rPwmEntrada[2]:= TEMP.rCrtlTempPotTemp2*(rSetPorcentagemInferior[2]/100);	

PWM[2].i_stPara.tCyclTime:=T#10MS;
PWM[2].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[2](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[2], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm2, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	


// Controle Resistencia 03

SR_ControleTemperatura.FbCrtlAquecimento[3](
	i_xEnable:= InterfaceHeat.P_xHabTemp3 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[3], 
	i_rProcessValue:= I_rTemperatura3, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp3 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[3], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[3], 
	iq_stParameterSetsPID:= stParameterSetsPID[3], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[3], 
	q_etResult=> TEMP.iCrtlTempStsTemp3, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp3, 
	q_xPwmOutput=> Q_xAquecimento3, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp3, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp3);

rPwmEntrada[3]:= TEMP.rCrtlTempPotTemp3*(rSetPorcentagemInferior[3]/100);	

PWM[3].i_stPara.tCyclTime:=T#10MS;
PWM[3].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[3](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[3], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm3, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 04

SR_ControleTemperatura.FbCrtlAquecimento[4](
	i_xEnable:= InterfaceHeat.P_xHabTemp4 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[4], 
	i_rProcessValue:= I_rTemperatura4, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp4 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[4], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[4], 
	iq_stParameterSetsPID:= stParameterSetsPID[4], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[4], 
	q_etResult=> TEMP.iCrtlTempStsTemp4, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp4, 
	q_xPwmOutput=> Q_xAquecimento4, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp4, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp4);

rPwmEntrada[4]:= TEMP.rCrtlTempPotTemp4*(rSetPorcentagemInferior[4]/100);	

PWM[4].i_stPara.tCyclTime:=T#10MS;
PWM[4].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[4](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[4], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm4, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 05

SR_ControleTemperatura.FbCrtlAquecimento[5](
	i_xEnable:= InterfaceHeat.P_xHabTemp5 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[5], 
	i_rProcessValue:= I_rTemperatura5, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp5 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[5], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[5], 
	iq_stParameterSetsPID:= stParameterSetsPID[5], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[5], 
	q_etResult=> TEMP.iCrtlTempStsTemp5, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp5, 
	q_xPwmOutput=> Q_xAquecimento5, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp5, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp5);

rPwmEntrada[5]:= TEMP.rCrtlTempPotTemp5*(rSetPorcentagemInferior[5]/100);	

PWM[5].i_stPara.tCyclTime:=T#10MS;
PWM[5].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[5](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[5], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm5, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 06

SR_ControleTemperatura.FbCrtlAquecimento[6](
	i_xEnable:= InterfaceHeat.P_xHabTemp6 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[6], 
	i_rProcessValue:= I_rTemperatura6, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp6 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[6], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[6], 
	iq_stParameterSetsPID:= stParameterSetsPID[6], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[6], 
	q_etResult=> TEMP.iCrtlTempStsTemp6, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp6, 
	q_xPwmOutput=> Q_xAquecimento6, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp6, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp6);

rPwmEntrada[6]:= TEMP.rCrtlTempPotTemp6*(rSetPorcentagemInferior[6]/100);	

PWM[6].i_stPara.tCyclTime:=T#10MS;
PWM[6].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[6](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[6], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm6, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 07

SR_ControleTemperatura.FbCrtlAquecimento[7](
	i_xEnable:= InterfaceHeat.P_xHabTemp7 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[7], 
	i_rProcessValue:= I_rTemperatura7, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp7 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[7], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[7], 
	iq_stParameterSetsPID:= stParameterSetsPID[7], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[7], 
	q_etResult=> TEMP.iCrtlTempStsTemp7, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp7, 
	q_xPwmOutput=> Q_xAquecimento7, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp7, 
	q_etStatusAutoTune=>TEMP.iAutoTuneStsTemp7);

rPwmEntrada[7]:= TEMP.rCrtlTempPotTemp7*(rSetPorcentagemInferior[7]/100);	

PWM[7].i_stPara.tCyclTime:=T#10MS;
PWM[7].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[7](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[7], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm7, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 08

SR_ControleTemperatura.FbCrtlAquecimento[8](
	i_xEnable:= InterfaceHeat.P_xHabTemp8 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[8], 
	i_rProcessValue:= I_rTemperatura8, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp8 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[8], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[8], 
	iq_stParameterSetsPID:= stParameterSetsPID[8], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[8], 
	q_etResult=> TEMP.iCrtlTempStsTemp8, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp8, 
	q_xPwmOutput=> Q_xAquecimento8, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp8, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp8);

rPwmEntrada[8]:= TEMP.rCrtlTempPotTemp8*(rSetPorcentagemInferior[8]/100);	

PWM[8].i_stPara.tCyclTime:=T#10MS;
PWM[8].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[8](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[8], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm8, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 09

SR_ControleTemperatura.FbCrtlAquecimento[9](
	i_xEnable:= InterfaceHeat.P_xHabTemp9 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[9], 
	i_rProcessValue:= I_rTemperatura9, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp9 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[9], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[9], 
	iq_stParameterSetsPID:= stParameterSetsPID[9], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[9], 
	q_etResult=> TEMP.iCrtlTempStsTemp9, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp9, 
	q_xPwmOutput=> Q_xAquecimento9, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp9, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp9);

rPwmEntrada[9]:= TEMP.rCrtlTempPotTemp9*(rSetPorcentagemInferior[9]/100);	

PWM[9].i_stPara.tCyclTime:=T#10MS;
PWM[9].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[9](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[9], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm9, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 10

SR_ControleTemperatura.FbCrtlAquecimento[10](
	i_xEnable:= InterfaceHeat.P_xHabTemp10 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[10], 
	i_rProcessValue:= I_rTemperatura10, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp10 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[10], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[10], 
	iq_stParameterSetsPID:= stParameterSetsPID[10], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[10], 
	q_etResult=> TEMP.iCrtlTempStsTemp10, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp10, 
	q_xPwmOutput=> Q_xAquecimento10, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp10, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp10);

rPwmEntrada[10]:= TEMP.rCrtlTempPotTemp10*(rSetPorcentagemInferior[10]/100);	

PWM[10].i_stPara.tCyclTime:=T#10MS;
PWM[10].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[10](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[10], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm10, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	


// Controle Resistencia 11

SR_ControleTemperatura.FbCrtlAquecimento[11](
	i_xEnable:= InterfaceHeat.P_xHabTemp11 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[11], 
	i_rProcessValue:= I_rTemperatura11, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp11 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[11], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[11], 
	iq_stParameterSetsPID:= stParameterSetsPID[11], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[11], 
	q_etResult=> TEMP.iCrtlTempStsTemp11, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp11, 
	q_xPwmOutput=> Q_xAquecimento11, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp11, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp11);

rPwmEntrada[11]:= TEMP.rCrtlTempPotTemp11*(rSetPorcentagemInferior[11]/100);	

PWM[11].i_stPara.tCyclTime:=T#10MS;
PWM[11].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[11](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[11], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm11, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 12

SR_ControleTemperatura.FbCrtlAquecimento[12](
	i_xEnable:= InterfaceHeat.P_xHabTemp12 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[12], 
	i_rProcessValue:= I_rTemperatura12, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp12 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[12], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[12], 
	iq_stParameterSetsPID:= stParameterSetsPID[12], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[12], 
	q_etResult=> TEMP.iCrtlTempStsTemp12, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp12, 
	q_xPwmOutput=> Q_xAquecimento12, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp12, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp12);

rPwmEntrada[12]:= TEMP.rCrtlTempPotTemp12*(rSetPorcentagemInferior[12]/100);	

PWM[12].i_stPara.tCyclTime:=T#10MS;
PWM[12].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[12](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[12], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm12, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 13

SR_ControleTemperatura.FbCrtlAquecimento[13](
	i_xEnable:= InterfaceHeat.P_xHabTemp13 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[13], 
	i_rProcessValue:= I_rTemperatura13, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp13 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[13], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[13], 
	iq_stParameterSetsPID:= stParameterSetsPID[13], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[13], 
	q_etResult=> TEMP.iCrtlTempStsTemp13, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp13, 
	q_xPwmOutput=> Q_xAquecimento13, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp13, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp13);

rPwmEntrada[13]:= TEMP.rCrtlTempPotTemp13*(rSetPorcentagemInferior[13]/100);	

PWM[13].i_stPara.tCyclTime:=T#10MS;
PWM[13].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[13](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[13], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm13, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 14

SR_ControleTemperatura.FbCrtlAquecimento[14](
	i_xEnable:= InterfaceHeat.P_xHabTemp14 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[14], 
	i_rProcessValue:= I_rTemperatura14, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp14 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[14], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[14], 
	iq_stParameterSetsPID:= stParameterSetsPID[14], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[14], 
	q_etResult=> TEMP.iCrtlTempStsTemp14, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp14, 
	q_xPwmOutput=> Q_xAquecimento14, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp14, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp14);

rPwmEntrada[14]:= TEMP.rCrtlTempPotTemp14*(rSetPorcentagemInferior[14]/100);	

PWM[14].i_stPara.tCyclTime:=T#10MS;
PWM[14].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[14](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[14], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm14, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 15

SR_ControleTemperatura.FbCrtlAquecimento[15](
	i_xEnable:= InterfaceHeat.P_xHabTemp15 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[15], 
	i_rProcessValue:= I_rTemperatura15, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp15 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[15], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[15], 
	iq_stParameterSetsPID:= stParameterSetsPID[15], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[15], 
	q_etResult=> TEMP.iCrtlTempStsTemp15, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp15, 
	q_xPwmOutput=> Q_xAquecimento15, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp15, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp15);

rPwmEntrada[15]:= TEMP.rCrtlTempPotTemp15*(rSetPorcentagemInferior[15]/100);	

PWM[15].i_stPara.tCyclTime:=T#10MS;
PWM[15].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[15](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[15], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm15, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 16

SR_ControleTemperatura.FbCrtlAquecimento[16](
	i_xEnable:= InterfaceHeat.P_xHabTemp16 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[16], 
	i_rProcessValue:= I_rTemperatura16, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp16 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[16], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[16], 
	iq_stParameterSetsPID:= stParameterSetsPID[16], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[16], 
	q_etResult=> TEMP.iCrtlTempStsTemp16, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp16, 
	q_xPwmOutput=> Q_xAquecimento16, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp16, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp16);

rPwmEntrada[16]:= TEMP.rCrtlTempPotTemp16*(rSetPorcentagemInferior[16]/100);	

PWM[16].i_stPara.tCyclTime:=T#10MS;
PWM[16].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[16](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[16], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm16, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 17

SR_ControleTemperatura.FbCrtlAquecimento[17](
	i_xEnable:= InterfaceHeat.P_xHabTemp17 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[17], 
	i_rProcessValue:= I_rTemperatura17, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp17 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[17], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[17], 
	iq_stParameterSetsPID:= stParameterSetsPID[17], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[17], 
	q_etResult=> TEMP.iCrtlTempStsTemp17, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp17, 
	q_xPwmOutput=> Q_xAquecimento17, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp17, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp17);

rPwmEntrada[17]:= TEMP.rCrtlTempPotTemp17*(rSetPorcentagemInferior[17]/100);	

PWM[17].i_stPara.tCyclTime:=T#10MS;
PWM[17].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[17](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[17], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm17, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 18

SR_ControleTemperatura.FbCrtlAquecimento[18](
	i_xEnable:= InterfaceHeat.P_xHabTemp18 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[18], 
	i_rProcessValue:= I_rTemperatura18, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp18 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[18], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[18], 
	iq_stParameterSetsPID:= stParameterSetsPID[18], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[18], 
	q_etResult=> TEMP.iCrtlTempStsTemp18, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp18, 
	q_xPwmOutput=> Q_xAquecimento18, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp18, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp18);

rPwmEntrada[18]:= TEMP.rCrtlTempPotTemp18*(rSetPorcentagemInferior[18]/100);	

PWM[18].i_stPara.tCyclTime:=T#10MS;
PWM[18].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[18](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[18], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm18, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 19

SR_ControleTemperatura.FbCrtlAquecimento[19](
	i_xEnable:= InterfaceHeat.P_xHabTemp19 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[19], 
	i_rProcessValue:= I_rTemperatura19, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp19 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[19], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[19], 
	iq_stParameterSetsPID:= stParameterSetsPID[19], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[19], 
	q_etResult=> TEMP.iCrtlTempStsTemp19, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp19, 
	q_xPwmOutput=> Q_xAquecimento19, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp19, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp19);

rPwmEntrada[19]:= TEMP.rCrtlTempPotTemp19*(rSetPorcentagemInferior[19]/100);	

PWM[19].i_stPara.tCyclTime:=T#10MS;
PWM[19].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[19](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[19], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm19, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 20

SR_ControleTemperatura.FbCrtlAquecimento[20](
	i_xEnable:= InterfaceHeat.P_xHabTemp20 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[20], 
	i_rProcessValue:= I_rTemperatura20, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp20 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[20], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[20], 
	iq_stParameterSetsPID:= stParameterSetsPID[20], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[20], 
	q_etResult=> TEMP.iCrtlTempStsTemp20, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp20, 
	q_xPwmOutput=> Q_xAquecimento20, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp20, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp20);

rPwmEntrada[20]:= TEMP.rCrtlTempPotTemp20*(rSetPorcentagemInferior[20]/100);	

PWM[20].i_stPara.tCyclTime:=T#10MS;
PWM[20].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[20](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[20], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm20, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 21

SR_ControleTemperatura.FbCrtlAquecimento[21](
	i_xEnable:= InterfaceHeat.P_xHabTemp21 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[21], 
	i_rProcessValue:= I_rTemperatura21, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp21 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[21], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[21], 
	iq_stParameterSetsPID:= stParameterSetsPID[21], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[21], 
	q_etResult=> TEMP.iCrtlTempStsTemp21, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp21, 
	q_xPwmOutput=> Q_xAquecimento21, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp21, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp21);

rPwmEntrada[21]:= TEMP.rCrtlTempPotTemp21*(rSetPorcentagemInferior[21]/100);	

PWM[21].i_stPara.tCyclTime:=T#10MS;
PWM[21].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[21](
	i_xEn:= 	xLigaDeslResInferiores,//xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[21], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm21, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	


// Controle Resistencia 22

SR_ControleTemperatura.FbCrtlAquecimento[22](
	i_xEnable:= InterfaceHeat.P_xHabTemp22 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[22], 
	i_rProcessValue:= I_rTemperatura22, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp22 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[22], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[22], 
	iq_stParameterSetsPID:= stParameterSetsPID[22], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[22], 
	q_etResult=> TEMP.iCrtlTempStsTemp22, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp22, 
	q_xPwmOutput=> Q_xAquecimento22, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp22, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp22);

rPwmEntrada[22]:= TEMP.rCrtlTempPotTemp22*(rSetPorcentagemInferior[22]/100);	

PWM[22].i_stPara.tCyclTime:=T#10MS;
PWM[22].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[22](
	i_xEn:= 	xLigaDeslResInferiores,//xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[22], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm22, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	


// Controle Resistencia 23

SR_ControleTemperatura.FbCrtlAquecimento[23](
	i_xEnable:= InterfaceHeat.P_xHabTemp23 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[23], 
	i_rProcessValue:= I_rTemperatura23, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp23 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[23], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[23], 
	iq_stParameterSetsPID:= stParameterSetsPID[23], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[23], 
	q_etResult=> TEMP.iCrtlTempStsTemp23, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp23, 
	q_xPwmOutput=> Q_xAquecimento23, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp23, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp23);

rPwmEntrada[23]:= TEMP.rCrtlTempPotTemp23*(rSetPorcentagemInferior[23]/100);	

PWM[23].i_stPara.tCyclTime:=T#10MS;
PWM[23].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[23](
	i_xEn:= 	xLigaDeslResInferiores,//xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[23], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm23, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	


// Controle Resistencia 24

SR_ControleTemperatura.FbCrtlAquecimento[24](
	i_xEnable:= InterfaceHeat.P_xHabTemp24 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[24], 
	i_rProcessValue:= I_rTemperatura24, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp24 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[24], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[24], 
	iq_stParameterSetsPID:= stParameterSetsPID[24], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[24], 
	q_etResult=> TEMP.iCrtlTempStsTemp24, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp24, 
	q_xPwmOutput=> Q_xAquecimento24, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp24, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp24);

rPwmEntrada[24]:= TEMP.rCrtlTempPotTemp24*(rSetPorcentagemInferior[24]/100);	

PWM[24].i_stPara.tCyclTime:=T#10MS;
PWM[24].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[24](
	i_xEn:= 	xLigaDeslResInferiores,//xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[24], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm24, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 25

SR_ControleTemperatura.FbCrtlAquecimento[25](
	i_xEnable:= InterfaceHeat.P_xHabTemp25 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[25], 
	i_rProcessValue:= I_rTemperatura25, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp25 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[25], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[25], 
	iq_stParameterSetsPID:= stParameterSetsPID[25], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[25], 
	q_etResult=> TEMP.iCrtlTempStsTemp25, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp25, 
	q_xPwmOutput=> Q_xAquecimento25, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp25, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp25);

rPwmEntrada[25]:= TEMP.rCrtlTempPotTemp25*(rSetPorcentagemInferior[25]/100);	

PWM[25].i_stPara.tCyclTime:=T#10MS;
PWM[25].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[25](
	i_xEn:= 	xLigaDeslResInferiores,//xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[25], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm25, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 26

SR_ControleTemperatura.FbCrtlAquecimento[26](
	i_xEnable:= InterfaceHeat.P_xHabTemp26 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[26], 
	i_rProcessValue:= I_rTemperatura26, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp26 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[26], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[26], 
	iq_stParameterSetsPID:= stParameterSetsPID[26], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[26], 
	q_etResult=> TEMP.iCrtlTempStsTemp26, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp26, 
	q_xPwmOutput=> Q_xAquecimento26, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp26, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp26);

rPwmEntrada[26]:= TEMP.rCrtlTempPotTemp26*(rSetPorcentagemInferior[26]/100);	

PWM[26].i_stPara.tCyclTime:=T#10MS;
PWM[26].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[26](
	i_xEn:= 	xLigaDeslResInferiores,//xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[26], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm26, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 27

SR_ControleTemperatura.FbCrtlAquecimento[27](
	i_xEnable:= InterfaceHeat.P_xHabTemp27 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[27], 
	i_rProcessValue:= I_rTemperatura27, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp27 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[27], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[27], 
	iq_stParameterSetsPID:= stParameterSetsPID[27], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[27], 
	q_etResult=> TEMP.iCrtlTempStsTemp27, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp27, 
	q_xPwmOutput=> Q_xAquecimento27, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp27, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp27);

rPwmEntrada[27]:= TEMP.rCrtlTempPotTemp27*(rSetPorcentagemInferior[27]/100);	

PWM[27].i_stPara.tCyclTime:=T#10MS;
PWM[27].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[27](
	i_xEn:= 	xLigaDeslResInferiores,//xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[27], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm27, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 28

SR_ControleTemperatura.FbCrtlAquecimento[28](
	i_xEnable:= InterfaceHeat.P_xHabTemp28 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[28], 
	i_rProcessValue:= I_rTemperatura28, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp28 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[28], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[28], 
	iq_stParameterSetsPID:= stParameterSetsPID[28], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[28], 
	q_etResult=> TEMP.iCrtlTempStsTemp28, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp28, 
	q_xPwmOutput=> Q_xAquecimento28, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp28, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp28);

rPwmEntrada[28]:= TEMP.rCrtlTempPotTemp28*(rSetPorcentagemInferior[28]/100);	

PWM[28].i_stPara.tCyclTime:=T#10MS;
PWM[28].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[28](
	i_xEn:= 	xLigaDeslResInferiores,//xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[28], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm28, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 29

SR_ControleTemperatura.FbCrtlAquecimento[29](
	i_xEnable:= InterfaceHeat.P_xHabTemp29 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[29], 
	i_rProcessValue:= I_rTemperatura29, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp29 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[29], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[29], 
	iq_stParameterSetsPID:= stParameterSetsPID[29], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[29], 
	q_etResult=> TEMP.iCrtlTempStsTemp29, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp29, 
	q_xPwmOutput=> Q_xAquecimento29, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp29, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp29);

	rPwmEntrada[29]:= TEMP.rCrtlTempPotTemp29*(rSetPorcentagemInferior[29]/100);	

PWM[29].i_stPara.tCyclTime:=T#10MS;
PWM[29].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[29](
	i_xEn:= 	xLigaDeslResInferiores,//xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[29], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm29, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 30

SR_ControleTemperatura.FbCrtlAquecimento[30](
	i_xEnable:= InterfaceHeat.P_xHabTemp30 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[30], 
	i_rProcessValue:= I_rTemperatura30, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp30 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[30], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[30], 
	iq_stParameterSetsPID:= stParameterSetsPID[30], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[30], 
	q_etResult=> TEMP.iCrtlTempStsTemp30, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp30, 
	q_xPwmOutput=> Q_xAquecimento30, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp30, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp30);

rPwmEntrada[30]:= TEMP.rCrtlTempPotTemp30*(rSetPorcentagemInferior[30]/100);	

PWM[30].i_stPara.tCyclTime:=T#10MS;
PWM[30].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[30](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[30], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm30, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 31

SR_ControleTemperatura.FbCrtlAquecimento[31](
	i_xEnable:= InterfaceHeat.P_xHabTemp31 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[31], 
	i_rProcessValue:= I_rTemperatura31, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp31 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[31], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[31], 
	iq_stParameterSetsPID:= stParameterSetsPID[31], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[31], 
	q_etResult=> TEMP.iCrtlTempStsTemp31, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp31, 
	q_xPwmOutput=> Q_xAquecimento31, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp31, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp31);

rPwmEntrada[31]:= TEMP.rCrtlTempPotTemp31*(rSetPorcentagemInferior[31]/100);	

PWM[31].i_stPara.tCyclTime:=T#10MS;
PWM[31].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[31](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[31], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm31, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 32

SR_ControleTemperatura.FbCrtlAquecimento[32](
	i_xEnable:= InterfaceHeat.P_xHabTemp32 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[32], 
	i_rProcessValue:= I_rTemperatura32, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp32 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[32], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[32], 
	iq_stParameterSetsPID:= stParameterSetsPID[32], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[32], 
	q_etResult=> TEMP.iCrtlTempStsTemp32, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp32, 
	q_xPwmOutput=> Q_xAquecimento32, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp32, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp32);

rPwmEntrada[32]:= TEMP.rCrtlTempPotTemp32*(rSetPorcentagemInferior[32]/100);	

PWM[32].i_stPara.tCyclTime:=T#10MS;
PWM[32].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[32](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[32], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm32, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 33

SR_ControleTemperatura.FbCrtlAquecimento[33](
	i_xEnable:= InterfaceHeat.P_xHabTemp33 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[33], 
	i_rProcessValue:= I_rTemperatura33, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp33 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[33], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[33], 
	iq_stParameterSetsPID:= stParameterSetsPID[33], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[33], 
	q_etResult=> TEMP.iCrtlTempStsTemp33, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp33, 
	q_xPwmOutput=> Q_xAquecimento33, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp33, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp33);

rPwmEntrada[33]:= TEMP.rCrtlTempPotTemp33*(rSetPorcentagemInferior[33]/100);	

PWM[33].i_stPara.tCyclTime:=T#10MS;
PWM[33].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[33](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[33], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm33, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 34

SR_ControleTemperatura.FbCrtlAquecimento[34](
	i_xEnable:= InterfaceHeat.P_xHabTemp34 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[34], 
	i_rProcessValue:= I_rTemperatura34, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp34 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[34], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[34], 
	iq_stParameterSetsPID:= stParameterSetsPID[34], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[34], 
	q_etResult=> TEMP.iCrtlTempStsTemp34, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp34, 
	q_xPwmOutput=> Q_xAquecimento34, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp34, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp34);

rPwmEntrada[34]:= TEMP.rCrtlTempPotTemp34*(rSetPorcentagemInferior[34]/100);	

PWM[34].i_stPara.tCyclTime:=T#10MS;
PWM[34].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[34](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[34], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm34, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 35

SR_ControleTemperatura.FbCrtlAquecimento[35](
	i_xEnable:= InterfaceHeat.P_xHabTemp35 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[35], 
	i_rProcessValue:= I_rTemperatura35, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp35 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[35], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[35], 
	iq_stParameterSetsPID:= stParameterSetsPID[35], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[35], 
	q_etResult=> TEMP.iCrtlTempStsTemp35, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp35, 
	q_xPwmOutput=> Q_xAquecimento35, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp35, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp35);

rPwmEntrada[35]:= TEMP.rCrtlTempPotTemp35*(rSetPorcentagemInferior[35]/100);	

PWM[35].i_stPara.tCyclTime:=T#10MS;
PWM[35].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[35](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[35], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm35, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 36

SR_ControleTemperatura.FbCrtlAquecimento[36](
	i_xEnable:= InterfaceHeat.P_xHabTemp36 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[36], 
	i_rProcessValue:= I_rTemperatura36, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp36 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[36], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[36], 
	iq_stParameterSetsPID:= stParameterSetsPID[36], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[36], 
	q_etResult=> TEMP.iCrtlTempStsTemp36, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp36, 
	q_xPwmOutput=> Q_xAquecimento36, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp36, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp36);

rPwmEntrada[36]:= TEMP.rCrtlTempPotTemp36*(rSetPorcentagemInferior[36]/100);	

PWM[36].i_stPara.tCyclTime:=T#10MS;
PWM[36].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[36](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[36], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm36, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 37

SR_ControleTemperatura.FbCrtlAquecimento[37](
	i_xEnable:= InterfaceHeat.P_xHabTemp37 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[37], 
	i_rProcessValue:= I_rTemperatura37, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp37 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[37], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[37], 
	iq_stParameterSetsPID:= stParameterSetsPID[37], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[37], 
	q_etResult=> TEMP.iCrtlTempStsTemp37, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp37, 
	q_xPwmOutput=> Q_xAquecimento37, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp37, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp37);

rPwmEntrada[37]:= TEMP.rCrtlTempPotTemp37*(rSetPorcentagemInferior[37]/100);	

PWM[37].i_stPara.tCyclTime:=T#10MS;
PWM[37].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[37](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[37], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm37, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 38

SR_ControleTemperatura.FbCrtlAquecimento[38](
	i_xEnable:= InterfaceHeat.P_xHabTemp38 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[38], 
	i_rProcessValue:= I_rTemperatura38, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp38 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[38], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[38], 
	iq_stParameterSetsPID:= stParameterSetsPID[38], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[38], 
	q_etResult=> TEMP.iCrtlTempStsTemp38, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp38, 
	q_xPwmOutput=> Q_xAquecimento38, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp38, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp38);

rPwmEntrada[38]:= TEMP.rCrtlTempPotTemp38*(rSetPorcentagemInferior[38]/100);	

PWM[38].i_stPara.tCyclTime:=T#10MS;
PWM[38].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[38](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[38], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm38, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 39

SR_ControleTemperatura.FbCrtlAquecimento[39](
	i_xEnable:= InterfaceHeat.P_xHabTemp39 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[39], 
	i_rProcessValue:= I_rTemperatura39, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp39 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[39], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[39], 
	iq_stParameterSetsPID:= stParameterSetsPID[39], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[39], 
	q_etResult=> TEMP.iCrtlTempStsTemp39, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp39, 
	q_xPwmOutput=> Q_xAquecimento39, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp39, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp39);

rPwmEntrada[39]:= TEMP.rCrtlTempPotTemp39*(rSetPorcentagemInferior[39]/100);	

PWM[39].i_stPara.tCyclTime:=T#10MS;
PWM[39].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[39](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[39], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm39, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 40

SR_ControleTemperatura.FbCrtlAquecimento[40](
	i_xEnable:= InterfaceHeat.P_xHabTemp40 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[40], 
	i_rProcessValue:= I_rTemperatura40, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp40 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[40], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[40], 
	iq_stParameterSetsPID:= stParameterSetsPID[40], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[40], 
	q_etResult=> TEMP.iCrtlTempStsTemp40, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp40, 
	q_xPwmOutput=> Q_xAquecimento40, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp40, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp40);

rPwmEntrada[40]:= TEMP.rCrtlTempPotTemp40*(rSetPorcentagemInferior[40]/100);	

PWM[40].i_stPara.tCyclTime:=T#10MS;
PWM[40].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[40](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[40], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm40, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 41

SR_ControleTemperatura.FbCrtlAquecimento[41](
	i_xEnable:= InterfaceHeat.P_xHabTemp41 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[41], 
	i_rProcessValue:= I_rTemperatura41, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp41 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[41], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[41], 
	iq_stParameterSetsPID:= stParameterSetsPID[41], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[41], 
	q_etResult=> TEMP.iCrtlTempStsTemp41, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp41, 
	q_xPwmOutput=> Q_xAquecimento41, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp41, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp41);

rPwmEntrada[41]:= TEMP.rCrtlTempPotTemp41*(rSetPorcentagemInferior[41]/100);	

PWM[41].i_stPara.tCyclTime:=T#10MS;
PWM[41].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[41](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[41], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm41, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 42

SR_ControleTemperatura.FbCrtlAquecimento[42](
	i_xEnable:= InterfaceHeat.P_xHabTemp42 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[42], 
	i_rProcessValue:= I_rTemperatura42, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp42 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[42], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[42], 
	iq_stParameterSetsPID:= stParameterSetsPID[42], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[42], 
	q_etResult=> TEMP.iCrtlTempStsTemp42, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp42, 
	q_xPwmOutput=> Q_xAquecimento42, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp42, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp42);

rPwmEntrada[42]:= TEMP.rCrtlTempPotTemp42*(rSetPorcentagemInferior[42]/100);	

PWM[42].i_stPara.tCyclTime:=T#10MS;
PWM[42].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[42](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[42], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm42, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 43

SR_ControleTemperatura.FbCrtlAquecimento[43](
	i_xEnable:= InterfaceHeat.P_xHabTemp43 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[43], 
	i_rProcessValue:= I_rTemperatura43, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp43 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[43], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[43], 
	iq_stParameterSetsPID:= stParameterSetsPID[43], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[43], 
	q_etResult=> TEMP.iCrtlTempStsTemp43, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp43, 
	q_xPwmOutput=> Q_xAquecimento43, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp43, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp43);

rPwmEntrada[43]:= TEMP.rCrtlTempPotTemp43*(rSetPorcentagemInferior[43]/100);	

PWM[43].i_stPara.tCyclTime:=T#10MS;
PWM[43].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[43](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[43], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm43, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 44

SR_ControleTemperatura.FbCrtlAquecimento[44](
	i_xEnable:= InterfaceHeat.P_xHabTemp44 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[44], 
	i_rProcessValue:= I_rTemperatura44, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp44 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[44], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[44], 
	iq_stParameterSetsPID:= stParameterSetsPID[44], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[44], 
	q_etResult=> TEMP.iCrtlTempStsTemp44, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp44, 
	q_xPwmOutput=> Q_xAquecimento44, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp44, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp44);

rPwmEntrada[44]:= TEMP.rCrtlTempPotTemp44*(rSetPorcentagemInferior[44]/100);	

PWM[44].i_stPara.tCyclTime:=T#10MS;
PWM[44].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[44](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[44], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm44, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 45

SR_ControleTemperatura.FbCrtlAquecimento[45](
	i_xEnable:= InterfaceHeat.P_xHabTemp45 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[45], 
	i_rProcessValue:= I_rTemperatura45, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp45 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[45], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[45], 
	iq_stParameterSetsPID:= stParameterSetsPID[45], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[45], 
	q_etResult=> TEMP.iCrtlTempStsTemp45, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp45, 
	q_xPwmOutput=> Q_xAquecimento45, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp45, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp45);

rPwmEntrada[45]:= TEMP.rCrtlTempPotTemp45*(rSetPorcentagemInferior[45]/100);	

PWM[45].i_stPara.tCyclTime:=T#10MS;
PWM[45].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[45](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[45], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm45, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 46

SR_ControleTemperatura.FbCrtlAquecimento[46](
	i_xEnable:= InterfaceHeat.P_xHabTemp46 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[46], 
	i_rProcessValue:= I_rTemperatura46, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp46 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[46], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[46], 
	iq_stParameterSetsPID:= stParameterSetsPID[46], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[46], 
	q_etResult=> TEMP.iCrtlTempStsTemp46, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp46, 
	q_xPwmOutput=> Q_xAquecimento46, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp46, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp46);

rPwmEntrada[46]:= TEMP.rCrtlTempPotTemp46*(rSetPorcentagemInferior[46]/100);	

PWM[46].i_stPara.tCyclTime:=T#10MS;
PWM[46].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[46](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[46], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm46, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 47

SR_ControleTemperatura.FbCrtlAquecimento[47](
	i_xEnable:= InterfaceHeat.P_xHabTemp47 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[47], 
	i_rProcessValue:= I_rTemperatura47, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp47 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[47], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[47], 
	iq_stParameterSetsPID:= stParameterSetsPID[47], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[47], 
	q_etResult=> TEMP.iCrtlTempStsTemp47, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp47, 
	q_xPwmOutput=> Q_xAquecimento47, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp47, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp47);

rPwmEntrada[47]:= TEMP.rCrtlTempPotTemp47*(rSetPorcentagemInferior[47]/100);	

PWM[47].i_stPara.tCyclTime:=T#10MS;
PWM[47].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[47](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[47], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm47, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 48

SR_ControleTemperatura.FbCrtlAquecimento[48](
	i_xEnable:= InterfaceHeat.P_xHabTemp48 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[48], 
	i_rProcessValue:= I_rTemperatura48, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp48 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[48], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[48], 
	iq_stParameterSetsPID:= stParameterSetsPID[48], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[48], 
	q_etResult=> TEMP.iCrtlTempStsTemp48, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp48, 
	q_xPwmOutput=> Q_xAquecimento48, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp48, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp48);

rPwmEntrada[48]:= TEMP.rCrtlTempPotTemp48*(rSetPorcentagemInferior[48]/100);	

PWM[48].i_stPara.tCyclTime:=T#10MS;
PWM[48].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[48](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[48], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm48, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 49

SR_ControleTemperatura.FbCrtlAquecimento[49](
	i_xEnable:= InterfaceHeat.P_xHabTemp49 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[49], 
	i_rProcessValue:= I_rTemperatura49, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp49 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[49], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[49], 
	iq_stParameterSetsPID:= stParameterSetsPID[49], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[49], 
	q_etResult=> TEMP.iCrtlTempStsTemp49, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp49, 
	q_xPwmOutput=> Q_xAquecimento49, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp49, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp49);

rPwmEntrada[49]:= TEMP.rCrtlTempPotTemp49*(rSetPorcentagemInferior[49]/100);	

PWM[49].i_stPara.tCyclTime:=T#10MS;
PWM[49].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[49](
	i_xEn:= 	xLigaDesligaInfG01, 
	i_rIput:= 	rPwmEntrada[49], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm49, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 50

SR_ControleTemperatura.FbCrtlAquecimento[50](
	i_xEnable:= InterfaceHeat.P_xHabTemp50 OR xLigaDeslResInferiores, 
	i_rSetPoint:= rSetPointTemperaturaInferior[50], 
	i_rProcessValue:= I_rTemperatura50, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp50 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[50], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[50], 
	iq_stParameterSetsPID:= stParameterSetsPID[50], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[50], 
	q_etResult=> TEMP.iCrtlTempStsTemp50, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp50, 
	q_xPwmOutput=> Q_xAquecimento50, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp50, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp50);

rPwmEntrada[50]:= TEMP.rCrtlTempPotTemp50*(rSetPorcentagemInferior[50]/100);	

PWM[50].i_stPara.tCyclTime:=T#10MS;
PWM[50].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[50](
	i_xEn:= 	xLigaDesligaInfG02, 
	i_rIput:= 	rPwmEntrada[50], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm50, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

//// SUPERIORES

// Controle Resistencia 51

SR_ControleTemperatura.FbCrtlAquecimento[51](
	i_xEnable:= InterfaceHeat.P_xHabTemp51 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[1], 
	i_rProcessValue:= I_rTemperatura51, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp51 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[51], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[51], 
	iq_stParameterSetsPID:= stParameterSetsPID[51], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[51], 
	q_etResult=> TEMP.iCrtlTempStsTemp51, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp51, 
	q_xPwmOutput=> Q_xAquecimento51, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp51, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp51);

rPwmEntrada[51]:= TEMP.rCrtlTempPotTemp51*(rSetPorcentagemSuperior[1]/100);	

PWM[51].i_stPara.tCyclTime:=T#10MS;
PWM[51].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[51](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[51], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm51, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 52

SR_ControleTemperatura.FbCrtlAquecimento[52](
	i_xEnable:= InterfaceHeat.P_xHabTemp52 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[2], 
	i_rProcessValue:= I_rTemperatura52, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp52 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[52], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[52], 
	iq_stParameterSetsPID:= stParameterSetsPID[52], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[52], 
	q_etResult=> TEMP.iCrtlTempStsTemp52, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp52, 
	q_xPwmOutput=> Q_xAquecimento52, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp52, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp52);

rPwmEntrada[52]:= TEMP.rCrtlTempPotTemp52*(rSetPorcentagemSuperior[2]/100);	

PWM[52].i_stPara.tCyclTime:=T#10MS;
PWM[52].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[52](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[52], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm52, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 53

SR_ControleTemperatura.FbCrtlAquecimento[53](
	i_xEnable:= InterfaceHeat.P_xHabTemp53 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[3], 
	i_rProcessValue:= I_rTemperatura53, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp53 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[53], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[53], 
	iq_stParameterSetsPID:= stParameterSetsPID[53], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[53], 
	q_etResult=> TEMP.iCrtlTempStsTemp53, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp53, 
	q_xPwmOutput=> Q_xAquecimento53, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp53, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp53);

rPwmEntrada[53]:= TEMP.rCrtlTempPotTemp53*(rSetPorcentagemSuperior[3]/100);	

PWM[53].i_stPara.tCyclTime:=T#10MS;
PWM[53].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[53](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[53], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm53, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 54

SR_ControleTemperatura.FbCrtlAquecimento[54](
	i_xEnable:= InterfaceHeat.P_xHabTemp54 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[4], 
	i_rProcessValue:= I_rTemperatura54, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp54 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[54], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[54], 
	iq_stParameterSetsPID:= stParameterSetsPID[54], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[54], 
	q_etResult=> TEMP.iCrtlTempStsTemp54, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp54, 
	q_xPwmOutput=> Q_xAquecimento54, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp54, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp54);

rPwmEntrada[54]:= TEMP.rCrtlTempPotTemp54*(rSetPorcentagemSuperior[4]/100);	

PWM[54].i_stPara.tCyclTime:=T#10MS;
PWM[54].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[54](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[54], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm54, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 55

SR_ControleTemperatura.FbCrtlAquecimento[55](
	i_xEnable:= InterfaceHeat.P_xHabTemp55 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[5], 
	i_rProcessValue:= I_rTemperatura55, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp55 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[55], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[55], 
	iq_stParameterSetsPID:= stParameterSetsPID[55], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[55], 
	q_etResult=> TEMP.iCrtlTempStsTemp55, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp55, 
	q_xPwmOutput=> Q_xAquecimento55, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp55, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp55);

rPwmEntrada[55]:= TEMP.rCrtlTempPotTemp55*(rSetPorcentagemSuperior[5]/100);	

PWM[55].i_stPara.tCyclTime:=T#10MS;
PWM[55].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[55](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[55], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm55, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 56

SR_ControleTemperatura.FbCrtlAquecimento[56](
	i_xEnable:= InterfaceHeat.P_xHabTemp56 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[6], 
	i_rProcessValue:= I_rTemperatura56, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp56 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[56], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[56], 
	iq_stParameterSetsPID:= stParameterSetsPID[56], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[56], 
	q_etResult=> TEMP.iCrtlTempStsTemp56, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp56, 
	q_xPwmOutput=> Q_xAquecimento56, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp56, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp56);

rPwmEntrada[56]:= TEMP.rCrtlTempPotTemp56*(rSetPorcentagemSuperior[6]/100);	

PWM[56].i_stPara.tCyclTime:=T#10MS;
PWM[56].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[56](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[56], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm56, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 57

SR_ControleTemperatura.FbCrtlAquecimento[57](
	i_xEnable:= InterfaceHeat.P_xHabTemp57 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[7], 
	i_rProcessValue:= I_rTemperatura57, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp57 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[57], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[57], 
	iq_stParameterSetsPID:= stParameterSetsPID[57], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[57], 
	q_etResult=> TEMP.iCrtlTempStsTemp57, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp57, 
	q_xPwmOutput=> Q_xAquecimento57, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp57, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp57);

rPwmEntrada[57]:= TEMP.rCrtlTempPotTemp57*(rSetPorcentagemSuperior[7]/100);	

PWM[57].i_stPara.tCyclTime:=T#10MS;
PWM[57].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[57](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[57], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm57, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 58

SR_ControleTemperatura.FbCrtlAquecimento[58](
	i_xEnable:= InterfaceHeat.P_xHabTemp58 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[8], 
	i_rProcessValue:= I_rTemperatura58, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp58 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[58], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[58], 
	iq_stParameterSetsPID:= stParameterSetsPID[58], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[58], 
	q_etResult=> TEMP.iCrtlTempStsTemp58, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp58, 
	q_xPwmOutput=> Q_xAquecimento58, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp58, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp58);

rPwmEntrada[58]:= TEMP.rCrtlTempPotTemp58*(rSetPorcentagemSuperior[8]/100);	

PWM[58].i_stPara.tCyclTime:=T#10MS;
PWM[58].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[58](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[58], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm58, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 59

SR_ControleTemperatura.FbCrtlAquecimento[59](
	i_xEnable:= InterfaceHeat.P_xHabTemp59 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[9], 
	i_rProcessValue:= I_rTemperatura59, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp59 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[59], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[59], 
	iq_stParameterSetsPID:= stParameterSetsPID[59], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[59], 
	q_etResult=> TEMP.iCrtlTempStsTemp59, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp59, 
	q_xPwmOutput=> Q_xAquecimento59, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp59, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp59);

rPwmEntrada[59]:= TEMP.rCrtlTempPotTemp59*(rSetPorcentagemSuperior[9]/100);	

PWM[59].i_stPara.tCyclTime:=T#10MS;
PWM[59].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[59](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[59], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm59, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 60

SR_ControleTemperatura.FbCrtlAquecimento[60](
	i_xEnable:= InterfaceHeat.P_xHabTemp60 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[10], 
	i_rProcessValue:= I_rTemperatura60, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp60 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[60], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[60], 
	iq_stParameterSetsPID:= stParameterSetsPID[60], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[60], 
	q_etResult=> TEMP.iCrtlTempStsTemp60, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp60, 
	q_xPwmOutput=> Q_xAquecimento60, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp60, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp60);

rPwmEntrada[60]:= TEMP.rCrtlTempPotTemp60*(rSetPorcentagemSuperior[10]/100);	

PWM[60].i_stPara.tCyclTime:=T#10MS;
PWM[60].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[60](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[60], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm60, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 61

SR_ControleTemperatura.FbCrtlAquecimento[61](
	i_xEnable:= InterfaceHeat.P_xHabTemp61 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[11], 
	i_rProcessValue:= I_rTemperatura61, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp61 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[61], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[61], 
	iq_stParameterSetsPID:= stParameterSetsPID[61], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[61], 
	q_etResult=> TEMP.iCrtlTempStsTemp61, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp61, 
	q_xPwmOutput=> Q_xAquecimento61, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp61, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp61);

rPwmEntrada[61]:= TEMP.rCrtlTempPotTemp6*(rSetPorcentagemSuperior[11]/100);	

PWM[61].i_stPara.tCyclTime:=T#10MS;
PWM[61].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[61](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[61], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm61, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 62

SR_ControleTemperatura.FbCrtlAquecimento[62](
	i_xEnable:= InterfaceHeat.P_xHabTemp62 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[12], 
	i_rProcessValue:= I_rTemperatura62, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp62 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[62], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[62], 
	iq_stParameterSetsPID:= stParameterSetsPID[62], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[62], 
	q_etResult=> TEMP.iCrtlTempStsTemp62, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp62, 
	q_xPwmOutput=> Q_xAquecimento62, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp62, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp62);

rPwmEntrada[62]:= TEMP.rCrtlTempPotTemp62*(rSetPorcentagemSuperior[12]/100);	

PWM[62].i_stPara.tCyclTime:=T#10MS;
PWM[62].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[62](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[62], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm62, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 63

SR_ControleTemperatura.FbCrtlAquecimento[63](
	i_xEnable:= InterfaceHeat.P_xHabTemp63 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[13], 
	i_rProcessValue:= I_rTemperatura63, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp63 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[63], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[63], 
	iq_stParameterSetsPID:= stParameterSetsPID[63], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[63], 
	q_etResult=> TEMP.iCrtlTempStsTemp63, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp63, 
	q_xPwmOutput=> Q_xAquecimento63, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp63, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp63);

rPwmEntrada[63]:= TEMP.rCrtlTempPotTemp63*(rSetPorcentagemSuperior[13]/100);	

PWM[63].i_stPara.tCyclTime:=T#10MS;
PWM[63].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[63](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[63], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm63, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 64

SR_ControleTemperatura.FbCrtlAquecimento[64](
	i_xEnable:= InterfaceHeat.P_xHabTemp64 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[14], 
	i_rProcessValue:= I_rTemperatura64, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp64 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[64], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[64], 
	iq_stParameterSetsPID:= stParameterSetsPID[64], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[64], 
	q_etResult=> TEMP.iCrtlTempStsTemp64, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp64, 
	q_xPwmOutput=> Q_xAquecimento64, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp64, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp64);

rPwmEntrada[64]:= TEMP.rCrtlTempPotTemp64*(rSetPorcentagemSuperior[14]/100);	

PWM[64].i_stPara.tCyclTime:=T#10MS;
PWM[64].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[64](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[64], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm64, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 65

SR_ControleTemperatura.FbCrtlAquecimento[65](
	i_xEnable:= InterfaceHeat.P_xHabTemp65 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[15], 
	i_rProcessValue:= I_rTemperatura65, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp65 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[65], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[65], 
	iq_stParameterSetsPID:= stParameterSetsPID[65], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[65], 
	q_etResult=> TEMP.iCrtlTempStsTemp65, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp65, 
	q_xPwmOutput=> Q_xAquecimento65, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp65, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp65);

rPwmEntrada[65]:= TEMP.rCrtlTempPotTemp65*(rSetPorcentagemSuperior[15]/100);	

PWM[65].i_stPara.tCyclTime:=T#10MS;
PWM[65].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[65](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[65], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm65, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 66

SR_ControleTemperatura.FbCrtlAquecimento[66](
	i_xEnable:= InterfaceHeat.P_xHabTemp66 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[16], 
	i_rProcessValue:= I_rTemperatura66, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp66 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[66], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[66], 
	iq_stParameterSetsPID:= stParameterSetsPID[66], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[66], 
	q_etResult=> TEMP.iCrtlTempStsTemp66, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp66, 
	q_xPwmOutput=> Q_xAquecimento66, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp66, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp66);

rPwmEntrada[66]:= TEMP.rCrtlTempPotTemp66*(rSetPorcentagemSuperior[16]/100);	

PWM[66].i_stPara.tCyclTime:=T#10MS;
PWM[66].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[66](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[66], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm66, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 67

SR_ControleTemperatura.FbCrtlAquecimento[67](
	i_xEnable:= InterfaceHeat.P_xHabTemp67 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[17], 
	i_rProcessValue:= I_rTemperatura67, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp67 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[67], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[67], 
	iq_stParameterSetsPID:= stParameterSetsPID[67], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[67], 
	q_etResult=> TEMP.iCrtlTempStsTemp67, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp67, 
	q_xPwmOutput=> Q_xAquecimento67, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp67, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp67);

rPwmEntrada[67]:= TEMP.rCrtlTempPotTemp67*(rSetPorcentagemSuperior[17]/100);	

PWM[67].i_stPara.tCyclTime:=T#10MS;
PWM[67].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[67](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[67], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm67, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 68

SR_ControleTemperatura.FbCrtlAquecimento[68](
	i_xEnable:= InterfaceHeat.P_xHabTemp68 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[18], 
	i_rProcessValue:= I_rTemperatura68, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp68 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[68], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[68], 
	iq_stParameterSetsPID:= stParameterSetsPID[68], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[68], 
	q_etResult=> TEMP.iCrtlTempStsTemp68, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp68, 
	q_xPwmOutput=> Q_xAquecimento68, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp68, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp68);

rPwmEntrada[68]:= TEMP.rCrtlTempPotTemp68*(rSetPorcentagemSuperior[18]/100);	

PWM[68].i_stPara.tCyclTime:=T#10MS;
PWM[68].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[68](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[68], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm68, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 69

SR_ControleTemperatura.FbCrtlAquecimento[69](
	i_xEnable:= InterfaceHeat.P_xHabTemp69 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[19], 
	i_rProcessValue:= I_rTemperatura69, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp69 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[69], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[69], 
	iq_stParameterSetsPID:= stParameterSetsPID[69], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[69], 
	q_etResult=> TEMP.iCrtlTempStsTemp69, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp69, 
	q_xPwmOutput=> Q_xAquecimento69, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp69, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp69);

rPwmEntrada[69]:= TEMP.rCrtlTempPotTemp69*(rSetPorcentagemSuperior[19]/100);	

PWM[69].i_stPara.tCyclTime:=T#10MS;
PWM[69].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[69](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[69], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm69, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 70

SR_ControleTemperatura.FbCrtlAquecimento[70](
	i_xEnable:= InterfaceHeat.P_xHabTemp70 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[20], 
	i_rProcessValue:= I_rTemperatura70, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp70 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[70], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[70], 
	iq_stParameterSetsPID:= stParameterSetsPID[70], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[70], 
	q_etResult=> TEMP.iCrtlTempStsTemp70, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp70, 
	q_xPwmOutput=> Q_xAquecimento70, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp70, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp70);

rPwmEntrada[70]:= TEMP.rCrtlTempPotTemp70*(rSetPorcentagemSuperior[20]/100);	

PWM[70].i_stPara.tCyclTime:=T#10MS;
PWM[70].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[70](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[70], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm70, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 71

SR_ControleTemperatura.FbCrtlAquecimento[71](
	i_xEnable:= InterfaceHeat.P_xHabTemp71 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[21], 
	i_rProcessValue:= I_rTemperatura71, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp71 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[71], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[71], 
	iq_stParameterSetsPID:= stParameterSetsPID[71], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[71], 
	q_etResult=> TEMP.iCrtlTempStsTemp71, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp71, 
	q_xPwmOutput=> Q_xAquecimento71, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp71, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp71);

rPwmEntrada[71]:= TEMP.rCrtlTempPotTemp71*(rSetPorcentagemSuperior[21]/100);	

PWM[71].i_stPara.tCyclTime:=T#10MS;
PWM[71].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[71](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[71], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm71, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 72

SR_ControleTemperatura.FbCrtlAquecimento[72](
	i_xEnable:= InterfaceHeat.P_xHabTemp72 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[22], 
	i_rProcessValue:= I_rTemperatura72, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp72 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[72], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[72], 
	iq_stParameterSetsPID:= stParameterSetsPID[72], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[72], 
	q_etResult=> TEMP.iCrtlTempStsTemp72, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp72, 
	q_xPwmOutput=> Q_xAquecimento72, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp72, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp72);

rPwmEntrada[72]:= TEMP.rCrtlTempPotTemp72*(rSetPorcentagemSuperior[22]/100);	

PWM[72].i_stPara.tCyclTime:=T#10MS;
PWM[72].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[72](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[72], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm72, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 73

SR_ControleTemperatura.FbCrtlAquecimento[73](
	i_xEnable:= InterfaceHeat.P_xHabTemp73 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[23], 
	i_rProcessValue:= I_rTemperatura73, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp73 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[73], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[73], 
	iq_stParameterSetsPID:= stParameterSetsPID[73], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[73], 
	q_etResult=> TEMP.iCrtlTempStsTemp73, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp73, 
	q_xPwmOutput=> Q_xAquecimento73, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp73, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp73);

rPwmEntrada[73]:= TEMP.rCrtlTempPotTemp73*(rSetPorcentagemSuperior[23]/100);	

PWM[73].i_stPara.tCyclTime:=T#10MS;
PWM[73].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[73](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[73], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm73, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 74

SR_ControleTemperatura.FbCrtlAquecimento[74](
	i_xEnable:= InterfaceHeat.P_xHabTemp74 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[24], 
	i_rProcessValue:= I_rTemperatura74, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp74 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[74], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[74], 
	iq_stParameterSetsPID:= stParameterSetsPID[74], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[74], 
	q_etResult=> TEMP.iCrtlTempStsTemp74, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp74, 
	q_xPwmOutput=> Q_xAquecimento74, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp74, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp74);

rPwmEntrada[74]:= TEMP.rCrtlTempPotTemp74*(rSetPorcentagemSuperior[24]/100);	

PWM[74].i_stPara.tCyclTime:=T#10MS;
PWM[74].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[74](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[74], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm74, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 75

FbAqueceRampa[75](
	iTermopar:= TermoparLogicoSuperior[25], 
	rSpTemperatura:= rSetPointTemperaturaSuperior[25], 
	iTempoEstab:= iTempoEstabRampa, 
	xReset:= , 
	xStartRampaCiclo=> , 
	xRampaAtiva=> xRampaAqAtiva[75], 
	TemperUp=> , 
	TemperDown=> , 
	rSpTemperaturaUp=> , 
	rSetTemperaturaRampa=> rSetTemperaturaRampaAq[75] );

SR_ControleTemperatura.FbCrtlAquecimento[75](
	i_xEnable:= InterfaceHeat.P_xHabTemp75 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[25], 
	i_rProcessValue:= I_rTemperatura75, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp75 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[75], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[75], 
	iq_stParameterSetsPID:= stParameterSetsPID[75], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[75], 
	q_etResult=> TEMP.iCrtlTempStsTemp75, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp75, 
	q_xPwmOutput=> Q_xAquecimento75, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp75, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp75);

rPwmEntrada[75]:= TEMP.rCrtlTempPotTemp75*(rSetPorcentagemSuperior[25]/100);	

PWM[75].i_stPara.tCyclTime:=T#10MS;
PWM[75].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[75](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[75], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm75, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	
	
	(*IF xRampaAqAtiva[75] THEN
		xReleSsrSuperior[25]:=Q_xAquecimento75;
	ELSE
		xReleSsrSuperior[25]:=Q_xAquecimentoPwm75;
	END_IF*)

// Controle Resistencia 76

SR_ControleTemperatura.FbCrtlAquecimento[76](
	i_xEnable:= InterfaceHeat.P_xHabTemp76 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[26], 
	i_rProcessValue:= I_rTemperatura76, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp76 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[76], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[76], 
	iq_stParameterSetsPID:= stParameterSetsPID[76], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[76], 
	q_etResult=> TEMP.iCrtlTempStsTemp76, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp76, 
	q_xPwmOutput=> Q_xAquecimento76, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp76, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp76);

rPwmEntrada[76]:= TEMP.rCrtlTempPotTemp76*(rSetPorcentagemSuperior[26]/100);	

PWM[76].i_stPara.tCyclTime:=T#10MS;
PWM[76].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[76](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[76], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm76, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 77

SR_ControleTemperatura.FbCrtlAquecimento[77](
	i_xEnable:= InterfaceHeat.P_xHabTemp77 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[27], 
	i_rProcessValue:= I_rTemperatura77, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp77 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[77], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[77], 
	iq_stParameterSetsPID:= stParameterSetsPID[77], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[77], 
	q_etResult=> TEMP.iCrtlTempStsTemp77, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp77, 
	q_xPwmOutput=> Q_xAquecimento77, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp77, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp77);

rPwmEntrada[77]:= TEMP.rCrtlTempPotTemp77*(rSetPorcentagemSuperior[27]/100);	

PWM[77].i_stPara.tCyclTime:=T#10MS;
PWM[77].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[77](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[77], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm77, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 78

SR_ControleTemperatura.FbCrtlAquecimento[78](
	i_xEnable:= InterfaceHeat.P_xHabTemp78 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[28], 
	i_rProcessValue:= I_rTemperatura78, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp78 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[78], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[78], 
	iq_stParameterSetsPID:= stParameterSetsPID[78], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[78], 
	q_etResult=> TEMP.iCrtlTempStsTemp78, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp78, 
	q_xPwmOutput=> Q_xAquecimento78, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp78, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp78);

	rPwmEntrada[78]:= TEMP.rCrtlTempPotTemp78*(rSetPorcentagemSuperior[28]/100);	

PWM[78].i_stPara.tCyclTime:=T#10MS;
PWM[78].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[78](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[78], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm78, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 79

SR_ControleTemperatura.FbCrtlAquecimento[79](
	i_xEnable:= InterfaceHeat.P_xHabTemp79 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[29], 
	i_rProcessValue:= I_rTemperatura79, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp79 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[79], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[79], 
	iq_stParameterSetsPID:= stParameterSetsPID[79], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[79], 
	q_etResult=> TEMP.iCrtlTempStsTemp79, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp79, 
	q_xPwmOutput=> Q_xAquecimento79, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp79, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp79);

	rPwmEntrada[79]:= TEMP.rCrtlTempPotTemp79*(rSetPorcentagemSuperior[29]/100);	

PWM[79].i_stPara.tCyclTime:=T#10MS;
PWM[79].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[79](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[79], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm79, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 80

SR_ControleTemperatura.FbCrtlAquecimento[80](
	i_xEnable:= InterfaceHeat.P_xHabTemp80 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[30], 
	i_rProcessValue:= I_rTemperatura80, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp80 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[80], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[80], 
	iq_stParameterSetsPID:= stParameterSetsPID[80], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[80], 
	q_etResult=> TEMP.iCrtlTempStsTemp80, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp80, 
	q_xPwmOutput=> Q_xAquecimento80, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp80, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp80);

rPwmEntrada[80]:= TEMP.rCrtlTempPotTemp80*(rSetPorcentagemSuperior[30]/100);	

PWM[80].i_stPara.tCyclTime:=T#10MS;
PWM[80].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[80](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[80], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm80, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 81

SR_ControleTemperatura.FbCrtlAquecimento[81](
	i_xEnable:= InterfaceHeat.P_xHabTemp81 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[31], 
	i_rProcessValue:= I_rTemperatura81, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp81 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[81], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[81], 
	iq_stParameterSetsPID:= stParameterSetsPID[81], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[81], 
	q_etResult=> TEMP.iCrtlTempStsTemp81, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp81, 
	q_xPwmOutput=> Q_xAquecimento81, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp81, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp81);

rPwmEntrada[81]:= TEMP.rCrtlTempPotTemp81*(rSetPorcentagemSuperior[31]/100);	

PWM[81].i_stPara.tCyclTime:=T#10MS;
PWM[81].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[81](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[81], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm81, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 82

SR_ControleTemperatura.FbCrtlAquecimento[82](
	i_xEnable:= InterfaceHeat.P_xHabTemp82 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[32], 
	i_rProcessValue:= I_rTemperatura82, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp82 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[82], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[82], 
	iq_stParameterSetsPID:= stParameterSetsPID[82], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[82], 
	q_etResult=> TEMP.iCrtlTempStsTemp82, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp82, 
	q_xPwmOutput=> Q_xAquecimento82, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp82, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp82);

rPwmEntrada[82]:= TEMP.rCrtlTempPotTemp82*(rSetPorcentagemSuperior[32]/100);	

PWM[82].i_stPara.tCyclTime:=T#10MS;
PWM[82].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[82](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[82], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm82, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 83

SR_ControleTemperatura.FbCrtlAquecimento[83](
	i_xEnable:= InterfaceHeat.P_xHabTemp83 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[33], 
	i_rProcessValue:= I_rTemperatura83, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp83 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[83], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[83], 
	iq_stParameterSetsPID:= stParameterSetsPID[83], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[83], 
	q_etResult=> TEMP.iCrtlTempStsTemp83, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp83, 
	q_xPwmOutput=> Q_xAquecimento83, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp83, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp83);

rPwmEntrada[83]:= TEMP.rCrtlTempPotTemp83*(rSetPorcentagemSuperior[33]/100);	

PWM[83].i_stPara.tCyclTime:=T#10MS;
PWM[83].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[83](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[83], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm83, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 84

SR_ControleTemperatura.FbCrtlAquecimento[84](
	i_xEnable:= InterfaceHeat.P_xHabTemp84 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[34], 
	i_rProcessValue:= I_rTemperatura84, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp84 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[84], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[84], 
	iq_stParameterSetsPID:= stParameterSetsPID[84], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[84], 
	q_etResult=> TEMP.iCrtlTempStsTemp84, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp84, 
	q_xPwmOutput=> Q_xAquecimento84, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp84, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp84);

rPwmEntrada[84]:= TEMP.rCrtlTempPotTemp84*(rSetPorcentagemSuperior[34]/100);	

PWM[84].i_stPara.tCyclTime:=T#10MS;
PWM[84].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[84](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[84], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm84, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 85

SR_ControleTemperatura.FbCrtlAquecimento[85](
	i_xEnable:= InterfaceHeat.P_xHabTemp85 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[35], 
	i_rProcessValue:= I_rTemperatura85, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp85 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[85], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[85], 
	iq_stParameterSetsPID:= stParameterSetsPID[85], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[85], 
	q_etResult=> TEMP.iCrtlTempStsTemp85, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp85, 
	q_xPwmOutput=> Q_xAquecimento85, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp85, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp85);

rPwmEntrada[85]:= TEMP.rCrtlTempPotTemp85*(rSetPorcentagemSuperior[35]/100);	

PWM[85].i_stPara.tCyclTime:=T#10MS;
PWM[85].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[85](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[85], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm85, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 86

SR_ControleTemperatura.FbCrtlAquecimento[86](
	i_xEnable:= InterfaceHeat.P_xHabTemp86 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[36], 
	i_rProcessValue:= I_rTemperatura86, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp86 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[86], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[86], 
	iq_stParameterSetsPID:= stParameterSetsPID[86], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[86], 
	q_etResult=> TEMP.iCrtlTempStsTemp86, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp86, 
	q_xPwmOutput=> Q_xAquecimento86, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp86, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp86);

rPwmEntrada[86]:= TEMP.rCrtlTempPotTemp86*(rSetPorcentagemSuperior[36]/100);	

PWM[86].i_stPara.tCyclTime:=T#10MS;
PWM[86].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[86](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[86], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm86, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 87

SR_ControleTemperatura.FbCrtlAquecimento[87](
	i_xEnable:= InterfaceHeat.P_xHabTemp87 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[37], 
	i_rProcessValue:= I_rTemperatura87, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp87 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[87], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[87], 
	iq_stParameterSetsPID:= stParameterSetsPID[87], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[87], 
	q_etResult=> TEMP.iCrtlTempStsTemp87, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp87, 
	q_xPwmOutput=> Q_xAquecimento87, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp87, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp87);

	rPwmEntrada[87]:= TEMP.rCrtlTempPotTemp87*(rSetPorcentagemSuperior[37]/100);	

PWM[87].i_stPara.tCyclTime:=T#10MS;
PWM[87].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[87](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[87], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm87, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 88

SR_ControleTemperatura.FbCrtlAquecimento[88](
	i_xEnable:= InterfaceHeat.P_xHabTemp88 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[38], 
	i_rProcessValue:= I_rTemperatura88, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp88 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[88], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[88], 
	iq_stParameterSetsPID:= stParameterSetsPID[88], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[88], 
	q_etResult=> TEMP.iCrtlTempStsTemp88, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp88, 
	q_xPwmOutput=> Q_xAquecimento88, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp88, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp88);

rPwmEntrada[88]:= TEMP.rCrtlTempPotTemp88*(rSetPorcentagemSuperior[38]/100);	

PWM[88].i_stPara.tCyclTime:=T#10MS;
PWM[88].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[88](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[88], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm88, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 89

SR_ControleTemperatura.FbCrtlAquecimento[89](
	i_xEnable:= InterfaceHeat.P_xHabTemp89 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[39], 
	i_rProcessValue:= I_rTemperatura89, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp89 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[89], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[89], 
	iq_stParameterSetsPID:= stParameterSetsPID[89], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[89], 
	q_etResult=> TEMP.iCrtlTempStsTemp89, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp89, 
	q_xPwmOutput=> Q_xAquecimento89, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp89, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp89);

rPwmEntrada[89]:= TEMP.rCrtlTempPotTemp89*(rSetPorcentagemSuperior[39]/100);	

PWM[89].i_stPara.tCyclTime:=T#10MS;
PWM[89].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[89](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[89], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm89, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 90

SR_ControleTemperatura.FbCrtlAquecimento[90](
	i_xEnable:= InterfaceHeat.P_xHabTemp90 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[40], 
	i_rProcessValue:= I_rTemperatura90, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp90 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[90], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[90], 
	iq_stParameterSetsPID:= stParameterSetsPID[90], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[90], 
	q_etResult=> TEMP.iCrtlTempStsTemp90, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp90, 
	q_xPwmOutput=> Q_xAquecimento90, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp90, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp90);

rPwmEntrada[90]:= TEMP.rCrtlTempPotTemp90*(rSetPorcentagemSuperior[40]/100);	

PWM[90].i_stPara.tCyclTime:=T#10MS;
PWM[90].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[90](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[90], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm90, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 91

SR_ControleTemperatura.FbCrtlAquecimento[91](
	i_xEnable:= InterfaceHeat.P_xHabTemp91 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[41], 
	i_rProcessValue:= I_rTemperatura91, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp91 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[91], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[91], 
	iq_stParameterSetsPID:= stParameterSetsPID[91], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[91], 
	q_etResult=> TEMP.iCrtlTempStsTemp91, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp91, 
	q_xPwmOutput=> Q_xAquecimento91, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp91, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp91);

rPwmEntrada[91]:= TEMP.rCrtlTempPotTemp91*(rSetPorcentagemSuperior[41]/100);	

PWM[91].i_stPara.tCyclTime:=T#10MS;
PWM[91].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[91](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[91], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm91, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 92

SR_ControleTemperatura.FbCrtlAquecimento[92](
	i_xEnable:= InterfaceHeat.P_xHabTemp92 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[42], 
	i_rProcessValue:= I_rTemperatura92, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp92 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[92], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[92], 
	iq_stParameterSetsPID:= stParameterSetsPID[92], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[92], 
	q_etResult=> TEMP.iCrtlTempStsTemp92, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp92, 
	q_xPwmOutput=> Q_xAquecimento92, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp92, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp92);

rPwmEntrada[92]:= TEMP.rCrtlTempPotTemp92*(rSetPorcentagemSuperior[42]/100);	

PWM[92].i_stPara.tCyclTime:=T#10MS;
PWM[92].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[92](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[92], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm92, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 93

SR_ControleTemperatura.FbCrtlAquecimento[93](
	i_xEnable:= InterfaceHeat.P_xHabTemp93 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[43], 
	i_rProcessValue:= I_rTemperatura93, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp93 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[93], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[93], 
	iq_stParameterSetsPID:= stParameterSetsPID[93], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[93], 
	q_etResult=> TEMP.iCrtlTempStsTemp93, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp93, 
	q_xPwmOutput=> Q_xAquecimento93, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp93, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp93);

rPwmEntrada[93]:= TEMP.rCrtlTempPotTemp93*(rSetPorcentagemSuperior[43]/100);	

PWM[93].i_stPara.tCyclTime:=T#10MS;
PWM[93].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[93](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[93], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm93, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 94

SR_ControleTemperatura.FbCrtlAquecimento[94](
	i_xEnable:= InterfaceHeat.P_xHabTemp94 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[44], 
	i_rProcessValue:= I_rTemperatura94, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp94 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[94], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[94], 
	iq_stParameterSetsPID:= stParameterSetsPID[94], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[94], 
	q_etResult=> TEMP.iCrtlTempStsTemp94, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp94, 
	q_xPwmOutput=> Q_xAquecimento94, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp94, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp94);

rPwmEntrada[94]:= TEMP.rCrtlTempPotTemp94*(rSetPorcentagemSuperior[44]/100);	

PWM[94].i_stPara.tCyclTime:=T#10MS;
PWM[94].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[94](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[94], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm94, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 95

SR_ControleTemperatura.FbCrtlAquecimento[95](
	i_xEnable:= InterfaceHeat.P_xHabTemp95 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[45], 
	i_rProcessValue:= I_rTemperatura95, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp95 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[95], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[95], 
	iq_stParameterSetsPID:= stParameterSetsPID[95], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[95], 
	q_etResult=> TEMP.iCrtlTempStsTemp95, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp95, 
	q_xPwmOutput=> Q_xAquecimento95, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp95, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp95);

rPwmEntrada[95]:= TEMP.rCrtlTempPotTemp95*(rSetPorcentagemSuperior[45]/100);	

PWM[95].i_stPara.tCyclTime:=T#10MS;
PWM[95].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[95](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[95], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm95, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 96

SR_ControleTemperatura.FbCrtlAquecimento[96](
	i_xEnable:= InterfaceHeat.P_xHabTemp96 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[46], 
	i_rProcessValue:= I_rTemperatura96, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp96 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[96], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[96], 
	iq_stParameterSetsPID:= stParameterSetsPID[96], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[96], 
	q_etResult=> TEMP.iCrtlTempStsTemp96, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp96, 
	q_xPwmOutput=> Q_xAquecimento96, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp96, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp96);

rPwmEntrada[96]:= TEMP.rCrtlTempPotTemp96*(rSetPorcentagemSuperior[46]/100);	

PWM[96].i_stPara.tCyclTime:=T#10MS;
PWM[96].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[96](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[96], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm96, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 97

SR_ControleTemperatura.FbCrtlAquecimento[97](
	i_xEnable:= InterfaceHeat.P_xHabTemp97 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[47], 
	i_rProcessValue:= I_rTemperatura97, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp97 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[97], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[97], 
	iq_stParameterSetsPID:= stParameterSetsPID[97], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[97], 
	q_etResult=> TEMP.iCrtlTempStsTemp97, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp97, 
	q_xPwmOutput=> Q_xAquecimento97, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp97, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp97);

rPwmEntrada[97]:= TEMP.rCrtlTempPotTemp97*(rSetPorcentagemSuperior[47]/100);	

PWM[97].i_stPara.tCyclTime:=T#10MS;
PWM[97].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[97](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[97], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm97, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 98

SR_ControleTemperatura.FbCrtlAquecimento[98](
	i_xEnable:= InterfaceHeat.P_xHabTemp98 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[48], 
	i_rProcessValue:= I_rTemperatura98, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp98 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[98], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[98], 
	iq_stParameterSetsPID:= stParameterSetsPID[98], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[98], 
	q_etResult=> TEMP.iCrtlTempStsTemp98, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp98, 
	q_xPwmOutput=> Q_xAquecimento98, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp98, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp98);

	rPwmEntrada[98]:= TEMP.rCrtlTempPotTemp98*(rSetPorcentagemSuperior[48]/100);	

PWM[98].i_stPara.tCyclTime:=T#10MS;
PWM[98].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[98](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[98], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm98, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

// Controle Resistencia 99

SR_ControleTemperatura.FbCrtlAquecimento[99](
	i_xEnable:= InterfaceHeat.P_xHabTemp99 OR xLigaDesligaSupG01, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[49], 
	i_rProcessValue:= I_rTemperatura99, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp99 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[99], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[99], 
	iq_stParameterSetsPID:= stParameterSetsPID[99], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[99], 
	q_etResult=> TEMP.iCrtlTempStsTemp99, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp99, 
	q_xPwmOutput=> Q_xAquecimento99, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp99, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp99);

rPwmEntrada[99]:= TEMP.rCrtlTempPotTemp99*(rSetPorcentagemSuperior[49]/100);	

PWM[99].i_stPara.tCyclTime:=T#10MS;
PWM[99].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[99](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[99], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm99, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	

	// Controle Resistencia 100

SR_ControleTemperatura.FbCrtlAquecimento[100](
	i_xEnable:= InterfaceHeat.P_xHabTemp100 OR xLigaDesligaSupG02, 
	i_rSetPoint:= rSetPointTemperaturaSuperior[50], 
	i_rProcessValue:= I_rTemperatura100, 
	i_xManualMode:= , 
	i_rManualValue:= , 
	i_xAutoTune:= TEMP.xAutoTuneTemp100 OR xAutoTuneTempGeral, 
	i_xHold:= , 
	i_xReset:= InterfaceHeat.xReset, 
	i_stTemperatureControl:= stTemperatureControl[100], 
	iq_etSelectParameterSetPID:= etSelectParameterSetPID[100], 
	iq_stParameterSetsPID:= stParameterSetsPID[100], 
	q_xActive=> , 
	q_xReady=> , 
	q_xError=> TEMP.xCrtlTemperatura[100], 
	q_etResult=> TEMP.iCrtlTempStsTemp100, 
	q_sResultMsg=> , 
	q_rAnalogOutput=> TEMP.rCrtlTempPotTemp100, 
	q_xPwmOutput=> Q_xAquecimento100, 
	q_xAutoTuneActive=> TEMP.xAutoTuneAtivoTemp100, 
	q_etStatusAutoTune=> TEMP.iAutoTuneStsTemp100);
	
rPwmEntrada[100]:= TEMP.rCrtlTempPotTemp100*(rSetPorcentagemSuperior[50]/100);	

PWM[100].i_stPara.tCyclTime:=T#10MS;
PWM[100].i_stPara.tPwmPeriod:=T#1000MS;	
PWM[100](
	i_xEn:= 	xHabilitaBlocosControleSuperior, 
	i_rIput:= 	rPwmEntrada[100], 
	i_stPara:= 	, 
	i_xErrRst:= xResetPid, 
	q_xEn=> 	, 
	q_xBusy=> 	, 
	q_xPstv=> 	Q_xAquecimentoPwm100, 
	q_xNgtv=> 	, 
	q_xErr=> 	, 
	q_uiErrId=> );	


//----------
	
	_30_AutoTunning();
