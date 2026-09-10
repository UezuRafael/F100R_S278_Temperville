__METADATA__
{
  "v3Meta": {
    "objectGuid": "5430824f-103b-4a2c-b934-babfcc2e153a",
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
PROGRAM J_DuctosResfriadorSup02
VAR
	PassoHomeDuctosResfrSup02: INT;
	PassoPausaHomeDuctosResfrSup02: INT;
	PassoAlmHomeDuctosResfrSup02: INT;
	PassoAjusteDuctosResfSup02: INT;
	PassoPausaAjusteDuctosResfSup02: INT;
	PassoAlmAjusteDuctosResfSup02: INT;
	PassoChaveDuctosResfrSup02: INT;
	PassoPausaChaveDuctosResfrSup02: INT;
	PassoAlmChaveDuctosResfrSup02: INT;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul01ResfrSup02: MmConversorPulso;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul02ResfrSup02: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilimResfrSup02: PulsoConversorMm;
	PulsoChDutosSup02Po: PulsoPositivo;
	PulsoChDutosSup02Ne: PulsoNegativo;
	xAbreDuctosResfriadorSup02: BOOL;
	xFechaDuctosResfriadorSup02: BOOL;
	xAbreResfridorSup02: BOOL;
	xFechaResfridorSup02: BOOL;
	xAjustarAlturaResfriadorSup02: BOOL;
	///Recebera uma valor fixo
	iVelocidadeHomeDuctosResfrSup02: INT;
	iVelocidadeJogDuctosResfrSup02: INT;
	iVelocidadeDuctosResfriadorSup02: INT;
	dValEncoAltura01ResfriadorSup02: DINT;
	dValEncoAltura02ResfriadorSup02: DINT;
	dValEncoAltura03ResfriadorSup02: DINT;
	dValEncoAlturaResfriadorSup02: DINT;
	dValEncoToleranciaResfrSup02: DINT;
	dValEncoAlturaVelMinimaResfrSup02: DINT := 35;
	xDifusorSup02Fechando: BOOL;
	xDifusorSup02Abrindo: BOOL;
	iCompValAltura01ResfriadorSup02: INT;
	iCompValAltura02ResfriadorSup02: INT;
	iCompValAltura03ResfriadorSup02: INT;
	iCompAlturaAtualDuctosResfriadorSup02: INT;
	iCompessaAlturaDuctosResfriadorSup02: INT;
	xPulsoChDutosSup02Po: BOOL;
	xPulsoChDutosSup02Ne: BOOL;
END_VAR
__IMPLEMENTATION__



iCompessaAlturaDuctosResfriadorSup02:=REAL_TO_INT(rOffSetResfSup02);
iCompValAltura01ResfriadorSup02:=	iValAltura01ResfriadorSup02 - iCompessaAlturaDuctosResfriadorSup02;
iCompValAltura02ResfriadorSup02:=	iValAltura02ResfriadorSup02 - iCompessaAlturaDuctosResfriadorSup02;
iCompValAltura03ResfriadorSup02:=	iValAltura03ResfriadorSup02 - iCompessaAlturaDuctosResfriadorSup02;


// CONVERSÃO MILIMETROS EM PULSOS	
ConversorMilimPul01ResfrSup02(
	dPulso:= 1051, 
	dMilimetro:= 114, 
	iEntrMilimetro01:= iCompValAltura01ResfriadorSup02, 
	iEntrMilimetro02:= iCompValAltura02ResfriadorSup02, 
	iEntrMilimetro03:= iCompValAltura03ResfriadorSup02, 
	dSaidaPulso01=> dValEncoAltura01ResfriadorSup02,
	dSaidaPulso02=> dValEncoAltura02ResfriadorSup02,
	dSaidaPulso03=> dValEncoAltura03ResfriadorSup02);
	
ConversorMilimPul02ResfrSup02(
	dPulso:= 1051, 
	dMilimetro:= 114, 
	iEntrMilimetro01:= 2,//iValEncoToleranciaDuctosSup02, 
	iEntrMilimetro02:= 10,//iValEncoAlturaVelMinimaDuctosSup02, 
	dSaidaPulso01=> dValEncoToleranciaResfrSup02, 
	dSaidaPulso02=> dValEncoAlturaVelMinimaResfrSup02);


// SEQUENCIA DE HOME

CASE PassoHomeDuctosResfrSup02 OF
	
		0:	IF xIniciaHomeDuctosSup02 (*OR xAutoHomeResfSup02*) THEN
				PassoHomeDuctosResfrSup02:=5;		
			END_IF
			
		5:	IF xChAbreDuctosResfriadorSup02 THEN
				PassoHomeDuctosResfrSup02:=6;
			ELSE
				PassoHomeDuctosResfrSup02:=10;
			END_IF
			
		6:	xAutoHomeResfSup02:=FALSE;
			xIniciaHomeDuctosSup02:=FALSE;
			PassoHomeDuctosResfrSup02:=0;
			
		10:	xIniciaHomeDuctosSup02:=FALSE;
			xHomeDuctosResfriadorSup02Ok:=FALSE;
			xAjusteAlturaDuctosSup02OK:=FALSE;
			xDuctosSup02EmHome:=TRUE;
			iVelocidadeDuctosResfriadorSup02:= 150;//1*iVelocidadeHomeDuctosResfrSup02;
			PassoHomeDuctosResfrSup02:=15;
			
		15: xFechaResfridorSup02:=TRUE;
			PassoHomeDuctosResfrSup02:=20;
			
		20:	IF xSensorFechadoResfriadorSup02 THEN
				PassoHomeDuctosResfrSup02:=50;
			END_IF
			IF xPause THEN
				PassoPausaHomeDuctosResfrSup02:=10;
				PassoHomeDuctosResfrSup02:=300;
			END_IF
			IF xAlarmeMotorDifusorSup02 THEN
				PassoAlmHomeDuctosResfrSup02:=10;
				PassoHomeDuctosResfrSup02:=400;
			END_IF

		50:	xFechaResfridorSup02:=FALSE;
			PassoHomeDuctosResfrSup02:=55;
			
		55:	iVelocidadeDuctosResfriadorSup02:= 50;
			PassoHomeDuctosResfrSup02:=56;
			
		56:	xAbreResfridorSup02:=TRUE;
			PassoHomeDuctosResfrSup02:=60;
			
		60:	IF NOT xSensorFechadoResfriadorSup02 THEN
				PassoHomeDuctosResfrSup02:=70;
			END_IF
			IF xPause THEN
				PassoPausaHomeDuctosResfrSup02:=50;
				PassoHomeDuctosResfrSup02:=300;
			END_IF
			IF xAlarmeMotorDifusorSup02 THEN
				PassoAlmHomeDuctosResfrSup02:=50;
				PassoHomeDuctosResfrSup02:=400;
			END_IF
			
		70:	xAbreResfridorSup02:=FALSE;
			PassoHomeDuctosResfrSup02:=74;
			
		74:	IF NOT xMotorDifusorSup02Ligado THEN
				PassoHomeDuctosResfrSup02:=75;
			END_IF
			
		75: xHomeEncoderDuctosResfriadorSup02:=TRUE;
			PassoHomeDuctosResfrSup02:=80;
		
		80: xHomeEncoderDuctosResfriadorSup02:=FALSE;
			xDuctosSup02EmHome:=FALSE;
			xAutoHomeResfSup02:=FALSE;
			xHomeDuctosResfriadorSup02Ok:=TRUE;
			PassoHomeDuctosResfrSup02:=0;
			
		// Emergência Pausa/Reinicio
		300:xFechaResfridorSup02:=FALSE;
			xAbreResfridorSup02:=FALSE;
			PassoHomeDuctosResfrSup02:=301;

		301:xDuctosSup02EmHome:=FALSE;
			PassoHomeDuctosResfrSup02:=302;
	
		302:IF xRestart THEN
				PassoHomeDuctosResfrSup02:=303;
			END_IF
			
		303:PassoHomeDuctosResfrSup02:=0;//PassoPausaHomeDuctosResfrSup02;
			
		// Alarme Motor Parada/Reinicio
		400:xFechaResfridorSup02:=FALSE;
			xAbreResfridorSup02:=FALSE;
			PassoHomeDuctosResfrSup02:=401;

		401:PassoHomeDuctosResfrSup02:=402;
	
		402:IF xRestart AND iCanOpenInverDuctResfrSup02StateOk THEN
				PassoHomeDuctosResfrSup02:=PassoAlmHomeDuctosResfrSup02;
			END_IF	
END_CASE

//
IF xTerceiroEstagioResfriador THEN
	dValEncoAlturaResfriadorSup02:=dValEncoAltura03ResfriadorSup02;
ELSIF xSegundoEstagioResfriador THEN
	dValEncoAlturaResfriadorSup02:=dValEncoAltura02ResfriadorSup02;
ELSE
	dValEncoAlturaResfriadorSup02:=dValEncoAltura01ResfriadorSup02;
END_IF

// SEQUENCIA DE FUNCIONAMENTO

IF (xBtRecAjustaAlturaDuctosSup02 OR BtParamDuctosResfriadorSup02 OR (xLigaSegEstagDuctosSup02 AND NOT xChAbreDuctosResfriadorSup02) OR (xLigaTerEstagDuctosSup02 AND NOT xChAbreDuctosResfriadorSup02) OR xReajustaAlturaDuctosSup02) AND xHomeDuctosResfriadorSup02Ok THEN
	xAjustarAlturaResfriadorSup02:=TRUE;
	xBtRecAjustaAlturaDuctosSup02:=FALSE;
	BtParamDuctosResfriadorSup02:=FALSE;
	xLigaSegEstagDuctosSup02:= FALSE;
	xLigaTerEstagDuctosSup02:= FALSE;
	xReajustaAlturaDuctosSup02:=FALSE;
ELSE
	xBtRecAjustaAlturaDuctosSup02:=FALSE;
	BtParamDuctosResfriadorSup02:=FALSE;
	xLigaSegEstagDuctosSup02:= FALSE;
	xLigaTerEstagDuctosSup02:= FALSE;
	xReajustaAlturaDuctosSup02:=FALSE;
END_IF

CASE PassoAjusteDuctosResfSup02 OF
		
		0:	IF xAjustarAlturaResfriadorSup02 AND NOT xAbreDuctosResfriadorSup02 THEN //AND NOT xChAbreDuctosResfriadorSup02 THEN
				PassoAjusteDuctosResfSup02:=10;
			END_IF
			
		10:	xAjustarAlturaResfriadorSup02:=FALSE;
			xAjusteAlturaDuctosSup02OK:=FALSE;
			xDuctosSup02EmAjuste:=TRUE;
			IF dValorEncoderDuctosResfriadorSup02<dValEncoAlturaResfriadorSup02-dValEncoToleranciaResfrSup02 THEN
				xDifusorSup02Abrindo:=TRUE;
				PassoAjusteDuctosResfSup02:=20;//Abre
			END_IF
			IF dValorEncoderDuctosResfriadorSup02>dValEncoAlturaResfriadorSup02+dValEncoToleranciaResfrSup02 THEN
				PassoAjusteDuctosResfSup02:=100;//Fecha
				xDifusorSup02Fechando:=TRUE;
			END_IF
			IF dValorEncoderDuctosResfriadorSup02>=dValEncoAlturaResfriadorSup02-dValEncoToleranciaResfrSup02 AND dValorEncoderDuctosResfriadorSup02<=dValEncoAlturaResfriadorSup02+dValEncoToleranciaResfrSup02 THEN
				PassoAjusteDuctosResfSup02:=180;//Não se Move
			END_IF
//Abre
		20:	iVelocidadeDuctosResfriadorSup02:= iVelocidadeAjusteDuctosResfriadorSup02;
			PassoAjusteDuctosResfSup02:=25;
			
		25:	xAbreResfridorSup02:=TRUE;
			PassoAjusteDuctosResfSup02:=30;
			
		30:	IF (dValorEncoderDuctosResfriadorSup02>=dValEncoAlturaResfriadorSup02-35(*dValEncoAlturaVelMinimaResfrSup02*)) OR xSensorAbertoResfriadorSup02  THEN
				PassoAjusteDuctosResfSup02:=40;
			END_IF
			IF iVelocidadeDuctosResfriadorSup02<> iVelocidadeAjusteDuctosResfriadorSup02 THEN
				PassoAjusteDuctosResfSup02:=20;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfSup02:=20;
				PassoAjusteDuctosResfSup02:=300;
			END_IF
			IF xAlarmeMotorDifusorSup02 THEN
				PassoAlmAjusteDuctosResfSup02:=20;
				PassoAjusteDuctosResfSup02:=400;
			END_IF

		40:	iVelocidadeDuctosResfriadorSup02:= iVelocidadeMinimaDuctosResfriadorSup02;
			PassoAjusteDuctosResfSup02:=50;
			
		50:	IF (dValorEncoderDuctosResfriadorSup02>=dValEncoAlturaResfriadorSup02) OR xSensorAbertoResfriadorSup02 THEN
				PassoAjusteDuctosResfSup02:=60;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfSup02:=40;
				PassoAjusteDuctosResfSup02:=300;
			END_IF
			IF xAlarmeMotorDifusorSup02 THEN
				PassoAlmAjusteDuctosResfSup02:=40;
				PassoAjusteDuctosResfSup02:=400;
			END_IF
			
		60: xAbreResfridorSup02:=FALSE;
			PassoAjusteDuctosResfSup02:=180;

//Desce
		100:iVelocidadeDuctosResfriadorSup02:= 1*iVelocidadeAjusteDuctosResfriadorSup02;
			PassoAjusteDuctosResfSup02:=105;
			
		105:xFechaResfridorSup02:=TRUE;
			PassoAjusteDuctosResfSup02:=110;
	
		110:IF (dValorEncoderDuctosResfriadorSup02 <= dValEncoAlturaResfriadorSup02+35(*dValEncoAlturaVelMinimaResfrSup02*)) OR xSensorFechadoResfriadorSup02 THEN
				PassoAjusteDuctosResfSup02:=120;
			END_IF
			IF iVelocidadeDuctosResfriadorSup02<> 1*iVelocidadeAjusteDuctosResfriadorSup02 THEN
				PassoAjusteDuctosResfSup02:=100;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfSup02:=100;
				PassoAjusteDuctosResfSup02:=300;
			END_IF
			IF xAlarmeMotorDifusorSup02 THEN
				PassoAlmAjusteDuctosResfSup02:=100;
				PassoAjusteDuctosResfSup02:=400;
			END_IF

		120:iVelocidadeDuctosResfriadorSup02:= 1*iVelocidadeMinimaDuctosResfriadorSup02;
			PassoAjusteDuctosResfSup02:=130;
			
		130:IF (dValorEncoderDuctosResfriadorSup02<=dValEncoAlturaResfriadorSup02) OR xSensorFechadoResfriadorSup02 THEN
				PassoAjusteDuctosResfSup02:=140;
			END_IF
			IF iVelocidadeDuctosResfriadorSup02<> 1*iVelocidadeMinimaDuctosResfriadorSup02 THEN
				PassoAjusteDuctosResfSup02:=120;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfSup02:=120;
				PassoAjusteDuctosResfSup02:=300;
			END_IF
			IF xAlarmeMotorDifusorSup02 THEN
				PassoAlmAjusteDuctosResfSup02:=120;
				PassoAjusteDuctosResfSup02:=400;
			END_IF
			
		140:xFechaResfridorSup02:=FALSE;
			PassoAjusteDuctosResfSup02:=180;
//Fim		
		180:xDifusorSup02Abrindo:=FALSE;
			xDifusorSup02Fechando:=FALSE;
			xDuctosSup02EmAjuste:=FALSE;
			xAjusteAlturaDuctosSup02OK:=TRUE;
			PassoAjusteDuctosResfSup02:=0;

		// Emergência Pausa/Reinicio
		300:xAbreResfridorSup02:=FALSE;
			xFechaResfridorSup02:=FALSE;
			PassoAjusteDuctosResfSup02:=301;

		301:PassoAjusteDuctosResfSup02:=302;
	
		302:IF xRestart THEN
				PassoAjusteDuctosResfSup02:=303;
			END_IF
			
		303:PassoAjusteDuctosResfSup02:=PassoPausaAjusteDuctosResfSup02;
			
		// Alarme Motor Parada/Reinicio
		400:xAbreResfridorSup02:=FALSE;
			xFechaResfridorSup02:=FALSE;
			PassoAjusteDuctosResfSup02:=401;

		401:PassoAjusteDuctosResfSup02:=402;
	
		402:IF xRestart AND iCanOpenInverDuctResfrSup02StateOk THEN
				PassoAjusteDuctosResfSup02:=PassoAlmAjusteDuctosResfSup02;
			END_IF	
			

END_CASE

// MOVIMENTO COM A CHAVE DE ABERTURA

PulsoChDutosSup02Po(Entrada:= xChAbreDuctosResfriadorSup02, SaidaPulsoPo=> xPulsoChDutosSup02Po);
PulsoChDutosSup02Ne(Entrada:= xChAbreDuctosResfriadorSup02, SaidaPulsoNe=> xPulsoChDutosSup02Ne);

IF xPulsoChDutosSup02Po THEN
	xPausaMesaResfrimento:=TRUE;
END_IF
IF xPulsoChDutosSup02Ne THEN
	xPausaMesaResfrimento:=FALSE;
END_IF

CASE PassoChaveDuctosResfrSup02 OF
			
		0:	IF xPulsoChDutosSup02Po AND xHomeDuctosResfriadorSup02Ok THEN //IF xChAbreDuctosResfriadorSup02 AND xHomeDuctosResfriadorSup02Ok THEN
				PassoChaveDuctosResfrSup02:=5;
				PassoAjusteDuctosResfSup02:=0;
				xFechaResfridorSup02:=FALSE;
			END_IF
			
		5:	IF NOT xPrimeiroEstagioResfriador THEN
				PassoChaveDuctosResfrSup02:=10;
			END_IF
			
		10:	iVelocidadeDuctosResfriadorSup02:=iVelocidadeAjusteDuctosResfriadorSup02;
			xAjusteAlturaDuctosSup02OK:=FALSE;
			xAbreDuctosResfriadorSup02:=TRUE;//xChAbreDuctosResfriadorSup02;
			IF xSensorAbertoResfriadorSup02 THEN
				PassoChaveDuctosResfrSup02:=20;
			END_IF
			IF xPause THEN
				PassoPausaChaveDuctosResfrSup02:=10;
				PassoChaveDuctosResfrSup02:=300;
			END_IF
			IF xAlarmeMotorDifusorSup02 THEN
				PassoAlmChaveDuctosResfrSup02:=10;
				PassoChaveDuctosResfrSup02:=400;
			END_IF
			
		20:	xAbreDuctosResfriadorSup02:=FALSE;
			PassoChaveDuctosResfrSup02:=21;
			
		21:	IF xPulsoChDutosSup02Ne THEN//IF NOT xChAbreDuctosResfriadorSup02 THEN
				xAbreDuctosResfriadorSup02:=FALSE;
				PassoChaveDuctosResfrSup02:=0;
				PassoAjusteDuctosResfSup02:=100;
			END_IF
			IF xPause THEN
				PassoPausaChaveDuctosResfrSup02:=21;
				PassoChaveDuctosResfrSup02:=300;
			END_IF
			IF xAlarmeMotorDifusorSup02 THEN
				PassoAlmChaveDuctosResfrSup02:=21;
				PassoChaveDuctosResfrSup02:=400;
			END_IF
				
		// Emergência Pausa/Reinicio
		300:xAbreDuctosResfriadorSup02:=FALSE;
			PassoChaveDuctosResfrSup02:=301;

		301:PassoChaveDuctosResfrSup02:=302;
	
		302:IF xRestart THEN
				PassoChaveDuctosResfrSup02:=303;
			END_IF
			
		303:PassoChaveDuctosResfrSup02:=PassoPausaChaveDuctosResfrSup02;
			
		// Alarme Motor Parada/Reinicio
		400:xAbreDuctosResfriadorSup02:=FALSE;
			PassoChaveDuctosResfrSup02:=401;

		401:PassoChaveDuctosResfrSup02:=402;
	
		402:IF xRestart AND iCanOpenInverDuctResfrSup02StateOk THEN
				PassoChaveDuctosResfrSup02:=PassoAlmChaveDuctosResfrSup02;
			END_IF	
	
END_CASE

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Dirreção
xMotorResfridorSup02Abre:= xAbreResfridorSup02 OR xAbreDuctosResfriadorSup02;
xMotorResfridorSup02Fecha:= xFechaResfridorSup02;

InversorResfSup02.i_xAvanco:=xMotorResfridorSup02Abre;
InversorResfSup02.i_xRecuo:=xMotorResfridorSup02Fecha;
// Velocidade
InversorResfSup02.i_iFreqRef:=iVelocidadeDuctosResfriadorSup02;
//---------------------------------------------------------------------------------\\

ConversorPulMilimResfrSup02(
	dPulso:= 1051, 
	dMilimetro:= 114, 
	dEntradaPulso01:= dValorEncoderDuctosResfriadorSup02,
	iSaidaMilimetro01=> iCompAlturaAtualDuctosResfriadorSup02 );
	
iAlturaAtualDuctosResfriadorSup02:=iCompAlturaAtualDuctosResfriadorSup02+iCompessaAlturaDuctosResfriadorSup02;

IF xOperacaoManual THEN
	PassoHomeDuctosResfrSup02:=0;
	PassoPausaHomeDuctosResfrSup02:=0;
	PassoAlmHomeDuctosResfrSup02:=0;
	PassoAjusteDuctosResfSup02:=0;
	PassoPausaAjusteDuctosResfSup02:=0;
	PassoAlmAjusteDuctosResfSup02:=0;
	PassoChaveDuctosResfrSup02:=0;
	PassoPausaChaveDuctosResfrSup02:=0;
	PassoAlmChaveDuctosResfrSup02:=0;
	xIniciaHomeDuctosSup02:=FALSE;
	xHomeEncoderDuctosResfriadorSup02:=FALSE;
	xAbreDuctosResfriadorSup02:=FALSE;
	xFechaDuctosResfriadorSup02:=FALSE;
	xDifusorSup02Abrindo:=FALSE;
	xDifusorSup02Fechando:=FALSE;
	xAjusteAlturaDuctosSup02OK:=FALSE;
	xFechaDuctosResfriadorSup02:=FALSE;
	xBtRecAjustaAlturaDuctosSup02:=FALSE;
	BtParamDuctosResfriadorSup02:=FALSE;
	xDuctosSup02EmHome:=FALSE;
	xDuctosSup02EmAjuste:=FALSE;
	xLigaSegEstagDuctosSup02:= FALSE;
	xLigaTerEstagDuctosSup02:= FALSE;
	xReajustaAlturaDuctosSup02:=FALSE;
	xDesceAutoFimCiclo:=FALSE;
	
	xFechaResfridorSup02:=FALSE;
	xAbreResfridorSup02:=FALSE;
	xLigaTerEstagDuctosSup02:=FALSE;		
END_IF
	
