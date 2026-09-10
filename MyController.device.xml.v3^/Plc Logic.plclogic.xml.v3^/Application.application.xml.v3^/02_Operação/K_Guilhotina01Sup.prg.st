__METADATA__
{
  "v3Meta": {
    "objectGuid": "86df7614-f58d-4415-8f63-4f31e1709dbf",
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
PROGRAM K_Guilhotina01Sup
VAR
	PassoHomeGuilhotina01Sup: INT;
	PassoAjusteGuilhotina01Sup: INT;
	PassoPausaHomeGuilhotina01Sup: INT;
	PassoPausaAjusteGuilhotina01Sup: INT;
	PassoAlmHomeGuilhotina01Sup: INT;
	PassoAlmAjusteGuilhotina01Sup: INT;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul01Guilho01Sup: MmConversorPulso;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul02Guilho01Sup: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilimGuilho01Sup: PulsoConversorMm;
	xSetValorSpAltGuil01SupSup: BOOL;
	iAlturaGhilhotina01SupAux: INT;
	xAjustarAlturaGuilhotina01Sup: BOOL;
	iVelocidadeHomeGuilhotina01Sup: INT;
	iVelocidadeGuilhotina01Sup: INT;
	dValEncoAlturaGuilhotina01Sup: DINT;
	dValEncoToleranciaGuilhotina01Sup: DINT;
	dValEncoAlturaVelMinGuilhotina01Sup: DINT;
	xAbreJogGuilhotina01Sup: BOOL;
	xFechaJogGuilhotina01Sup: BOOL;
	xAbreGuilhotina01Sup: BOOL;
	xFechaGuilhotina01Sup: BOOL;
END_VAR
__IMPLEMENTATION__
IF iAlturaGhilhotina01Sup <> iAlturaGhilhotina01SupAux THEN
	xSetValorSpAltGuil01SupSup:=TRUE;
	
END_IF;

IF xSetValorSpAltGuil01SupSup THEN
	iAlturaGhilhotina01SupAux:=iAlturaGhilhotina01Sup;
ELSE
	IF NOT xMotorGuilhotina01SupLigado THEN
		iAlturaGhilhotina01Sup:=iAlturaAtualGuilhotina01Sup;
	END_IF;
END_IF

IF iAlturaGhilhotina01SupAux=iAlturaAtualGuilhotina01Sup THEN
	xSetValorSpAltGuil01SupSup:=FALSE;
END_IF


// CONVERSÃO MILIMETROS EM PULSOS

ConversorMilimPul01Guilho01Sup(
	dPulso:= 107918, 
	dMilimetro:= 100, 
	iEntrMilimetro01:= iAlturaGhilhotina01SupAux,//iAlturaGhilhotina02, 
	dSaidaPulso01=> dValEncoAlturaGuilhotina01Sup);
	
ConversorMilimPul02Guilho01Sup(
	dPulso:= 107918, 
	dMilimetro:= 100, 
	iEntrMilimetro01:= 2,//iValEncoToleranciaGuilhotina, 
	iEntrMilimetro02:= 8,//iValEncoAlturaVelMinGuilhotina, 
	dSaidaPulso01=> dValEncoToleranciaGuilhotina01Sup,	 
	dSaidaPulso02=> dValEncoAlturaVelMinGuilhotina01Sup);

// SEQUENCIA DE HOME

CASE PassoHomeGuilhotina01Sup OF
	
		0:	IF xIniciaHomeGuilhotina01Sup THEN
				PassoHomeGuilhotina01Sup:=10;		
			END_IF
			
		10:	xIniciaHomeGuilhotina01Sup:=FALSE;
			xHomeGuilhotina01SupOk:=FALSE;
			xAjusteAlturaGuilhotina01SupOK:=FALSE;
			xGuilhotina01SupEmHome:=TRUE;
			iVelocidadeGuilhotina01Sup:= 300;//1*iVelocidadeHomeDuctosResfrSup02;
			PassoHomeGuilhotina01Sup:=15;
			
		15: xFechaGuilhotina01Sup:=TRUE;
			PassoHomeGuilhotina01Sup:=20;
			
		20:	IF xSensorFechadoGuilhotina01Sup THEN
				PassoHomeGuilhotina01Sup:=50;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina01Sup:=10;
				PassoHomeGuilhotina01Sup:=300;
			END_IF
			IF xAlarmeMotorGuilhotina01Sup THEN
				PassoAlmHomeGuilhotina01Sup:=10;
				PassoHomeGuilhotina01Sup:=400;
			END_IF

		50:	xFechaGuilhotina01Sup:=FALSE;
			PassoHomeGuilhotina01Sup:=55;
				
		55:	iVelocidadeGuilhotina01Sup:= 50;
			PassoHomeGuilhotina01Sup:=56;
			
		56:	xAbreGuilhotina01Sup:=TRUE;
			PassoHomeGuilhotina01Sup:=60;
			
		60:	IF NOT xSensorFechadoGuilhotina01Sup THEN
				PassoHomeGuilhotina01Sup:=70;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina01Sup:=50;
				PassoHomeGuilhotina01Sup:=300;
			END_IF
			IF xAlarmeMotorGuilhotina01Sup THEN
				PassoAlmHomeGuilhotina01Sup:=50;
				PassoHomeGuilhotina01Sup:=400;
			END_IF

		70:	xAbreGuilhotina01Sup:=FALSE;
			PassoHomeGuilhotina01Sup:=74;
			
		74:	IF NOT xMotorGuilhotina01SupLigado THEN
				PassoHomeGuilhotina01Sup:=75;
			END_IF
			
		75: xHomeEncoderGuilhotinaResfriador01Sup:=TRUE;
			PassoHomeGuilhotina01Sup:=80;
		
		80: xHomeEncoderGuilhotinaResfriador01Sup:=FALSE;
			xGuilhotina01SupEmHome:=FALSE;
			xHomeGuilhotina01SupOk:=TRUE;
			
		// Emergência Pausa/Reinicio
		300:xAbreGuilhotina01Sup:=FALSE;
			xAbreGuilhotina01Sup:=FALSE;
			PassoHomeGuilhotina01Sup:=301;

		301:xDuctosSup02EmHome:=FALSE;
			PassoHomeGuilhotina01Sup:=302;
	
		302:IF xRestart THEN
				PassoHomeGuilhotina01Sup:=303;
			END_IF
			
		303:PassoHomeGuilhotina01Sup:=0;//PassoPausaHomeDuctosResfrSup02;
			
		// Alarme Motor Parada/Reinicio
		400:xFechaGuilhotina01Sup:=FALSE;
			xAbreGuilhotina01Sup:=FALSE;
			PassoHomeGuilhotina01Sup:=401;

		401:PassoHomeGuilhotina01Sup:=402;
	
		402:IF xRestart AND iCanOpenInverGuilResfr01SupStateOk THEN
				PassoHomeGuilhotina01Sup:=PassoAlmHomeGuilhotina01Sup;
			END_IF					
END_CASE

// SEQUENCIA DE FUNCIONAMENTO

IF (xBtRecAjustaGuilhotina01Sup OR BtParamGuilhotina01Sup) AND xHomeGuilhotina01SupOk THEN
	xAjustarAlturaGuilhotina01Sup:=TRUE;
	xBtRecAjustaGuilhotina01Sup:=FALSE;
	BtParamGuilhotina01Sup:=FALSE;
ELSE
	xBtRecAjustaGuilhotina01Sup:=FALSE;
	BtParamGuilhotina01Sup:=FALSE;
END_IF

CASE PassoAjusteGuilhotina01Sup OF
		
		0:	IF xAjustarAlturaGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=10;
			END_IF
			
		10:	xAjustarAlturaGuilhotina01Sup:=FALSE;
			xAjusteAlturaGuilhotina01SupOK:=FALSE;
			xGuilhotina01SupEmAjuste:=TRUE;
			IF (dValorEncoderGuilhotinaResfriador01Sup>=dValEncoAlturaGuilhotina01Sup-dValEncoToleranciaGuilhotina01Sup) AND (dValorEncoderGuilhotinaResfriador01Sup<=dValEncoAlturaGuilhotina01Sup+dValEncoToleranciaGuilhotina01Sup) THEN
				PassoAjusteGuilhotina01Sup:=180;//Não se Move
			END_IF
			IF dValorEncoderGuilhotinaResfriador01Sup<dValEncoAlturaGuilhotina01Sup-dValEncoToleranciaGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=20;//Sobe
			END_IF
			IF dValorEncoderGuilhotinaResfriador01Sup>dValEncoAlturaGuilhotina01Sup+dValEncoToleranciaGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=100;//Desce
			END_IF
			
//Sobe

		20:	iVelocidadeGuilhotina01Sup:= iVelocidadeAjusteGuilhotina01Sup;
			PassoAjusteGuilhotina01Sup:=25;

		25: xAbreGuilhotina01Sup:=TRUE;
			PassoAjusteGuilhotina01Sup:=30;
			
		30:	IF dValorEncoderGuilhotinaResfriador01Sup>=dValEncoAlturaGuilhotina01Sup-dValEncoAlturaVelMinGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=40;
			END_IF
			IF iVelocidadeGuilhotina01Sup<> iVelocidadeAjusteGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=20;
			END_IF
			IF xSensorAbertoGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=200;
			END_IF

			IF xPause THEN
				PassoPausaAjusteGuilhotina01Sup:=20;
				PassoAjusteGuilhotina01Sup:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01Sup THEN
				PassoAlmAjusteGuilhotina01Sup:=20;
				PassoAjusteGuilhotina01Sup:=400;
			END_IF		

		40:	iVelocidadeGuilhotina01Sup:= iVelocidadeMinimaGuilhotina01Sup;
			PassoAjusteGuilhotina01Sup:=50;
			
		50:	IF dValorEncoderGuilhotinaResfriador01Sup>=dValEncoAlturaGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=60;
			END_IF
			IF iVelocidadeGuilhotina01Sup<> iVelocidadeMinimaGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=40;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina01Sup:=40;
				PassoAjusteGuilhotina01Sup:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01Sup THEN
				PassoAlmAjusteGuilhotina01Sup:=40;
				PassoAjusteGuilhotina01Sup:=400;
			END_IF		
			
		60: xAbreGuilhotina01Sup:=FALSE;
			PassoAjusteGuilhotina01Sup:=180;
//Desce

		100:iVelocidadeGuilhotina01Sup:= 1*iVelocidadeAjusteGuilhotina01Sup;
			PassoAjusteGuilhotina01Sup:=105;
			
		105:xFechaGuilhotina01Sup:=TRUE;
			PassoAjusteGuilhotina01Sup:=110;
			
		110:IF dValorEncoderGuilhotinaResfriador01Sup<dValEncoAlturaGuilhotina01Sup+dValEncoAlturaVelMinGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=120;
			END_IF
			IF iVelocidadeGuilhotina01Sup<> 1*iVelocidadeAjusteGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=100;
			END_IF
			IF	xSensorFechadoGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=200;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina01Sup:=100;
				PassoAjusteGuilhotina01Sup:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01Sup THEN
				PassoAlmAjusteGuilhotina01Sup:=100;
				PassoAjusteGuilhotina01Sup:=400;
			END_IF		

		120:iVelocidadeGuilhotina01Sup:= 1*iVelocidadeMinimaGuilhotina01Sup;
			PassoAjusteGuilhotina01Sup:=130;
			
		130:IF  dValorEncoderGuilhotinaResfriador01Sup<=dValEncoAlturaGuilhotina01Sup THEN
				PassoAjusteGuilhotina01Sup:=140;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina01Sup:=120;
				PassoAjusteGuilhotina01Sup:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01Sup THEN
				PassoAlmAjusteGuilhotina01Sup:=120;
				PassoAjusteGuilhotina01Sup:=400;
			END_IF		

		140:xFechaGuilhotina01Sup:=FALSE;
			PassoAjusteGuilhotina01Sup:=180;
//Fim		

		180:xAjusteAlturaGuilhotina01SupOK:=TRUE;
			xGuilhotina01SupEmAjuste:=FALSE;
			PassoAjusteGuilhotina01Sup:=0;

		200:xAbreGuilhotina01Sup:=FALSE;
			xFechaGuilhotina01Sup:=FALSE;
			PassoAjusteGuilhotina01Sup:=0;

		// Emergência Pausa/Reinicio
		300:xAbreGuilhotina01Sup:=FALSE;
			xFechaGuilhotina01Sup:=FALSE;
			PassoAjusteGuilhotina01Sup:=301;

		301:PassoAjusteGuilhotina01Sup:=302;
	
		302:IF xRestart THEN
				PassoAjusteGuilhotina01Sup:=303;
			END_IF
			
		303: PassoAjusteGuilhotina01Sup:=PassoPausaAjusteGuilhotina01Sup;

		// Alarme Motor Parada/Reinicio
		400:xAbreGuilhotina01Sup:=FALSE;
			xFechaGuilhotina01Sup:=FALSE;
			PassoAjusteGuilhotina01Sup:=401;

		401:PassoAjusteGuilhotina01Sup:=402;
	
		402:IF xRestart AND iCanOpenInverGuilResfr01SupStateOk THEN
				PassoAjusteGuilhotina01Sup:=PassoAlmAjusteGuilhotina01Sup;
			END_IF	
	
END_CASE			

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Dirreção
xMotorGuilhotina01SupAbre:= xAbreGuilhotina01Sup OR xAbreJogGuilhotina01Sup;
xMotorGuilhotina01SupFecha:= xFechaGuilhotina01Sup OR xFechaJogGuilhotina01Sup;

InversorGuilhot01Sup.i_xAvanco:=xMotorGuilhotina01SupAbre;
InversorGuilhot01Sup.i_xRecuo:=xMotorGuilhotina01SupFecha;

// Velocidade
InversorGuilhot01Sup.i_iFreqRef:=iVelocidadeGuilhotina01Sup;
//---------------------------------------------------------------------------------\\

ConversorPulMilimGuilho01Sup(
	dPulso:=107918, 
	dMilimetro:= 100, 
	dEntradaPulso01:= dValorEncoderGuilhotinaResfriador01Sup,
	iSaidaMilimetro01=> iAlturaAtualGuilhotina01Sup );
	
IF xOperacaoManual THEN
	PassoHomeGuilhotina01Sup:=0;
	PassoAjusteGuilhotina01Sup:=0;
	xIniciaHomeGuilhotina01Sup:=FALSE;
	xAjusteAlturaGuilhotina01SupOK:=FALSE;
	xGuilhotina01SupEmHome:=FALSE;
	xGuilhotina01SupEmAjuste:=FALSE;
	
	xAbreGuilhotina01Sup:=FALSE;
	xFechaGuilhotina01Sup:=FALSE;
END_IF

(*-------------------- Manual Jog--------------------------*)














