__METADATA__
{
  "v3Meta": {
    "objectGuid": "afcb26ed-01e4-4a06-9316-3e6fb709bd9f",
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
PROGRAM K_Guilhotina01
VAR
	PassoHomeGuilhotina01: INT;
	PassoAjusteGuilhotina01: INT;
	PassoPausaHomeGuilhotina01: INT;
	PassoPausaAjusteGuilhotina01: INT;
	PassoAlmHomeGuilhotina01: INT;
	PassoAlmAjusteGuilhotina01: INT;
	xSinalAjusteG01: INT;
	ContadorEncoderPo: ContadorUpDown;
	TonHomeGuilho01: TON;
	xTonHomeGuilho01In: BOOL;
	xTonHomeGuilho01Q: BOOL;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul01Guilho01: MmConversorPulso;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul02Guilho01: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilimGuilho01: PulsoConversorMm;
	xExecutaMovGuilhotina01: BOOL;
	xExecutaStopGuilhotina01: BOOL;
	xStopGuilhotina01Done: BOOL;
	xSetValorSpAltGuil01Sup: BOOL;
	iAlturaGhilhotina01Aux: INT;
	xAjustarAlturaGuilhotina01: BOOL;
	iVelocidadeHomeGuilhotina01: INT;
	iVelocidadeGuilhotina01: INT;
	dValEncoAlturaGuilhotina01: DINT;
	dValEncoToleranciaGuilhotina01: DINT;
	dValEncoAlturaVelMinGuilhotina01: DINT;
	xCmdPositivoGuilhotina01: BOOL;
	xCmdNegativoGuilhotina01: BOOL;
	xIncrementaEncoderGuilhotina01Po: BOOL;
	xDecrementaEncoderGuilhotina01Po: BOOL;
	iValorEncoderGuilhotina01Po: INT;
	xSobeJogGuilhotina01: BOOL;
	xDesceJogGuilhotina01: BOOL;
	xSobeGuilhotina01: BOOL;
	xDesceGuilhotina01: BOOL;
END_VAR
__IMPLEMENTATION__
IF iAlturaGhilhotina01 <> iAlturaGhilhotina01Aux THEN
	xSetValorSpAltGuil01Sup:=TRUE;
	
END_IF;

IF xSetValorSpAltGuil01Sup THEN
	iAlturaGhilhotina01Aux:=iAlturaGhilhotina01;
ELSE
	IF NOT xMotorGuilhotina01Ligado THEN
		iAlturaGhilhotina01:=iAlturaAtualGuilhotina01;
	END_IF;
END_IF

IF iAlturaGhilhotina01Aux=iAlturaAtualGuilhotina01 THEN
	xSetValorSpAltGuil01Sup:=FALSE;
END_IF


// CONVERSÃO MILIMETROS EM PULSOS

ConversorMilimPul01Guilho01(
	dPulso:= 110981, 
	dMilimetro:= 100, 
	iEntrMilimetro01:= iAlturaGhilhotina01Aux,//iAlturaGhilhotina02, 
	dSaidaPulso01=> dValEncoAlturaGuilhotina01);
	
ConversorMilimPul02Guilho01(
	dPulso:= 110981, 
	dMilimetro:= 100, 
	iEntrMilimetro01:= 2,//iValEncoToleranciaGuilhotina, 
	iEntrMilimetro02:= 8,//iValEncoAlturaVelMinGuilhotina, 
	dSaidaPulso01=> dValEncoToleranciaGuilhotina01,	 
	dSaidaPulso02=> dValEncoAlturaVelMinGuilhotina01);

// SEQUENCIA DE HOME

CASE PassoHomeGuilhotina01 OF
	
		0:	IF xIniciaHomeGuilhotina01 OR xAutoHomeGuilho01 THEN
				PassoHomeGuilhotina01:=5;		
			END_IF

		5:	xIniciaHomeGuilhotina01:=FALSE;
			xAutoHomeGuilho01:=FALSE;
			xGuilhotina01EmAjuste:=FALSE;
			xHomeGuilhotina01Ok:=FALSE;
			xAjusteAlturaGuilhotina01OK:=FALSE;
			xGuilhotina01EmHome:=TRUE;
			PassoHomeGuilhotina01:=8;

		8: IF xSensorZeroGuilhotina01 THEN
				PassoHomeGuilhotina01:=9;
			ELSE
				PassoHomeGuilhotina01:=13;
			END_IF
		
		9: iVelocidadeGuilhotina01:= 600;//iVelocidadeHomeGuilhotina01;
		   PassoHomeGuilhotina01:=10;
		 
		10:	xSobeGuilhotina01:=TRUE;
			PassoHomeGuilhotina01:=11;

		11: IF NOT xSensorZeroGuilhotina01 THEN
				PassoHomeGuilhotina01:=30;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina01:=50;
				PassoHomeGuilhotina01:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01 THEN
				PassoAlmHomeGuilhotina01:=50;
				PassoHomeGuilhotina01:=400;
			END_IF		

		13:	PassoHomeGuilhotina01:=14;

		14:	iVelocidadeGuilhotina01:= 600;//iVelocidadeHomeGuilhotina01;
			xSinalAjusteG01:=1;			
			PassoHomeGuilhotina01:=15;

		15:	xSobeGuilhotina01:=TRUE;
			PassoHomeGuilhotina01:=20;

		20:	IF xSensorPositivoGuilhotina01 THEN
				PassoHomeGuilhotina01:=30;
			END_IF
			IF xSensorZeroGuilhotina01 THEN
				PassoHomeGuilhotina01:=9;//50;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina01:=15;
				PassoHomeGuilhotina01:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01 THEN
				PassoAlmHomeGuilhotina01:=15;
				PassoHomeGuilhotina01:=400;
			END_IF		
			
		30: xSobeGuilhotina01:=TRUE;
			PassoHomeGuilhotina01:=31;
		
		31:	iVelocidadeGuilhotina01:=-1*600;//iVelocidadeHomeGuilhotina01;
			xSinalAjusteG01:=-1;	
			PassoHomeGuilhotina01:=40;
		
		40:	IF xSensorNegativoGuilhotina01 THEN
				PassoHomeGuilhotina01:=13;
			END_IF
			IF xSensorZeroGuilhotina01 THEN
				PassoHomeGuilhotina01:=50;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina01:=30;
				PassoHomeGuilhotina01:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01 THEN
				PassoAlmHomeGuilhotina01:=30;
				PassoHomeGuilhotina01:=400;
			END_IF		

			
		50: iVelocidadeGuilhotina01:= xSinalAjusteG01*150; 
			PassoHomeGuilhotina01:=53;
			
		53:	xTonHomeGuilho01In:=TRUE;
			PassoHomeGuilhotina01:=54;
			
		54: IF xTonHomeGuilho01Q THEN
				PassoHomeGuilhotina01:=60;	
			END_IF


		60:	xTonHomeGuilho01In:=FALSE;
			PassoHomeGuilhotina01:=70;
			

		70: xSobeGuilhotina01:=FALSE;
			PassoHomeGuilhotina01:=80;
		
		80: xHomeEncoderGuilhotinaResfriador01:=TRUE;
			PassoHomeGuilhotina01:=81;
			
		81:PassoHomeGuilhotina01:=82;

		82: xHomeEncoderGuilhotinaResfriador01:=FALSE;
			PassoHomeGuilhotina01:=83;
		
		83:	xHomeGuilhotina01Ok:=TRUE;
			xGuilhotina01EmHome:=FALSE;
			PassoHomeGuilhotina01:=0;
			
		// Emergência Pausa/Reinicio
		300:xSobeGuilhotina01:=FALSE;
			xDesceGuilhotina01:=FALSE;
			PassoHomeGuilhotina01:=301;

		301:xGuilhotina01EmHome:=FALSE;
			PassoHomeGuilhotina01:=302;
	
		302:IF xRestart THEN
				PassoHomeGuilhotina01:=303;
			END_IF
			
		303:PassoHomeGuilhotina01:=0;//PassoPausaHomeGuilhotina;
			
		// Alarme Motor Parada/Reinicio
		400:xSobeGuilhotina01:=FALSE;
			xDesceGuilhotina01:=FALSE;
			PassoHomeGuilhotina01:=401;

		401:PassoHomeGuilhotina01:=402;
	
		402:IF xRestart AND iCanOpenInverGuilResfr01StateOk THEN
				PassoHomeGuilhotina01:=PassoAlmHomeGuilhotina01;
			END_IF	
			
END_CASE
			
TonHomeGuilho01(IN:= xTonHomeGuilho01In, PT:=T#1720MS , Q=> xTonHomeGuilho01Q, ET=> );

// SEQUENCIA DE FUNCIONAMENTO

IF (xBtRecAjustaGuilhotina01 OR BtParamGuilhotina01) AND xHomeGuilhotina01Ok THEN
	xAjustarAlturaGuilhotina01:=TRUE;
	xBtRecAjustaGuilhotina01:=FALSE;
	BtParamGuilhotina01:=FALSE;
ELSE
	xBtRecAjustaGuilhotina01:=FALSE;
	BtParamGuilhotina01:=FALSE;
END_IF

CASE PassoAjusteGuilhotina01 OF
		
		0:	IF xAjustarAlturaGuilhotina01 THEN
				PassoAjusteGuilhotina01:=10;
			END_IF
			
		10:	xAjustarAlturaGuilhotina01:=FALSE;
			xAjusteAlturaGuilhotina01OK:=FALSE;
			xGuilhotina01EmAjuste:=TRUE;
			IF (dValorEncoderGuilhotinaResfriador01>=dValEncoAlturaGuilhotina01-dValEncoToleranciaGuilhotina01) AND (dValorEncoderGuilhotinaResfriador01<=dValEncoAlturaGuilhotina01+dValEncoToleranciaGuilhotina01) THEN
				PassoAjusteGuilhotina01:=180;//Não se Move
			END_IF
			IF dValorEncoderGuilhotinaResfriador01<dValEncoAlturaGuilhotina01-dValEncoToleranciaGuilhotina01 THEN
				PassoAjusteGuilhotina01:=20;//Sobe
			END_IF
			IF dValorEncoderGuilhotinaResfriador01>dValEncoAlturaGuilhotina01+dValEncoToleranciaGuilhotina01 THEN
				PassoAjusteGuilhotina01:=100;//Desce
			END_IF
			
//Sobe
		20:	iVelocidadeGuilhotina01:= iVelocidadeAjusteGuilhotina01;
			PassoAjusteGuilhotina01:=25;

		25: xSobeGuilhotina01:=TRUE;
			PassoAjusteGuilhotina01:=30;
			
		30:	IF dValorEncoderGuilhotinaResfriador01>=dValEncoAlturaGuilhotina01-dValEncoAlturaVelMinGuilhotina01 THEN
				PassoAjusteGuilhotina01:=40;
			END_IF
			IF iVelocidadeGuilhotina01<> iVelocidadeAjusteGuilhotina01 THEN
				PassoAjusteGuilhotina01:=20;
			END_IF
			IF xSensorPositivoGuilhotina01 THEN
				PassoAjusteGuilhotina01:=200;
			END_IF

			IF xPause THEN
				PassoPausaAjusteGuilhotina01:=20;
				PassoAjusteGuilhotina01:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01 THEN
				PassoAlmAjusteGuilhotina01:=20;
				PassoAjusteGuilhotina01:=400;
			END_IF		

		40:	iVelocidadeGuilhotina01:= iVelocidadeMinimaGuilhotina01;
			PassoAjusteGuilhotina01:=50;
			
		50:	IF dValorEncoderGuilhotinaResfriador01>=dValEncoAlturaGuilhotina01 THEN
				PassoAjusteGuilhotina01:=60;
			END_IF
			IF iVelocidadeGuilhotina01<> iVelocidadeMinimaGuilhotina01 THEN
				PassoAjusteGuilhotina01:=40;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina01:=40;
				PassoAjusteGuilhotina01:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01 THEN
				PassoAlmAjusteGuilhotina01:=40;
				PassoAjusteGuilhotina01:=400;
			END_IF		
			
		60: xSobeGuilhotina01:=FALSE;
			PassoAjusteGuilhotina01:=180;
//Desce

		100:iVelocidadeGuilhotina01:= 1*iVelocidadeAjusteGuilhotina01;
			PassoAjusteGuilhotina01:=105;
			
		105:xDesceGuilhotina01:=TRUE;
			PassoAjusteGuilhotina01:=110;
			
		110:IF dValorEncoderGuilhotinaResfriador01<dValEncoAlturaGuilhotina01+dValEncoAlturaVelMinGuilhotina01 THEN
				PassoAjusteGuilhotina01:=120;
			END_IF
			IF iVelocidadeGuilhotina01<> 1*iVelocidadeAjusteGuilhotina01 THEN
				PassoAjusteGuilhotina01:=100;
			END_IF
			IF	xSensorNegativoGuilhotina01 THEN
				PassoAjusteGuilhotina01:=200;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina01:=100;
				PassoAjusteGuilhotina01:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01 THEN
				PassoAlmAjusteGuilhotina01:=100;
				PassoAjusteGuilhotina01:=400;
			END_IF		

		120:iVelocidadeGuilhotina01:= 1*iVelocidadeMinimaGuilhotina01;
			PassoAjusteGuilhotina01:=130;
			
		130:IF  dValorEncoderGuilhotinaResfriador01<=dValEncoAlturaGuilhotina01 THEN
				PassoAjusteGuilhotina01:=140;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina01:=120;
				PassoAjusteGuilhotina01:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01 THEN
				PassoAlmAjusteGuilhotina01:=120;
				PassoAjusteGuilhotina01:=400;
			END_IF		

		140:xDesceGuilhotina01:=FALSE;
			PassoAjusteGuilhotina01:=180;
//Fim		
		180:xExecutaStopGuilhotina01:=FALSE;
			xAjusteAlturaGuilhotina01OK:=TRUE;
			xGuilhotina01EmAjuste:=FALSE;
			PassoAjusteGuilhotina01:=0;

		200:xSobeGuilhotina01:=FALSE;
			xDesceGuilhotina01:=FALSE;
			PassoAjusteGuilhotina01:=0;

		// Emergência Pausa/Reinicio
		300:xSobeGuilhotina01:=FALSE;
			xDesceGuilhotina01:=FALSE;
			PassoAjusteGuilhotina01:=301;

		301:PassoAjusteGuilhotina01:=302;
	
		302:IF xRestart THEN
				PassoAjusteGuilhotina01:=303;
			END_IF
			
		303: PassoAjusteGuilhotina01:=PassoPausaAjusteGuilhotina01;

		// Alarme Motor Parada/Reinicio
		400:xSobeGuilhotina01:=FALSE;
			xDesceGuilhotina01:=FALSE;
			PassoAjusteGuilhotina01:=401;

		401:PassoAjusteGuilhotina01:=402;
	
		402:IF xRestart AND iCanOpenInverGuilResfr01StateOk THEN
				PassoAjusteGuilhotina01:=PassoAlmAjusteGuilhotina01;
			END_IF	
	
END_CASE			

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Dirreção
xMotorGuilhotina01Sobe:= xSobeGuilhotina01 OR xSobeJogGuilhotina01;
xMotorGuilhotina01Desce:= xDesceGuilhotina01 OR xDesceJogGuilhotina01;

InversorGuilhot01.i_xAvanco:=xMotorGuilhotina01Sobe;
InversorGuilhot01.i_xRecuo:=xMotorGuilhotina01Desce;

// Velocidade
InversorGuilhot01.i_iFreqRef:=iVelocidadeGuilhotina01;
//---------------------------------------------------------------------------------\\

ConversorPulMilimGuilho01(
	dPulso:=110981, 
	dMilimetro:= 100, 
	dEntradaPulso01:= dValorEncoderGuilhotinaResfriador01,
	iSaidaMilimetro01=> iAlturaAtualGuilhotina01 );
	
IF xOperacaoManual THEN
	PassoHomeGuilhotina01:=0;
	PassoAjusteGuilhotina01:=0;
	xIniciaHomeGuilhotina01:=FALSE;
	xAjusteAlturaGuilhotina01OK:=FALSE;
	xGuilhotina01EmHome:=FALSE;
	xGuilhotina01EmAjuste:=FALSE;
	
	xSobeGuilhotina01:=FALSE;
	xDesceGuilhotina01:=FALSE;
END_IF

(*-------------------- Manual Jog--------------------------*)

xSobeJogGuilhotina01:=xBtSobeGuilhtina01Manual AND NOT xSensorPositivoGuilhotina01 AND NOT xPausaEmergencia ;
xDesceJogGuilhotina01:=xBtDesceGuilhotina01Manual AND NOT xSensorNegativoGuilhotina01 AND NOT xPausaEmergencia ; 
