__METADATA__
{
  "v3Meta": {
    "objectGuid": "92a317c3-86a1-4be2-9aa8-85824954a927",
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
PROGRAM D_ConvecVentSai
VAR
	PassoVentConvecSai: INT;
	PassoPauseVentConvecSai: INT;
	PassoAlmVentConvecSai: INT;
	PassoManualVentConvecSai: INT;
	///Blocos Nativos
	///Blocos Criados
	ControleSsrConveccaoSai: PidPwm;
	HabResConveccaoSai: HabilitaDesabilita;
	ReleDefeitoConvecSaiSsr01: AlarmeRelesSsr;
	ReleDefeitoConvecSaiSsr02: AlarmeRelesSsr;
	ReleDefeitoConvecSaiSsr03: AlarmeRelesSsr;
	xExecutaVentConvecSai: BOOL;
	xExecutaStopVentConvecSai: BOOL;
	xStopVentConvecSaiDone: BOOL;
	iVelocidadeVentConvecSai: INT;
	rTermoparVentConvecSaiLeitura: REAL;
	rTermoparVentConvecSaiControle: REAL;
	rSetPointTemperaturaConveccaoSai: REAL;
	xLigaDesligaResistConvecSai: BOOL;
	xLigaDesligaVentConvecSai: BOOL;

	xLigaMotorConveccaoSai: BOOL;
	
	xAlarmeSsr01ConvecSaiSon: BOOL;
	xAlarmeSsr02ConvecSaiSon: BOOL;
	xAlarmeSsr03ConvecSaiSon: BOOL;
	
END_VAR
__IMPLEMENTATION__
// CONVEÇÃO FONÇADA COM VENTILADOR 

//Lógica Ventilador


CASE PassoVentConvecSai OF
		
		0:	PassoVentConvecSai:=2;

		2: 	IF xLigaDesligaResistConvecSai THEN 
				PassoVentConvecSai:=10;		
			END_IF
			IF rTemperaturaConveccaoSai>=150 THEN
				PassoVentConvecSai:=50;	
			END_IF
			
		10: iVelocidadeVentConvecSai:=iVelocidadeStbVentConvecSai;
			PassoVentConvecSai:=15;

		15:	xLigaMotorConveccaoSai:=TRUE;
			PassoVentConvecSai:=20;
			
		20: PassoVentConvecSai:=25;
			
		21: IF (rTemperaturaConveccaoSai>150) THEN
				PassoVentConvecSai:=50;
			END_IF
			IF iVelocidadeVentConvecSai<>iVelocidadeStbVentConvecSai THEN
				PassoVentConvecSai:=10;
			END_IF
			IF NOT xLigaDesligaResistConvecSai THEN
				PassoVentConvecSai:=25;
			END_IF
			IF xPause THEN
				PassoPauseVentConvecSai:=10;
				PassoVentConvecSai:=300;
			END_IF		
			IF xAlarmeMotorVentConvecSai THEN
				PassoAlmVentConvecSai:=10;
				PassoVentConvecSai:=400;
			END_IF		
						
		25: IF (rTemperaturaConveccaoSai<130) THEN
				PassoVentConvecSai:=30;
			END_IF
			IF xLigaDesligaResistConvecSai THEN
				PassoVentConvecSai:=50;
			END_IF
			IF xPause THEN
				PassoPauseVentConvecSai:=10;
				PassoVentConvecSai:=300;
			END_IF		
			IF xAlarmeMotorVentConvecSai THEN
				PassoAlmVentConvecSai:=10;
				PassoVentConvecSai:=400;
			END_IF		
		
		30: xLigaMotorConveccaoSai:=FALSE;
			PassoVentConvecSai:=35;
		
		35: PassoVentConvecSai:=0;
			
		50:	iVelocidadeVentConvecSai:=iVelocidadeJogVentConvecSai;
			PassoVentConvecSai:=55;
			
		55: xLigaMotorConveccaoSai:=TRUE;
			PassoVentConvecSai:=60;

		60: PassoVentConvecSai:=65;
			
		65: IF iVelocidadeVentConvecSai<>iVelocidadeJogVentConvecSai THEN
				PassoVentConvecSai:=50;
			END_IF
			IF NOT xLigaDesligaResistConvecSai THEN
				PassoVentConvecSai:=70;
			END_IF
			IF xPause THEN
				PassoPauseVentConvecSai:=50;
				PassoVentConvecSai:=300;
			END_IF		
			IF xAlarmeMotorVentConvecSai THEN
				PassoAlmVentConvecSai:=50;
				PassoVentConvecSai:=400;
			END_IF		
			
		70: iVelocidadeVentConvecSai:=iVelocidadeStbVentConvecSai;
			PassoVentConvecSai:=75;

		75:	PassoVentConvecSai:=80;
			
		80: PassoVentConvecSai:=25;

		// Emergência Pausa/Reinicio
		300:xLigaMotorConveccaoSai:=FALSE;
			PassoVentConvecSai:=301;
		
		301:PassoVentConvecSai:=302;
	
		302:IF xRestart THEN
				PassoVentConvecSai:=303;
			END_IF
			
		303:PassoVentConvecSai:=PassoPauseVentConvecSai;

		// Alarme Motor Parada/Reinicio
		400:xLigaMotorConveccaoSai:=FALSE;
			PassoVentConvecSai:=401;

		401:PassoVentConvecSai:=402;
	
		402:IF xRestart AND iCanOpenInverConvecSaiStateOk THEN
				PassoVentConvecSai:=PassoAlmVentConvecSai;
			END_IF	
		
END_CASE

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorConveccaoSai:=xLigaMotorConveccaoSai;

InversorConvecSai.i_xAvanco:=xMotorConveccaoSai;

// Velocidade
InversorConvecSai.i_iFreqRef:=iVelocidadeVentConvecSai;
//------------------------------------------------------------------------\\

IF xOperacaoManual THEN
	PassoVentConvecSai:=0;
	PassoPauseVentConvecSai:=0;
	PassoAlmVentConvecSai:=0;
	PassoManualVentConvecSai:=0;
	xExecutaVentConvecSai:=FALSE;
	xLigaMotorConveccaoSai:=FALSE;
END_IF

// CONTROLE DE TEMPERATURA
rTermoparVentConvecSaiLeitura:=INT_TO_REAL(TermoparConveccaoSai)/10;
rTermoparVentConvecSaiControle:=INT_TO_REAL(TermoparConveccaoSai)/10;
rSetPointTemperaturaConveccaoSai:=INT_TO_REAL(iSetPointTemperaturaConveccaoSai);

//HabResConveccaoSai(	
//			Alarme01:= 	(*xAlarmeResistRompidaInferior[Index]*), 
//			Alarme02:= 	,//AlmTermoparAbertoLogicoInf[Index], 
//			Alarme03:=	,//AlmTemperaturaExcedeuLogicoInf[Index],
//			Entrada:= 	BtHabDesabResistConveccaoSai, 
//			Entrada02:=	,//BtHabilitaResistenciasGeralInferior OR TpHabilitaResistenciasOnQ,
//			Entrada03:= ,//BtDesabilitaResistenciasGeralInferior OR xDesabilitaSobreTemperInferior OR xDesabilitaSobreTemperSuperior,
//			StatusSaida=> xHabDesabResistConveccaoSai);

IF BtHabDesabResistConveccaoSai AND NOT xHabDesabResistConveccaoSai THEN
	xHabDesabResistConveccaoSai:=TRUE;
END_IF	
IF (BtHabDesabResistConveccaoSai AND xHabDesabResistConveccaoSai) OR xAlmTemperExcedeuConvecSaiSin OR xAlmTermoparAbertoConvecSaiSin THEN
	xHabDesabResistConveccaoSai:=FALSE;
END_IF			
			

IF (xResistenciasLigadas AND rMediaLogicaTemperaturaTotal>400 AND xHabDesabResistConveccaoSai) OR xForceLigConvecSaiVent THEN
	xLigaDesligaResistConvecSai:=TRUE;
ELSE
	xLigaDesligaResistConvecSai:=FALSE;
END_IF




// Setor - Convecção
	ControleSsrConveccaoSai(
	xLigaDesliga		:=  xLigaDesligaResistConvecSai AND xMotorVentConvecSaiLigado,
	xHabilitaControle	:=  TRUE,//xHabilitaBlocoResistConvec, 
	xForceResistencia	:=  FALSE, 
	xHabilitaResistencia:=  TRUE,
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	,
	rTermoparLeitura	:= 	rTermoparVentConvecSaiLeitura, 
	rTermoparControle	:=  rTermoparVentConvecSaiControle, 
	rSetTemperatura		:= 	rSetPointTemperaturaConveccaoSai,
	rProcentagem		:= 	100, 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=>	xReleSsrConveccaoSai, 
	xTemperaturaOk		=>	,
	rTemperatura		=>	rTemperaturaConveccaoSai);

	
xRetornoSsrConveccaoSai:= xRetornoSsr01ConveccaoSai OR xRetornoSsr02ConveccaoSai OR xRetornoSsr03ConveccaoSai;


ReleDefeitoConvecSaiSsr01(
	RetornoReleSsr:= 	xRetornoSsr01ConveccaoSai, 
	ResistRompida:= 	, 
	ReleSsr:= 			xReleSsrConveccaoSai, 
	ResetAlarm:= 		bResetAlmGeral, 
	AlarmeSsrAberto=> 	xAlarmeSsr01ConvecSaiAberto, 
	AlarmeSsrFechado=>	xAlarmeSsr01ConvecSaiFechado, 
	AlarmeSonoro=> 		xAlarmeSsr01ConvecSaiSon);
	
ReleDefeitoConvecSaiSsr02(
	RetornoReleSsr:= 	xRetornoSsr02ConveccaoSai, 
	ResistRompida:= 	, 
	ReleSsr:= 			xReleSsrConveccaoSai, 
	ResetAlarm:= 		bResetAlmGeral, 
	AlarmeSsrAberto=> 	xAlarmeSsr02ConvecSaiAberto, 
	AlarmeSsrFechado=>	xAlarmeSsr02ConvecSaiFechado, 
	AlarmeSonoro=> 		xAlarmeSsr02ConvecSaiSon);
	
ReleDefeitoConvecSaiSsr03(
	RetornoReleSsr:= 	xRetornoSsr03ConveccaoSai, 
	ResistRompida:= 	, 
	ReleSsr:= 			xReleSsrConveccaoSai, 
	ResetAlarm:= 		bResetAlmGeral, 
	AlarmeSsrAberto=> 	xAlarmeSsr03ConvecSaiAberto, 
	AlarmeSsrFechado=>	xAlarmeSsr03ConvecSaiFechado, 
	AlarmeSonoro=> 		xAlarmeSsr03ConvecSaiSon);	
	
xAlarmeSsrConvecSaiAberto:= xAlarmeSsr01ConvecSaiAberto OR xAlarmeSsr02ConvecSaiAberto OR xAlarmeSsr03ConvecSaiAberto;
xAlarmeSsrConvecSaiFechado:= xAlarmeSsr01ConvecSaiFechado OR xAlarmeSsr02ConvecSaiFechado OR xAlarmeSsr03ConvecSaiFechado;	

xAlarmeSsrConvecSaiSin:=xAlarmeSsrConvecSaiAberto OR xAlarmeSsrConvecSaiFechado;
xAlarmeSsrConvecSaiSon:=xAlarmeSsr01ConvecSaiSon OR xAlarmeSsr02ConvecSaiSon OR xAlarmeSsr03ConvecSaiSon;
	
//resistencia 01
	IF NOT xRetornoSsr01ConveccaoSai THEN
			iAnimaResistenciaSsr01ConvecSai:=1;(*Resistência Desligada*)
	END_IF
	IF xRetornoSsr01ConveccaoSai THEN
			iAnimaResistenciaSsr01ConvecSai:=2; (*Resistência Ligada*)
	END_IF
	IF xAlarmeSsr01ConvecSaiAberto THEN
			iAnimaResistenciaSsr01ConvecSai:=3; (*Resistência Alarme Aberto*)
	END_IF
	IF  xAlarmeSsr01ConvecSaiFechado THEN
			iAnimaResistenciaSsr01ConvecSai:=4; (*Resistência Alarme rele em curto*)
	END_IF
	IF TermoparConvecSaiAberto THEN
			iAnimaResistenciaSsr01ConvecSai:=5; (*Termopar Alarme*)
	END_IF
	
//resistencia 02
	IF NOT xRetornoSsr02ConveccaoSai THEN
			iAnimaResistenciaSsr02ConvecSai:=1;(*Resistência Desligada*)
	END_IF
	IF xRetornoSsr02ConveccaoSai THEN
			iAnimaResistenciaSsr02ConvecSai:=2; (*Resistência Ligada*)
	END_IF
	IF xAlarmeSsr02ConvecSaiAberto THEN
			iAnimaResistenciaSsr02ConvecSai:=3; (*Resistência Alarme Aberto*)
	END_IF
	IF  xAlarmeSsr02ConvecSaiFechado THEN
			iAnimaResistenciaSsr02ConvecSai:=4; (*Resistência Alarme rele em curto*)
	END_IF
	IF TermoparConvecSaiAberto THEN
			iAnimaResistenciaSsr02ConvecSai:=5; (*Termopar Alarme*)
	END_IF	
//resistencia 03
	IF NOT xRetornoSsr03ConveccaoSai THEN
			iAnimaResistenciaSsr03ConvecSai:=1;(*Resistência Desligada*)
	END_IF
	IF xRetornoSsr03ConveccaoSai THEN
			iAnimaResistenciaSsr03ConvecSai:=2; (*Resistência Ligada*)
	END_IF
	IF xAlarmeSsr03ConvecSaiAberto THEN
			iAnimaResistenciaSsr03ConvecSai:=3; (*Resistência Alarme Aberto*)
	END_IF
	IF  xAlarmeSsr03ConvecSaiFechado THEN
			iAnimaResistenciaSsr03ConvecSai:=4; (*Resistência Alarme rele em curto*)
	END_IF
	IF TermoparConvecSaiAberto THEN
			iAnimaResistenciaSsr03ConvecSai:=5; (*Termopar Alarme*)
	END_IF
	
