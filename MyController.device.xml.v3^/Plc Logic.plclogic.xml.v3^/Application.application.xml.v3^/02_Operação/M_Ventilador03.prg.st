__METADATA__
{
  "v3Meta": {
    "objectGuid": "dc39d175-f95f-4f70-b17f-3caa5bba6c94",
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
PROGRAM M_Ventilador03
VAR
	PassoVentilador03: INT;
	PassoPauseVentilador03: INT;
	PassoAlmVentilador03: INT;
	PulsoLigaVentilador03: PulsoPositivo;
	iVelocidadeVentilador03: INT;
	xLigaVentilador03: BOOL;
	xFimVentilacao03: BOOL;
	xLigaTempoVentilador03: BOOL;
	xPulsoLigaVentilador03: BOOL;
	xLigaVent03SairForno: BOOL;
	xTempoMvVent03In: BOOL;
	xTempoMvVent03Q: BOOL;
	TempoMvVent03: ton;
	xLigaMotorVentilador03: BOOL;
	iVelocidadeVentilador03HZ: INT;
	dVelocidadeVentilador03HZ: DINT;
	rVelocidadeVentilador03HZ:REAL;
	rVelocidadeVentilador03 :REAL;
END_VAR
__IMPLEMENTATION__

IF xEspessuraVidroFino THEN
	IF (iTempoAquecFornoRestante<=iTempoLigaVentilador03VidroFino) AND (iTempoAquecFornoRestante>0) AND xFornoEmCiclo THEN
		xLigaTempoVentilador03:=TRUE;
	ELSE
		xLigaTempoVentilador03:=FALSE;
	END_IF
ELSE
	IF (iTempoAquecFornoRestante<=iTempoLigaVentilador03VidroGros) AND (iTempoAquecFornoRestante>0) AND xFornoEmCiclo THEN
		xLigaTempoVentilador03:=TRUE;
	ELSE
		xLigaTempoVentilador03:=FALSE;
	END_IF
END_IF

xLigaVent03SairForno:=xSairForno AND xFornoEmCiclo AND xFornoComCarga;

PulsoLigaVentilador03(Entrada:= xLigaTempoVentilador03 OR xLigaVent03SairForno OR xLigaVent03FimForno, SaidaPulsoPo=>xPulsoLigaVentilador03 );
IF xPulsoLigaVentilador03 THEN
	xLigaVentilador03:=TRUE;
	xReajustaAlturaDuctosSup02:=TRUE;
	xReajustaAlturaDuctosInf02:=TRUE;
END_IF

TempoMvVent03(IN:= xTempoMvVent03In, PT:=T#2S , Q=> xTempoMvVent03Q, ET=> );

// SEQUENCIA DE FUNCIONAMENTO



CASE PassoVentilador03 OF
		
		0:	IF xLigaVentilador03 THEN
				IF xResfriadorCarregado THEN
					PassoVentilador03:=2;
				ELSE
					PassoVentilador03:=10;
				END_IF
			END_IF
			
		2: IF NOT xResfriadorCarregado THEN
				PassoVentilador03:=10;
		   END_IF 	
			
		10:	xLigaVentilador03:=FALSE;
			xDesligaVentilador03:=FALSE;
			xDesligaFimVentilador03:=FALSE;
			xSegundoEstagioVentilador03:=FALSE;
			xTerceiroEstagioVentilador03:=FALSE;
			PassoVentilador03:=15;
			
		15:	xPrimeiroEstagioVentilador03:=TRUE;
			PassoVentilador03:=16;
		
		16:	IF  xSemEnergia THEN
				PassoVentilador03:=80;
			ELSIF xPause THEN
				PassoPauseVentilador03:=16;
				PassoVentilador03:=300;
			ELSIF xAlarmeMotorVentilador03 THEN
				PassoAlmVentilador03:=16;
				PassoVentilador03:=400;
			ELSE
				PassoVentilador03:=20;
			END_IF
			
		20:	iVelocidadeVentilador03:=REAL_TO_INT(iVelocidade01Ventilador03);
			PassoVentilador03:=21;

		21:	xLigaMotorVentilador03:=TRUE;
			PassoVentilador03:=22;
			
		22:	PassoVentilador03:=29;
			
		29:	PassoVentilador03:=30;
			
		// Fica Parado no passo 30 aguardando o inicio do segundo Estágio	
		30:	IF iVelocidadeVentilador03<>REAL_TO_INT(iVelocidade01Ventilador03) THEN
				PassoVentilador03:=20;
			END_IF
			IF xSegundoEstagioVentilador03 THEN //<-TASK/EstagiosResfriador
				PassoVentilador03:=40;
			END_IF
			IF xLigaVentilador03 THEN
				PassoVentilador03:=10;
			END_IF
			IF xDesligaVentilador03 AND NOT xPrimeiroEstagioVentilador03 THEN
				PassoVentilador03:=41;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador03:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador03:=20;
				PassoVentilador03:=300;
			END_IF
			IF xAlarmeMotorVentilador03 THEN
				PassoAlmVentilador03:=20;
				PassoVentilador03:=400;
			END_IF
		
		40:	xSegundoEstagioVentilador03:=FALSE;
			xDesligaVentilador03:=FALSE; // Zera memoria desliga vent caso esteja em 1
			PassoVentilador03:=42;
		
		41:	xLigaMotorVentilador03:=TRUE;
			PassoVentilador03:=42;

		42:	xPrimeiroEstagioVentilador03:=FALSE;
			iVelocidadeVentilador03:=REAL_TO_INT(iVelocidade02Ventilador03);
			PassoVentilador03:=43;
			
		43:	PassoVentilador03:=44;
			
		44:	PassoVentilador03:=50;
		// Fica Parado no Passo 50 aguardando o inicio do Terceiro Estágio	
		50:	IF iVelocidadeVentilador03<>REAL_TO_INT(iVelocidade02Ventilador03) THEN
				PassoVentilador03:=41;
			END_IF
			IF xTerceiroEstagioVentilador03 THEN //<-TASK/EstagiosResfriador
				PassoVentilador03:=51;
			END_IF
			IF xLigaVentilador03 THEN
				PassoVentilador03:=10;
			END_IF
			IF xDesligaVentilador03 THEN
				PassoVentilador03:=52;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador03:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador03:=41;
				PassoVentilador03:=300;
			END_IF
			IF xAlarmeMotorVentilador03 THEN
				PassoAlmVentilador03:=41;
				PassoVentilador03:=400;
			END_IF

		51:	xTerceiroEstagioVentilador03:=FALSE;
			xDesligaVentilador03:=FALSE; // Zera memoria desliga vent caso esteja em 1
			PassoVentilador03:=53;
		
		52:	xLigaMotorVentilador03:=TRUE;
			PassoVentilador03:=53;

		53:	xSegundoEstagioVentilador03:=FALSE;
			iVelocidadeVentilador03:=REAL_TO_INT(iVelocidade03Ventilador03);
			PassoVentilador03:=54;
			
		54:	PassoVentilador03:=55;
			
		55:	PassoVentilador03:=59;

			// Fica Parado no Passo 59 Aguardando
		59:	IF iVelocidadeVentilador03<>REAL_TO_INT(iVelocidade03Ventilador03) THEN
				PassoVentilador03:=52;
			END_IF
			IF xLigaVentilador03 THEN
				PassoVentilador03:=10;
			END_IF
			IF xDesligaVentilador03 AND NOT xFornoEmEspera THEN
				PassoVentilador03:=60;
			END_IF
			IF xDesligaVentilador03 AND xFornoEmEspera THEN
				PassoVentilador03:=80;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador03:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador03:=52;
				PassoVentilador03:=300;
			END_IF
			IF xAlarmeMotorVentilador03 THEN
				PassoAlmVentilador03:=52;
				PassoVentilador03:=400;
			END_IF
			
		60:	xDesligaVentilador03:=FALSE;
			PassoVentilador03:=62;
			
		61:	IF iVelocidadeStbVentilador03<>0 THEN
				PassoVentilador03:=62;
			ELSE
				PassoVentilador03:=63;
			END_IF
			
		62:	xLigaMotorVentilador03:=TRUE;
			PassoVentilador03:=70;
			
		63:	xLigaMotorVentilador03:=FALSE;
			PassoVentilador03:=70;
			
		70:	iVelocidadeVentilador03:=iVelocidadeStbVentilador03;
			PassoVentilador03:=71;
			
		71:	IF iVelocidadeVentilador03<>iVelocidadeStbVentilador03 THEN
				PassoVentilador03:=61;
			END_IF
			IF xLigaVentilador03 THEN
				PassoVentilador03:=10;
			END_IF
			IF xDesligaFimVentilador03 THEN
				PassoVentilador03:=80;
			END_IF
			IF  xSemEnergia THEN
				PassoVentilador03:=80;
			END_IF
			IF xPause THEN
				PassoPauseVentilador03:=61;
				PassoVentilador03:=300;
			END_IF
			IF xAlarmeMotorVentilador03 THEN
				PassoAlmVentilador03:=61;
				PassoVentilador03:=400;
			END_IF
			
		80:	xPrimeiroEstagioVentilador03:=FALSE;
			xDesligaVentilador03:=FALSE;
			xDesligaFimVentilador03:=FALSE;
			PassoVentilador03:=81;
			
		81:	xLigaMotorVentilador03:=FALSE;
			PassoVentilador03:=90;
			
		90: PassoVentilador03:=91;
			
		91:PassoVentilador03:=0;
	

		// Emergência Pausa/Reinicio
		300:xLigaMotorVentilador03:=FALSE;
			PassoVentilador03:=301;
		
		301:PassoVentilador03:=302;
	
		302:IF xRestart THEN
				PassoVentilador03:=303;
			END_IF
			
		303:PassoVentilador03:=PassoPauseVentilador03;

		// Alarme Motor Parada/Reinicio
		400:xLigaMotorVentilador03:=FALSE;
			PassoVentilador03:=401;

		401:PassoVentilador03:=402;
	
		402:IF xRestart AND iCanOpenInverVentila03StateOk THEN
				PassoVentilador03:=PassoAlmVentilador03;
			END_IF	
		
END_CASE
// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorVentilador03:=xLigaMotorVentilador03;

InversorVentila03.i_xAvanco:=xMotorVentilador03;

// Velocidade
rVelocidadeVentilador03:=INT_TO_REAL(iVelocidadeVentilador03);
rVelocidadeVentilador03HZ:=((rVelocidadeVentilador03*600)/1787);
dVelocidadeVentilador03HZ:=REAL_TO_DINT(rVelocidadeVentilador03HZ);
iVelocidadeVentilador03HZ:=DINT_TO_INT(dVelocidadeVentilador03HZ);

InversorVentila03.i_iFreqRef:=iVelocidadeVentilador03HZ;

//InversorVentila03.i_iFreqRef:=iVelocidadeVentilador03;
//------------------------------------------------------------------------\\
IF xOperacaoManual THEN
	PassoVentilador03:=0;
	PassoPauseVentilador03:=0;
	PassoAlmVentilador03:=0;
	xLigaVentilador03:=FALSE;
	xDesligaVentilador03:=FALSE;
	xDesligaFimVentilador03:=FALSE;
	xFimVentilacao03:=FALSE;
	xPrimeiroEstagioVentilador03:=FALSE;
	xVelocidadeVentilador03Ok:=FALSE;
	xTempoMvVent03In:=FALSE;
	xLigaMotorVentilador03:=FALSE;
END_IF

IF iFrequenciaMotorVentilador03>=REAL_TO_INT(iVelocidade01Ventilador03/100) AND xPrimeiroEstagioVentilador03 THEN
	xVelocidadeVentilador03Ok:=TRUE;
END_IF

IF NOT xPrimeiroEstagioVentilador03 THEN
	xVelocidadeVentilador03Ok:=FALSE;
END_IF

