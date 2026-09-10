__METADATA__
{
  "v3Meta": {
    "objectGuid": "5a88920b-fc16-4900-85f1-c66389de1c50",
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
PROGRAM J_DuctosResfriadorSup01
VAR
	PassoHomeDuctosResfrSup01: INT;
	PassoPausaHomeDuctosResfrSup01: INT;
	PassoAlmHomeDuctosResfrSup01: INT;
	PassoAjusteDuctosResfSup01: INT;
	PassoPausaAjusteDuctosResfSup01: INT;
	PassoAlmAjusteDuctosResfSup01: INT;
	PassoChaveDuctosResfrSup01: INT;
	PassoPausaChaveDuctosResfrSup01: INT;
	PassoAlmChaveDuctosResfrSup01: INT;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul01ResfrSup01: MmConversorPulso;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul02ResfrSup01: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilimResfrSup01: PulsoConversorMm;
	PulsoChDutosSup01Po: PulsoPositivo;
	PulsoChDutosSup01Ne: PulsoNegativo;
	xAbreDuctosResfriadorSup01: BOOL;
	xFechaDuctosResfriadorSup01: BOOL;
	xAbreResfridorSup01: BOOL;
	xFechaResfridorSup01: BOOL;
	xAjustarAlturaResfriadorSup01: BOOL;
	///Recebera uma valor fixo
	iVelocidadeHomeDuctosResfrSup01: INT;
	iVelocidadeJogDuctosResfrSup01: INT;
	iVelocidadeDuctosResfriadorSup01: INT;
	dValEncoAltura01ResfriadorSup01: DINT;
	dValEncoAltura02ResfriadorSup01: DINT;
	dValEncoAltura03ResfriadorSup01: DINT;
	dValEncoAlturaResfriadorSup01: DINT;
	dValEncoToleranciaResfrSup01: DINT;
	dValEncoAlturaVelMinimaResfrSup01: DINT := 35;
	xDifusorSup01Fechando: BOOL;
	xDifusorSup01Abrindo: BOOL;
	iCompValAltura01ResfriadorSup01: INT;
	iCompValAltura02ResfriadorSup01: INT;
	iCompValAltura03ResfriadorSup01: INT;
	iCompAlturaAtualDuctosResfriadorSup01: INT;
	iCompessaAlturaDuctosResfriadorSup01: INT;
	xPulsoChDutosSup01Po: BOOL;
	xPulsoChDutosSup01Ne: BOOL;
END_VAR
__IMPLEMENTATION__



iCompessaAlturaDuctosResfriadorSup01:=REAL_TO_INT(rOffSetResfSup01);
iCompValAltura01ResfriadorSup01:=	iValAltura01ResfriadorSup01 - iCompessaAlturaDuctosResfriadorSup01;
iCompValAltura02ResfriadorSup01:=	iValAltura02ResfriadorSup01 - iCompessaAlturaDuctosResfriadorSup01;
iCompValAltura03ResfriadorSup01:=	iValAltura03ResfriadorSup01 - iCompessaAlturaDuctosResfriadorSup01;


// CONVERSÃO MILIMETROS EM PULSOS	
ConversorMilimPul01ResfrSup01(
	dPulso:= 257614, 
	dMilimetro:= 33, 
	iEntrMilimetro01:= iCompValAltura01ResfriadorSup01, 
	iEntrMilimetro02:= iCompValAltura02ResfriadorSup01, 
	iEntrMilimetro03:= iCompValAltura03ResfriadorSup01, 
	dSaidaPulso01=> dValEncoAltura01ResfriadorSup01,
	dSaidaPulso02=> dValEncoAltura02ResfriadorSup01,
	dSaidaPulso03=> dValEncoAltura03ResfriadorSup01);
	
ConversorMilimPul02ResfrSup01(
	dPulso:= 257614, 
	dMilimetro:= 33, 
	iEntrMilimetro01:= 2,//iValEncoToleranciaDuctosSup01, 
	iEntrMilimetro02:= 8,//iValEncoAlturaVelMinimaDuctosSup01, 
	dSaidaPulso01=> dValEncoToleranciaResfrSup01, 
	dSaidaPulso02=> dValEncoAlturaVelMinimaResfrSup01);


// SEQUENCIA DE HOME

CASE PassoHomeDuctosResfrSup01 OF
	
		0:	IF xIniciaHomeDuctosSup01 THEN
				PassoHomeDuctosResfrSup01:=10;//5;		
			END_IF
			
		5:	IF xChAbreDuctosResfriadorSup01 THEN
				PassoHomeDuctosResfrSup01:=6;
			ELSE
				PassoHomeDuctosResfrSup01:=10;
			END_IF
			
		6:	xIniciaHomeDuctosSup01:=FALSE;
			PassoHomeDuctosResfrSup01:=0;
			
		10:	xIniciaHomeDuctosSup01:=FALSE;
			xHomeDuctosResfriadorSup01Ok:=FALSE;
			xAjusteAlturaDuctosSup01OK:=FALSE;
			xDuctosSup01EmHome:=TRUE;
			iVelocidadeDuctosResfriadorSup01:= 150;//1*iVelocidadeHomeDuctosResfr;
			PassoHomeDuctosResfrSup01:=15;
			
		15: xFechaResfridorSup01:=TRUE;
			PassoHomeDuctosResfrSup01:=20;

		20:	IF xSensorFechadoResfriadorSup01 THEN
				PassoHomeDuctosResfrSup01:=50;
			END_IF
			IF xPause THEN
				PassoPausaHomeDuctosResfrSup01:=10;
				PassoHomeDuctosResfrSup01:=300;
			END_IF
			IF xAlarmeMotorDifusorSup01 THEN
				PassoAlmHomeDuctosResfrSup01:=10;
				PassoHomeDuctosResfrSup01:=400;
			END_IF

		50:	xFechaResfridorSup01:=FALSE;
			PassoHomeDuctosResfrSup01:=55;
			
		55:	iVelocidadeDuctosResfriadorSup01:= 50;
			PassoHomeDuctosResfrSup01:=56;
			
		56:	xAbreResfridorSup01:=TRUE;
			PassoHomeDuctosResfrSup01:=60;
							
		60:	IF NOT xSensorFechadoResfriadorSup01 THEN
				PassoHomeDuctosResfrSup01:=70;
			END_IF
			IF xPause THEN
				PassoPausaHomeDuctosResfrSup01:=50;
				PassoHomeDuctosResfrSup01:=300;
			END_IF
			IF xAlarmeMotorDifusorSup01 THEN
				PassoAlmHomeDuctosResfrSup01:=50;
				PassoHomeDuctosResfrSup01:=400;
			END_IF
			
		70:	xAbreResfridorSup01:=FALSE;
			PassoHomeDuctosResfrSup01:=74;
			
		74:	IF NOT xMotorDifusorSup01Ligado THEN
				PassoHomeDuctosResfrSup01:=75;
			END_IF
			
		75: xHomeEncoderDuctosResfriadorSup01:=TRUE;
			PassoHomeDuctosResfrSup01:=80;
		
		80: xHomeEncoderDuctosResfriadorSup01:=FALSE;
			xDuctosSup01EmHome:=FALSE;
			xHomeDuctosResfriadorSup01Ok:=TRUE;
			
		// Emergência Pausa/Reinicio
		300:xFechaResfridorSup01:=FALSE;
			xAbreResfridorSup01:=FALSE;
			PassoHomeDuctosResfrSup01:=301;

		301:xDuctosSup01EmHome:=FALSE;
			PassoHomeDuctosResfrSup01:=302;
	
		302:IF xRestart THEN
				PassoHomeDuctosResfrSup01:=303;
			END_IF
			
		303:PassoHomeDuctosResfrSup01:=0;//PassoPausaHomeDuctosResfr;
			
		// Alarme Motor Parada/Reinicio
		400:xFechaResfridorSup01:=FALSE;
			xAbreResfridorSup01:=FALSE;
			PassoHomeDuctosResfrSup01:=401;

		401:PassoHomeDuctosResfrSup01:=402;
	
		402:IF xRestart AND iCanOpenInverDuctResfrSup01StateOk THEN
				PassoHomeDuctosResfrSup01:=PassoAlmHomeDuctosResfrSup01;
			END_IF	
END_CASE


//IF xTerceiroEstagioResfriador THEN
//	dValEncoAlturaResfriadorSup01:=dValEncoAltura03ResfriadorSup01;
//ELSIF xSegundoEstagioResfriador THEN
//	dValEncoAlturaResfriadorSup01:=dValEncoAltura02ResfriadorSup01;
//ELSE
	dValEncoAlturaResfriadorSup01:=dValEncoAltura01ResfriadorSup01;
//END_IF

// SEQUENCIA DE FUNCIONAMENTO

IF (xBtRecAjustaAlturaDuctosSup01 OR BtParamDuctosResfriadorSup01 OR xLigaSegEstagDuctosSup01 OR xLigaTerEstagDuctosSup01 OR xReajustaAlturaDuctosSup01) AND xHomeDuctosResfriadorSup01Ok THEN
	xAjustarAlturaResfriadorSup01:=TRUE;
	xBtRecAjustaAlturaDuctosSup01:=FALSE;
	BtParamDuctosResfriadorSup01:=FALSE;
	xLigaSegEstagDuctosSup01:= FALSE;
	xLigaTerEstagDuctosSup01:= FALSE;
	xReajustaAlturaDuctosSup01:=FALSE;
ELSE
	xBtRecAjustaAlturaDuctosSup01:=FALSE;
	BtParamDuctosResfriadorSup01:=FALSE;
	xLigaSegEstagDuctosSup01:= FALSE;
	xLigaTerEstagDuctosSup01:= FALSE;
	xReajustaAlturaDuctosSup01:=FALSE;
END_IF

CASE PassoAjusteDuctosResfSup01 OF
		
		0:	IF xAjustarAlturaResfriadorSup01 (*AND NOT xChAbreDuctosResfriadorSup01*) THEN
				PassoAjusteDuctosResfSup01:=10;
			END_IF
			
		10:	xAjustarAlturaResfriadorSup01:=FALSE;
			xAjusteAlturaDuctosSup01OK:=FALSE;
			xDuctosSup01EmAjuste:=TRUE;
			IF dValorEncoderDuctosResfriadorSup01<dValEncoAlturaResfriadorSup01-dValEncoToleranciaResfrSup01 THEN
				xDifusorSup01Abrindo:=TRUE;
				PassoAjusteDuctosResfSup01:=20;//Sobe
			END_IF
			IF dValorEncoderDuctosResfriadorSup01>dValEncoAlturaResfriadorSup01+dValEncoToleranciaResfrSup01 THEN
				PassoAjusteDuctosResfSup01:=100;//Desce
				xDifusorSup01Fechando:=TRUE;
			END_IF
			IF dValorEncoderDuctosResfriadorSup01>=dValEncoAlturaResfriadorSup01-dValEncoToleranciaResfrSup01 AND dValorEncoderDuctosResfriadorSup01<=dValEncoAlturaResfriadorSup01+dValEncoToleranciaResfrSup01 THEN
				PassoAjusteDuctosResfSup01:=180;//Não se Move
			END_IF
//Sobe
		20:	iVelocidadeDuctosResfriadorSup01:= iVelocidadeAjusteDuctosResfriadorSup01;
			PassoAjusteDuctosResfSup01:=25;
			
		25:	xAbreResfridorSup01:=TRUE;
			PassoAjusteDuctosResfSup01:=30;
			
		30:	IF (dValorEncoderDuctosResfriadorSup01>=dValEncoAlturaResfriadorSup01-35(*dValEncoAlturaVelMinimaResfrSup01*)) OR xSensorAbertoResfriadorSup01 THEN
				PassoAjusteDuctosResfSup01:=40;
			END_IF
			IF iVelocidadeDuctosResfriadorSup01<> iVelocidadeAjusteDuctosResfriadorSup01 THEN
				PassoAjusteDuctosResfSup01:=20;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfSup01:=20;
				PassoAjusteDuctosResfSup01:=300;
			END_IF
			IF xAlarmeMotorDifusorSup01 THEN
				PassoAlmAjusteDuctosResfSup01:=20;
				PassoAjusteDuctosResfSup01:=400;
			END_IF

		40:	iVelocidadeDuctosResfriadorSup01:= iVelocidadeMinimaDuctosResfriadorSup01;
			PassoAjusteDuctosResfSup01:=50;
			
		50:	IF (dValorEncoderDuctosResfriadorSup01>=dValEncoAlturaResfriadorSup01) OR xSensorAbertoResfriadorSup01 THEN
				PassoAjusteDuctosResfSup01:=60;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfSup01:=40;
				PassoAjusteDuctosResfSup01:=300;
			END_IF
			IF xAlarmeMotorDifusorSup01 THEN
				PassoAlmAjusteDuctosResfSup01:=40;
				PassoAjusteDuctosResfSup01:=400;
			END_IF
			
		60: xAbreResfridorSup01:=FALSE;
			PassoAjusteDuctosResfSup01:=180;

//Desce
		100:iVelocidadeDuctosResfriadorSup01:= 1*iVelocidadeAjusteDuctosResfriadorSup01;
			PassoAjusteDuctosResfSup01:=105;
			
		105:xFechaResfridorSup01:=TRUE;
			PassoAjusteDuctosResfSup01:=110;
	
		110:IF (dValorEncoderDuctosResfriadorSup01 <= dValEncoAlturaResfriadorSup01+35(*dValEncoAlturaVelMinimaResfrSup01*)) OR xSensorFechadoResfriadorSup01 THEN
				PassoAjusteDuctosResfSup01:=120;
			END_IF
			IF iVelocidadeDuctosResfriadorSup01<> 1*iVelocidadeAjusteDuctosResfriadorSup01 THEN
				PassoAjusteDuctosResfSup01:=100;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfSup01:=100;
				PassoAjusteDuctosResfSup01:=300;
			END_IF
			IF xAlarmeMotorDifusorSup01 THEN
				PassoAlmAjusteDuctosResfSup01:=100;
				PassoAjusteDuctosResfSup01:=400;
			END_IF

		120:iVelocidadeDuctosResfriadorSup01:= 1*iVelocidadeMinimaDuctosResfriadorSup01;
			PassoAjusteDuctosResfSup01:=130;
			
		130:IF (dValorEncoderDuctosResfriadorSup01<=dValEncoAlturaResfriadorSup01) OR xSensorFechadoResfriadorSup01 THEN
				PassoAjusteDuctosResfSup01:=140;
			END_IF
			IF iVelocidadeDuctosResfriadorSup01<> 1*iVelocidadeMinimaDuctosResfriadorSup01 THEN
				PassoAjusteDuctosResfSup01:=120;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfSup01:=120;
				PassoAjusteDuctosResfSup01:=300;
			END_IF
			IF xAlarmeMotorDifusorSup01 THEN
				PassoAlmAjusteDuctosResfSup01:=120;
				PassoAjusteDuctosResfSup01:=400;
			END_IF
			
		140:xFechaResfridorSup01:=FALSE;
			PassoAjusteDuctosResfSup01:=180;
//Fim		
		180:xDifusorSup01Abrindo:=FALSE;
			xDifusorSup01Fechando:=FALSE;
			xDuctosSup01EmAjuste:=FALSE;
			xAjusteAlturaDuctosSup01OK:=TRUE;
			PassoAjusteDuctosResfSup01:=0;

		// Emergência Pausa/Reinicio
		300:xAbreResfridorSup01:=FALSE;
			xFechaResfridorSup01:=FALSE;
			PassoAjusteDuctosResfSup01:=301;

		301:PassoAjusteDuctosResfSup01:=302;
	
		302:IF xRestart THEN
				PassoAjusteDuctosResfSup01:=303;
			END_IF
			
		303:PassoAjusteDuctosResfSup01:=PassoPausaAjusteDuctosResfSup01;
			
		// Alarme Motor Parada/Reinicio
		400:xAbreResfridorSup01:=FALSE;
			xFechaResfridorSup01:=FALSE;
			PassoAjusteDuctosResfSup01:=401;

		401:PassoAjusteDuctosResfSup01:=402;
	
		402:IF xRestart AND iCanOpenInverDuctResfrSup01StateOk THEN
				PassoAjusteDuctosResfSup01:=PassoAlmAjusteDuctosResfSup01;
			END_IF	
			

END_CASE

// MOVIMENTO COM A CHAVE DE ABERTURA

(*PulsoChDutosSup01Po(Entrada:= xChAbreDuctosResfriadorSup01, SaidaPulsoPo=> xPulsoChDutosSup01Po);
PulsoChDutosSup01Ne(Entrada:= xChAbreDuctosResfriadorSup01, SaidaPulsoNe=> xPulsoChDutosSup01Ne);

IF xPulsoChDutosSup01Po THEN
	xPausaMesaResfrimento:=TRUE;
END_IF
IF xPulsoChDutosSup01Ne THEN
	xPausaMesaResfrimento:=FALSE;
END_IF

CASE PassoChaveDuctosResfrSup01 OF
			
		0:	IF xChAbreDuctosResfriadorSup01 AND xHomeDuctosResfriadorSup01Ok THEN
				PassoChaveDuctosResfrSup01:=10;
				PassoAjusteDuctosResfSup01:=0;
				xFechaResfridorSup01:=FALSE;
				END_IF
			
		5:	IF NOT xPrimeiroEstagioResfriador THEN
				PassoChaveDuctosResfrSup01:=10;
			END_IF
			
		10:	iVelocidadeJogDuctosResfrSup01:=iVelocidadeAjusteDuctosResfriadorSup01;
			xAjusteAlturaDuctosSup01OK:=FALSE;
			xAbreDuctosResfriadorSup01:=TRUE;
			IF xSensorAbertoResfriadorSup01 THEN
				PassoChaveDuctosResfrSup01:=20;
			END_IF
			IF xPause THEN
				PassoPausaChaveDuctosResfrSup01:=10;
				PassoChaveDuctosResfrSup01:=300;
			END_IF
			IF xAlarmeMotorDifusorSup01 THEN
				PassoAlmChaveDuctosResfrSup01:=10;
				PassoChaveDuctosResfrSup01:=400;
			END_IF

		20:	xAbreDuctosResfriadorSup01:=FALSE;
			PassoChaveDuctosResfrSup01:=21;
			
		21:	IF xPulsoChDutosSup01Ne THEN//IF NOT xChAbreDuctosResfriadorSup02 THEN
				xAbreDuctosResfriadorSup01:=FALSE;
				PassoChaveDuctosResfrSup01:=0;
				PassoAjusteDuctosResfSup01:=100;
			END_IF
			IF xPause THEN
				PassoPausaChaveDuctosResfrSup01:=21;
				PassoChaveDuctosResfrSup01:=300;
			END_IF
			IF xAlarmeMotorDifusorSup01 THEN
				PassoAlmChaveDuctosResfrSup01:=21;
				PassoChaveDuctosResfrSup01:=400;
			END_IF
			
		// Emergência Pausa/Reinicio
		300:xAbreDuctosResfriadorSup01:=FALSE;
			PassoChaveDuctosResfrSup01:=301;

		301:PassoChaveDuctosResfrSup01:=302;
	
		302:IF xRestart THEN
				PassoChaveDuctosResfrSup01:=303;
			END_IF
			
		303:PassoChaveDuctosResfrSup01:=PassoPausaChaveDuctosResfrSup01;
			
		// Alarme Motor Parada/Reinicio
		400:xAbreDuctosResfriadorSup01:=FALSE;
			PassoChaveDuctosResfrSup01:=401;

		401:PassoChaveDuctosResfrSup01:=402;
	
		402:IF xRestart AND iCanOpenInverDuctResfrSup01StateOk THEN
				PassoChaveDuctosResfrSup01:=PassoAlmChaveDuctosResfrSup01;
			END_IF	
	
END_CASE
*)
// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorResfridorSup01Abre:= xAbreResfridorSup01 OR xAbreDuctosResfriadorSup01;
xMotorResfridorSup01Fecha:= xFechaResfridorSup01;

InversorResfSup01.i_xAvanco:=xMotorResfridorSup01Abre;
InversorResfSup01.i_xRecuo:=xMotorResfridorSup01Fecha;
// Velocidade
InversorResfSup01.i_iFreqRef:=iVelocidadeDuctosResfriadorSup01;
//---------------------------------------------------------------------------------\\

ConversorPulMilimResfrSup01(
	dPulso:= 257614, 
	dMilimetro:= 33, 
	dEntradaPulso01:= dValorEncoderDuctosResfriadorSup01,
	iSaidaMilimetro01=> iCompAlturaAtualDuctosResfriadorSup01 );
	
iAlturaAtualDuctosResfriadorSup01:=iCompAlturaAtualDuctosResfriadorSup01+iCompessaAlturaDuctosResfriadorSup01;
	
IF xOperacaoManual THEN
	PassoHomeDuctosResfrSup01:=0;
	PassoPausaHomeDuctosResfrSup01:=0;
	PassoAlmHomeDuctosResfrSup01:=0;
	PassoAjusteDuctosResfSup01:=0;
	PassoPausaAjusteDuctosResfSup01:=0;
	PassoAlmAjusteDuctosResfSup01:=0;
	PassoChaveDuctosResfrSup01:=0;
	PassoPausaChaveDuctosResfrSup01:=0;
	PassoAlmChaveDuctosResfrSup01:=0;
	xIniciaHomeDuctosSup01:=FALSE;
	xHomeEncoderDuctosResfriadorSup01:=FALSE;
	xAbreDuctosResfriadorSup01:=FALSE;
	xFechaDuctosResfriadorSup01:=FALSE;
	xDifusorSup01Abrindo:=FALSE;
	xDifusorSup01Fechando:=FALSE;
	xAjusteAlturaDuctosSup01OK:=FALSE;
	xFechaDuctosResfriadorSup01:=FALSE;
	xBtRecAjustaAlturaDuctosSup01:=FALSE;
	BtParamDuctosResfriadorSup01:=FALSE;
	xDuctosSup01EmHome:=FALSE;
	xDuctosSup01EmAjuste:=FALSE;
	xLigaSegEstagDuctosSup01:= FALSE;
	xLigaTerEstagDuctosSup01:= FALSE;
	xReajustaAlturaDuctosSup01:=FALSE;
	xFechaResfridorSup01:=FALSE;
	xAbreResfridorSup01:=FALSE;
	xFechaResfridorSup01:=FALSE;
	xAbreResfridorSup01:=FALSE;
	xLigaTerEstagDuctosSup01:=FALSE;	
END_IF
	
