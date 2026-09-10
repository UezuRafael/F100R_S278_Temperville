__METADATA__
{
  "v3Meta": {
    "objectGuid": "7d64acea-4b56-49a9-9aa0-5e1c3f087ccd",
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
PROGRAM J_DuctosResfriadorInf02
VAR
	PassoHomeDuctosResfrInf02: INT;
	PassoPausaHomeDuctosResfrInf02: INT;
	PassoAlmHomeDuctosResfrInf02: INT;
	PassoAjusteDuctosResfInf02: INT;
	PassoPausaAjusteDuctosResfInf02: INT;
	PassoAlmAjusteDuctosResfInf02: INT;
	PassoChaveDuctosResfrInf02: INT;
	PassoPausaChaveDuctosResfrInf02: INT;
	PassoAlmChaveDuctosResfrInf02: INT;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul01ResfrInf02: MmConversorPulso;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul02ResfrInf02: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilimResfrInf02: PulsoConversorMm;
	PulsoChDutosInf02Po: PulsoPositivo;
	PulsoChDutosInf02Ne: PulsoNegativo;
	xAbreDuctosResfriadorInf02: BOOL;
	xFechaDuctosResfriadorInf02: BOOL;
	xAbreResfridorInf02: BOOL;
	xFechaResfridorInf02: BOOL;
	xAjustarAlturaResfriadorInf02: BOOL;
	///Recebera uma valor fixo
	iVelocidadeHomeDuctosResfrInf02: INT;
	iVelocidadeJogDuctosResfrInf02: INT;
	iVelocidadeDuctosResfriadorInf02: INT;
	dValEncoAltura01ResfriadorInf02: DINT;
	dValEncoAltura02ResfriadorInf02: DINT;
	dValEncoAltura03ResfriadorInf02: DINT;
	dValEncoAlturaResfriadorInf02: DINT;
	dValEncoToleranciaResfrInf02: DINT;
	dValEncoAlturaVelMinimaResfrInf02: DINT := 35;
	xDifusorInf02Fechando: BOOL;
	xDifusorInf02Abrindo: BOOL;
	iCompValAltura01ResfriadorInf02: INT;
	iCompValAltura02ResfriadorInf02: INT;
	iCompValAltura03ResfriadorInf02: INT;
	iCompAlturaAtualDuctosResfriadorInf02: INT;
	iCompessaAlturaDuctosResfriadorInf02: INT;
	xPulsoChDutosInf02Po: BOOL;
	xPulsoChDutosInf02Ne: BOOL;
END_VAR
__IMPLEMENTATION__



iCompessaAlturaDuctosResfriadorInf02:=REAL_TO_INT(rOffSetResfInf02);
iCompValAltura01ResfriadorInf02:=	iValAltura01ResfriadorInf02 - iCompessaAlturaDuctosResfriadorInf02;
iCompValAltura02ResfriadorInf02:=	iValAltura02ResfriadorInf02 - iCompessaAlturaDuctosResfriadorInf02;
iCompValAltura03ResfriadorInf02:=	iValAltura03ResfriadorInf02 - iCompessaAlturaDuctosResfriadorInf02;


// CONVERSÃO MILIMETROS EM PULSOS	
ConversorMilimPul01ResfrInf02(
	dPulso:= 1853, 
	dMilimetro:= 115, 
	iEntrMilimetro01:= iCompValAltura01ResfriadorInf02, 
	iEntrMilimetro02:= iCompValAltura02ResfriadorInf02, 
	iEntrMilimetro03:= iCompValAltura03ResfriadorInf02, 
	dSaidaPulso01=> dValEncoAltura01ResfriadorInf02,
	dSaidaPulso02=> dValEncoAltura02ResfriadorInf02,
	dSaidaPulso03=> dValEncoAltura03ResfriadorInf02);
	
ConversorMilimPul02ResfrInf02(
	dPulso:= 1853, 
	dMilimetro:= 115, 
	iEntrMilimetro01:= 2,//iValEncoToleranciaDuctosInf02, 
	iEntrMilimetro02:= 10,//iValEncoAlturaVelMinimaDuctosInf02, 
	dSaidaPulso01=> dValEncoToleranciaResfrInf02, 
	dSaidaPulso02=> dValEncoAlturaVelMinimaResfrInf02);


// SEQUENCIA DE HOME

CASE PassoHomeDuctosResfrInf02 OF
	
		0:	IF xIniciaHomeDuctosInf02 OR xAutoHomeResfInf02 THEN
				PassoHomeDuctosResfrInf02:=2;		
			END_IF
			
		2: //F xFcLimMinLimpaResfriador02 AND NOT xFcLimMaxLimpaResfriador02 THEN
				PassoHomeDuctosResfrInf02:=5;
			//ELSE
			//	PassoHomeDuctosResfrInf02:=6;
			//END_IF
			
		5:	IF xChAbreDuctosResfriadorInf02 THEN
				PassoHomeDuctosResfrInf02:=6;
			ELSE
				PassoHomeDuctosResfrInf02:=10;
			END_IF
			
		6:	xIniciaHomeDuctosInf02:=FALSE;
			xAutoHomeResfInf02:=FALSE;
			PassoHomeDuctosResfrInf02:=0;
			
		10:	xIniciaHomeDuctosInf02:=FALSE;
			xHomeDuctosResfriadorInf02Ok:=FALSE;
			xAjusteAlturaDuctosInf02OK:=FALSE;
			xDuctosInf02EmHome:=TRUE;
			iVelocidadeDuctosResfriadorInf02:= 150;//1*iVelocidadeHomeDuctosResfrSup02;
			PassoHomeDuctosResfrInf02:=15;
			
		15: xFechaResfridorInf02:=TRUE;
			PassoHomeDuctosResfrInf02:=20;
			
		20:	IF xSensorFechadoResfriadorInf02 THEN
				PassoHomeDuctosResfrInf02:=50;
			END_IF
			IF xPause THEN
				PassoPausaHomeDuctosResfrInf02:=10;
				PassoHomeDuctosResfrInf02:=300;
			END_IF
			IF xAlarmeMotorDifusorInf02 THEN
				PassoAlmHomeDuctosResfrInf02:=10;
				PassoHomeDuctosResfrInf02:=400;
			END_IF

		50:	xFechaResfridorInf02:=FALSE;
			PassoHomeDuctosResfrInf02:=55;

		55:	iVelocidadeDuctosResfriadorInf02:= 50;
			PassoHomeDuctosResfrInf02:=56;
			
		56:	xAbreResfridorInf02:=TRUE;
			PassoHomeDuctosResfrInf02:=60;

		60:	IF NOT xSensorFechadoResfriadorInf02 THEN
				PassoHomeDuctosResfrInf02:=70;
			END_IF
			IF xPause THEN
				PassoPausaHomeDuctosResfrInf02:=50;
				PassoHomeDuctosResfrInf02:=300;
			END_IF
			IF xAlarmeMotorDifusorInf02 THEN
				PassoAlmHomeDuctosResfrInf02:=50;
				PassoHomeDuctosResfrInf02:=400;
			END_IF
			
		70:	xAbreResfridorInf02:=FALSE;
			PassoHomeDuctosResfrInf02:=74;
			
		74:	IF NOT xMotorDifusorInf02Ligado THEN
				PassoHomeDuctosResfrInf02:=75;
			END_IF
			
		75: xHomeEncoderDuctosResfriadorInf02:=TRUE;
			PassoHomeDuctosResfrInf02:=80;
		
		80: xHomeEncoderDuctosResfriadorInf02:=FALSE;
			xDuctosInf02EmHome:=FALSE;
			xHomeDuctosResfriadorInf02Ok:=TRUE;
			xAutoHomeResfInf02:=FALSE;
			PassoHomeDuctosResfrInf02:=0;
			
		// Emergência Pausa/Reinicio
		300:xFechaResfridorInf02:=FALSE;
			xAbreResfridorInf02:=FALSE;
			PassoHomeDuctosResfrInf02:=301;

		301:xDuctosInf02EmHome:=FALSE;
			PassoHomeDuctosResfrInf02:=302;
	
		302:IF xRestart THEN
				PassoHomeDuctosResfrInf02:=303;
			END_IF
			
		303:PassoHomeDuctosResfrInf02:=0;//PassoPausaHomeDuctosResfrInf01;
			
		// Alarme Motor Parada/Reinicio
		400:xFechaResfridorInf02:=FALSE;
			xAbreResfridorInf02:=FALSE;
			PassoHomeDuctosResfrInf02:=401;

		401:PassoHomeDuctosResfrInf02:=402;
	
		402:IF xRestart AND iCanOpenInverDuctResfrInf02StateOk THEN
				PassoHomeDuctosResfrInf02:=PassoAlmHomeDuctosResfrInf02;
			END_IF	
END_CASE

//
IF xTerceiroEstagioResfriador THEN
	dValEncoAlturaResfriadorInf02:=dValEncoAltura03ResfriadorInf02;
ELSIF xSegundoEstagioResfriador THEN
	dValEncoAlturaResfriadorInf02:=dValEncoAltura02ResfriadorInf02;
ELSE
	dValEncoAlturaResfriadorInf02:=dValEncoAltura01ResfriadorInf02;
END_IF

// SEQUENCIA DE FUNCIONAMENTO

IF (xBtRecAjustaAlturaDuctosInf02 OR BtParamDuctosResfriadorInf02 OR (xLigaSegEstagDuctosInf02 AND NOT xChAbreDuctosResfriadorInf02) OR (xLigaTerEstagDuctosInf02 AND NOT xChAbreDuctosResfriadorInf02) OR xReajustaAlturaDuctosInf02) AND xHomeDuctosResfriadorInf02Ok THEN
	xAjustarAlturaResfriadorInf02:=TRUE;
	xBtRecAjustaAlturaDuctosInf02:=FALSE;
	BtParamDuctosResfriadorInf02:=FALSE;
	xLigaSegEstagDuctosInf02:= FALSE;
	xLigaTerEstagDuctosInf02:= FALSE;
	xReajustaAlturaDuctosInf02:=FALSE;
ELSE
	xBtRecAjustaAlturaDuctosInf02:=FALSE;
	BtParamDuctosResfriadorInf02:=FALSE;
	xLigaSegEstagDuctosInf02:= FALSE;
	xLigaTerEstagDuctosInf02:= FALSE;
	xReajustaAlturaDuctosInf02:=FALSE;
END_IF

CASE PassoAjusteDuctosResfInf02 OF
		
		0:	IF xAjustarAlturaResfriadorInf02 AND NOT xAbreDuctosResfriadorInf02 THEN //AND NOT xChAbreDuctosResfriadorInf02 THEN
				PassoAjusteDuctosResfInf02:=10;
			END_IF
			
		10:	xAjustarAlturaResfriadorInf02:=FALSE;
			xAjusteAlturaDuctosInf02OK:=FALSE;
			xDuctosInf02EmAjuste:=TRUE;
			IF dValorEncoderDuctosResfriadorInf02<dValEncoAlturaResfriadorInf02-dValEncoToleranciaResfrInf02 THEN
				xDifusorInf02Abrindo:=TRUE;
				PassoAjusteDuctosResfInf02:=20;//Abre
			END_IF
			IF dValorEncoderDuctosResfriadorInf02>dValEncoAlturaResfriadorInf02+dValEncoToleranciaResfrInf02 THEN
				PassoAjusteDuctosResfInf02:=100;//Fecha
				xDifusorInf02Fechando:=TRUE;
			END_IF
			IF dValorEncoderDuctosResfriadorInf02>=dValEncoAlturaResfriadorInf02-dValEncoToleranciaResfrInf02 AND dValorEncoderDuctosResfriadorInf02<=dValEncoAlturaResfriadorInf02+dValEncoToleranciaResfrInf02 THEN
				PassoAjusteDuctosResfInf02:=180;//Não se Move
			END_IF
//Abre
		20:	iVelocidadeDuctosResfriadorInf02:= iVelocidadeAjusteDuctosResfriadorInf02;
			PassoAjusteDuctosResfInf02:=25;
			
		25:	xAbreResfridorInf02:=TRUE;
			PassoAjusteDuctosResfInf02:=30;

		30:	IF (dValorEncoderDuctosResfriadorInf02>=dValEncoAlturaResfriadorInf02-35(*dValEncoAlturaVelMinimaResfrInf02*)) OR xSensorAbertoResfriadorInf02 THEN
				PassoAjusteDuctosResfInf02:=40;
			END_IF
			IF iVelocidadeDuctosResfriadorInf02<> iVelocidadeAjusteDuctosResfriadorInf02 THEN
				PassoAjusteDuctosResfInf02:=20;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfInf02:=20;
				PassoAjusteDuctosResfInf02:=300;
			END_IF
			IF xAlarmeMotorDifusorInf02 THEN
				PassoAlmAjusteDuctosResfInf02:=20;
				PassoAjusteDuctosResfInf02:=400;
			END_IF

		40:	iVelocidadeDuctosResfriadorInf02:= iVelocidadeMinimaDuctosResfriadorInf02;
			PassoAjusteDuctosResfInf02:=50;
			
		50:	IF (dValorEncoderDuctosResfriadorInf02>=dValEncoAlturaResfriadorInf02) OR xSensorAbertoResfriadorInf02 THEN
				PassoAjusteDuctosResfInf02:=60;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfInf02:=40;
				PassoAjusteDuctosResfInf02:=300;
			END_IF
			IF xAlarmeMotorDifusorInf02 THEN
				PassoAlmAjusteDuctosResfInf02:=40;
				PassoAjusteDuctosResfInf02:=400;
			END_IF
			
		60: xAbreResfridorInf02:=FALSE;
			PassoAjusteDuctosResfInf02:=180;

//Desce
		100:iVelocidadeDuctosResfriadorInf02:= 1*iVelocidadeAjusteDuctosResfriadorInf02;
			PassoAjusteDuctosResfInf02:=105;
			
		105:xFechaResfridorInf02:=TRUE;
			PassoAjusteDuctosResfInf02:=110;
			
		110:IF (dValorEncoderDuctosResfriadorInf02 <= dValEncoAlturaResfriadorInf02+35(*dValEncoAlturaVelMinimaResfrInf02*)) OR xSensorFechadoResfriadorInf02 THEN
				PassoAjusteDuctosResfInf02:=120;
			END_IF
			IF iVelocidadeDuctosResfriadorInf02<> 1*iVelocidadeAjusteDuctosResfriadorInf02 THEN
				PassoAjusteDuctosResfInf02:=100;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfInf02:=100;
				PassoAjusteDuctosResfInf02:=300;
			END_IF
			IF xAlarmeMotorDifusorInf02 THEN
				PassoAlmAjusteDuctosResfInf02:=100;
				PassoAjusteDuctosResfInf02:=400;
			END_IF

		120:iVelocidadeDuctosResfriadorInf02:= 1*iVelocidadeMinimaDuctosResfriadorInf02;
			PassoAjusteDuctosResfInf02:=130;
			
		130:IF (dValorEncoderDuctosResfriadorInf02<=dValEncoAlturaResfriadorInf02) OR xSensorFechadoResfriadorInf02 THEN
				PassoAjusteDuctosResfInf02:=140;
			END_IF
			IF iVelocidadeDuctosResfriadorInf02<> 1*iVelocidadeMinimaDuctosResfriadorInf02 THEN
				PassoAjusteDuctosResfInf02:=120;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfInf02:=120;
				PassoAjusteDuctosResfInf02:=300;
			END_IF
			IF xAlarmeMotorDifusorInf02 THEN
				PassoAlmAjusteDuctosResfInf02:=120;
				PassoAjusteDuctosResfInf02:=400;
			END_IF
			
		140:xFechaResfridorInf02:=FALSE;
			PassoAjusteDuctosResfInf02:=180;
//Fim		
		180:xDifusorInf02Abrindo:=FALSE;
			xDifusorInf02Fechando:=FALSE;
			xDuctosInf02EmAjuste:=FALSE;
			xAjusteAlturaDuctosInf02OK:=TRUE;
			PassoAjusteDuctosResfInf02:=0;

		// Emergência Pausa/Reinicio
		300:xAbreResfridorInf02:=FALSE;
			xFechaResfridorInf02:=FALSE;
			PassoAjusteDuctosResfInf02:=301;

		301:PassoAjusteDuctosResfInf02:=302;
	
		302:IF xRestart THEN
				PassoAjusteDuctosResfInf02:=303;
			END_IF
			
		303:PassoAjusteDuctosResfInf02:=PassoPausaAjusteDuctosResfInf02;
			
		// Alarme Motor Parada/Reinicio
		400:xAbreResfridorInf02:=FALSE;
			xFechaResfridorInf02:=FALSE;
			PassoAjusteDuctosResfInf02:=401;

		401:PassoAjusteDuctosResfInf02:=402;
	
		402:IF xRestart AND iCanOpenInverDuctResfrInf02StateOk THEN
				PassoAjusteDuctosResfInf02:=PassoAlmAjusteDuctosResfInf02;
			END_IF	
			

END_CASE

// MOVIMENTO COM A CHAVE DE ABERTURA

PulsoChDutosInf02Po(Entrada:= xChAbreDuctosResfriadorInf02, SaidaPulsoPo=> xPulsoChDutosInf02Po);
PulsoChDutosInf02Ne(Entrada:= xChAbreDuctosResfriadorInf02, SaidaPulsoNe=> xPulsoChDutosInf02Ne);

(*IF xPulsoChDutosInf02Po THEN
	xPausaMesaResfrimento:=TRUE;
END_IF
IF xPulsoChDutosInf02Ne THEN
	xPausaMesaResfrimento:=FALSE;
END_IF*)

CASE PassoChaveDuctosResfrInf02 OF
			
		0:	IF xPulsoChDutosInf02Po AND xHomeDuctosResfriadorInf02Ok THEN //IF xChAbreDuctosResfriadorInf02 AND xHomeDuctosResfriadorInf02Ok THEN
				PassoChaveDuctosResfrInf02:=5;
				PassoAjusteDuctosResfInf02:=0;
				xFechaResfridorInf02:=FALSE;			
			END_IF
			
		5:	IF NOT xPrimeiroEstagioResfriador THEN
				PassoChaveDuctosResfrInf02:=10;
			END_IF
			
		10:	iVelocidadeJogDuctosResfrInf02:=iVelocidadeAjusteDuctosResfriadorInf02;
			xAjusteAlturaDuctosInf02OK:=FALSE;
			xAbreDuctosResfriadorInf02:=TRUE;
			IF xSensorAbertoResfriadorInf02 THEN
				PassoChaveDuctosResfrInf02:=20;
			END_IF
			IF xPause THEN
				PassoPausaChaveDuctosResfrInf02:=10;
				PassoChaveDuctosResfrInf02:=300;
			END_IF
			IF xAlarmeMotorDifusorInf02 THEN
				PassoAlmChaveDuctosResfrInf02:=10;
				PassoChaveDuctosResfrInf02:=400;
			END_IF

			
		20:	xAbreDuctosResfriadorInf02:=FALSE;
			PassoChaveDuctosResfrInf02:=21;
			
		21:	IF xPulsoChDutosInf02Ne THEN//IF NOT xChAbreDuctosResfriadorInf02 THEN
				xAbreDuctosResfriadorInf02:=FALSE;
				PassoChaveDuctosResfrInf02:=0;
				PassoAjusteDuctosResfInf02:=100;
			END_IF
			IF xPause THEN
				PassoPausaChaveDuctosResfrInf02:=21;
				PassoChaveDuctosResfrInf02:=300;
			END_IF
			IF xAlarmeMotorDifusorInf02 THEN
				PassoAlmChaveDuctosResfrInf02:=21;
				PassoChaveDuctosResfrInf02:=400;
			END_IF
			
		// Emergência Pausa/Reinicio
		300:xAbreDuctosResfriadorInf02:=FALSE;
			PassoChaveDuctosResfrInf02:=301;

		301:PassoChaveDuctosResfrInf02:=302;
	
		302:IF xRestart THEN
				PassoChaveDuctosResfrInf02:=303;
			END_IF
			
		303:PassoChaveDuctosResfrInf02:=PassoPausaChaveDuctosResfrInf02;
			
		// Alarme Motor Parada/Reinicio
		400:xAbreDuctosResfriadorInf02:=FALSE;
			PassoChaveDuctosResfrInf02:=401;

		401:PassoChaveDuctosResfrInf02:=402;
	
		402:IF xRestart AND iCanOpenInverDuctResfrInf02StateOk THEN
				PassoChaveDuctosResfrInf02:=PassoAlmChaveDuctosResfrInf02;
			END_IF	

		
	
END_CASE

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Dirreção
xMotorResfridorInf02Abre:= xAbreResfridorInf02 OR xAbreDuctosResfriadorInf02;
xMotorResfridorInf02Fecha:= xFechaResfridorInf02;

InversorResfInf02.i_xAvanco:=xMotorResfridorInf02Abre;
InversorResfInf02.i_xRecuo:=xMotorResfridorInf02Fecha;
// Velocidade
InversorResfInf02.i_iFreqRef:=iVelocidadeDuctosResfriadorInf02;
//---------------------------------------------------------------------------------\\

ConversorPulMilimResfrInf02(
	dPulso:= 1853, 
	dMilimetro:= 115, 
	dEntradaPulso01:= dValorEncoderDuctosResfriadorInf02,
	iSaidaMilimetro01=> iCompAlturaAtualDuctosResfriadorInf02 );
	
iAlturaAtualDuctosResfriadorInf02:=iCompAlturaAtualDuctosResfriadorInf02+iCompessaAlturaDuctosResfriadorInf02;
	
IF xOperacaoManual THEN
	PassoHomeDuctosResfrInf02:=0;
	PassoPausaHomeDuctosResfrInf02:=0;
	PassoAlmHomeDuctosResfrInf02:=0;
	PassoAjusteDuctosResfInf02:=0;
	PassoPausaAjusteDuctosResfInf02:=0;
	PassoAlmAjusteDuctosResfInf02:=0;
	PassoChaveDuctosResfrInf02:=0;
	PassoPausaChaveDuctosResfrInf02:=0;
	PassoAlmChaveDuctosResfrInf02:=0;
	xIniciaHomeDuctosInf02:=FALSE;
	xHomeEncoderDuctosResfriadorInf02:=FALSE;
	xAbreDuctosResfriadorInf02:=FALSE;
	xFechaDuctosResfriadorInf02:=FALSE;
	xDifusorInf02Abrindo:=FALSE;
	xDifusorInf02Fechando:=FALSE;
	xAjusteAlturaDuctosInf02OK:=FALSE;
	xFechaDuctosResfriadorInf02:=FALSE;
	xBtRecAjustaAlturaDuctosInf02:=FALSE;
	BtParamDuctosResfriadorInf02:=FALSE;
	xDuctosInf02EmHome:=FALSE;
	xDuctosInf02EmAjuste:=FALSE;
	xLigaSegEstagDuctosInf02:= FALSE;
	xLigaTerEstagDuctosInf02:= FALSE;
	xReajustaAlturaDuctosInf02:=FALSE;
	
	xFechaResfridorInf02:=FALSE;
	xAbreResfridorInf02:=FALSE;
	xLigaTerEstagDuctosInf02:=FALSE;	
END_IF
	
