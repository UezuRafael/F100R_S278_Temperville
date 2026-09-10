__METADATA__
{
  "v3Meta": {
    "objectGuid": "b8aed9cb-1608-4c0a-b17a-b0cecc76e5c8",
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
PROGRAM E_MesaEntrada
VAR
	PassoMesaEntrada: INT;
	PassoPauseEntrada: INT;
	PassoAlmEntrada: INT;
	PassoManualEntrada: INT;
	///Blocos Nativos
	PulsaLedCarga: TimerGeneration;
	PulsoRetornaSensor: TOF;
	TempoLimRetornoSensor: TON;
	TonDelayMovEntrada: TON;
	TempoDelayCarga: Temporizador;
	TempoAposSairSensor: TON;
	TempoAposSairSensorIn: BOOL;
	TempoAposSairSensorQ: BOOL;
	TonAbortaCargaVazio: TON;
	TonAbortaCargaVazioIn: BOOL;
	TonAbortaCargaVazioQ: BOOL;
	PulsaLedCargaIn: BOOL;
	PulsaLedCargaQ: BOOL;
	///Blocos Criados
	PulsoPoChAvanco: PulsoPositivo;
	PulsoNeChAvanco: PulsoNegativo;
	xChAvancaMesaEntradaPo: BOOL;
	xChAvancaMesaEntradaNe: BOOL;
	xAvancoMesaEntrada: BOOL;
	xRecuoMesaEntrada: BOOL;
	xAvancoJogMesaEntrada: BOOL;
	xRecuoJogMesaEntrada: BOOL;
	xCmdAvancoMesaEntrada: BOOL;
	xCarregaFornoManual: BOOL;
	xCarregaFornoAuto: BOOL;
	///xCarregamentoHabilitado: BOOL;
	xLigaCargaForno: BOOL;
	xCarregandoMesaEntrada: BOOL;
	xSeguraCarga: BOOL;
	xCarregaForno: BOOL;
	xRetornoSensor: BOOL;
	xFornoProntoReceber: BOOL;
	iVelocidadeMesaEntrada: INT;
	///xCargaFornoEmAutomatico: BOOL;
	xCargaFornoEmManual: BOOL;
	xPulsoRetornaSensor: BOOL;
	xDelayMovEntrada: BOOL;
	xFimDelayCarregamento: BOOL;
	xDelayCargaOn: BOOL;
	xTempoDiferencaCargas: BOOL;
	xDesligaCargaVazia: BOOL;
	RPM: INT;
	HZ: INT;
END_VAR
__IMPLEMENTATION__

// JOG DA MESA DE ENTRADA
(*Avanço*)
PulsoPoChAvanco(Entrada:= xChAvancaMesaEntrada, SaidaPulsoPo=>xChAvancaMesaEntradaPo );
PulsoNeChAvanco(Entrada:= xChAvancaMesaEntrada, SaidaPulsoNe=>xChAvancaMesaEntradaNe );

xCmdAvancoMesaEntrada:=(xChAvancaMesaEntradaPo OR xCmdAvancoMesaEntrada) AND NOT xChAvancaMesaEntradaNe AND NOT xSensorEntrada;

IF xCmdAvancoMesaEntrada AND NOT xCarregandoForno AND NOT xRetornandoForno AND NOT xSensorEntrada (*AND NOT xPausaEmergencia*) AND xTonOperacaoAutoma THEN
	xAvancoJogMesaEntrada:=TRUE;
ELSE
	xAvancoJogMesaEntrada:=FALSE;
END_IF

PulsoRetornaSensor(IN:=xChAvancaMesaEntradaPo , PT:=T#100MS , Q=>xPulsoRetornaSensor , ET=> );
IF (xPulsoRetornaSensor OR xBtHabilitaCarregamento OR xRecargaForno) AND xSensorEntrada  THEN
	xRetornoSensor:=TRUE;
(*ELSE
	xRetornoSensor:=FALSE;*)
END_IF
// Tempo Limite de retorno pelo sensor
TempoLimRetornoSensor(IN:=xRetornoSensor, PT:=T#6S , Q=> , ET=> );

TempoAposSairSensorIn:=NOT xSensorEntrada;
TempoAposSairSensor(IN:=TempoAposSairSensorIn, PT:=T#3S , Q=>TempoAposSairSensorQ , ET=> );

IF TempoAposSairSensorQ OR TempoLimRetornoSensor.Q  THEN
	xRetornoSensor:=FALSE;
END_IF


(*Recuo*)
IF (xChRecuaMesaEntrada OR xRetornoSensor) AND NOT xCarregandoForno AND NOT xRetornandoForno (*AND NOT xPausaEmergencia*) THEN
	xRecuoJogMesaEntrada:=TRUE;
ELSE
	xRecuoJogMesaEntrada:=FALSE;
END_IF

//PRE CONDIÇÕES PARA CARREGAMENTO
(*xTempoDiferencaCargas*) 
// Tempo de Restante de Resfriamento Maior que Programado de Forno -> Segura Carregamento 
IF (iTempoResfriamentoRestante>=iTempoAquecimForno-10 ) THEN
	xTempoDiferencaCargas:=TRUE;
ELSE
	xTempoDiferencaCargas:=FALSE;
END_IF
IF xTempoDiferencaCargas AND xResfriadorEmCiclo(*xResfriadorCheio*) THEN
	xSeguraCarga:= TRUE;
ELSE
	xSeguraCarga:= FALSE;
END_IF;
// Habilita Carregamento Automatico
IF xBtHabilitaCarregamento AND xFornoEmCiclo AND NOT xBloqueioCargaEnvioRec AND NOT xFornoFinalizando AND NOT xAvancoJogMesaEntrada AND NOT xRecuoJogMesaEntrada AND NOT xSensorEntrada (**)AND NOT xAlarmeMotorForno (**)AND NOT xAlarmeMotorEntrada THEN
	xCarregamentoHabilitado:=TRUE;
	xCargaFornoEmAutomatico:=TRUE;
	
END_IF
// Carregamento Manual
IF xBtHabilitaCarregamento AND xFornoEmCiclo AND NOT xBloqueioCargaEnvioRec AND NOT xFornoFinalizando AND xFornoVazio THEN
	xCarregaFornoManual:=TRUE;
	
END_IF


IF xRecargaForno AND xCarregamentoHabilitado AND NOT xSensorEntrada THEN
	xCarregaFornoAuto:=TRUE;
	xCargaFornoEmAutomatico:=TRUE;
END_IF
IF xRecargaForno THEN
	xRecargaForno:=FALSE;
END_IF

// Tempo de atraso no Carregamento automatico do forno
TempoDelayCarga(
	IniciaTempo:= xDelayCargaForno, 
	AbortaTempo:= xOperacaoManual, 
	SetPointTempo:= iTempoDelayCarga, 
	FimTempo:= xFimDelayCarregamento, 
	TempoDecorrido=> iTempoDelayCargaDecorrido, 
	TempoRestante=> );
	
IF xDelayCargaForno THEN
	xDelayCargaOn:=TRUE;
	xDelayCargaForno:=FALSE;
END_IF

IF xFimDelayCarregamento THEN
	xDelayCargaOn:=FALSE;
END_IF
	
IF (xCarregaFornoAuto OR xCarregaFornoManual) AND NOT  xSeguraCarga AND NOT xDelayCargaOn AND (sEntradaNomedaReceita=sFornoNomedaReceita) THEN
	xCarregaForno:=TRUE;
	xCarregaFornoAuto:=FALSE;
	xCarregaFornoManual:=FALSE;
END_IF

IF  xCarregaForno AND xCarregamentoHabilitado AND NOT xSeguranca THEN
	xLigaCargaForno:=TRUE;
	xCarregaForno:=FALSE;
	xCarregamentoHabilitado:=FALSE;
	xFimDelayCarregamento:=FALSE;
END_IF
IF xSeguranca THEN
	xLigaCargaForno:=FALSE;
	xCarregaForno:=FALSE;
	xCarregamentoHabilitado:=FALSE;	
END_IF

IF NOT xCarregandoForno AND xFornoEmCiclo AND NOT xBloqueioCargaEnvioRec AND NOT xFornoFinalizando (**)AND NOT xAlarmeMotorForno (**)and not xAlarmeMotorEntrada THEN
	xFornoProntoReceber:=TRUE;
ELSE
	xFornoProntoReceber:=FALSE;
END_IF

PulsaLedCarga(ENABLE:= xFornoProntoReceber, TIMELOW:=T#500MS , TIMEHIGH:=T#500MS , OUT=>PulsaLedCargaQ );
xLedCargaForno:=(xCargaFornoEmAutomatico OR PulsaLedCargaQ) AND NOT xCarregandoForno;

xCargaEmAutomatico:=xCargaFornoEmAutomatico;

//Aborta Carregamento Automático
IF (((xAvancoJogMesaEntrada OR xRecuoJogMesaEntrada ) AND NOT  xCarregandoForno AND NOT xRetornandoForno) OR NOT xFornoEmCiclo (*OR xAlarmePortaEntradaForno OR xAlarmeMotorEntrada OR xAlarmeMotorForno*)) AND xIniciaCargaMesaEntrada THEN
	xFornoEmCicloComCarga:=FALSE;//
END_IF
IF ((xAvancoJogMesaEntrada OR xRecuoJogMesaEntrada ) AND NOT  xCarregandoForno AND NOT xRetornandoForno) OR NOT xFornoEmCiclo (*OR xAlarmePortaEntradaForno OR xAlarmeMotorEntrada OR xAlarmeMotorForno*) THEN
	xCarregaFornoAuto:=FALSE;
	xCarregaFornoManual:=FALSE;
	xCarregamentoHabilitado:=FALSE;
	PassoMesaEntrada:=0;
	xCargaFornoEmAutomatico:=FALSE;
    xPortaEntradaForno:=FALSE;
	xIniciaCargaMesaEntrada:=FALSE; //->TASK/MesaForno
	xCarregandoMesaEntrada:=FALSE;
	xLigaCargaForno:=FALSE;//
	
	xFimCarregamentoMesaEntrada:=FALSE;(**)
	xFimCargaMesaEntrada:=FALSE;(**)
	xRetornaMesaEntrada:=FALSE;(**)
	
	xRecuoMesaEntrada:=FALSE; (*teste*)
	xFimRetornoMesaEntrada:=FALSE;(*teste*)
	xAvancoMesaEntrada:=FALSE;(*teste*)

END_IF

// SEQUENCIA DE CARREGAMENTO
TonDelayMovEntrada(IN:= xInvMesaEntradaHabilitado, PT:=T#1S , Q=> xDelayMovEntrada, ET=> );

CASE PassoMesaEntrada OF
	
		0:	IF xLigaCargaForno THEN
				IF xMotorFornoLigado THEN
					PassoMesaEntrada:=1;			
				END_IF
				IF xPause THEN
					PassoPauseEntrada:=0;
					PassoMesaEntrada:=200;
				END_IF
				IF xAlarmeMotorEntrada OR xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno THEN
					PassoMesaEntrada:=200;
				END_IF
			END_IF

		1: 	xLigaCargaForno:=FALSE;
			PassoMesaEntrada:=2;
			
		2:	xFornoEmCicloComCarga:=TRUE;
			PassoMesaEntrada:=3;
	
		3:	iVelocidadeMesaForno:= iVelocidadeCargaMesaForno;(*Velocidade Carga Forno*)
			PassoMesaEntrada:=4;

		4:	PassoMesaEntrada:=5;

		5:	PassoMesaEntrada:=6;
			
		6:	IF iVelocidadeCargaMesaForno= iFrequenciaMotorMesaForno THEN
				PassoMesaEntrada:=10;
			ELSE
				PassoMesaEntrada:=2;
			END_IF
	
		10:	xPortaEntradaForno:=TRUE;
			PassoMesaEntrada:=20;

		20:	IF xSensorPortaEntrada THEN
				PassoMesaEntrada:=30;
			END_IF
			IF xPause THEN
				PassoPauseEntrada:=0;
				PassoMesaEntrada:=200;
			END_IF
			IF xAlarmeMotorEntrada OR xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno OR xAlarmePortaEntradaForno THEN
				PassoMesaEntrada:=200;
			END_IF
		
		30:	iVelocidadeMesaEntrada:= iVelocidadeCargaMesaEntrada;(*Velocidade Carga Mesa Entrada*)
			PassoMesaEntrada:=31;
		
		31:	xAvancoMesaEntrada:=TRUE;
			PassoMesaEntrada:=40;

   		40:	IF xCarregandoForno THEN
				PassoMesaEntrada:=50;
			ELSE
				PassoMesaEntrada:=44;
			END_IF
		
		44:	xIniciaCargaMesaEntrada:=TRUE; //->TASK/MesaForno
			xCarregandoMesaEntrada:=TRUE;
			TonAbortaCargaVazioIn:=TRUE;
			PassoMesaEntrada:=45;
		
		45:	IF xIniciaCargaForno THEN
				PassoMesaEntrada:=46;
			END_IF
			IF xPause THEN
				PassoPauseEntrada:=0;
				PassoMesaEntrada:=200;
			END_IF
			IF xAlarmeMotorEntrada OR xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno OR xAlarmePortaEntradaForno THEN
				PassoMesaEntrada:=200;
			END_IF
			IF TonAbortaCargaVazioQ  THEN
				PassoMesaEntrada:=200;
			END_IF

		46: TonAbortaCargaVazioIn:=FALSE;
			PassoMesaEntrada:=50;
			
	
		50:	IF xFimCarregamentoMesaEntrada THEN //<- TASK/MesaForno //
				PassoMesaEntrada:=55;
			END_IF
			IF xPause THEN
				PassoPauseEntrada:=30;
				PassoMesaEntrada:=300;
			END_IF
			IF xAlarmeMotorEntrada OR xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno OR xAlarmePortaEntradaForno THEN
				PassoAlmEntrada:=30;
				PassoMesaEntrada:=400;
			END_IF
	
			
		55:	xAvancoMesaEntrada:=FALSE;
			PassoMesaEntrada:=56;
			
		56:	xCargaFornoEmAutomatico:=FALSE;
			xLigaCargaForno:=FALSE;
			xFimCarregamentoMesaEntrada:=FALSE;
			xCarregandoMesaEntrada:=FALSE;
			PassoMesaEntrada:=60;
		
		60: PassoMesaEntrada:=70;
			
		70:	IF xFimCargaMesaEntrada THEN //<- TASK/MesaForno
				PassoMesaEntrada:=120;
			END_IF;
			IF xRetornaMesaEntrada THEN //<- TASK/MesaForno
				PassoMesaEntrada:=80;
			END_IF
			
		80:	xLigaCargaForno:=FALSE;
			xRetornaMesaEntrada:=FALSE;
			iVelocidadeMesaEntrada:= 1*iVelocidadeCargaMesaEntrada;(*iVelRetornoMesaEntrada;Velocidade Retorno Mesa Entrada*)
			PassoMesaEntrada:=81;

		81:	xRecuoMesaEntrada:=TRUE;
			PassoMesaEntrada:=90;
			
		90:	IF xFimRetornoMesaEntrada THEN //<- TASK/MesaForno
				PassoMesaEntrada:=100;
			END_IF
			IF xPause THEN
				PassoPauseEntrada:=80;
				PassoMesaEntrada:=300;
			END_IF
			IF xAlarmeMotorEntrada OR xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno OR xAlarmePortaEntradaForno THEN
				PassoAlmEntrada:=80;
				PassoMesaEntrada:=400;
			END_IF
			
		100:PassoMesaEntrada:=101;

		101:xRecuoMesaEntrada:=FALSE;
			PassoMesaEntrada:=110;
			
			
		110:xFimRetornoMesaEntrada:=FALSE;
		    xPortaEntradaForno:=FALSE;
			PassoMesaEntrada:=0;
			
		120:xFimCargaMesaEntrada:=FALSE;
		    xPortaEntradaForno:=FALSE;
			PassoMesaEntrada:=0;
		
		
		//Alarmes		
		200:xRecuoMesaEntrada:=FALSE;
			xAvancoMesaEntrada:=FALSE;
			PassoMesaEntrada:=201;

		201:PassoMesaEntrada:=202;
			
		202: xLigaCargaForno:=FALSE;
			 xPortaEntradaForno:=FALSE;
			 xFornoEmCicloComCarga:=FALSE;
			 xCargaFornoEmAutomatico:=FALSE;
			 xIniciaCargaMesaEntrada:=FALSE; 
			 xCarregandoMesaEntrada:=FALSE;
			 PassoMesaEntrada:=0;
			 
		// Emergência Pausa/Reinicio
		300:xRecuoMesaEntrada:=FALSE;
			xAvancoMesaEntrada:=FALSE;
			PassoMesaEntrada:=301;

		301:PassoMesaEntrada:=302;
	
		302:IF xRestart THEN
				PassoMesaEntrada:=303;
			END_IF
			
		303:PassoMesaEntrada:=PassoPauseEntrada;
			
		
		// Alarme Motor Parada/Reinicio
		400:xRecuoMesaEntrada:=FALSE;
			xAvancoMesaEntrada:=FALSE;
			PassoMesaEntrada:=401;

		401:PassoMesaEntrada:=402;
	
		402:IF xRestart AND iCanOpenInverMesaEntraStateOk THEN
				PassoMesaEntrada:=PassoAlmEntrada;
			END_IF	
	
END_CASE


// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorMesaEntradaAvanco:= xAvancoMesaEntrada OR xAvancoJogMesaEntrada;
xMotorMesaEntradaRecuo:= xRecuoMesaEntrada OR xRecuoJogMesaEntrada;

InversorMesaEntrada.i_xAvanco:=xMotorMesaEntradaAvanco;
InversorMesaEntrada.i_xRecuo:=xMotorMesaEntradaRecuo;

// Velocidade
IF xAvancoJogMesaEntrada OR xRecuoJogMesaEntrada THEN
	IF xRetornoSensor THEN
		InversorMesaEntrada.i_iFreqRef:=50;
	ELSE
		InversorMesaEntrada.i_iFreqRef:=iVelocidadeJogMesaEntrada;
	END_IF
ELSE
	InversorMesaEntrada.i_iFreqRef:=iVelocidadeMesaEntrada;	
END_IF
//--------------------------------------------------------------------------\\


IF xOperacaoManual THEN
	PassoMesaEntrada:=0;
	PassoPauseEntrada:=0;
	PassoAlmEntrada:=0;
	xCarregamentoHabilitado:=FALSE;
	xCargaFornoEmAutomatico:=FALSE;
	xCarregaFornoManual:=FALSE;
	xCarregaFornoAuto:=FALSE;
	xCarregaForno:=FALSE;
	xLigaCargaForno:=FALSE;
	xIniciaCargaMesaEntrada:=FALSE; 
	xCarregandoMesaEntrada:=FALSE;
	xFimCarregamentoMesaEntrada:=FALSE;
	xFimCargaMesaEntrada:=FALSE;
	xRetornaMesaEntrada:=FALSE;
	xFimRetornoMesaEntrada:=FALSE;	
	xDelayCargaForno:=FALSE;
	xFimDelayCarregamento:=FALSE;
	xDelayCargaOn:=FALSE;
	xBloqueioCargaEnvioRec:=FALSE;
	
	xAvancoJogMesaEntrada:=FALSE;
	xRecuoJogMesaEntrada:=FALSE;
	xAvancoMesaEntrada:=FALSE;
	xRecuoMesaEntrada:=FALSE;

END_IF


TonAbortaCargaVazio(IN:= TonAbortaCargaVazioIn, PT:=T#20S , Q=>  TonAbortaCargaVazioQ, ET=>);
IF TonAbortaCargaVazioQ OR xOperacaoManual THEN
	TonAbortaCargaVazioIn:=FALSE;
END_IF
