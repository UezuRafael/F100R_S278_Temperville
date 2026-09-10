__METADATA__
{
  "v3Meta": {
    "objectGuid": "8136d68a-3bcb-4f46-81f8-239e3051f1e4",
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
PROGRAM K_Guilhotina01Inf
VAR
	PassoHomeGuilhotina01Inf: INT;
	PassoAjusteGuilhotina01Inf: INT;
	PassoPausaHomeGuilhotina01Inf: INT;
	PassoPausaAjusteGuilhotina01Inf: INT;
	PassoAlmHomeGuilhotina01Inf: INT;
	PassoAlmAjusteGuilhotina01Inf: INT;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul01Guilho01Inf: MmConversorPulso;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul02Guilho01Inf: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilimGuilho01Inf: PulsoConversorMm;
	xSetValorSpAltGuil01InfSup: BOOL;
	iAlturaGhilhotina01InfAux: INT;
	xAjustarAlturaGuilhotina01Inf: BOOL;
	iVelocidadeHomeGuilhotina01Inf: INT;
	iVelocidadeGuilhotina01Inf: INT;
	dValEncoAlturaGuilhotina01Inf: DINT;
	dValEncoToleranciaGuilhotina01Inf: DINT;
	dValEncoAlturaVelMinGuilhotina01Inf: DINT;
	xAbreJogGuilhotina01Inf: BOOL;
	xFechaJogGuilhotina01Inf: BOOL;
	xAbreGuilhotina01Inf: BOOL;
	xFechaGuilhotina01Inf: BOOL;
END_VAR
__IMPLEMENTATION__
IF iAlturaGhilhotina01Inf <> iAlturaGhilhotina01InfAux THEN
	xSetValorSpAltGuil01InfSup:=TRUE;
	
END_IF;

IF xSetValorSpAltGuil01InfSup THEN
	iAlturaGhilhotina01InfAux:=iAlturaGhilhotina01Inf;
ELSE
	IF NOT xMotorGuilhotina01InfLigado THEN
		iAlturaGhilhotina01Inf:=iAlturaAtualGuilhotina01Inf;
	END_IF;
END_IF

IF iAlturaGhilhotina01InfAux=iAlturaAtualGuilhotina01Inf THEN
	xSetValorSpAltGuil01InfSup:=FALSE;
END_IF


// CONVERSÃO MILIMETROS EM PULSOS

ConversorMilimPul01Guilho01Inf(
	dPulso:= 105563, 
	dMilimetro:= 100, 
	iEntrMilimetro01:= iAlturaGhilhotina01InfAux,//iAlturaGhilhotina02, 
	dSaidaPulso01=> dValEncoAlturaGuilhotina01Inf);
	
ConversorMilimPul02Guilho01Inf(
	dPulso:= 105563, 
	dMilimetro:= 100, 
	iEntrMilimetro01:= 2,//iValEncoToleranciaGuilhotina, 
	iEntrMilimetro02:= 8,//iValEncoAlturaVelMinGuilhotina, 
	dSaidaPulso01=> dValEncoToleranciaGuilhotina01Inf,	 
	dSaidaPulso02=> dValEncoAlturaVelMinGuilhotina01Inf);

// SEQUENCIA DE HOME

CASE PassoHomeGuilhotina01Inf OF
	
		0:	IF xIniciaHomeGuilhotina01Inf THEN
				PassoHomeGuilhotina01Inf:=10;		
			END_IF
			
		10:	xIniciaHomeGuilhotina01Inf:=FALSE;
			xHomeGuilhotina01InfOk:=FALSE;
			xAjusteAlturaGuilhotina01InfOK:=FALSE;
			xGuilhotina01InfEmHome:=TRUE;
			iVelocidadeGuilhotina01Inf:= 300;//1*iVelocidadeHomeDuctosResfrSup02;
			PassoHomeGuilhotina01Inf:=15;
			
		15: xFechaGuilhotina01Inf:=TRUE;
			PassoHomeGuilhotina01Inf:=20;
			
		20:	IF xSensorFechadoGuilhotina01Inf THEN
				PassoHomeGuilhotina01Inf:=50;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina01Inf:=10;
				PassoHomeGuilhotina01Inf:=300;
			END_IF
			IF xAlarmeMotorGuilhotina01Inf THEN
				PassoAlmHomeGuilhotina01Inf:=10;
				PassoHomeGuilhotina01Inf:=400;
			END_IF

		50:	xFechaGuilhotina01Inf:=FALSE;
			PassoHomeGuilhotina01Inf:=55;
				
		55:	iVelocidadeGuilhotina01Inf:= 50;
			PassoHomeGuilhotina01Inf:=56;
			
		56:	xAbreGuilhotina01Inf:=TRUE;
			PassoHomeGuilhotina01Inf:=60;
			
		60:	IF NOT xSensorFechadoGuilhotina01Inf THEN
				PassoHomeGuilhotina01Inf:=70;
			END_IF
			IF xPause THEN
				PassoPausaHomeGuilhotina01Inf:=50;
				PassoHomeGuilhotina01Inf:=300;
			END_IF
			IF xAlarmeMotorGuilhotina01Inf THEN
				PassoAlmHomeGuilhotina01Inf:=50;
				PassoHomeGuilhotina01Inf:=400;
			END_IF

		70:	xAbreGuilhotina01Inf:=FALSE;
			PassoHomeGuilhotina01Inf:=74;
			
		74:	IF NOT xMotorGuilhotina01InfLigado THEN
				PassoHomeGuilhotina01Inf:=75;
			END_IF
			
		75: xHomeEncoderGuilhotinaResfriador01Inf:=TRUE;
			PassoHomeGuilhotina01Inf:=80;
		
		80: xHomeEncoderGuilhotinaResfriador01Inf:=FALSE;
			xGuilhotina01InfEmHome:=FALSE;
			xHomeGuilhotina01InfOk:=TRUE;
			
		// Emergência Pausa/Reinicio
		300:xAbreGuilhotina01Inf:=FALSE;
			xAbreGuilhotina01Inf:=FALSE;
			PassoHomeGuilhotina01Inf:=301;

		301:xDuctosSup02EmHome:=FALSE;
			PassoHomeGuilhotina01Inf:=302;
	
		302:IF xRestart THEN
				PassoHomeGuilhotina01Inf:=303;
			END_IF
			
		303:PassoHomeGuilhotina01Inf:=0;//PassoPausaHomeDuctosResfrSup02;
			
		// Alarme Motor Parada/Reinicio
		400:xFechaGuilhotina01Inf:=FALSE;
			xAbreGuilhotina01Inf:=FALSE;
			PassoHomeGuilhotina01Inf:=401;

		401:PassoHomeGuilhotina01Inf:=402;
	
		402:IF xRestart AND iCanOpenInverGuilResfr01InfStateOk THEN
				PassoHomeGuilhotina01Inf:=PassoAlmHomeGuilhotina01Inf;
			END_IF					
END_CASE

// SEQUENCIA DE FUNCIONAMENTO

IF (xBtRecAjustaGuilhotina01Inf OR BtParamGuilhotina01Inf) AND xHomeGuilhotina01InfOk THEN
	xAjustarAlturaGuilhotina01Inf:=TRUE;
	xBtRecAjustaGuilhotina01Inf:=FALSE;
	BtParamGuilhotina01Inf:=FALSE;
ELSE
	xBtRecAjustaGuilhotina01Inf:=FALSE;
	BtParamGuilhotina01Inf:=FALSE;
END_IF

CASE PassoAjusteGuilhotina01Inf OF
		
		0:	IF xAjustarAlturaGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=10;
			END_IF
			
		10:	xAjustarAlturaGuilhotina01Inf:=FALSE;
			xAjusteAlturaGuilhotina01InfOK:=FALSE;
			xGuilhotina01InfEmAjuste:=TRUE;
			IF (dValorEncoderGuilhotinaResfriador01Inf>=dValEncoAlturaGuilhotina01Inf-dValEncoToleranciaGuilhotina01Inf) AND (dValorEncoderGuilhotinaResfriador01Inf<=dValEncoAlturaGuilhotina01Inf+dValEncoToleranciaGuilhotina01Inf) THEN
				PassoAjusteGuilhotina01Inf:=180;//Não se Move
			END_IF
			IF dValorEncoderGuilhotinaResfriador01Inf<dValEncoAlturaGuilhotina01Inf-dValEncoToleranciaGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=20;//Sobe
			END_IF
			IF dValorEncoderGuilhotinaResfriador01Inf>dValEncoAlturaGuilhotina01Inf+dValEncoToleranciaGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=100;//Desce
			END_IF
			
//Sobe

		20:	iVelocidadeGuilhotina01Inf:= iVelocidadeAjusteGuilhotina01Inf;
			PassoAjusteGuilhotina01Inf:=25;

		25: xAbreGuilhotina01Inf:=TRUE;
			PassoAjusteGuilhotina01Inf:=30;
			
		30:	IF dValorEncoderGuilhotinaResfriador01Inf>=dValEncoAlturaGuilhotina01Inf-dValEncoAlturaVelMinGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=40;
			END_IF
			IF iVelocidadeGuilhotina01Inf<> iVelocidadeAjusteGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=20;
			END_IF
			IF xSensorAbertoGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=200;
			END_IF

			IF xPause THEN
				PassoPausaAjusteGuilhotina01Inf:=20;
				PassoAjusteGuilhotina01Inf:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01Inf THEN
				PassoAlmAjusteGuilhotina01Inf:=20;
				PassoAjusteGuilhotina01Inf:=400;
			END_IF		

		40:	iVelocidadeGuilhotina01Inf:= iVelocidadeMinimaGuilhotina01Inf;
			PassoAjusteGuilhotina01Inf:=50;
			
		50:	IF dValorEncoderGuilhotinaResfriador01Inf>=dValEncoAlturaGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=60;
			END_IF
			IF iVelocidadeGuilhotina01Inf<> iVelocidadeMinimaGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=40;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina01Inf:=40;
				PassoAjusteGuilhotina01Inf:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01Inf THEN
				PassoAlmAjusteGuilhotina01Inf:=40;
				PassoAjusteGuilhotina01Inf:=400;
			END_IF		
			
		60: xAbreGuilhotina01Inf:=FALSE;
			PassoAjusteGuilhotina01Inf:=180;
//Desce

		100:iVelocidadeGuilhotina01Inf:= 1*iVelocidadeAjusteGuilhotina01Inf;
			PassoAjusteGuilhotina01Inf:=105;
			
		105:xFechaGuilhotina01Inf:=TRUE;
			PassoAjusteGuilhotina01Inf:=110;
			
		110:IF dValorEncoderGuilhotinaResfriador01Inf<dValEncoAlturaGuilhotina01Inf+dValEncoAlturaVelMinGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=120;
			END_IF
			IF iVelocidadeGuilhotina01Inf<> 1*iVelocidadeAjusteGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=100;
			END_IF
			IF	xSensorFechadoGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=200;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina01Inf:=100;
				PassoAjusteGuilhotina01Inf:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01Inf THEN
				PassoAlmAjusteGuilhotina01Inf:=100;
				PassoAjusteGuilhotina01Inf:=400;
			END_IF		

		120:iVelocidadeGuilhotina01Inf:= 1*iVelocidadeMinimaGuilhotina01Inf;
			PassoAjusteGuilhotina01Inf:=130;
			
		130:IF  dValorEncoderGuilhotinaResfriador01Inf<=dValEncoAlturaGuilhotina01Inf THEN
				PassoAjusteGuilhotina01Inf:=140;
			END_IF
			IF xPause THEN
				PassoPausaAjusteGuilhotina01Inf:=120;
				PassoAjusteGuilhotina01Inf:=300;
			END_IF		
			IF xAlarmeMotorGuilhotina01Inf THEN
				PassoAlmAjusteGuilhotina01Inf:=120;
				PassoAjusteGuilhotina01Inf:=400;
			END_IF		

		140:xFechaGuilhotina01Inf:=FALSE;
			PassoAjusteGuilhotina01Inf:=180;
//Fim		

		180:xAjusteAlturaGuilhotina01InfOK:=TRUE;
			xGuilhotina01InfEmAjuste:=FALSE;
			PassoAjusteGuilhotina01Inf:=0;

		200:xAbreGuilhotina01Inf:=FALSE;
			xFechaGuilhotina01Inf:=FALSE;
			PassoAjusteGuilhotina01Inf:=0;

		// Emergência Pausa/Reinicio
		300:xAbreGuilhotina01Inf:=FALSE;
			xFechaGuilhotina01Inf:=FALSE;
			PassoAjusteGuilhotina01Inf:=301;

		301:PassoAjusteGuilhotina01Inf:=302;
	
		302:IF xRestart THEN
				PassoAjusteGuilhotina01Inf:=303;
			END_IF
			
		303: PassoAjusteGuilhotina01Inf:=PassoPausaAjusteGuilhotina01Inf;

		// Alarme Motor Parada/Reinicio
		400:xAbreGuilhotina01Inf:=FALSE;
			xFechaGuilhotina01Inf:=FALSE;
			PassoAjusteGuilhotina01Inf:=401;

		401:PassoAjusteGuilhotina01Inf:=402;
	
		402:IF xRestart AND iCanOpenInverGuilResfr01InfStateOk THEN
				PassoAjusteGuilhotina01Inf:=PassoAlmAjusteGuilhotina01Inf;
			END_IF	
	
END_CASE			

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Dirreção
xMotorGuilhotina01InfAbre:= xAbreGuilhotina01Inf OR xAbreJogGuilhotina01Inf;
xMotorGuilhotina01InfFecha:= xFechaGuilhotina01Inf OR xFechaJogGuilhotina01Inf;

InversorGuilhot01Inf.i_xAvanco:=xMotorGuilhotina01InfAbre;
InversorGuilhot01Inf.i_xRecuo:=xMotorGuilhotina01InfFecha;

// Velocidade
InversorGuilhot01Inf.i_iFreqRef:=iVelocidadeGuilhotina01Inf;
//---------------------------------------------------------------------------------\\

ConversorPulMilimGuilho01Inf(
	dPulso:=105563, 
	dMilimetro:= 100, 
	dEntradaPulso01:= dValorEncoderGuilhotinaResfriador01Inf,
	iSaidaMilimetro01=> iAlturaAtualGuilhotina01Inf );
	
IF xOperacaoManual THEN
	PassoHomeGuilhotina01Inf:=0;
	PassoAjusteGuilhotina01Inf:=0;
	xIniciaHomeGuilhotina01Inf:=FALSE;
	xAjusteAlturaGuilhotina01InfOK:=FALSE;
	xGuilhotina01InfEmHome:=FALSE;
	xGuilhotina01InfEmAjuste:=FALSE;
	
	xAbreGuilhotina01Inf:=FALSE;
	xFechaGuilhotina01Inf:=FALSE;
END_IF

(*-------------------- Manual Jog--------------------------*)














