__METADATA__
{
  "v3Meta": {
    "objectGuid": "e1c72e7a-c9c4-4c17-a033-88522a2425fd",
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
PROGRAM M_Ventilador01
VAR
	PassoVentilador01: INT;
	PassoPauseVentilador01: INT;
	PassoAlmVentilador01: INT;
	PulsoLigaVentilador01: PulsoPositivo;
	iVelocidadeVentilador01: INT;
	xLigaVentilador01: BOOL;
	xFimVentilacao01: BOOL;
	xLigaTempoVentilador01: BOOL;
	xPulsoLigaVentilador01: BOOL;
	xLigaVent01SairForno: BOOL;
	xTempoMvVent01In: BOOL;
	xTempoMvVent01Q: BOOL;
	TempoMvVent01: ton;
	xLigaMotorVentilador01: BOOL;
	iVelocidadeVentilador01HZ: INT;
	dVelocidadeVentilador01HZ: DINT;
	rVelocidadeVentilador01HZ:REAL;
	rVelocidadeVentilador01 :REAL;	
	PIDVENT01: FB_PID;
	
	rPidSaidaVent01	: REAL;
	iRefFreqVent01Pid	: INT ;
	
	xVentPassHabilitado	: BOOL ;
END_VAR
__IMPLEMENTATION__
IF iVelocidade01Ventilador01<> 0 THEN
	xVentPassHabilitado:=TRUE;
ELSE
	xVentPassHabilitado:=FALSE;
END_IF
		
IF xEspessuraVidroFino THEN
	IF (iTempoAquecFornoRestante<=iTempoLigaVentilador01VidroFino) AND (iTempoAquecFornoRestante>0) AND xFornoEmCiclo AND xVentPassHabilitado THEN
		xLigaTempoVentilador01:=TRUE;
	ELSE
		xLigaTempoVentilador01:=FALSE;
	END_IF
ELSE
	IF (iTempoAquecFornoRestante<=iTempoLigaVentilador01VidroGros) AND (iTempoAquecFornoRestante>0) AND xFornoEmCiclo AND xVentPassHabilitado THEN
		xLigaTempoVentilador01:=TRUE;
	ELSE
		xLigaTempoVentilador01:=FALSE;
	END_IF
END_IF

xLigaVent01SairForno:=xSairForno AND xFornoEmCiclo and xFornoComCarga;

PulsoLigaVentilador01(Entrada:= xLigaTempoVentilador01 OR xLigaVent01SairForno OR xLigaVent01FimForno, SaidaPulsoPo=>xPulsoLigaVentilador01 );
IF xPulsoLigaVentilador01 THEN
	xLigaVentilador01:=TRUE;
	xFechaVenezVentPassV01:=TRUE;//-> TASK/T_VenezianaVentInfPass
END_IF


TempoMvVent01(IN:= xTempoMvVent01In, PT:=T#2S , Q=> xTempoMvVent01Q, ET=> );

// SEQUENCIA DE FUNCIONAMENTO
iVelocidade02Ventilador01:=iVelocidade01Ventilador01;
iVelocidade03Ventilador01:=iVelocidade01Ventilador01;

CASE PassoVentilador01 OF
		
		0:	IF xLigaVentilador01 THEN
				PassoVentilador01:=10;
			END_IF
			








		10:	xLigaVentilador01:=FALSE;
			xDesligaVentilador01:=FALSE;
			xDesligaFimVentilador01:=FALSE;
			xSegundoEstagioVentilador01:=FALSE;
			xTerceiroEstagioVentilador01:=FALSE;
			PassoVentilador01:=15;
			
		15:	xPrimeiroEstagioVentilador01:=TRUE;
			PassoVentilador01:=16;
		
		16:	IF  xSemEnergia THEN
				PassoVentilador01:=80;
			ELSIF xPause THEN
				PassoPauseVentilador01:=16;
				PassoVentilador01:=300;
			ELSIF xAlarmeMotorVentilador01 THEN
				PassoAlmVentilador01:=16;
				PassoVentilador01:=400;
			ELSE
				PassoVentilador01:=20;
			END_IF
	
		20:	iVelocidadeVentilador01:=iVelocidade01Ventilador01;
			PassoVentilador01:=21;
			
		21:	xLigaMotorVentilador01:=TRUE;
			PassoVentilador01:=22;
			
		22:	PassoVentilador01:=29;
			
		29:	PassoVentilador01:=59;//30; (* Alterado Ventilador tempera passagem*)
		
		// Fica Parado no passo 30 aguardando o inicio do segundo Estágio	
		30:	IF iVelocidadeVentilador01<>iVelocidade01Ventilador01 THEN
				PassoVentilador01:=20;
			END_IF
			IF xSegundoEstagioVentilador01 THEN //<-TASK/EstagiosResfriador
				PassoVentilador01:=40;
			END_IF
			IF xDesligaVentilador01 THEN
				PassoVentilador01:=41;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador01:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador01:=20;
				PassoVentilador01:=300;
			END_IF
			IF xAlarmeMotorVentilador01 THEN
				PassoAlmVentilador01:=20;
				PassoVentilador01:=400;
			END_IF
		
		40:	xSegundoEstagioVentilador01:=FALSE;
			xDesligaVentilador01:=FALSE; // Zera memoria desliga vent caso esteja em 1
			PassoVentilador01:=41;
		
		41:	xPrimeiroEstagioVentilador01:=FALSE;
			iVelocidadeVentilador01:=iVelocidade02Ventilador01;
			PassoVentilador01:=42;
			
		42:	PassoVentilador01:=43;
			
		43:	PassoVentilador01:=44;
			
		44:	PassoVentilador01:=50;
		// Fica Parado no Passo 50 aguardando o inicio do Terceiro Estágio	
		50:	IF iVelocidadeVentilador01<>iVelocidade02Ventilador01 THEN
				PassoVentilador01:=41;
			END_IF
			IF xTerceiroEstagioVentilador01 THEN //<-TASK/EstagiosResfriador
				PassoVentilador01:=51;
			END_IF
			IF xDesligaVentilador01 THEN
				PassoVentilador01:=52;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador01:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador01:=41;
				PassoVentilador01:=300;
			END_IF
			IF xAlarmeMotorVentilador01 THEN
				PassoAlmVentilador01:=41;
				PassoVentilador01:=400;
			END_IF

		51:	xTerceiroEstagioVentilador01:=FALSE;
			xDesligaVentilador01:=FALSE; // Zera memoria desliga vent caso esteja em 1
			PassoVentilador01:=52;
		
		52:	xSegundoEstagioVentilador01:=FALSE;
			iVelocidadeVentilador01:=iVelocidade03Ventilador01;
			PassoVentilador01:=53;
			
		53:	PassoVentilador01:=54;
			
		54:	PassoVentilador01:=55;
			
		55:	PassoVentilador01:=59;

			// Fica Parado no Passo 59 Aguardando
		59:	IF iVelocidadeVentilador01<>iVelocidade03Ventilador01 THEN
				PassoVentilador01:=20;//52; (* Alterador Tempera de passagem *)
			END_IF
			IF xLigaVentilador01 THEN
				PassoVentilador01:=10;
			END_IF
			IF xDesligaVentilador01 AND NOT xFornoEmEspera THEN
				PassoVentilador01:=60;
			END_IF
			IF xDesligaVentilador01 AND xFornoEmEspera THEN
				PassoVentilador01:=80;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador01:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador01:=20;//52;
				PassoVentilador01:=300;
			END_IF
			IF xAlarmeMotorVentilador01 THEN
				PassoAlmVentilador01:=20;//52;
				PassoVentilador01:=400;
			END_IF
			
		60:	xDesligaVentilador01:=FALSE;
			xPrimeiroEstagioVentilador01:=FALSE;
			PassoVentilador01:=61;
			
		61:	IF iVelocidadeStbVentilador01<>0 THEN
				PassoVentilador01:=62;
			ELSE
				PassoVentilador01:=63;
			END_IF
			
		62:	xLigaMotorVentilador01:=TRUE;
			PassoVentilador01:=70;
			
		63:	xLigaMotorVentilador01:=FALSE;
			PassoVentilador01:=70;
			
		70:	iVelocidadeVentilador01:=iVelocidadeStbVentilador01;
			PassoVentilador01:=71;
			
		71:	IF iVelocidadeVentilador01<> iVelocidadeStbVentilador01 THEN
				PassoVentilador01:=61;
			END_IF
			IF xLigaVentilador01 THEN
				PassoVentilador01:=10;
			END_IF
			IF xDesligaFimVentilador01 THEN
				PassoVentilador01:=80;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador01:=80;
			END_IF
			IF NOT xVentPassHabilitado THEN
				PassoVentilador01:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador01:=60;
				PassoVentilador01:=300;
			END_IF
			IF xAlarmeMotorVentilador01 THEN
				PassoAlmVentilador01:=60;
				PassoVentilador01:=400;
			END_IF
			
		80:	xPrimeiroEstagioVentilador01:=FALSE;
			xDesligaVentilador01:=FALSE;
			xDesligaFimVentilador01:=FALSE;
			xPrimeiroEstagioVentilador01:=FALSE;
			PassoVentilador01:=81;
			
		81:	xLigaMotorVentilador01:=FALSE;
			PassoVentilador01:=90;	
			
		90:	PassoVentilador01:=91;
			
		91:PassoVentilador01:=0;
	

		// Emergência Pausa/Reinicio
		300:xLigaMotorVentilador01:=FALSE;
			PassoVentilador01:=301;
		
		301:PassoVentilador01:=302;
	
		302:IF xRestart THEN
				PassoVentilador01:=303;
			END_IF
			
		303:PassoVentilador01:=PassoPauseVentilador01;
			
		// Alarme Motor Parada/Reinicio
		400:xLigaMotorVentilador01:=FALSE;
			PassoVentilador01:=401;

		401:PassoVentilador01:=402;
	
		402:IF xRestart AND xInvVentilador01Habilitado THEN
				PassoVentilador01:=PassoAlmVentilador01;
			END_IF	
				
END_CASE
// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorVentilador01:=xLigaMotorVentilador01;

//InversorVentila01.i_xAvanco:=xMotorVentilador01;

// Velocidade
//InversorVentila01.i_iFreqRef:=iVelocidadeVentilador01;

// Velocidade
rVelocidadeVentilador01:=INT_TO_REAL(iVelocidadeVentilador01);
rVelocidadeVentilador01HZ:=((rVelocidadeVentilador01*600)/1800);
dVelocidadeVentilador01HZ:=REAL_TO_DINT(rVelocidadeVentilador01HZ);
iVelocidadeVentilador01HZ:=DINT_TO_INT(dVelocidadeVentilador01HZ);

iRefFreqVent01Pid:=iVelocidadeVentilador01HZ*10;


PIDVENT01.i_stPid.rLowLim:=0;
PIDVENT01.i_stPid.rHighLim:=100;
PIDVENT01.i_stPid.rTargCyclTime:=10;

PIDVENT01(
	i_xEn:= 		TRUE, 
	i_rSp:= 		iRefFreqVent01Pid, 
	i_rPv1:= 		iFrequenciaMotorVentilador01, 
	i_iPv2:= 		, 
	i_xHold:= 		, 
	i_rKp:= 		10,//rGanhoPorporcionaKp, 
	i_rTn:= 		0.8,//rGanhoIntegralKi, 
	i_rTv:= 		2,//rGanhoDerivativoKd, 
	i_rTd:= 		, 
	i_xManMode:= 	, 
	i_rManVal:= 	, 
	i_stPid:= 		, 
	i_xErrRst:= 	, 
	q_xEn=> 		, 
	q_xBusy=> 		, 
	q_rPidOput=> 	rPidSaidaVent01, 
	q_xMinLimActv=> , 
	q_xMaxLimActv=> , 
	q_xARWActv=> 	, 
	q_xErr=> 		, 
	q_uiErrId=> 	, 
	q_sErrMsge=> 	, 
	q_sFBstat=> 	);

//iAnaFreqRefVentilador01:=REAL_TO_INT (rPidSaidaVent01*17.0);

iAnaFreqRefVentilador01:=iRefFreqVent01Pid;
//------------------------------------------------------------------------\\
IF xOperacaoManual THEN
	PassoVentilador01:=0;
	PassoPauseVentilador01:=0;
	PassoAlmVentilador01:=0;
	xLigaVentilador01:=FALSE;
	xDesligaVentilador01:=FALSE;
	xDesligaFimVentilador01:=FALSE;
	xFimVentilacao01:=FALSE;
	xPrimeiroEstagioVentilador01:=FALSE;
	xVelocidadeVentilador01Ok:=FALSE;
	xFechaVenezVentPassV01:=FALSE;
	xLigaMotorVentilador01:=FALSE;
END_IF


IF iFrequenciaMotorVentilador01>=iVelocidade01Ventilador01 AND xPrimeiroEstagioVentilador01 THEN
	xVelocidadeVentilador01Ok:=TRUE;
END_IF

IF NOT xPrimeiroEstagioVentilador01 THEN
	xVelocidadeVentilador01Ok:=FALSE;
END_IF
