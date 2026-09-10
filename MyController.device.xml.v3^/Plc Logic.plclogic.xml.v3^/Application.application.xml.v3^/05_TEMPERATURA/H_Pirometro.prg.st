__METADATA__
{
  "v3Meta": {
    "objectGuid": "91e29733-0acf-4294-acbc-81ebbc2c84fb",
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
PROGRAM H_Pirometro
VAR
	xPulsoEntrada74: BOOL;
	xReset74: BOOL;
	iDadoEntrada74: INT;

	iDadoSaida74: INT;

	PulsoEntrada74: PulsoPositivo;
	TgTemper74 : TimerGeneration;
	xPulsoSaida74: BOOL;
	
	PassoMonitorTemper74 : INT ;
	TemperUp74	: BOOL;
	TemperDown74	: BOOL;
	
	xStartRampaCiclo74 : BOOL ;
	PulsoStartRampa74 : PulsoPositivo ;
	xPulsoStartRampa74: BOOL ;

	rTempoInicialRamp74 : REAL ;
	rTempoFinalRamp74: REAL ;
	rTempoRamp74	: REAL ;
	iTempoEstab74	: INT ;
	
	rTemperaturaRampIni74: REAL ;
	rTemperaturaRampFim74: REAL ;
	
	rTamperaturaRamp74	: REAL ;
	rGradienteRamp74		:REAL ;
	
	TonDlyCarga74	: TON ;
	xTonDlyCargaIn74	: BOOL ;
	xTonDlyCargaQ74	: BOOL ;
	
	rSpTemperaturaUp74:REAL;
	
	TonCicloRamp74	: TON ;
	xTonCicloRampIn74	: BOOL ;
	xTonCicloRampQ74	: BOOL ;
	
	rTemperaturaSpRampOk74	: BOOL;
	rTemperaturaRampOk74	: BOOL; 
	rTempoRampOk74	: BOOL; 
	
	rTempoTemperatura74: REAL ;
	rTempoTemperaturaSp74: REAL ;
	
	rSetTemperaturaRampa74	: REAL ;
	
	bloqSpR74: BOOL;
	bloqR74: BOOL;
	
	TermoparSuperior74:REAL;
	
END_VAR
__IMPLEMENTATION__
rTemperaturaPirometroInferior:= INT_TO_REAL (iTemperaturaPirometroInferior)/10;
rTemperaturaPirometroSuperior:= INT_TO_REAL (iTemperaturaPirometroSuperior)/10;


// Teste Aquecimento Rampa

iDadoEntrada74:=	TermoparSuperior[24]; // 74

TgTemper74(ENABLE:= TRUE, TIMELOW:= T#500MS, TIMEHIGH:=T#500MS , OUT=> xPulsoEntrada74);
	
PulsoEntrada74(Entrada:=xPulsoEntrada74 , SaidaPulsoPo=> xPulsoSaida74);

//CASE PassoMonitorTemper OF
	

	//0:	
	IF xPulsoSaida74 THEN
			iDadoSaida74:=iDadoEntrada74;
			iDadoEntrada74:=TermoparSuperior[24];
			//PassoMonitorTemper:=5;
		END_IF

	//5:
	IF 	iDadoSaida74<TermoparSuperior[24] THEN
			TemperUp74:=TRUE;
			TemperDown74:=FALSE;
		END_IF
		//PassoMonitorTemper:=0;
	IF 	iDadoSaida74>TermoparSuperior[24] THEN
			TemperUp74:=FALSE;
			TemperDown74:=TRUE;
		END_IF


//END_CASE

IF xReset74 THEN
	iDadoSaida74:=0;
END_IF

xTonDlyCargaIn74:=xFornoCheio;
TonDlyCarga74(IN:= xTonDlyCargaIn74, PT:=T#15S , Q=> xTonDlyCargaQ74, ET=> );

IF xTonDlyCargaQ74 AND TemperUp74 THEN
	xStartRampaCiclo74:=TRUE;
END_IF

IF NOT xFornoCheio THEN
	xStartRampaCiclo74:=FALSE;
END_IF

PulsoStartRampa74(Entrada:= xStartRampaCiclo74, SaidaPulsoPo=> xPulsoStartRampa74);

IF xPulsoStartRampa74 THEN
	rTempoInicialRamp74:=INT_TO_REAL(iTempoAquecFornoDecorrido);
	rTempoFinalRamp74:=INT_TO_REAL(iTempoAquecimForno-iTempoEstab74);
	rTemperaturaRampIni74:=INT_TO_REAL(TermoparSuperior[24]/10);
	rTemperaturaRampFim74:=rSetPointTemperaturaSuperior[24]; 
	rSpTemperaturaUp74:=rTemperaturaRampIni74;
	bloqSpR74:=FALSE;
	bloqR74:=FALSE;
END_IF

rTempoRamp74:=rTempoFinalRamp74-rTempoInicialRamp74;
rTamperaturaRamp74:=rTemperaturaRampFim74-rTemperaturaRampIni74;

rGradienteRamp74:=rTamperaturaRamp74/rTempoRamp74;

xTonCicloRampIn74 := NOT xTonCicloRampQ74 AND xStartRampaCiclo74 ;
TonCicloRamp74(IN:= xTonCicloRampIn74, PT:=T#940MS , Q=> xTonCicloRampQ74, ET=> );
IF xTonCicloRampQ74 AND rSpTemperaturaUp74<=rSetPointTemperaturaSuperior[24] THEN
	rSpTemperaturaUp74:=rSpTemperaturaUp74+rGradienteRamp74;
END_IF

IF rSpTemperaturaUp74 >= rSetPointTemperaturaSuperior[24] THEN rTemperaturaSpRampOk74 :=TRUE; ELSE rTemperaturaSpRampOk74 :=FALSE; END_IF
IF 	rTempoFinalRamp74 <= iTempoAquecFornoDecorrido THEN rTempoRampOk74:=TRUE ; ELSE rTempoRampOk74:=FALSE; END_IF 
IF  TermoparSuperior[24]/10 >= rSetPointTemperaturaSuperior[24] THEN rTemperaturaRampOk74 :=TRUE; ELSE rTemperaturaRampOk74 :=FALSE; END_IF
	
IF rTemperaturaSpRampOk74 AND NOT bloqSpR74 THEN
rTempoTemperaturaSp74:=iTempoAquecFornoDecorrido;
bloqSpR74:=TRUE;
END_IF
IF rTemperaturaRampOk74 AND NOT bloqR74 THEN
rTempoTemperatura74:=iTempoAquecFornoDecorrido;
bloqR74:=TRUE;
END_IF

IF xStartRampaCiclo74 THEN
	rSetTemperaturaRampa74:=rSpTemperaturaUp74;
	//xReleSsrSuperior[24]:=xReleSsrSuperiorRampa74;
ELSE
	rSetTemperaturaRampa74:=rSetPointTemperaturaSuperior[24];
	//xReleSsrSuperior[24]:=Q_xAquecimentoPwm74;
END_IF

TermoparSuperior74:=TermoparSuperior[24]/10;

IF rSetTemperaturaRampa74>=TermoparSuperior74 THEN
		xReleSsrSuperiorRampa74:=TRUE;
ELSE
		xReleSsrSuperiorRampa74:=FALSE;
END_IF


