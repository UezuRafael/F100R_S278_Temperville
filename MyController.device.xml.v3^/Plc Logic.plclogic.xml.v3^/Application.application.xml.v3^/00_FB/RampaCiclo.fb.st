__METADATA__
{
  "v3Meta": {
    "objectGuid": "de60dccb-f99d-40e6-befb-cf820190e895",
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
FUNCTION_BLOCK RampaCiclo
VAR_INPUT
	iTermopar	: INT ;
	rSpTemperatura	: REAL ;
	iTempoEstab	: INT ;
	xReset		: BOOL ;
END_VAR
VAR_OUTPUT
	xStartRampaCiclo	: BOOL ;
	xRampaAtiva	: BOOL ;
	TemperUp	: BOOL ;
	TemperDown	: BOOL ;
	rSpTemperaturaUp	: REAL ;
	rSetTemperaturaRampa: REAL ;
END_VAR
VAR
	iDadoEntrada: INT ;
	iDadoSaida	: INT ;
	
	rTermopar	: REAL ;
	
	rTempoInicialRamp : REAL ;
	rTempoFinalRamp: REAL ;
	rTempoRamp	: REAL ;
	
	rTemperaturaRampIni: REAL ;
	rTemperaturaRampFim: REAL ;
	
	rTamperaturaRamp	: REAL ;
	rGradienteRamp		:REAL ;
	
	rTempoTemperatura: REAL ;
	rTempoTemperaturaSp: REAL ;
	
	TgTemper : TimerGeneration;

	PulsoEntrada: PulsoPositivo;
	xPulsoEntrada: BOOL ;
	xPulsoSaida	: BOOL;

	TonDlyCarga	: TON ;
	xTonDlyCargaIn	: BOOL ;
	xTonDlyCargaQ	: BOOL ;
	tTonDlyCargaPt	: BOOL ;
	
	PulsoStartRampa : PulsoPositivo ;
	xPulsoStartRampa: BOOL ;
	
	TonCicloRamp	: TON ;
	xTonCicloRampIn	: BOOL ;
	xTonCicloRampQ	: BOOL ;
	
	rTemperaturaSpRampOk	: BOOL;
	rTemperaturaRampOk	: BOOL; 
	rTempoRampOk 	: BOOL; 
	
	bloqSpR: BOOL;
	bloqR: BOOL;
END_VAR
__IMPLEMENTATION__

// Teste Aquecimento Rampa

rTermopar:=INT_TO_REAL(iTermopar/10);

iDadoEntrada:=	iTermopar; 

TgTemper(ENABLE:= TRUE, TIMELOW:= T#500MS, TIMEHIGH:=T#500MS , OUT=> xPulsoEntrada);
	
PulsoEntrada(Entrada:=xPulsoEntrada , SaidaPulsoPo=> xPulsoSaida);

	IF xPulsoSaida THEN
		iDadoSaida:=iDadoEntrada;
		iDadoEntrada:=iTermopar;
	END_IF

	IF 	iDadoSaida<iTermopar THEN
		TemperUp:=TRUE;
		TemperDown:=FALSE;
	END_IF

	IF 	iDadoSaida>iTermopar THEN
		TemperUp:=FALSE;
		TemperDown:=TRUE;
	END_IF

(*IF xReset THEN
	iDadoSaida:=0;
END_IF*)

xTonDlyCargaIn:=xFornoCheio;
TonDlyCarga(IN:= xTonDlyCargaIn, PT:=T#15S , Q=> xTonDlyCargaQ, ET=> );

IF xTonDlyCargaQ AND TemperUp THEN
	xStartRampaCiclo:=TRUE;
END_IF

IF NOT xFornoCheio THEN
	xStartRampaCiclo:=FALSE;
	xRampaAtiva	:= FALSE ;
END_IF

PulsoStartRampa(Entrada:= xStartRampaCiclo, SaidaPulsoPo=> xPulsoStartRampa);

IF xPulsoStartRampa THEN
	rTempoInicialRamp:=INT_TO_REAL(iTempoAquecFornoDecorrido);
	rTempoFinalRamp:=INT_TO_REAL(iTempoAquecimForno-iTempoEstab);
	rTemperaturaRampIni:=rTermopar;
	rTemperaturaRampFim:=rSpTemperatura; 
	rSpTemperaturaUp:=rTemperaturaRampIni;
	xRampaAtiva	:= TRUE ;
	bloqSpR:=FALSE;
	bloqR:=FALSE;
END_IF

rTempoRamp:=rTempoFinalRamp-rTempoInicialRamp;
rTamperaturaRamp:=rTemperaturaRampFim-rTemperaturaRampIni;

rGradienteRamp:=rTamperaturaRamp/rTempoRamp;

xTonCicloRampIn := NOT xTonCicloRampQ AND xStartRampaCiclo ;
TonCicloRamp(IN:= xTonCicloRampIn, PT:=T#940MS , Q=> xTonCicloRampQ, ET=> );
IF xTonCicloRampQ AND rSpTemperaturaUp<=rSpTemperatura THEN
	rSpTemperaturaUp:=rSpTemperaturaUp+rGradienteRamp;
END_IF

IF rSpTemperaturaUp >= rSpTemperatura THEN rTemperaturaSpRampOk :=TRUE; ELSE rTemperaturaSpRampOk :=FALSE; END_IF
IF 	rTempoFinalRamp <= iTempoAquecFornoDecorrido THEN rTempoRampOk:=TRUE ; ELSE rTempoRampOk:=FALSE; END_IF 
IF  rTermopar >= rSpTemperatura THEN rTemperaturaRampOk :=TRUE; ELSE rTemperaturaRampOk :=FALSE; END_IF
	
IF rTemperaturaSpRampOk AND NOT bloqSpR THEN
rTempoTemperaturaSp:=iTempoAquecFornoDecorrido;
bloqSpR:=TRUE;
END_IF
IF rTemperaturaRampOk AND NOT bloqR THEN
rTempoTemperatura:=iTempoAquecFornoDecorrido;
xRampaAtiva	:= FALSE ;
bloqR:=TRUE;
END_IF

IF xStartRampaCiclo THEN
	rSetTemperaturaRampa:=rSpTemperaturaUp;
//	xReleSsrSuperior[24]:=xReleSsrSuperiorRampa;
ELSE
	rSetTemperaturaRampa:=rSpTemperatura;
//	xReleSsrSuperior[24]:=Q_xAquecimentoPwm;
END_IF

// Liga/Desliga Resistência
(*IF rSetTemperaturaRampa>=rTermopar THEN
		xReleSsrSuperiorRampa:=TRUE;
ELSE
		xReleSsrSuperiorRampa:=FALSE;
END_IF*)
