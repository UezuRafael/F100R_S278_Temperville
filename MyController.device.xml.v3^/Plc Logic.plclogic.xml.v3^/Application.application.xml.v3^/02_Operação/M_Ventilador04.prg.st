__METADATA__
{
  "v3Meta": {
    "objectGuid": "1d14d559-4c5e-42c3-a5ef-df9afaf501c7",
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
PROGRAM M_Ventilador04
VAR
	PassoVentilador04: INT;
	PassoPauseVentilador04: INT;
	PassoAlmVentilador04: INT;
	PulsoLigaVentilador04: PulsoPositivo;
	/// Bloco Movimenta Guilhotina do Resfriador
	McMoveVelocityVentilador04: GIPLC.MC_MoveVelocity;
	/// Bloco Desliga Motor Guilhotina do Resfriador
	McStopVentilador04: GIPLC.MC_Stop;
	xExecutaMovVentilador04: BOOL;
	xExecutaStopVentilador04: BOOL;
	xStopVentilador04Done: BOOL;
	iVelocidadeVentilador04: INT;
	xLigaVentilador04: BOOL;
	xFimVentilacao04: BOOL;
	xLigaTempoVentilador04: BOOL;
	xPulsoLigaVentilador04: BOOL;
	xLigaVent04SairForno: BOOL;
	xTempoMvVent04In: BOOL;
	xTempoMvVent04Q: BOOL;
	TempoMvVent04: ton;
END_VAR
__IMPLEMENTATION__

IF xEspessuraVidroFino THEN
	IF (iTempoAquecFornoRestante<=iTempoLigaVentilador04VidroFino) AND (iTempoAquecFornoRestante>0) AND xFornoEmCiclo THEN
		xLigaTempoVentilador04:=TRUE;
	ELSE
		xLigaTempoVentilador04:=FALSE;
	END_IF
ELSE
	IF (iTempoAquecFornoRestante<=iTempoLigaVentilador04VidroGros) AND (iTempoAquecFornoRestante>0) AND xFornoEmCiclo THEN
		xLigaTempoVentilador04:=TRUE;
	ELSE
		xLigaTempoVentilador04:=FALSE;
	END_IF
END_IF

xLigaVent04SairForno:=xSairForno AND xFornoEmCiclo AND xFornoComCarga;

PulsoLigaVentilador04(Entrada:= xLigaTempoVentilador04 OR xLigaVent04SairForno OR xLigaVent04FimForno, SaidaPulsoPo=>xPulsoLigaVentilador04 );
IF xPulsoLigaVentilador04 THEN
	xLigaVentilador04:=TRUE;
END_IF


TempoMvVent04(IN:= xTempoMvVent04In, PT:=T#2S , Q=> xTempoMvVent04Q, ET=> );

// SEQUENCIA DE FUNCIONAMENTO


CASE PassoVentilador04 OF
		
		0:	IF xLigaVentilador04 THEN
				IF xResfriadorCarregado THEN
					PassoVentilador04:=2;
				ELSE
					PassoVentilador04:=10;
				END_IF
			END_IF
			
		2: IF NOT xResfriadorCarregado THEN
				PassoVentilador04:=10;
		   END_IF 	
			
		10:	xLigaVentilador04:=FALSE;
			xDesligaVentilador04:=FALSE;
			xDesligaFimVentilador04:=FALSE;
			xSegundoEstagioVentilador04:=FALSE;
			xTerceiroEstagioVentilador04:=FALSE;
			PassoVentilador04:=15;
			
		15:	xPrimeiroEstagioVentilador04:=TRUE;
			PassoVentilador04:=16;
		
		16:	IF  xSemEnergia THEN
				PassoVentilador04:=80;
			ELSIF xPause THEN
				PassoPauseVentilador04:=16;
				PassoVentilador04:=300;
			ELSIF xAlarmeMotorVentilador04 THEN
				PassoAlmVentilador04:=16;
				PassoVentilador04:=400;
			ELSE
				PassoVentilador04:=20;
			END_IF
			
		20:	iVelocidadeVentilador04:=iVelocidade01Ventilador04;
			PassoVentilador04:=21;

		21:	xExecutaMovVentilador04:=TRUE;
			PassoVentilador04:=22;
			
		22:	IF McMoveVelocityVentilador04.Busy THEN
				PassoVentilador04:=29;
			ELSE
				PassoVentilador04:=23;
			END_IF
			
		23:xExecutaMovVentilador04:=FALSE;
			xTempoMvVent04In:=TRUE;
			IF	xTempoMvVent04Q THEN
				PassoVentilador04:=24;
			END_IF
				
		24:	xTempoMvVent04In:=FALSE;
			xExecutaStopVentilador04:=TRUE;
			PassoVentilador04:=25;
	
		25:	xExecutaStopVentilador04:=FALSE;
			PassoVentilador04:=16;
			
		29:	xExecutaMovVentilador04:=FALSE;
			PassoVentilador04:=30;
		// Fica Parado no passo 30 aguardando o inicio do segundo Estágio	
		30:	IF iVelocidadeVentilador04<>iVelocidade01Ventilador04 THEN
				PassoVentilador04:=20;
			END_IF
			IF xSegundoEstagioVentilador04 THEN //<-TASK/EstagiosResfriador
				PassoVentilador04:=40;
			END_IF
			IF xDesligaVentilador04 THEN
				PassoVentilador04:=41;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador04:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador04:=20;
				PassoVentilador04:=300;
			END_IF
			IF xAlarmeMotorVentilador04 THEN
				PassoAlmVentilador04:=20;
				PassoVentilador04:=400;
			END_IF
		
		40:	xSegundoEstagioVentilador04:=FALSE;
			xDesligaVentilador04:=FALSE; // Zera memoria desliga vent caso esteja em 1
			PassoVentilador04:=41;
		
		41:	xPrimeiroEstagioVentilador04:=FALSE;
			iVelocidadeVentilador04:=iVelocidade02Ventilador04;
			PassoVentilador04:=42;
			
		42:	xExecutaMovVentilador04:=TRUE;
			PassoVentilador04:=43;
			
		43:	IF McMoveVelocityVentilador04.Busy THEN
				PassoVentilador04:=44;
			ELSE
				PassoVentilador04:=45;
			END_IF
			
		45:xExecutaMovVentilador04:=FALSE;
			xTempoMvVent04In:=TRUE;
			IF	xTempoMvVent04Q THEN
				PassoVentilador04:=46;
			END_IF
				
		46:	xTempoMvVent04In:=FALSE;
			xExecutaStopVentilador04:=TRUE;
			PassoVentilador04:=47;
	
		47:	xExecutaStopVentilador04:=FALSE;
			PassoVentilador04:=41;		
			
		44:	xExecutaMovVentilador04:=FALSE;
			PassoVentilador04:=50;
		// Fica Parado no Passo 50 aguardando o inicio do Terceiro Estágio	
		50:	IF iVelocidadeVentilador04<>iVelocidade02Ventilador04 THEN
				PassoVentilador04:=41;
			END_IF
			IF xTerceiroEstagioVentilador04 THEN //<-TASK/EstagiosResfriador
				PassoVentilador04:=51;
			END_IF
			IF xDesligaVentilador04 THEN
				PassoVentilador04:=52;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador04:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador04:=41;
				PassoVentilador04:=300;
			END_IF
			IF xAlarmeMotorVentilador04 THEN
				PassoAlmVentilador04:=41;
				PassoVentilador04:=400;
			END_IF

		51:	xTerceiroEstagioVentilador04:=FALSE;
			xDesligaVentilador04:=FALSE; // Zera memoria desliga vent caso esteja em 1
			PassoVentilador04:=52;
		
		52:	xSegundoEstagioVentilador04:=FALSE;
			iVelocidadeVentilador04:=iVelocidade03Ventilador04;
			PassoVentilador04:=53;
			
		53:	xExecutaMovVentilador04:=TRUE;
			PassoVentilador04:=54;
			
		54:	IF McMoveVelocityVentilador04.Busy THEN
				PassoVentilador04:=55;
			ELSE
				PassoVentilador04:=56;
			END_IF
			
		56:xExecutaMovVentilador04:=FALSE;
			xTempoMvVent04In:=TRUE;
			IF	xTempoMvVent04Q THEN
				PassoVentilador04:=57;
			END_IF
				
		57:	xTempoMvVent04In:=FALSE;
			xExecutaStopVentilador04:=TRUE;
			PassoVentilador04:=58;
	
		58:	xExecutaStopVentilador04:=FALSE;
			PassoVentilador04:=52;			
			

		55:	xExecutaMovVentilador04:=FALSE;
			PassoVentilador04:=59;

			// Fica Parado no Passo 59 Aguardando
		59:	IF iVelocidadeVentilador04<>iVelocidade03Ventilador04 THEN
				PassoVentilador04:=52;
			END_IF
			IF xLigaVentilador04 THEN
				PassoVentilador04:=10;
			END_IF
			IF xDesligaVentilador04 AND NOT xFornoEmEspera THEN
				PassoVentilador04:=60;
			END_IF
			IF xDesligaVentilador04 AND xFornoEmEspera THEN
				PassoVentilador04:=80;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador04:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador04:=52;
				PassoVentilador04:=300;
			END_IF
			IF xAlarmeMotorVentilador04 THEN
				PassoAlmVentilador04:=52;
				PassoVentilador04:=400;
			END_IF

			
		60:	xDesligaVentilador04:=FALSE;
			PassoVentilador04:=61;
			
		61:	iVelocidadeVentilador04:=iVelocidadeStbVentilador04;
			PassoVentilador04:=62;
			
		62:	xExecutaMovVentilador04:=TRUE;
			PassoVentilador04:=63;
			
		63:	IF McMoveVelocityVentilador04.Busy THEN
				PassoVentilador04:=70;
			ELSE
				PassoVentilador04:=64;
			END_IF
			
		64:xExecutaMovVentilador04:=FALSE;
			xTempoMvVent04In:=TRUE;
			IF	xTempoMvVent04Q THEN
				PassoVentilador04:=65;
			END_IF
				
		65:	xTempoMvVent04In:=FALSE;
			xExecutaStopVentilador04:=TRUE;
			PassoVentilador04:=66;
	
		66:	xExecutaStopVentilador04:=FALSE;
			PassoVentilador04:=60;			


		
		70:	xExecutaMovVentilador04:=FALSE;
			PassoVentilador04:=71;
			
		71:	IF iVelocidadeVentilador04<>iVelocidadeStbVentilador04 THEN
				PassoVentilador04:=61;
			END_IF
			IF xLigaVentilador04 THEN
				PassoVentilador04:=10;
			END_IF
			IF xDesligaFimVentilador04 THEN
				PassoVentilador04:=80;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador04:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador04:=60;
				PassoVentilador04:=300;
			END_IF
			IF xAlarmeMotorVentilador04 THEN
				PassoAlmVentilador04:=60;
				PassoVentilador04:=400;
			END_IF
			
		80:	xPrimeiroEstagioVentilador04:=FALSE;
			xDesligaVentilador04:=FALSE;
			xDesligaFimVentilador04:=FALSE;
			xExecutaStopVentilador04:=TRUE;
			PassoVentilador04:=81;
			
		81:	IF	xStopVentilador04Done THEN
				PassoVentilador04:=90;
			END_IF	
			
		90:	xExecutaStopVentilador04:=FALSE;
			PassoVentilador04:=91;
			
		91:PassoVentilador04:=0;
	

		// Emergência Pausa/Reinicio
		300:xExecutaStopVentilador04:=TRUE;
			PassoVentilador04:=301;
		
		301:xExecutaMovVentilador04:=FALSE;
			xExecutaStopVentilador04:=FALSE;
			PassoVentilador04:=302;
	
		302:IF xRestart THEN
				PassoVentilador04:=303;
			END_IF
			
		303:IF xInvVentilador04Habilitado THEN
				PassoVentilador04:=PassoPauseVentilador04;
			END_IF

		// Alarme Motor Parada/Reinicio
		400:xExecutaStopVentilador04:=TRUE;
			PassoVentilador04:=401;

		401:xExecutaStopVentilador04:=FALSE;
			xExecutaMovVentilador04:=FALSE;
			PassoVentilador04:=402;
	
		402:IF xRestart AND xInvVentilador04Habilitado THEN
				PassoVentilador04:=PassoAlmVentilador04;
			END_IF	
		
END_CASE

// BLOCOS DE EXECUÇÃO CANOPEN
//McMoveVelocityVentilador04(Execute:= xExecutaMovVentilador04,	Velocity:=iVelocidadeVentilador04,	Axis:= Ventilador_04,	InVelocity=> ,	Busy=> ,CommandAborted=> , Error=> );
//McStopVentilador04(Execute:=xExecutaStopVentilador04,	Axis:= Ventilador_04, Done=>xStopVentilador04Done ,Busy=> , Error=> );

IF xOperacaoManual THEN
	PassoVentilador04:=0;
	PassoPauseVentilador04:=0;
	PassoAlmVentilador04:=0;
	xExecutaMovVentilador04:=FALSE;
	xExecutaStopVentilador04:=FALSE;
	xLigaVentilador04:=FALSE;
	xDesligaVentilador04:=FALSE;
	xDesligaFimVentilador04:=FALSE;
	xFimVentilacao04:=FALSE;
	xPrimeiroEstagioVentilador04:=FALSE;
	xVelocidadeVentilador04Ok:=FALSE;
	xTempoMvVent04In:=FALSE;
END_IF

//IF  xEmergencia THEN
//	xExecutaStopVentilador04:=TRUE;
//	xExecutaMovVentilador04:=FALSE;
//ELSE
//	xExecutaStopVentilador04:=FALSE;	
//END_IF

IF iFrequenciaMotorVentilador04>=iVelocidade01Ventilador04 AND xPrimeiroEstagioVentilador04 THEN
	xVelocidadeVentilador04Ok:=TRUE;
END_IF

IF NOT xPrimeiroEstagioVentilador04 THEN
	xVelocidadeVentilador04Ok:=FALSE;
END_IF

