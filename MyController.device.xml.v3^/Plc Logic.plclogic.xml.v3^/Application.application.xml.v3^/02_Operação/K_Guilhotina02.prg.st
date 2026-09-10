__METADATA__
{
  "v3Meta": {
    "objectGuid": "61c85ec5-222f-4a70-8555-4c170df50f78",
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
PROGRAM K_Guilhotina02
VAR
	PassoHomeGuilhotina02: INT;
	PassoAjusteGuilhotina02: INT;
	PassoPausaHomeGuilhotina02: INT;
	PassoPausaAjusteGuilhotina02: INT;
	PassoAlmHomeGuilhotina02: INT;
	PassoAlmAjusteGuilhotina02: INT;
	xSinalAjusteG02: INT;
	ContadorEncoderPo: ContadorUpDown;
	TonHomeGuilho02: TON;
	xTonHomeGuilho02In: BOOL;
	xTonHomeGuilho02Q: BOOL;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul01Guilho02: MmConversorPulso;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul02Guilho02: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilimGuilho02: PulsoConversorMm;
	xExecutaMovGuilhotina02: BOOL;
	xExecutaStopGuilhotina02: BOOL;
	xStopGuilhotina02Done: BOOL;
	xSetValorSpAltGuil02Sup: BOOL;
	iAlturaGhilhotina02Aux: INT;
	xAjustarAlturaGuilhotina02: BOOL;
	iVelocidadeHomeGuilhotina02: INT;
	iVelocidadeGuilhotina02: INT;
	dValEncoAlturaGuilhotina02: DINT;
	dValEncoToleranciaGuilhotina02: DINT;
	dValEncoAlturaVelMinGuilhotina02: DINT;
	xCmdPositivoGuilhotina02: BOOL;
	xCmdNegativoGuilhotina02: BOOL;
	xIncrementaEncoderGuilhotina02Po: BOOL;
	xDecrementaEncoderGuilhotina02Po: BOOL;
	iValorEncoderGuilhotina02Po: INT;
	xSobeJogGuilhotina02: BOOL;
	xDesceJogGuilhotina02: BOOL;
	xSobeGuilhotina02: BOOL;
	xDesceGuilhotina02: BOOL;

END_VAR
__IMPLEMENTATION__
IF iAlturaGhilhotina02 <> iAlturaGhilhotina02Aux THEN
	xSetValorSpAltGuil02Sup:=TRUE;
	
END_IF;

IF xSetValorSpAltGuil02Sup THEN
	iAlturaGhilhotina02Aux:=iAlturaGhilhotina02;
ELSE
	IF NOT xMotorGuilhotina02Ligado THEN
		iAlturaGhilhotina02:=iAlturaAtualGuilhotina02;
	END_IF;
END_IF

IF iAlturaGhilhotina02Aux=iAlturaAtualGuilhotina02 THEN
	xSetValorSpAltGuil02Sup:=FALSE;
END_IF


// CONVERSÃO MILIMETROS EM PULSOS

ConversorMilimPul01Guilho02(
	dPulso:= 234600, 
	dMilimetro:= 100, 
	iEntrMilimetro01:= iAlturaGhilhotina02Aux,//iAlturaGhilhotina02, 
	dSaidaPulso01=> dValEncoAlturaGuilhotina02);
	
ConversorMilimPul02Guilho02(
	dPulso:= 234600, 
	dMilimetro:= 100, 
	iEntrMilimetro01:= 2,//iValEncoToleranciaGuilhotina, 
	iEntrMilimetro02:= 4,//iValEncoAlturaVelMinGuilhotina, 
	dSaidaPulso01=> dValEncoToleranciaGuilhotina02,	 
	dSaidaPulso02=> dValEncoAlturaVelMinGuilhotina02);

// SEQUENCIA DE HOME

CASE PassoHomeGuilhotina02 OF
	
		0:	IF xIniciaHomeGuilhotina02(* OR xAutoHomeGuilho02*) THEN
				PassoHomeGuilhotina02:=5;		
			END_IF

		5:	xIniciaHomeGuilhotina02:=FALSE;
			xAutoHomeGuilho02:=FALSE;
			xGuilhotina02EmAjuste:=FALSE;
			xHomeGuilhotina02Ok:=FALSE;
			xAjusteAlturaGuilhotina02OK:=FALSE;
			xGuilhotina02EmHome:=TRUE;
			PassoHomeGuilhotina02:=8;

		8: IF xSensorZeroGuilhotina02 THEN
				PassoHomeGuilhotina02:=9;
			ELSE
				PassoHomeGuilhotina02:=13;
			END_IF
		
		9: iVelocidadeGuilhotina02:= 600;//iVelocidadeHomeGuilhotina02;
		   PassoHomeGuilhotina02:=10;
		 
		10:	xSobeGuilhotina02:=TRUE;
			PassoHomeGuilhotina02:=11;

		11: IF NOT xSensorZeroGuilhotina02 THEN
				PassoHomeGuilhotina02:=30;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina02:=50;
				PassoHomeGuilhotina02:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina02 THEN
				PassoAlmHomeGuilhotina02:=50;
				PassoHomeGuilhotina02:=400;
			END_IF		

		13:	PassoHomeGuilhotina02:=14;

		14:	iVelocidadeGuilhotina02:= 600;//iVelocidadeHomeGuilhotina02;
			xSinalAjusteG02:=1;			
			PassoHomeGuilhotina02:=15;

		15:	xSobeGuilhotina02:=TRUE;
			PassoHomeGuilhotina02:=20;

		20:	IF xSensorPositivoGuilhotina02 THEN
				PassoHomeGuilhotina02:=30;
			END_IF
			IF xSensorZeroGuilhotina02 THEN
				PassoHomeGuilhotina02:=9;//50;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina02:=15;
				PassoHomeGuilhotina02:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina02 THEN
				PassoAlmHomeGuilhotina02:=15;
				PassoHomeGuilhotina02:=400;
			END_IF		
			
		30: xSobeGuilhotina02:=TRUE;
			PassoHomeGuilhotina02:=31;
		
		31:	iVelocidadeGuilhotina02:=-1*600;//iVelocidadeHomeGuilhotina02;
			xSinalAjusteG02:=-1;	
			PassoHomeGuilhotina02:=40;
		
		40:	IF xSensorNegativoGuilhotina02 THEN
				PassoHomeGuilhotina02:=13;
			END_IF
			IF xSensorZeroGuilhotina02 THEN
				PassoHomeGuilhotina02:=50;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina02:=30;
				PassoHomeGuilhotina02:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina02 THEN
				PassoAlmHomeGuilhotina02:=30;
				PassoHomeGuilhotina02:=400;
			END_IF		

			
		50: iVelocidadeGuilhotina02:= xSinalAjusteG02*150; 
			PassoHomeGuilhotina02:=53;
			
		53:	xTonHomeGuilho02In:=TRUE;
			PassoHomeGuilhotina02:=54;
			
		54: IF xTonHomeGuilho02Q THEN
				PassoHomeGuilhotina02:=60;	
			END_IF


		60:	xTonHomeGuilho02In:=FALSE;
			PassoHomeGuilhotina02:=70;
			

		70: xSobeGuilhotina02:=FALSE;
			PassoHomeGuilhotina02:=80;
		
		80: xHomeEncoderGuilhotinaResfriador02:=TRUE;
			PassoHomeGuilhotina02:=81;
			
		81:PassoHomeGuilhotina02:=82;

		82: xHomeEncoderGuilhotinaResfriador02:=FALSE;
			PassoHomeGuilhotina02:=83;
		
		83:	xHomeGuilhotina02Ok:=TRUE;
			xGuilhotina02EmHome:=FALSE;
			PassoHomeGuilhotina02:=0;
			
		// Emergência Pausa/Reinicio
		300:xSobeGuilhotina02:=FALSE;
			xDesceGuilhotina02:=FALSE;
			PassoHomeGuilhotina02:=301;

		301:xGuilhotina02EmHome:=FALSE;
			PassoHomeGuilhotina02:=302;
	
		302:IF xRestart THEN
				PassoHomeGuilhotina02:=303;
			END_IF
			
		303:PassoHomeGuilhotina02:=0;//PassoPausaHomeGuilhotina;
			
		// Alarme Motor Parada/Reinicio
		400:xSobeGuilhotina02:=FALSE;
			xDesceGuilhotina02:=FALSE;
			PassoHomeGuilhotina02:=401;

		401:PassoHomeGuilhotina02:=402;
	
		402:IF xRestart AND iCanOpenInverGuilResfr02StateOk THEN
				PassoHomeGuilhotina02:=PassoAlmHomeGuilhotina02;
			END_IF	
			
END_CASE
			
TonHomeGuilho02(IN:= xTonHomeGuilho02In, PT:=T#1720MS , Q=> xTonHomeGuilho02Q, ET=> );

// SEQUENCIA DE FUNCIONAMENTO

IF (xBtRecAjustaGuilhotina02 OR BtParamGuilhotina02) AND xHomeGuilhotina02Ok THEN
	xAjustarAlturaGuilhotina02:=TRUE;
	xBtRecAjustaGuilhotina02:=FALSE;
	BtParamGuilhotina02:=FALSE;
ELSE
	xBtRecAjustaGuilhotina02:=FALSE;
	BtParamGuilhotina02:=FALSE;
END_IF

CASE PassoAjusteGuilhotina02 OF
		
		0:	IF xAjustarAlturaGuilhotina02 THEN
				PassoAjusteGuilhotina02:=10;
			END_IF
			
		10:	xAjustarAlturaGuilhotina02:=FALSE;
			xAjusteAlturaGuilhotina02OK:=FALSE;
			xGuilhotina02EmAjuste:=TRUE;
			IF (dValorEncoderGuilhotinaResfriador02>=dValEncoAlturaGuilhotina02-dValEncoToleranciaGuilhotina02) AND (dValorEncoderGuilhotinaResfriador02<=dValEncoAlturaGuilhotina02+dValEncoToleranciaGuilhotina02) THEN
				PassoAjusteGuilhotina02:=180;//Não se Move
			END_IF
			IF dValorEncoderGuilhotinaResfriador02<dValEncoAlturaGuilhotina02-dValEncoToleranciaGuilhotina02 THEN
				PassoAjusteGuilhotina02:=20;//Sobe
			END_IF
			IF dValorEncoderGuilhotinaResfriador02>dValEncoAlturaGuilhotina02+dValEncoToleranciaGuilhotina02 THEN
				PassoAjusteGuilhotina02:=100;//Desce
			END_IF
			
//Sobe
		20:	iVelocidadeGuilhotina02:= iVelocidadeAjusteGuilhotina02;
			PassoAjusteGuilhotina02:=25;

		25: xSobeGuilhotina02:=TRUE;
			PassoAjusteGuilhotina02:=30;
			
		30:	IF dValorEncoderGuilhotinaResfriador02>=dValEncoAlturaGuilhotina02-dValEncoAlturaVelMinGuilhotina02 THEN
				PassoAjusteGuilhotina02:=40;
			END_IF
			IF iVelocidadeGuilhotina02<> iVelocidadeAjusteGuilhotina02 THEN
				PassoAjusteGuilhotina02:=20;
			END_IF
			IF xSensorPositivoGuilhotina02 THEN
				PassoAjusteGuilhotina02:=200;
			END_IF

			IF xPause THEN
				PassoPausaAjusteGuilhotina02:=20;
				PassoAjusteGuilhotina02:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina02 THEN
				PassoAlmAjusteGuilhotina02:=20;
				PassoAjusteGuilhotina02:=400;
			END_IF		

		40:	iVelocidadeGuilhotina02:= iVelocidadeMinimaGuilhotina02;
			PassoAjusteGuilhotina02:=50;
			
		50:	IF dValorEncoderGuilhotinaResfriador02>=dValEncoAlturaGuilhotina02 THEN
				PassoAjusteGuilhotina02:=60;
			END_IF
			IF iVelocidadeGuilhotina02<> iVelocidadeMinimaGuilhotina02 THEN
				PassoAjusteGuilhotina02:=40;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina02:=40;
				PassoAjusteGuilhotina02:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina02 THEN
				PassoAlmAjusteGuilhotina02:=40;
				PassoAjusteGuilhotina02:=400;
			END_IF		
			
		60: xSobeGuilhotina02:=FALSE;
			PassoAjusteGuilhotina02:=180;
//Desce

		100:iVelocidadeGuilhotina02:= 1*iVelocidadeAjusteGuilhotina02;
			PassoAjusteGuilhotina02:=105;
			
		105:xDesceGuilhotina02:=TRUE;
			PassoAjusteGuilhotina02:=110;
			
		110:IF dValorEncoderGuilhotinaResfriador02<dValEncoAlturaGuilhotina02+dValEncoAlturaVelMinGuilhotina02 THEN
				PassoAjusteGuilhotina02:=120;
			END_IF
			IF iVelocidadeGuilhotina02<> 1*iVelocidadeAjusteGuilhotina02 THEN
				PassoAjusteGuilhotina02:=100;
			END_IF
			IF	xSensorNegativoGuilhotina02 THEN
				PassoAjusteGuilhotina02:=200;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina02:=100;
				PassoAjusteGuilhotina02:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina02 THEN
				PassoAlmAjusteGuilhotina02:=100;
				PassoAjusteGuilhotina02:=400;
			END_IF		

		120:iVelocidadeGuilhotina02:= 1*iVelocidadeMinimaGuilhotina02;
			PassoAjusteGuilhotina02:=130;
			
		130:IF  dValorEncoderGuilhotinaResfriador02<=dValEncoAlturaGuilhotina02 THEN
				PassoAjusteGuilhotina02:=140;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina02:=120;
				PassoAjusteGuilhotina02:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina02 THEN
				PassoAlmAjusteGuilhotina02:=120;
				PassoAjusteGuilhotina02:=400;
			END_IF		

		140:xDesceGuilhotina02:=FALSE;
			PassoAjusteGuilhotina02:=180;
//Fim		
		180:xExecutaStopGuilhotina02:=FALSE;
			xAjusteAlturaGuilhotina02OK:=TRUE;
			xGuilhotina02EmAjuste:=FALSE;
			PassoAjusteGuilhotina02:=0;

		200:xSobeGuilhotina02:=FALSE;
			xDesceGuilhotina02:=FALSE;
			PassoAjusteGuilhotina02:=0;

		// Emergência Pausa/Reinicio
		300:xSobeGuilhotina02:=FALSE;
			xDesceGuilhotina02:=FALSE;
			PassoAjusteGuilhotina02:=301;

		301:PassoAjusteGuilhotina02:=302;
	
		302:IF xRestart THEN
				PassoAjusteGuilhotina02:=303;
			END_IF
			
		303: PassoAjusteGuilhotina02:=PassoPausaAjusteGuilhotina02;

		// Alarme Motor Parada/Reinicio
		400:xSobeGuilhotina02:=FALSE;
			xDesceGuilhotina02:=FALSE;
			PassoAjusteGuilhotina02:=401;

		401:PassoAjusteGuilhotina02:=402;
	
		402:IF xRestart AND iCanOpenInverGuilResfr02StateOk THEN
				PassoAjusteGuilhotina02:=PassoAlmAjusteGuilhotina02;
			END_IF	
	
END_CASE			

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Dirreção
xMotorGuilhotina02Sobe:= xSobeGuilhotina02 OR xSobeJogGuilhotina02;
xMotorGuilhotina02Desce:= xDesceGuilhotina02 OR xDesceJogGuilhotina02;

InversorGuilhot02.i_xAvanco:=xMotorGuilhotina02Sobe;
InversorGuilhot02.i_xRecuo:=xMotorGuilhotina02Desce;

// Velocidade
InversorGuilhot02.i_iFreqRef:=iVelocidadeGuilhotina02;
//---------------------------------------------------------------------------------\\

ConversorPulMilimGuilho02(
	dPulso:= 234600, 
	dMilimetro:= 100, 
	dEntradaPulso01:= dValorEncoderGuilhotinaResfriador02,
	iSaidaMilimetro01=> iAlturaAtualGuilhotina02 );
	
IF xOperacaoManual THEN
	PassoHomeGuilhotina02:=0;
	PassoAjusteGuilhotina02:=0;
	xIniciaHomeGuilhotina02:=FALSE;
	xAjusteAlturaGuilhotina02OK:=FALSE;
	xGuilhotina02EmHome:=FALSE;
	xGuilhotina02EmAjuste:=FALSE;
	
	xSobeGuilhotina02:=FALSE;
	xDesceGuilhotina02:=FALSE;
END_IF

(*-------------------- Manual Jog--------------------------*)

xSobeJogGuilhotina02:=xBtSobeGuilhtina02Manual AND NOT xSensorPositivoGuilhotina02 AND NOT xPausaEmergencia ;
xDesceJogGuilhotina02:=xBtDesceGuilhotina02Manual AND NOT xSensorNegativoGuilhotina02 AND NOT xPausaEmergencia ; 
