__METADATA__
{
  "v3Meta": {
    "objectGuid": "74117167-4d5e-4cec-b320-f5e365f493b7",
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
PROGRAM M_Ventilador02
VAR
	PassoVentilador02: INT;
	PassoPauseVentilador02: INT;
	PassoAlmVentilador02: INT;
	PulsoLigaVentilador02: PulsoPositivo;
	/// Bloco Movimenta Guilhotina do Resfriador
	McMoveVelocityVentilador02: GIPLC.MC_MoveVelocity;
	/// Bloco Desliga Motor Guilhotina do Resfriador
	McStopVentilador02: GIPLC.MC_Stop;
	xExecutaMovVentilador02: BOOL;
	xExecutaStopVentilador02: BOOL;
	xStopVentilador02Done: BOOL;
	iVelocidadeVentilador02: INT;
	xLigaVentilador02: BOOL;
	xFimVentilacao02: BOOL;
	xLigaTempoVentilador02: BOOL;
	xPulsoLigaVentilador02: BOOL;
	xLigaVent02SairForno: BOOL;
	xTempoMvVent02In: BOOL;
	xTempoMvVent02Q: BOOL;
	TempoMvVent02: ton;
END_VAR
__IMPLEMENTATION__

IF xEspessuraVidroFino THEN
	IF (iTempoAquecFornoRestante<=iTempoLigaVentilador02VidroFino) AND (iTempoAquecFornoRestante>0) AND xFornoEmCiclo THEN
		xLigaTempoVentilador02:=TRUE;
	ELSE
		xLigaTempoVentilador02:=FALSE;
	END_IF
ELSE
	IF (iTempoAquecFornoRestante<=iTempoLigaVentilador02VidroGros) AND (iTempoAquecFornoRestante>0) AND xFornoEmCiclo THEN
		xLigaTempoVentilador02:=TRUE;
	ELSE
		xLigaTempoVentilador02:=FALSE;
	END_IF
END_IF

xLigaVent02SairForno:=xSairForno AND xFornoEmCiclo AND xFornoComCarga;

PulsoLigaVentilador02(Entrada:= xLigaTempoVentilador02 OR xLigaVent02SairForno OR xLigaVent02FimForno, SaidaPulsoPo=>xPulsoLigaVentilador02 );
IF xPulsoLigaVentilador02 THEN
	xLigaVentilador02:=TRUE;
	xFechaVenezVentPassV02:=TRUE;//-> TASK/T_VenezianaVentInfPass
END_IF

(*IF xDesligaVentilador02 THEN
	xFimVentilacao02:=TRUE;
	xDesligaVentilador02:=FALSE;
END_IF*)

TempoMvVent02(IN:= xTempoMvVent02In, PT:=T#2S , Q=> xTempoMvVent02Q, ET=> );

// SEQUENCIA DE FUNCIONAMENTO


iVelocidade02Ventilador02:=iVelocidade01Ventilador02;
iVelocidade03Ventilador02:=iVelocidade01Ventilador02;


CASE PassoVentilador02 OF
		
		0:	IF xLigaVentilador02 THEN
				PassoVentilador02:=10;
			END_IF
			
		10:	xLigaVentilador02:=FALSE;
			xDesligaFimVentilador02:=FALSE;
			xPrimeiroEstagioVentilador02:=TRUE;
			xSegundoEstagioVentilador02:=FALSE;
			xTerceiroEstagioVentilador02:=FALSE;
			PassoVentilador02:=15;
			
		15:	PassoVentilador02:=16;
		
		16:	IF  xSemEnergia THEN
				PassoVentilador02:=80;
			ELSIF xPause THEN
				PassoPauseVentilador02:=16;
				PassoVentilador02:=300;
			ELSIF xAlarmeMotorVentilador02 THEN
				PassoAlmVentilador02:=16;
				PassoVentilador02:=400;
			ELSE
				PassoVentilador02:=20;
			END_IF
			
			
		20:	iVelocidadeVentilador02:=iVelocidade01Ventilador02;
			PassoVentilador02:=21;

		21:	xExecutaMovVentilador02:=TRUE;
			PassoVentilador02:=22;
			
		22:	IF McMoveVelocityVentilador02.Busy THEN
				PassoVentilador02:=29;
			ELSE
				PassoVentilador02:=23;
			END_IF
			
		23:xExecutaMovVentilador02:=FALSE;
			xTempoMvVent02In:=TRUE;
			IF	xTempoMvVent02Q THEN
				PassoVentilador02:=24;
			END_IF
				
		24:	xTempoMvVent02In:=FALSE;
			xExecutaStopVentilador02:=TRUE;
			PassoVentilador02:=25;
	
		25:	xExecutaStopVentilador02:=FALSE;
			PassoVentilador02:=16;
			
		29:	xExecutaMovVentilador02:=FALSE;
			PassoVentilador02:=59;//30; (* Alterado Ventilador tempera passagem*)
		// Fica Parado no passo 30 aguardando o inicio do segundo Estágio	
		30:	IF iVelocidadeVentilador02<>iVelocidade01Ventilador02 THEN
				PassoVentilador02:=20;
			END_IF
			IF xSegundoEstagioVentilador02 THEN //<-TASK/EstagiosResfriador
				PassoVentilador02:=40;
			END_IF
			IF xDesligaVentilador02 THEN
				PassoVentilador02:=41;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador02:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador02:=20;
				PassoVentilador02:=300;
			END_IF
			IF xAlarmeMotorVentilador02 THEN
				PassoAlmVentilador02:=20;
				PassoVentilador02:=400;
			END_IF
		
		40:	xSegundoEstagioVentilador02:=FALSE;
			xDesligaVentilador02:=FALSE; // Zera memoria desliga vent caso esteja em 1
			PassoVentilador02:=41;
		
		41:	xPrimeiroEstagioVentilador02:=FALSE;
			iVelocidadeVentilador02:=iVelocidade02Ventilador02;
			PassoVentilador02:=42;
			
		42:	xExecutaMovVentilador02:=TRUE;
			PassoVentilador02:=43;
			
		43:	IF McMoveVelocityVentilador02.Busy THEN
				PassoVentilador02:=44;
			END_IF
			
		44:	xExecutaMovVentilador02:=FALSE;
			PassoVentilador02:=50;
		// Fica Parado no Passo 50 aguardando o inicio do Terceiro Estágio	
		50:	IF iVelocidadeVentilador02<>iVelocidade02Ventilador02 THEN
				PassoVentilador02:=41;
			END_IF
			IF xTerceiroEstagioVentilador02 THEN //<-TASK/EstagiosResfriador
				PassoVentilador02:=51;
			END_IF
			IF xDesligaVentilador02 THEN
				PassoVentilador02:=52;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador02:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador02:=41;
				PassoVentilador02:=300;
			END_IF
			IF xAlarmeMotorVentilador02 THEN
				PassoAlmVentilador02:=41;
				PassoVentilador02:=400;
			END_IF

		51:	xTerceiroEstagioVentilador02:=FALSE;
			xDesligaVentilador02:=FALSE; // Zera memoria desliga vent caso esteja em 1
			PassoVentilador02:=52;
		
		52:	xSegundoEstagioVentilador02:=FALSE;
			iVelocidadeVentilador02:=iVelocidade03Ventilador02;
			PassoVentilador02:=53;
			
		53:	xExecutaMovVentilador02:=TRUE;
			PassoVentilador02:=54;
			
		54:	IF McMoveVelocityVentilador02.Busy THEN
				PassoVentilador02:=55;
			END_IF
			
		55:	xExecutaMovVentilador02:=FALSE;
			PassoVentilador02:=59;

			// Fica Parado no Passo 59 Aguardando
		59:	IF iVelocidadeVentilador02<>iVelocidade03Ventilador02 THEN
				PassoVentilador02:=20;//52; (* Alterador Tempera de passagem *)
			END_IF
			IF xLigaVentilador02 THEN
				PassoVentilador02:=10;
			END_IF
			IF xDesligaVentilador02 AND NOT xFornoEmEspera THEN
				PassoVentilador02:=60;
			END_IF
			IF xDesligaVentilador02 AND xFornoEmEspera THEN
				PassoVentilador02:=80;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador02:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador02:=20;//52; (* Alterador Tempera de passagem *)
				PassoVentilador02:=300;
			END_IF
			IF xAlarmeMotorVentilador02 THEN
				PassoAlmVentilador02:=20;//52; (* Alterador Tempera de passagem *)
				PassoVentilador02:=400;
			END_IF

			
		60:	xDesligaVentilador02:=FALSE;
			PassoVentilador02:=61;
			
		61:	iVelocidadeVentilador02:=iVelocidadeStbVent02Pass;//iVelocidadeStbVentilador02;
			PassoVentilador02:=62;
			
		62:	xExecutaMovVentilador02:=TRUE;
			PassoVentilador02:=63;
			
		63:	IF McMoveVelocityVentilador02.Busy THEN
				PassoVentilador02:=70;
			ELSE
				PassoVentilador02:=64;
			END_IF
			
		64:xExecutaMovVentilador02:=FALSE;
			xTempoMvVent02In:=TRUE;
			IF	xTempoMvVent02Q THEN
				PassoVentilador02:=65;
			END_IF
				
		65:	xTempoMvVent02In:=FALSE;
			xExecutaStopVentilador02:=TRUE;
			PassoVentilador02:=66;
	
		66:	xExecutaStopVentilador02:=FALSE;
			PassoVentilador02:=60;			


		
		70:	xExecutaMovVentilador02:=FALSE;
			PassoVentilador02:=71;
			
		71:	IF iVelocidadeVentilador02<>iVelocidadeStbVent02Pass(*iVelocidadeStbVentilador02*) THEN
				PassoVentilador02:=61;
			END_IF
			IF xLigaVentilador02 THEN
				PassoVentilador02:=10;
			END_IF
			IF xDesligaFimVentilador02 THEN
				PassoVentilador02:=80;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador02:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador02:=60;
				PassoVentilador02:=300;
			END_IF
			IF xAlarmeMotorVentilador02 THEN
				PassoAlmVentilador02:=60;
				PassoVentilador02:=400;
			END_IF
			
		80:	xPrimeiroEstagioVentilador02:=FALSE;
			xDesligaVentilador02:=FALSE;
			xDesligaFimVentilador02:=FALSE;
			xExecutaStopVentilador02:=TRUE;
			PassoVentilador02:=81;
			
		81:	IF	xStopVentilador02Done THEN
				PassoVentilador02:=90;
			END_IF	
			
		90:	xExecutaStopVentilador02:=FALSE;
			PassoVentilador02:=91;
			
		91:PassoVentilador02:=0;
	

		// Emergência Pausa/Reinicio
		300:xExecutaStopVentilador02:=TRUE;
			PassoVentilador02:=301;
		
		301:xExecutaMovVentilador02:=FALSE;
			xExecutaStopVentilador02:=FALSE;
			PassoVentilador02:=302;
	
		302:IF xRestart THEN
				PassoVentilador02:=303;
			END_IF
			
		303:IF xInvVentilador02Habilitado THEN
				PassoVentilador02:=PassoPauseVentilador02;
			END_IF

		// Alarme Motor Parada/Reinicio
		400:xExecutaStopVentilador02:=TRUE;
			PassoVentilador02:=401;

		401:xExecutaStopVentilador02:=FALSE;
			xExecutaMovVentilador02:=FALSE;
			PassoVentilador02:=402;
	
		402:IF xRestart AND xInvVentilador02Habilitado THEN
				PassoVentilador02:=PassoAlmVentilador02;
			END_IF	
		
END_CASE

// BLOCOS DE EXECUÇÃO CANOPEN
//McMoveVelocityVentilador02(Execute:= xExecutaMovVentilador02,	Velocity:=iVelocidadeVentilador02,	Axis:= Ventilador_02,	InVelocity=> ,	Busy=> ,CommandAborted=> , Error=> );
//McStopVentilador02(Execute:=xExecutaStopVentilador02,	Axis:= Ventilador_02, Done=>xStopVentilador02Done ,Busy=> , Error=> );

IF xOperacaoManual THEN
	PassoVentilador02:=0;
	PassoPauseVentilador02:=0;
	PassoAlmVentilador02:=0;
	xExecutaMovVentilador02:=FALSE;
	xExecutaStopVentilador02:=FALSE;
	xLigaVentilador02:=FALSE;
	xDesligaVentilador02:=FALSE;
	xDesligaFimVentilador02:=FALSE;
	xFimVentilacao02:=FALSE;
	xPrimeiroEstagioVentilador02:=FALSE;
	xVelocidadeVentilador02Ok:=FALSE;
	xFechaVenezVentPassV02:=FALSE;
END_IF

IF  xEmergencia THEN
	xExecutaStopVentilador02:=TRUE;
	xExecutaMovVentilador02:=FALSE;
ELSE
	xExecutaStopVentilador02:=FALSE;	
END_IF

IF iFrequenciaMotorVentilador02>=iVelocidade01Ventilador02 AND xPrimeiroEstagioVentilador02 THEN
	xVelocidadeVentilador02Ok:=TRUE;
END_IF

IF NOT xPrimeiroEstagioVentilador02 THEN
	xVelocidadeVentilador02Ok:=FALSE;
END_IF
