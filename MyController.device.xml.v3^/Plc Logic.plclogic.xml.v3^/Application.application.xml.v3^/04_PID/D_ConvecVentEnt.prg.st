__METADATA__
{
  "v3Meta": {
    "objectGuid": "884d89bc-c355-437b-bd06-5e8e32262c16",
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
PROGRAM D_ConvecVentEnt
VAR
	PassoVentConvecEnt: INT;
	PassoPauseVentConvecEnt: INT;
	PassoAlmVentConvecEnt: INT;
	PassoManualVentConvecEnt: INT;
	///Blocos Nativos
	///Blocos Criados
	ControleSsrConveccaoEnt: PidPwm;
	HabResConveccaoEnt: HabilitaDesabilita;
	ReleDefeitoConvecEntSsr01: AlarmeRelesSsr;
	ReleDefeitoConvecEntSsr02: AlarmeRelesSsr;
	ReleDefeitoConvecEntSsr03: AlarmeRelesSsr;
	xExecutaVentConvecEnt: BOOL;
	xExecutaStopVentConvecEnt: BOOL;
	xStopVentConvecEntDone: BOOL;
	iVelocidadeVentConvecEnt: INT;
	rTermoparVentConvecEntLeitura: REAL;
	rTermoparVentConvecEntControle: REAL;
	rSetPointTemperaturaConveccaoEnt: REAL;
	xLigaDesligaResistConvecEnt: BOOL;
	xLigaDesligaVentConvecEnt: BOOL;

	xLigaMotorConveccaoEnt: BOOL;
	
	xAlarmeSsr01ConvecEntSon: BOOL;
	xAlarmeSsr02ConvecEntSon: BOOL;
	xAlarmeSsr03ConvecEntSon: BOOL;
	
END_VAR
__IMPLEMENTATION__
// CONVEÇÃO FONÇADA COM VENTILADOR 

//Lógica Ventilador


CASE PassoVentConvecEnt OF
		
		0:	PassoVentConvecEnt:=2;

		2: 	IF xLigaDesligaResistConvecEnt THEN 
				PassoVentConvecEnt:=10;		
			END_IF
			IF rTemperaturaConveccaoEnt>=150 THEN
				PassoVentConvecEnt:=50;	
			END_IF
			
		10: iVelocidadeVentConvecEnt:=iVelocidadeStbVentConvecEnt;
			PassoVentConvecEnt:=15;

		15:	xLigaMotorConveccaoEnt:=TRUE;
			PassoVentConvecEnt:=20;
			
		20: PassoVentConvecEnt:=25;
			
		21: IF (rTemperaturaConveccaoEnt>150) THEN
				PassoVentConvecEnt:=50;
			END_IF
			IF iVelocidadeVentConvecEnt<>iVelocidadeStbVentConvecEnt THEN
				PassoVentConvecEnt:=10;
			END_IF
			IF NOT xLigaDesligaResistConvecEnt THEN
				PassoVentConvecEnt:=25;
			END_IF
			IF xPause THEN
				PassoPauseVentConvecEnt:=10;
				PassoVentConvecEnt:=300;
			END_IF		
			IF xAlarmeMotorVentConvecEnt THEN
				PassoAlmVentConvecEnt:=10;
				PassoVentConvecEnt:=400;
			END_IF		
						
		25: IF (rTemperaturaConveccaoEnt<130) THEN
				PassoVentConvecEnt:=30;
			END_IF
			IF xLigaDesligaResistConvecEnt THEN
				PassoVentConvecEnt:=50;
			END_IF
			IF xPause THEN
				PassoPauseVentConvecEnt:=10;
				PassoVentConvecEnt:=300;
			END_IF		
			IF xAlarmeMotorVentConvecEnt THEN
				PassoAlmVentConvecEnt:=10;
				PassoVentConvecEnt:=400;
			END_IF		
		
		30: xLigaMotorConveccaoEnt:=FALSE;
			PassoVentConvecEnt:=35;
		
		35: PassoVentConvecEnt:=0;
			
		50:	iVelocidadeVentConvecEnt:=iVelocidadeJogVentConvecEnt;
			PassoVentConvecEnt:=55;
			
		55: xLigaMotorConveccaoEnt:=TRUE;
			PassoVentConvecEnt:=60;

		60: PassoVentConvecEnt:=65;
			
		65: IF iVelocidadeVentConvecEnt<>iVelocidadeJogVentConvecEnt THEN
				PassoVentConvecEnt:=50;
			END_IF
			IF NOT xLigaDesligaResistConvecEnt THEN
				PassoVentConvecEnt:=70;
			END_IF
			IF xPause THEN
				PassoPauseVentConvecEnt:=50;
				PassoVentConvecEnt:=300;
			END_IF		
			IF xAlarmeMotorVentConvecEnt THEN
				PassoAlmVentConvecEnt:=50;
				PassoVentConvecEnt:=400;
			END_IF		
			
		70: iVelocidadeVentConvecEnt:=iVelocidadeStbVentConvecEnt;
			PassoVentConvecEnt:=75;

		75:	PassoVentConvecEnt:=80;
			
		80: PassoVentConvecEnt:=25;

		// Emergência Pausa/Reinicio
		300:xLigaMotorConveccaoEnt:=FALSE;
			PassoVentConvecEnt:=301;
		
		301:PassoVentConvecEnt:=302;
	
		302:IF xRestart THEN
				PassoVentConvecEnt:=303;
			END_IF
			
		303:PassoVentConvecEnt:=PassoPauseVentConvecEnt;

		// Alarme Motor Parada/Reinicio
		400:xLigaMotorConveccaoEnt:=FALSE;
			PassoVentConvecEnt:=401;

		401:PassoVentConvecEnt:=402;
	
		402:IF xRestart AND iCanOpenInverConvecEntStateOk THEN
				PassoVentConvecEnt:=PassoAlmVentConvecEnt;
			END_IF	
		
END_CASE

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorConveccaoEnt:=xLigaMotorConveccaoEnt;

InversorConvecEnt.i_xAvanco:=xMotorConveccaoEnt;

// Velocidade
InversorConvecEnt.i_iFreqRef:=iVelocidadeVentConvecEnt;
//------------------------------------------------------------------------\\

IF xOperacaoManual THEN
	PassoVentConvecEnt:=0;
	PassoPauseVentConvecEnt:=0;
	PassoAlmVentConvecEnt:=0;
	PassoManualVentConvecEnt:=0;
	xExecutaVentConvecEnt:=FALSE;
	xLigaMotorConveccaoEnt:=FALSE;
END_IF

// CONTROLE DE TEMPERATURA
rTermoparVentConvecEntLeitura:=INT_TO_REAL(TermoparConveccaoEnt)/10;
rTermoparVentConvecEntControle:=INT_TO_REAL(TermoparConveccaoEnt)/10;
rSetPointTemperaturaConveccaoEnt:=INT_TO_REAL(iSetPointTemperaturaConveccaoEnt);

//HabResConveccaoEnt(	
//			Alarme01:= 	(*xAlarmeResistRompidaInferior[Index]*), 
//			Alarme02:= 	,//AlmTermoparAbertoLogicoInf[Index], 
//			Alarme03:=	,//AlmTemperaturaExcedeuLogicoInf[Index],
//			Entrada:= 	BtHabDesabResistConveccaoEnt, 
//			Entrada02:=	,//BtHabilitaResistenciasGeralInferior OR TpHabilitaResistenciasOnQ,
//			Entrada03:= ,//BtDesabilitaResistenciasGeralInferior OR xDesabilitaSobreTemperInferior OR xDesabilitaSobreTemperSuperior,
//			StatusSaida=> xHabDesabResistConveccaoEnt);

IF BtHabDesabResistConveccaoEnt AND NOT xHabDesabResistConveccaoEnt THEN
	xHabDesabResistConveccaoEnt:=TRUE;
END_IF	
IF (BtHabDesabResistConveccaoEnt AND xHabDesabResistConveccaoEnt) OR xAlmTemperExcedeuConvecEntSin OR xAlmTermoparAbertoConvecEntSin THEN
	xHabDesabResistConveccaoEnt:=FALSE;
END_IF			
			

IF (xResistenciasLigadas AND rMediaLogicaTemperaturaTotal>400 AND xHabDesabResistConveccaoEnt) OR xForceLigConvecEntVent THEN
	xLigaDesligaResistConvecEnt:=TRUE;
ELSE
	xLigaDesligaResistConvecEnt:=FALSE;
END_IF




// Setor - Convecção
	ControleSsrConveccaoEnt(
	xLigaDesliga		:=  xLigaDesligaResistConvecEnt AND xMotorVentConvecEntLigado,
	xHabilitaControle	:=  TRUE,//xHabilitaBlocoResistConvec, 
	xForceResistencia	:=  FALSE, 
	xHabilitaResistencia:=  TRUE,
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	,
	rTermoparLeitura	:= 	rTermoparVentConvecEntLeitura, 
	rTermoparControle	:=  rTermoparVentConvecEntControle, 
	rSetTemperatura		:= 	rSetPointTemperaturaConveccaoEnt,
	rProcentagem		:= 	100, 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=>	xReleSsrConveccaoEnt, 
	xTemperaturaOk		=>	,
	rTemperatura		=>	rTemperaturaConveccaoEnt);

	
xRetornoSsrConveccaoEnt:= xRetornoSsr01ConveccaoEnt OR xRetornoSsr02ConveccaoEnt OR xRetornoSsr03ConveccaoEnt;


ReleDefeitoConvecEntSsr01(
	RetornoReleSsr:= 	xRetornoSsr01ConveccaoEnt, 
	ResistRompida:= 	, 
	ReleSsr:= 			xReleSsrConveccaoEnt, 
	ResetAlarm:= 		bResetAlmGeral, 
	AlarmeSsrAberto=> 	xAlarmeSsr01ConvecEntAberto, 
	AlarmeSsrFechado=>	xAlarmeSsr01ConvecEntFechado, 
	AlarmeSonoro=> 		xAlarmeSsr01ConvecEntSon);
	
ReleDefeitoConvecEntSsr02(
	RetornoReleSsr:= 	xRetornoSsr02ConveccaoEnt, 
	ResistRompida:= 	, 
	ReleSsr:= 			xReleSsrConveccaoEnt, 
	ResetAlarm:= 		bResetAlmGeral, 
	AlarmeSsrAberto=> 	xAlarmeSsr02ConvecEntAberto, 
	AlarmeSsrFechado=>	xAlarmeSsr02ConvecEntFechado, 
	AlarmeSonoro=> 		xAlarmeSsr02ConvecEntSon);
	
ReleDefeitoConvecEntSsr03(
	RetornoReleSsr:= 	xRetornoSsr03ConveccaoEnt, 
	ResistRompida:= 	, 
	ReleSsr:= 			xReleSsrConveccaoEnt, 
	ResetAlarm:= 		bResetAlmGeral, 
	AlarmeSsrAberto=> 	xAlarmeSsr03ConvecEntAberto, 
	AlarmeSsrFechado=>	xAlarmeSsr03ConvecEntFechado, 
	AlarmeSonoro=> 		xAlarmeSsr03ConvecEntSon);	
	
xAlarmeSsrConvecEntAberto:= xAlarmeSsr01ConvecEntAberto OR xAlarmeSsr02ConvecEntAberto OR xAlarmeSsr03ConvecEntAberto;
xAlarmeSsrConvecEntFechado:= xAlarmeSsr01ConvecEntFechado OR xAlarmeSsr02ConvecEntFechado OR xAlarmeSsr03ConvecEntFechado;	

xAlarmeSsrConvecEntSin:=xAlarmeSsrConvecEntAberto OR xAlarmeSsrConvecEntFechado;
xAlarmeSsrConvecEntSon:=xAlarmeSsr01ConvecEntSon OR xAlarmeSsr02ConvecEntSon OR xAlarmeSsr03ConvecEntSon;
	
//resistencia 01
	IF NOT xRetornoSsr01ConveccaoEnt THEN
			iAnimaResistenciaSsr01ConvecEnt:=1;(*Resistência Desligada*)
	END_IF
	IF xRetornoSsr01ConveccaoEnt THEN
			iAnimaResistenciaSsr01ConvecEnt:=2; (*Resistência Ligada*)
	END_IF
	IF xAlarmeSsr01ConvecEntAberto THEN
			iAnimaResistenciaSsr01ConvecEnt:=3; (*Resistência Alarme Aberto*)
	END_IF
	IF  xAlarmeSsr01ConvecEntFechado THEN
			iAnimaResistenciaSsr01ConvecEnt:=4; (*Resistência Alarme rele em curto*)
	END_IF
	IF TermoparConvecEntAberto THEN
			iAnimaResistenciaSsr01ConvecEnt:=5; (*Termopar Alarme*)
	END_IF
	
//resistencia 02
	IF NOT xRetornoSsr02ConveccaoEnt THEN
			iAnimaResistenciaSsr02ConvecEnt:=1;(*Resistência Desligada*)
	END_IF
	IF xRetornoSsr02ConveccaoEnt THEN
			iAnimaResistenciaSsr02ConvecEnt:=2; (*Resistência Ligada*)
	END_IF
	IF xAlarmeSsr02ConvecEntAberto THEN
			iAnimaResistenciaSsr02ConvecEnt:=3; (*Resistência Alarme Aberto*)
	END_IF
	IF  xAlarmeSsr02ConvecEntFechado THEN
			iAnimaResistenciaSsr02ConvecEnt:=4; (*Resistência Alarme rele em curto*)
	END_IF
	IF TermoparConvecEntAberto THEN
			iAnimaResistenciaSsr02ConvecEnt:=5; (*Termopar Alarme*)
	END_IF	
//resistencia 03
	IF NOT xRetornoSsr03ConveccaoEnt THEN
			iAnimaResistenciaSsr03ConvecEnt:=1;(*Resistência Desligada*)
	END_IF
	IF xRetornoSsr03ConveccaoEnt THEN
			iAnimaResistenciaSsr03ConvecEnt:=2; (*Resistência Ligada*)
	END_IF
	IF xAlarmeSsr03ConvecEntAberto THEN
			iAnimaResistenciaSsr03ConvecEnt:=3; (*Resistência Alarme Aberto*)
	END_IF
	IF  xAlarmeSsr03ConvecEntFechado THEN
			iAnimaResistenciaSsr03ConvecEnt:=4; (*Resistência Alarme rele em curto*)
	END_IF
	IF TermoparConvecEntAberto THEN
			iAnimaResistenciaSsr03ConvecEnt:=5; (*Termopar Alarme*)
	END_IF
	
