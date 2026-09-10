__METADATA__
{
  "v3Meta": {
    "objectGuid": "deb9efa4-b67a-4e5e-96b9-4bb0f779fb56",
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
PROGRAM J_DuctosResfriadorInf01
VAR
	PassoHomeDuctosResfrInf01: INT;
	PassoPausaHomeDuctosResfrInf01: INT;
	PassoAlmHomeDuctosResfrInf01: INT;
	PassoAjusteDuctosResfInf01: INT;
	PassoPausaAjusteDuctosResfInf01: INT;
	PassoAlmAjusteDuctosResfInf01: INT;
	PassoChaveDuctosResfrInf01: INT;
	PassoPausaChaveDuctosResfrInf01: INT;
	PassoAlmChaveDuctosResfrInf01: INT;
	/// Bloco Movimenta Ductos do Resfriador
	McMoveVelocityDuctosInf01: GIPLC.MC_MoveVelocity;
	/// Bloco Desliga Motor Ductos do Resfriador
	McStopDuctosResfriadorInf01: GIPLC.MC_Stop;
	/// Bloco Jog Motor Ductos do Resfriador
	McJogDuctosResfriadorInf01: GIPLC.MC_Jog;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul01ResfrInf01: MmConversorPulso;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul02ResfrInf01: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilimResfrInf01: PulsoConversorMm;
	xExecutaMovDuctosResfriadorInf01: BOOL;
	xExecutaStopDuctosResfriadorInf01: BOOL;
	xStopMesaDuctosResfriadorInf01Done: BOOL;
	xAbreDuctosResfriadorInf01: BOOL;
	xFechaDuctosResfriadorInf01: BOOL;
	xAjustarAlturaResfriadorInf01: BOOL;
	///Recebera uma valor fixo
	iVelocidadeHomeDuctosResfrInf01: INT;
	iVelocidadeJogDuctosResfrInf01: INT;
	iVelocidadeDuctosResfriadorInf01: INT;
	dValEncoAltura01ResfriadorInf01: DINT;
	dValEncoAltura02ResfriadorInf01: DINT;
	dValEncoAltura03ResfriadorInf01: DINT;
	dValEncoAlturaResfriadorInf01: DINT;
	dValEncoToleranciaResfrInf01: DINT;
	dValEncoAlturaVelMinimaResfrInf01: DINT := 35;
	xDifusorInf01Fechando: BOOL;
	xDifusorInf01Abrindo: BOOL;
	iCompValAltura01ResfriadorInf01: INT;
	iCompValAltura02ResfriadorInf01: INT;
	iCompValAltura03ResfriadorInf01: INT;
	iCompAlturaAtualDuctosResfriadorInf01: INT;
	iCompessaAlturaDuctosResfriadorInf01: INT;
END_VAR
__IMPLEMENTATION__



iCompessaAlturaDuctosResfriadorInf01:=REAL_TO_INT(rOffSetResfInf01);
iCompValAltura01ResfriadorInf01:=	iValAltura01ResfriadorInf01 - iCompessaAlturaDuctosResfriadorInf01;
iCompValAltura02ResfriadorInf01:=	iValAltura02ResfriadorInf01 - iCompessaAlturaDuctosResfriadorInf01;
iCompValAltura03ResfriadorInf01:=	iValAltura03ResfriadorInf01 - iCompessaAlturaDuctosResfriadorInf01;


// CONVERSÃO MILIMETROS EM PULSOS	
ConversorMilimPul01ResfrInf01(
	dPulso:= 1261, 
	dMilimetro:= 133, 
	iEntrMilimetro01:= iCompValAltura01ResfriadorInf01, 
	iEntrMilimetro02:= iCompValAltura02ResfriadorInf01, 
	iEntrMilimetro03:= iCompValAltura03ResfriadorInf01, 
	dSaidaPulso01=> dValEncoAltura01ResfriadorInf01,
	dSaidaPulso02=> dValEncoAltura02ResfriadorInf01,
	dSaidaPulso03=> dValEncoAltura03ResfriadorInf01);
	
ConversorMilimPul02ResfrInf01(
	dPulso:= 1261, 
	dMilimetro:= 133, 
	iEntrMilimetro01:= 2,//iValEncoToleranciaDuctosInf01, 
	iEntrMilimetro02:= 8,//iValEncoAlturaVelMinimaDuctosInf01, 
	dSaidaPulso01=> dValEncoToleranciaResfrInf01, 
	dSaidaPulso02=> dValEncoAlturaVelMinimaResfrInf01);


// SEQUENCIA DE HOME

CASE PassoHomeDuctosResfrInf01 OF
	
		0:	IF xIniciaHomeDuctosInf01 THEN
				PassoHomeDuctosResfrInf01:=5;		
			END_IF
			
		5:	IF xChAbreDuctosResfriadorInf01 THEN
				PassoHomeDuctosResfrInf01:=6;
			ELSE
				PassoHomeDuctosResfrInf01:=10;
			END_IF
			
		6:	xIniciaHomeDuctosInf01:=FALSE;
			PassoHomeDuctosResfrInf01:=0;
			
		10:	xIniciaHomeDuctosInf01:=FALSE;
			xHomeDuctosResfriadorInf01Ok:=FALSE;
			xAjusteAlturaDuctosInf01OK:=FALSE;
			xDuctosInf01EmHome:=TRUE;
			iVelocidadeDuctosResfriadorInf01:= -150;//1*iVelocidadeHomeDuctosResfrInf01;
			xExecutaMovDuctosResfriadorInf01:=TRUE;
			IF McMoveVelocityDuctosInf01.Busy THEN
				PassoHomeDuctosResfrInf01:=20;
			END_IF
			
		20:	xExecutaMovDuctosResfriadorInf01:=FALSE;
			IF xSensorFechadoResfriadorInf01 THEN
				PassoHomeDuctosResfrInf01:=50;
			END_IF
			IF xPause THEN
				PassoPausaHomeDuctosResfrInf01:=10;
				PassoHomeDuctosResfrInf01:=300;
			END_IF
			IF xAlarmeMotorDifusorInf01 THEN
				PassoAlmHomeDuctosResfrInf01:=10;
				PassoHomeDuctosResfrInf01:=400;
			END_IF

	
		(*30: xExecutaStopDuctosResfriadorInf01:=TRUE;
			IF	xStopMesaDuctosResfriadorInf01Done THEN
				PassoHomeDuctosResfrInf01:=40;
			END_IF	
		
		40: xExecutaStopDuctosResfriadorInf01:=FALSE;
			PassoHomeDuctosResfrInf01:=50;*)
			
		50:	iVelocidadeDuctosResfriadorInf01:= 50;
			xExecutaMovDuctosResfriadorInf01:=TRUE;
			IF McMoveVelocityDuctosInf01.Busy THEN
				PassoHomeDuctosResfrInf01:=60;
			END_IF
			
		60:	xExecutaMovDuctosResfriadorInf01:=FALSE;
			IF NOT xSensorFechadoResfriadorInf01 THEN
				PassoHomeDuctosResfrInf01:=70;
			END_IF
			IF xPause THEN
				PassoPausaHomeDuctosResfrInf01:=50;
				PassoHomeDuctosResfrInf01:=300;
			END_IF
			IF xAlarmeMotorDifusorInf01 THEN
				PassoAlmHomeDuctosResfrInf01:=50;
				PassoHomeDuctosResfrInf01:=400;
			END_IF
			
		70:	xExecutaStopDuctosResfriadorInf01:=TRUE;
			IF	xStopMesaDuctosResfriadorInf01Done THEN
				xHomeEncoderDuctosResfriadorInf01:=TRUE;
				PassoHomeDuctosResfrInf01:=80;
			END_IF	
		
		80: xHomeEncoderDuctosResfriadorInf01:=FALSE;
			xExecutaStopDuctosResfriadorInf01:=FALSE;
			xDuctosInf01EmHome:=FALSE;
			xHomeDuctosResfriadorInf01Ok:=TRUE;
			
		// Emergência Pausa/Reinicio
		300:xExecutaStopDuctosResfriadorInf01:=TRUE;
			PassoHomeDuctosResfrInf01:=301;

		301:xExecutaStopDuctosResfriadorInf01:=FALSE;
			xExecutaMovDuctosResfriadorInf01:=FALSE;
			xDuctosInf01EmHome:=FALSE;
			PassoHomeDuctosResfrInf01:=302;
	
		302:IF xRestart THEN
				PassoHomeDuctosResfrInf01:=303;
			END_IF
			
		303:IF xInvDuctosInf01Habilitado THEN
				PassoHomeDuctosResfrInf01:=0;//PassoPausaHomeDuctosResfrInf01;
			END_IF
			
		// Alarme Motor Parada/Reinicio
		400:xExecutaStopDuctosResfriadorInf01:=TRUE;
			PassoHomeDuctosResfrInf01:=401;

		401:xExecutaStopDuctosResfriadorInf01:=FALSE;
			xExecutaMovDuctosResfriadorInf01:=FALSE;
			PassoHomeDuctosResfrInf01:=402;
	
		402:IF xRestart AND xInvDuctosInf01Habilitado THEN
				PassoHomeDuctosResfrInf01:=PassoAlmHomeDuctosResfrInf01;
			END_IF	
END_CASE

//
//IF xTerceiroEstagioResfriador THEN
//	dValEncoAlturaResfriadorInf01:=dValEncoAltura03ResfriadorInf01;
//ELSIF xSegundoEstagioResfriador THEN
//	dValEncoAlturaResfriadorInf01:=dValEncoAltura02ResfriadorInf01;
//ELSE
	dValEncoAlturaResfriadorInf01:=dValEncoAltura01ResfriadorInf01;
//END_IF

// SEQUENCIA DE FUNCIONAMENTO

IF (xBtRecAjustaAlturaDuctosInf01 OR BtParamDuctosResfriadorInf01 OR xLigaSegEstagDuctosInf01 OR xLigaTerEstagDuctosInf01 OR xReajustaAlturaDuctosInf01) AND xHomeDuctosResfriadorInf01Ok THEN
	xAjustarAlturaResfriadorInf01:=TRUE;
	xBtRecAjustaAlturaDuctosInf01:=FALSE;
	BtParamDuctosResfriadorInf01:=FALSE;
	xLigaSegEstagDuctosInf01:= FALSE;
	xLigaTerEstagDuctosInf01:= FALSE;
	xReajustaAlturaDuctosInf01:=FALSE;
ELSE
	xBtRecAjustaAlturaDuctosInf01:=FALSE;
	BtParamDuctosResfriadorInf01:=FALSE;
	xLigaSegEstagDuctosInf01:= FALSE;
	xLigaTerEstagDuctosInf01:= FALSE;
	xReajustaAlturaDuctosInf01:=FALSE;
END_IF

CASE PassoAjusteDuctosResfInf01 OF
		
		0:	IF xAjustarAlturaResfriadorInf01 AND NOT xChAbreDuctosResfriadorInf01 THEN
				PassoAjusteDuctosResfInf01:=10;
			END_IF
			
		10:	xAjustarAlturaResfriadorInf01:=FALSE;
			xAjusteAlturaDuctosInf01OK:=FALSE;
			xDuctosInf01EmAjuste:=TRUE;
			IF dValorEncoderDuctosResfriadorInf01<dValEncoAlturaResfriadorInf01-dValEncoToleranciaResfrInf01 THEN
				xDifusorInf01Abrindo:=TRUE;
				PassoAjusteDuctosResfInf01:=20;//Sobe
			END_IF
			IF dValorEncoderDuctosResfriadorInf01>dValEncoAlturaResfriadorInf01+dValEncoToleranciaResfrInf01 THEN
				PassoAjusteDuctosResfInf01:=100;//Desce
				xDifusorInf01Fechando:=TRUE;
			END_IF
			IF dValorEncoderDuctosResfriadorInf01>=dValEncoAlturaResfriadorInf01-dValEncoToleranciaResfrInf01 AND dValorEncoderDuctosResfriadorInf01<=dValEncoAlturaResfriadorInf01+dValEncoToleranciaResfrInf01 THEN
				PassoAjusteDuctosResfInf01:=180;//Não se Move
			END_IF
//Sobe
		20:	iVelocidadeDuctosResfriadorInf01:= iVelocidadeAjusteDuctosResfriadorInf01;
			xExecutaMovDuctosResfriadorInf01:=TRUE;
			IF McMoveVelocityDuctosInf01.Busy THEN
				PassoAjusteDuctosResfInf01:=30;
			END_IF
			
		30:	xExecutaMovDuctosResfriadorInf01:=FALSE;
			IF dValorEncoderDuctosResfriadorInf01>=dValEncoAlturaResfriadorInf01-35(*dValEncoAlturaVelMinimaResfrInf01*) THEN
				PassoAjusteDuctosResfInf01:=40;
			END_IF
			IF iVelocidadeDuctosResfriadorInf01<> iVelocidadeAjusteDuctosResfriadorInf01 THEN
				PassoAjusteDuctosResfInf01:=20;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfInf01:=20;
				PassoAjusteDuctosResfInf01:=300;
			END_IF
			IF xAlarmeMotorDifusorInf01 THEN
				PassoAlmAjusteDuctosResfInf01:=20;
				PassoAjusteDuctosResfInf01:=400;
			END_IF


		40:	iVelocidadeDuctosResfriadorInf01:= iVelocidadeMinimaDuctosResfriadorInf01;
			xExecutaMovDuctosResfriadorInf01:=TRUE;
			IF McMoveVelocityDuctosInf01.Busy THEN
				PassoAjusteDuctosResfInf01:=50;
			END_IF
			
		50:	xExecutaMovDuctosResfriadorInf01:=FALSE;
			IF (dValorEncoderDuctosResfriadorInf01>=dValEncoAlturaResfriadorInf01) OR xSensorAbertoResfriadorInf01 THEN
				PassoAjusteDuctosResfInf01:=60;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfInf01:=40;
				PassoAjusteDuctosResfInf01:=300;
			END_IF
			IF xAlarmeMotorDifusorInf01 THEN
				PassoAlmAjusteDuctosResfInf01:=40;
				PassoAjusteDuctosResfInf01:=400;
			END_IF
			
		60: xExecutaStopDuctosResfriadorInf01:=TRUE;
			IF	xStopMesaDuctosResfriadorInf01Done THEN
				PassoAjusteDuctosResfInf01:=180;
			END_IF	
//Desce
		100:iVelocidadeDuctosResfriadorInf01:= -1*iVelocidadeAjusteDuctosResfriadorInf01;
			xExecutaMovDuctosResfriadorInf01:=TRUE;
			IF McMoveVelocityDuctosInf01.Busy THEN
				PassoAjusteDuctosResfInf01:=110;
			END_IF
			
		110:xExecutaMovDuctosResfriadorInf01:=FALSE;
			IF dValorEncoderDuctosResfriadorInf01 <= dValEncoAlturaResfriadorInf01+35(*dValEncoAlturaVelMinimaResfrInf01*) THEN
				PassoAjusteDuctosResfInf01:=120;
			END_IF
			IF iVelocidadeDuctosResfriadorInf01<> -1*iVelocidadeAjusteDuctosResfriadorInf01 THEN
				PassoAjusteDuctosResfInf01:=100;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfInf01:=100;
				PassoAjusteDuctosResfInf01:=300;
			END_IF
			IF xAlarmeMotorDifusorInf01 THEN
				PassoAlmAjusteDuctosResfInf01:=100;
				PassoAjusteDuctosResfInf01:=400;
			END_IF

		120:iVelocidadeDuctosResfriadorInf01:= -1*iVelocidadeMinimaDuctosResfriadorInf01;
			xExecutaMovDuctosResfriadorInf01:=TRUE;
			IF McMoveVelocityDuctosInf01.Busy THEN
				PassoAjusteDuctosResfInf01:=130;
			END_IF
			
		130:xExecutaMovDuctosResfriadorInf01:=FALSE;
			IF dValorEncoderDuctosResfriadorInf01<=dValEncoAlturaResfriadorInf01 THEN
				PassoAjusteDuctosResfInf01:=140;
			END_IF
			IF xPause THEN
				PassoPausaAjusteDuctosResfInf01:=120;
				PassoAjusteDuctosResfInf01:=300;
			END_IF
			IF xAlarmeMotorDifusorInf01 THEN
				PassoAlmAjusteDuctosResfInf01:=120;
				PassoAjusteDuctosResfInf01:=400;
			END_IF
			
		140:xExecutaStopDuctosResfriadorInf01:=TRUE;
			IF	xStopMesaDuctosResfriadorInf01Done THEN
				PassoAjusteDuctosResfInf01:=180;
			END_IF	
//Fim		
		180:xDifusorInf01Abrindo:=FALSE;
			xDifusorInf01Fechando:=FALSE;
			xExecutaStopDuctosResfriadorInf01:=FALSE;
			xDuctosInf01EmAjuste:=FALSE;
			xAjusteAlturaDuctosInf01OK:=TRUE;
			PassoAjusteDuctosResfInf01:=0;

		// Emergência Pausa/Reinicio
		300:xExecutaStopDuctosResfriadorInf01:=TRUE;
			PassoAjusteDuctosResfInf01:=301;

		301:xExecutaStopDuctosResfriadorInf01:=FALSE;
			xExecutaMovDuctosResfriadorInf01:=FALSE;
			PassoAjusteDuctosResfInf01:=302;
	
		302:IF xRestart THEN
				PassoAjusteDuctosResfInf01:=303;
			END_IF
			
		303:IF xInvDuctosInf01Habilitado THEN
				PassoAjusteDuctosResfInf01:=PassoPausaAjusteDuctosResfInf01;
			END_IF
			
		// Alarme Motor Parada/Reinicio
		400:xExecutaStopDuctosResfriadorInf01:=TRUE;
			PassoAjusteDuctosResfInf01:=401;

		401:xExecutaStopDuctosResfriadorInf01:=FALSE;
			xExecutaMovDuctosResfriadorInf01:=FALSE;
			PassoAjusteDuctosResfInf01:=402;
	
		402:IF xRestart AND xInvDuctosInf01Habilitado THEN
				PassoAjusteDuctosResfInf01:=PassoAlmAjusteDuctosResfInf01;
			END_IF	
			

END_CASE

// MOVIMENTO COM A CHAVE DE ABERTURA

CASE PassoChaveDuctosResfrInf01 OF
			
		0:	IF xChAbreDuctosResfriadorInf01 AND xHomeDuctosResfriadorInf01Ok THEN
				PassoChaveDuctosResfrInf01:=10;
				PassoAjusteDuctosResfInf01:=0;
			END_IF
			
		10:	iVelocidadeJogDuctosResfrInf01:=iVelocidadeAjusteDuctosResfriadorInf01;
			xAjusteAlturaDuctosInf01OK:=FALSE;
			xAbreDuctosResfriadorInf01:=xChAbreDuctosResfriadorInf01;
			IF xSensorAbertoResfriadorInf01 THEN
				PassoChaveDuctosResfrInf01:=20;
			END_IF
			IF xPause THEN
				PassoPausaChaveDuctosResfrInf01:=10;
				PassoChaveDuctosResfrInf01:=300;
			END_IF
			IF xAlarmeMotorDifusorInf01 THEN
				PassoAlmChaveDuctosResfrInf01:=10;
				PassoChaveDuctosResfrInf01:=400;
			END_IF

			
		20:	xAbreDuctosResfriadorInf01:=FALSE;
			PassoChaveDuctosResfrInf01:=21;
			
		21:	IF NOT xChAbreDuctosResfriadorInf01 THEN
				PassoChaveDuctosResfrInf01:=0;
				PassoAjusteDuctosResfInf01:=100;
			END_IF
			IF xPause THEN
				PassoPausaChaveDuctosResfrInf01:=21;
				PassoChaveDuctosResfrInf01:=300;
			END_IF
			IF xAlarmeMotorDifusorInf01 THEN
				PassoAlmChaveDuctosResfrInf01:=21;
				PassoChaveDuctosResfrInf01:=400;
			END_IF
			
		// Emergência Pausa/Reinicio
		300:xExecutaStopDuctosResfriadorInf01:=TRUE;
			PassoChaveDuctosResfrInf01:=301;

		301:xExecutaStopDuctosResfriadorInf01:=FALSE;
			xExecutaMovDuctosResfriadorInf01:=FALSE;
			PassoChaveDuctosResfrInf01:=302;
	
		302:IF xRestart THEN
				PassoChaveDuctosResfrInf01:=303;
			END_IF
			
		303:IF xInvDuctosInf01Habilitado THEN
				PassoChaveDuctosResfrInf01:=PassoPausaChaveDuctosResfrInf01;
			END_IF
			
		// Alarme Motor Parada/Reinicio
		400:xExecutaStopDuctosResfriadorInf01:=TRUE;
			PassoChaveDuctosResfrInf01:=401;

		401:xExecutaStopDuctosResfriadorInf01:=FALSE;
			xExecutaMovDuctosResfriadorInf01:=FALSE;
			PassoChaveDuctosResfrInf01:=402;
	
		402:IF xRestart AND xInvDuctosInf01Habilitado THEN
				PassoChaveDuctosResfrInf01:=PassoAlmChaveDuctosResfrInf01;
			END_IF	

		
	
END_CASE

// BLOCOS DE EXECUÇÃO CANOPEN
//McMoveVelocityDuctosInf01(Execute:= xExecutaMovDuctosResfriadorInf01,	Velocity:=iVelocidadeDuctosResfriadorInf01,	Axis:= Resfriador_Inf01,	InVelocity=> ,	Busy=> ,CommandAborted=> , Error=> );
//McJogDuctosResfriadorInf01(Forward:= xAbreDuctosResfriadorInf01,	Backward:= xFechaDuctosResfriadorInf01, Velocity:= iVelocidadeJogDuctosResfrInf01, Axis:= Resfriador_Inf01, Done=> ,Busy=> ,CommandAborted=> ,Error=> );
//McStopDuctosResfriadorInf01(Execute:=xExecutaStopDuctosResfriadorInf01,	Axis:= Resfriador_Inf01, Done=> xStopMesaDuctosResfriadorInf01Done,Busy=> , Error=> );


ConversorPulMilimResfrInf01(
	dPulso:= 1261, 
	dMilimetro:= 133, 
	dEntradaPulso01:= dValorEncoderDuctosResfriadorInf01,
	iSaidaMilimetro01=> iCompAlturaAtualDuctosResfriadorInf01 );
	
iAlturaAtualDuctosResfriadorInf01:=iCompAlturaAtualDuctosResfriadorInf01+iCompessaAlturaDuctosResfriadorInf01;
	
IF xOperacaoManual THEN
	PassoHomeDuctosResfrInf01:=0;
	PassoPausaHomeDuctosResfrInf01:=0;
	PassoAlmHomeDuctosResfrInf01:=0;
	PassoAjusteDuctosResfInf01:=0;
	PassoPausaAjusteDuctosResfInf01:=0;
	PassoAlmAjusteDuctosResfInf01:=0;
	PassoChaveDuctosResfrInf01:=0;
	PassoPausaChaveDuctosResfrInf01:=0;
	PassoAlmChaveDuctosResfrInf01:=0;
	xIniciaHomeDuctosInf01:=FALSE;
	xExecutaMovDuctosResfriadorInf01:=FALSE;
	xHomeEncoderDuctosResfriadorInf01:=FALSE;
	xExecutaStopDuctosResfriadorInf01:=FALSE;
	xAbreDuctosResfriadorInf01:=FALSE;
	xFechaDuctosResfriadorInf01:=FALSE;
	xDifusorInf01Abrindo:=FALSE;
	xDifusorInf01Fechando:=FALSE;
	xAjusteAlturaDuctosInf01OK:=FALSE;
	xFechaDuctosResfriadorInf01:=FALSE;
	xBtRecAjustaAlturaDuctosInf01:=FALSE;
	BtParamDuctosResfriadorInf01:=FALSE;
	xDuctosInf01EmHome:=FALSE;
	xDuctosInf01EmAjuste:=FALSE;
	xLigaSegEstagDuctosInf01:= FALSE;
	xLigaTerEstagDuctosInf01:= FALSE;
	xReajustaAlturaDuctosInf01:=FALSE;
END_IF
	
