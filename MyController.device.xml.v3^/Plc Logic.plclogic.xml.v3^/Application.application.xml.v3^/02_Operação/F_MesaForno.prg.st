__METADATA__
{
  "v3Meta": {
    "objectGuid": "97f941fe-75ae-43e4-b478-949d711cc8de",
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
PROGRAM F_MesaForno
VAR
	///Passo da Execução da Movimentação do Forno
	PassoMesaForno: INT;
	///Passo da Execução da Movimentação do Forno
	PassoIniciaForno: INT;
	PassoAlmIniForno: INT;
	PassoManualForno: INT;
	PassoEmergenciaForno: INT;
	PassoPauseForno: INT;
	PassoAlmMesaForno: INT;
	PassoPauseIniForno: INT;
	PassoVelVaivem: INT;
	////////
	PassoPosVaivem: INT;
	///////
	SetRampasForno: GIATV.SetDriveRamp_ATV;
	TpSairForno: TP;
	TonParadaSemEner: TON;
	TonDelayMovForno: TON;
	TonParadaSemEnerIn: BOOL;
	TonParadaSemEnerQ: BOOL;
	TonParadaSemEnerEt: TIME;
	TonAutoResetMotorForno: TON;
	TonAutoResetMotorFornoIn: BOOL;
	TonAutoResetMotorFornoQ: BOOL;
	TonIniVelStd: TON;
	TonIniVelStdIn: BOOL;
	TonIniVelStdQ: BOOL;
	///Bloco Conta Tempo de Pausa dos Roletes
	TempoPausaRoletes: Temporizador;
	///Bloco Conta Tempo de Permanecia no Forno
	TempoAquecimForno: Temporizador;
	TempoTrocaVelocidade: Temporizador;
	///////////////////////////////////////////
	TempoTrocaPosicao: Temporizador;
	///////////////////////////////////////////
	TamanhoCarga: ComprimentoCarga;
	///Bloco Calcula Posições de Paradas da Carga
	CalculosMesaForno: CalculosForno;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilim: PulsoConversorMm;
	///Bloco Seleciona Pulsos para Vidro Fino ou Grosso
	SelecaoPulsos: BlocoSelecaoEspessura;
	xExecutaSetRampasForno: BOOL;
	dAceleracaoMesaForno: DINT;
	dDesaceleracaoMesaForno: DINT;
	dAccMesaForno: DINT;
	dDecMesaForno: DINT;
	///Contador muda posição de parada do VaiVem
	ContadorMudaPos: INT;
	///Variaveis que Habilitam o Inicio do Ciclo de Aquecimento
	///Variáveis Booleanas Auxiliares
	xFimTempoPausaRoletes: BOOL;
	xFimTempoAquecForno: BOOL;
	xFinalizaVaivemForno: BOOL;
	xFimCalculoCarga: BOOL;
	xTamanhoCargaFora: BOOL;
	xTamanhoCargaOk: BOOL;
	xReativaVaivem: BOOL;
	///Variáveis inteiras Auxiliares
	dValEncoVelMinForno: DINT;
	dValEncoCargaForno: DINT;
	dValEncoAvancoForno: DINT;
	dValEncoRecuoForno: DINT;
	dValEncoDescargaForno: DINT;
	dValEncoReferenciaResfriador: DINT;
	dValEncoSemEnergia: DINT;
	dValLiberaCargaForno: DINT;
	dTamanhoAreaUtilForno: DINT;
	dTamanhoMaximoCarga: DINT;
	dTamanhoCarga: DINT;
	///Distancia Restante para o fim do Carregamento (milimetro)
	iValorVelMinimaForno: INT;
	iValorCargaForno: INT;
	iValorOscilacaoForno: INT;
	iValorDescargaForno: INT;
	iTamanhoAreaUtilForno: INT;
	iValMilimetroVelMinForno: INT;
	iValMilimetroCargaForno: INT;
	iValMilimetroAvancoForno: INT;
	iValMilimetroRecuoForno: INT;
	iValMilimetroDescargaForno: INT;
	iValMilimetroAreaUtilForno: INT;
	iValMilimetroTamMaxCarga: INT;
	iValMilimetroReferenciaResfriador: INT;
	xSensorEntradaPo: BOOL;
	PulsoPoSensorEntrada: PulsoPositivo;
	xliberaDescargaForno: BOOL;
	xDelayMovForno: BOOL;
	xForceSaidadoVidro: BOOL;
	///Variáveis internas auxiliares para mundaça de Velocidade e Posição
	dValorAvancoForno: DINT;
	///////////////
	dValorRecuoForno: DINT;
	////////////////
	xVelocidade01VaivemForno: BOOL;
	//////	
	xPosicao01VaivemForno: BOOL;
	/////////
	xFimTempoTrocaVelocidade: BOOL;
	//////
	xFimTempoTrocaPosicao: BOOL;
	//////
	xTemperaturaDesliga: BOOL;
	xDesligaMotorForno: BOOL;
	xTempoMvFornoIn: BOOL;
	xTempoMvFornoQ: BOOL;
	TempoMvForno: ton;
	rConsumoInicialCarga_kW: REAL;
END_VAR
__IMPLEMENTATION__
//SELEÇÃO DOS PARAMETROS PELA ESPESSURA DO VIDRO
// Parametros de medidas do Forno
SelecaoPulsos(
	xSelecao:= xEspessuraVidroFino, 	
	iEntrada0101:= iValorVelMinimaFornoVidroFin, 
	iEntrada0102:= iValorVelMinimaFornoVidroGro, 
	iEntrada0201:= iValorCargaFornoVidroFin, 
	iEntrada0202:= iValorCargaFornoVidroGro, 
	iEntrada0301:= iValorOscilacaoFornoVidroFin, 
	iEntrada0302:= iValorOscilacaoFornoVidroGro, 
	iEntrada0401:= iValorDescargaFornoVidroFin, 
	iEntrada0402:= iValorDescargaFornoVidroGro, 
	iEntrada0501:= iTamanhoAreaUtilFornoVidroFin, 
	iEntrada0502:= iTamanhoAreaUtilFornoVidroGro, 
	iEntrada0601:= iTamanhoCargaMaxFornoVidroFin, 
	iEntrada0602:= iTamanhoCargaMaxFornoVidroGro, 
	iEntrada0701:= iTamanahoFornoContratoVidroFin, 
	iEntrada0702:= iTamanahoFornoContratoVidroGro, 
	iSaida01=> iValorVelMinimaForno, 
	iSaida02=> iValorCargaForno, 
	iSaida03=> iValorOscilacaoForno, 
	iSaida04=> iValorDescargaForno, 
	iSaida05=> iTamanhoAreaUtilForno, 
	iSaida06=> iTamanhoCargaMaxForno,
	iSaida07=> iTamanhoCargaContrato);

//Parametros de Rampas do Inversor	
//Aceleração
IF 	xEspessuraVidroFino THEN
	dAccMesaForno:=dAccMesaFornoVidroFin;
	dDecMesaForno:=dDecMesaFornoVidroFin;
ELSE
	dAccMesaForno:=dAccMesaFornoVidroGro;
	dDecMesaForno:=dDecMesaFornoVidroGro;
END_IF

IF (dAccMesaForno<>dAceleracaoMesaForno) OR (dDecMesaForno<>dDesaceleracaoMesaForno) THEN
	dAceleracaoMesaForno:=dAccMesaForno;
	dDesaceleracaoMesaForno:=dDecMesaForno;
	xExecutaSetRampasForno:=TRUE;
ELSE
	xExecutaSetRampasForno:=FALSE;
END_IF


// CALCULOS DE POSICIONAMENTO
CalculosMesaForno(
	DistanciaVelMinForno:= 	iValorVelMinimaForno, 
	DistanciaCargaForno:= 	iValorCargaForno, 
	TamanhoAreaUtil:= 		iTamanhoAreaUtilForno, 
	TamanhoCargaMaxima:= 	iTamanhoCargaMaxForno, 
	TamanhoCarga:= 			iTamanhoCargaAtualForno, 
	SetPointVelMinCarga=> 	iValMilimetroVelMinForno, 
	SetPointCargaForno=> 	iValMilimetroCargaForno, 
	SetPointDescargaForno=> iValMilimetroDescargaForno, 
	SetPointAvancaVaiVemForno=> iValMilimetroAvancoForno, 
	SetPointRecuaVaiVemForno=> iValMilimetroRecuoForno, 
	TamanhoAreaUtilForno=> 	iValMilimetroAreaUtilForno, 
	TamanhoCargaMaxForno=> 	iValMilimetroTamMaxCarga);
	
// CONVERSÃO MILIMETROS EM PULSOS

iValMilimetroReferenciaResfriador:=iValDistanciaReferenciaResfriador;

ConversorMilimPul(
	dPulso:= 82071, 
	dMilimetro:= 6192, 
	iEntrMilimetro01:= iValMilimetroVelMinForno, 
	iEntrMilimetro02:= iValMilimetroCargaForno, 
	iEntrMilimetro03:= iValMilimetroAvancoForno, 
	iEntrMilimetro04:= iValMilimetroRecuoForno, 
	iEntrMilimetro05:= iValorDescargaForno,//iValMilimetroDescargaForno, 
	iEntrMilimetro06:= iValMilimetroAreaUtilForno, 
	iEntrMilimetro07:= iValMilimetroTamMaxCarga, 
	iEntrMilimetro08:= 40,
	iEntrMilimetro09:= iValMilimetroReferenciaResfriador,
	iEntrMilimetro10:= 400,//distancia da porta de saida para liberar a carga
	dSaidaPulso01=> dValEncoVelMinForno, 
	dSaidaPulso02=> dValEncoCargaForno, 
	dSaidaPulso03=> dValEncoAvancoForno, 
	dSaidaPulso04=> dValEncoRecuoForno, 
	dSaidaPulso05=> dValEncoDescargaForno, 
	dSaidaPulso06=> dTamanhoAreaUtilForno, 
	dSaidaPulso07=> dTamanhoMaximoCarga,
	dSaidaPulso08=>	dValEncoSemEnergia,  
	dSaidaPulso09=> dValEncoReferenciaResfriador,
	dSaidaPulso10=> dValLiberaCargaForno);

// CALCULO DO TAMANHO DA CARGA


PulsoPoSensorEntrada(Entrada:= xSensorEntrada, SaidaPulsoPo=>xSensorEntradaPo );

IF	xSensorEntradaPo AND xIniciaCargaMesaEntrada THEN
	xIniciaCargaForno:=TRUE;
	xIniciaCargaMesaEntrada:=FALSE;
END_IF

TamanhoCarga(
	Sensor:= xSensorEntrada, 
	Habilita:= xCarregandoForno, 
	ValEncoder:= dValorEncoderForno, 
	FimMedicao:= xFimCalculoCarga, 
	TamanhoCarga=> dTamanhoCarga);
	
// Desligamento pela Temperatura

IF rMediaLogicaTemperaturaTotal< 0 THEN
	xTemperaturaDesliga:=TRUE;
ELSE
	xTemperaturaDesliga:=FALSE;
END_IF

IF xTemperaturaDesliga AND NOT xResistenciasLigadas THEN
	xDesligaMotorForno:=TRUE;
	xDesligaMotorFornoTempBaixa:=TRUE;
ELSE
	xDesligaMotorForno:=FALSE;
	xDesligaMotorFornoTempBaixa:=FALSE;
END_IF

// MOVIMENTAÇÃO DA MESA DO FORNO
// Atrase para iniciar motor após habilitação
TonDelayMovForno(IN:= xInvMesaFornoHabilitado, PT:=T#1S , Q=> xDelayMovForno, ET=> );
TempoMvForno(IN:= xTempoMvFornoIn, PT:=T#2S , Q=> xTempoMvFornoQ, ET=> );

// Movimentação Stand-By
CASE PassoIniciaForno OF
	
	0:	(*IF xDelayMovForno THEN
			xLedStart:=TRUE;
		END_IF
		IF xRestart THEN
			PassoIniciaForno:=1;
		END_IF
	
	1:*)  xLedStart:=FALSE;
		IF NOT xFornoEmCicloComCarga (*AND xDelayMovForno AND NOT xErroEixoMf*) AND NOT xOperacaoManual THEN
			PassoIniciaForno:=2;
			PassoManualForno:=0;
		END_IF
	
	2:	TonIniVelStdIn:=TRUE; 
		IF TonIniVelStdQ THEN
			PassoIniciaForno:=3;		
		END_IF

	3:	TonIniVelStdIn:=FALSE;
		PassoIniciaForno:=5;
		
	5:  iVelocidadeMesaForno:= iVelocidadeStbForno;(*Velocidade Stand-By Forno*)
		PassoIniciaForno:=10;
		
	10:	xAvancoMesaForno:=TRUE;
		PassoIniciaForno:=15;
		
	15:	IF iVelocidadeMesaForno<> iVelocidadeStbForno THEN
			PassoIniciaForno:=5;
		END_IF
		IF xFornoEmCicloComCarga THEN
			PassoIniciaForno:=20;
		END_IF 
		IF	xDesligaMotorForno THEN
			PassoIniciaForno:=100;
		END_IF
		IF xSemEnergia THEN
			PassoIniciaForno:=50;
		END_IF
		IF xPause THEN
			PassoPauseIniForno:=5;
			PassoIniciaForno:=300;
		END_IF
		IF xAlarmeMotorForno THEN
			PassoAlmIniForno:=5;
			PassoIniciaForno:=400;
		END_IF

	20: IF NOT xFornoEmCicloComCarga THEN
			PassoIniciaForno:=0;
		END_IF 	
		
	50: xAvancoMesaForno:=FALSE;
		PassoIniciaForno:=55;
		
	55: PassoIniciaForno:=60;
		
	60:	TonParadaSemEnerIn:=TRUE;
		IF TonParadaSemEnerQ THEN
			PassoIniciaForno:=63;
		END_IF
		IF xEnergiaOk THEN
			PassoIniciaForno:=90;
		END_IF
		
	63:	TonParadaSemEnerIn:=FALSE;
		xHomeEncoderForno:=TRUE;
		PassoIniciaForno:=64;
		
	64: iVelocidadeMesaForno:= iVelocidadeStbForno;(*Velocidade Stand-By Forno*)
		PassoIniciaForno:=65;
	
	65:	xHomeEncoderForno:=FALSE;
		PassoIniciaForno:=70;
		
	70:	xAvancoMesaForno:=TRUE;
		PassoIniciaForno:=75;
		
	75: IF (dValorEncoderForno>=dValEncoSemEnergia) THEN
			PassoIniciaForno:=50;
		END_IF
		
	90:	TonParadaSemEnerIn:=FALSE;
		PassoIniciaForno:=0;
		
		
	100:xAvancoMesaForno:=FALSE;
		PassoIniciaForno:=105;
		
	105: PassoIniciaForno:=110;
		
	110: IF NOT xDesligaMotorForno THEN
		    PassoIniciaForno:=0;
	     END_IF
		
	// Emergência Pausa/Reinicio
	300:xAvancoMesaForno:=FALSE;
		PassoIniciaForno:=301;

	301:PassoIniciaForno:=302;
	
	302:IF xRestart THEN
			PassoIniciaForno:=303;
		END_IF
		
	303:PassoIniciaForno:=PassoPauseIniForno;
		
		// Alarme Motor Parada/Reinicio
		
	400:xAvancoMesaForno:=FALSE;
		PassoIniciaForno:=401;

	401:TonAutoResetMotorFornoIn:=TRUE;
		IF TonAutoResetMotorFornoQ THEN
			PassoIniciaForno:=402;			
		END_IF
		
	402: xAutoResetMotorForno:=TRUE;
		PassoIniciaForno:=403;
		
	403: TonAutoResetMotorFornoIn:=FALSE;
		 PassoIniciaForno:=404;
	
	404:IF (xRestart OR xAutoResetMotorForno) AND iCanOpenInverMesaFornoStateOk  THEN
			xAutoResetMotorForno:=FALSE;
			PassoIniciaForno:=PassoAlmIniForno;
		END_IF
	
END_CASE
TonAutoResetMotorForno(IN:=TonAutoResetMotorFornoIn , PT:=T#1000MS , Q=>TonAutoResetMotorFornoQ , ET=> );


TonIniVelStd(IN:=TonIniVelStdIn , PT:=T#100MS , Q=>TonIniVelStdQ , ET=> );
TonParadaSemEner(IN:=TonParadaSemEnerIn , PT:=T#1M , Q=>TonParadaSemEnerQ , ET=>TonParadaSemEnerEt );

iTempoPassoSemEnerg:= DINT_TO_INT((TIME_TO_DINT(T#1M))/1000-(TIME_TO_DINT(TonParadaSemEnerEt))/1000);



// Condição para Descarga do Forno
xliberaDescargaForno:= (xAvancandMesaResfriador AND xFinalizaVaivemForno AND xResfriadorVazio(*AND xDuctosSup01CheckOk AND xGuilhotina01CheckOk AND xVelocidadeVentilador01Ok AND xVelocidadeVentilador02Ok AND xVelocidadeVentilador03Ok*)) OR xForceSaidadoVidro;

// Movimentação em Ciclo
// Sequencia de mudança de Velocidade de VaiVem
CASE PassoVelVaivem OF
	0:	IF xVelocidade01VaivemForno THEN
			PassoVelVaivem:=5;
		END_IF
	
	5:	xVelocidade01VaivemForno:=FALSE;
		PassoVelVaivem:=10;
		
	10:	iVelocidadeVaiVemMesaForno := REAL_TO_INT(iVelocidade01Vaivem/10);
		IF xFimTempoTrocaPosicao THEN
			PassoVelVaivem:=15;
		END_IF
	
	15:	iVelocidadeVaiVemMesaForno:= REAL_TO_INT(iVelocidade02Vaivem/10);
		IF xFimTempoTrocaVelocidade THEN
			PassoVelVaivem:=20;
		END_IF
		
	20: iVelocidadeVaiVemMesaForno:=REAL_TO_INT(iVelocidade03Vaivem/10);
		//PassoVelVaivem:=20;
		
	//20:	PassoVelVaivem:=0;
END_CASE

// Sequencia de mudança de Posicao de VaiVem
CASE PassoPosVaivem OF
	0:	IF xPosicao01VaivemForno THEN
			PassoPosVaivem:=5;
		END_IF
		
	5:	xPosicao01VaivemForno:=FALSE;
		PassoPosVaivem:=10;
		
	10:	IF NOT xFimTempoTrocaPosicao THEN
			IF ContadorMudaPos=0 THEN
				dValorAvancoForno:= dValEncoCargaForno;
				dValorRecuoForno:= dValEncoCargaForno-773;//Recua 50mm
			END_IF
			IF ContadorMudaPos=1 THEN
				dValorAvancoForno:= dValEncoCargaForno-154;// Avança com -10mm da posição inicial
				dValorRecuoForno:= dValEncoCargaForno-927;//Recua 60mm
			END_IF
			IF ContadorMudaPos=2 THEN
				dValorAvancoForno:= dValEncoCargaForno-309;// Avança com -20mm da posição inicial
				dValorRecuoForno:= dValEncoCargaForno-1081;//Recua 70mm;
			END_IF
			IF ContadorMudaPos=3 THEN
				dValorAvancoForno:= dValEncoCargaForno-463;// Avança com -30mm da posição inicial
				dValorRecuoForno:= dValEncoCargaForno-1235;//Recua 80mm;
			END_IF
		ELSE
			xTempoPausaRoletesOn:=FALSE;
			PassoPosVaivem:=15;
		END_IF
		
	15:	IF ContadorMudaPos=0 THEN
			dValorAvancoForno:= dValEncoAvancoForno;
			dValorRecuoForno:= dValEncoRecuoForno;
		END_IF
		IF ContadorMudaPos=1 THEN
			dValorAvancoForno:= dValEncoAvancoForno-154;
			dValorRecuoForno:= dValEncoRecuoForno-154;
		END_IF
		IF ContadorMudaPos=2 THEN
			dValorAvancoForno:= dValEncoAvancoForno-309;
			dValorRecuoForno:= dValEncoRecuoForno-309;
		END_IF
		IF ContadorMudaPos=3 THEN
			dValorAvancoForno:= dValEncoAvancoForno-463;
			dValorRecuoForno:= dValEncoRecuoForno-463;
		END_IF
		//PassoPosVaivem:=0;
	
END_CASE
	
// Sequencia de Entrada, Oscilação e Saída

CASE PassoMesaForno OF

	0:	IF xIniciaCargaForno AND xFornoEmCiclo THEN
			PassoMesaForno:=1;	
		END_IF
		
	1:	xHomeEncoderForno:=TRUE;
		PassoMesaForno:=2;	
		
	2:	xMesaFornoOn:=TRUE;
		PassoMesaForno:=5;	
		
	5:	xHomeEncoderForno:=FALSE;
		PassoMesaForno:=6;

	6:	iVelocidadeMesaForno:= iVelocidadeCargaMesaForno;(*Velocidade Carga Forno*)
		PassoMesaForno:=7;

	7:	xAvancoMesaForno:=TRUE;
		PassoMesaForno:=10;
		
	10:	xIniciaCargaForno:=FALSE;
		xIniciaCargaMesaEntrada:=FALSE;
		xExecutaMovMesaForno:=FALSE;
		//xPortaEntradaForno:=TRUE;
		xCarregandoForno:=TRUE;
		xStartCargaForno:=TRUE;
		xFornoCheio:=TRUE;
		PassoMesaForno:=20;
		
	20: IF (dValorEncoderForno>=dValEncoVelMinForno) THEN
			PassoMesaForno:=30;
		END_IF
		IF xPause THEN
			PassoPauseForno:=5;
			PassoMesaForno:=300;
		END_IF
		IF xAlarmeMotorEntrada OR xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno OR xAlarmePortaEntradaForno THEN
			PassoAlmMesaForno:=5;
			PassoMesaForno:=400;
		END_IF

	30: iVelocidadeMesaForno:= iVelMinCargaForno;(*Velocidade Minima Carga Forno*)
		PassoMesaForno:=40;

	40: IF (dValorEncoderForno>=dValEncoCargaForno) THEN
			PassoMesaForno:=42;
		END_IF
		IF xPause THEN
			PassoPauseForno:=5;
			PassoMesaForno:=300;
		END_IF
		IF xAlarmeMotorForno THEN
			PassoAlmMesaForno:=5;
			PassoMesaForno:=400;
		END_IF
		
	42: iVelocidadeMesaForno:= 0;
		xAvancoMesaForno:=FALSE; 
		PassoMesaForno:=45;
		
	45: IF (iVelocidade01Vaivem=0) AND (iTempoPosicaoForno<>0)THEN
			xTempoPausaRoletesOn:=TRUE;
		END_IF
		PassoMesaForno:=50;
		
	50: xExecutaMovMesaForno:=FALSE;
		xCarregandoForno:=FALSE;
		xIniciaCargaForno:=FALSE;
		xFimCarregamentoMesaEntrada:=TRUE; //-> TASK/MesaEntrada
		PassoMesaForno:=55;
		
	55: IF xFimCalculoCarga THEN
			PassoMesaForno:=60;
		END_IF
		
	60:	IF (dTamanhoCarga>=dTamanhoAreaUtilForno) OR (dTamanhoCarga>dTamanhoMaximoCarga) OR (dTamanhoCarga<=0) OR  (xSensorEntrada) THEN
			xTamanhoCargaFora:=TRUE;
			xRetornaMesaEntrada:=TRUE; //-> TASK/MesaEntrada
			PassoMesaForno:=70;
		END_IF
		IF (dTamanhoCarga<=dTamanhoMaximoCarga) AND NOT xSensorEntrada THEN
			xTamanhoCargaOk:=TRUE;
			xFimCargaMesaEntrada:=TRUE;//-> TASK/MesaEntrada
			PassoMesaForno:=100;
		END_IF
				
	70:	xTamanhoCargaFora:=FALSE;
		iVelocidadeMesaForno:= 1*iVelocidadeCargaMesaForno;(*iVelRetornoCargaForno;Velocidade de Retorno Forno*)
		PassoMesaForno:=71;

	71:	xRecuoMesaForno:=TRUE;
		PassoMesaForno:=80;
		
	80:	xRetornandoForno:=TRUE;
		xExecutaMovMesaForno:=FALSE;
		xTempoPausaRoletesOn:=FALSE;
		IF (dValorEncoderForno<=0) THEN
			PassoMesaForno:=90;
		END_IF	
		IF xPause THEN
			PassoPauseForno:=70;
			PassoMesaForno:=300;
		END_IF
		IF xAlarmeMotorEntrada OR xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno OR xAlarmePortaEntradaForno THEN
			PassoAlmMesaForno:=70;
			PassoMesaForno:=400;
		END_IF
	
	90: xFimRetornoMesaEntrada:=TRUE; //-> TASK/MesaEntrada
		xRecuoMesaForno:=FALSE;		(* DesLiga Recuo Motor Pre Forno *)		
		xRetornandoForno:=FALSE;
		xFornoCheio:=FALSE;
		xFornoEmCicloComCarga:=FALSE;
		xPortaEntradaForno:=FALSE;
		xMesaFornoOn:=FALSE;
		PassoIniciaForno:=20;
		PassoMesaForno:=0;
				
	100: uNumeroCargaRel:=uNumeroCargaRel+1;
		 rConsumoInicialCarga_kW:=rConsumoEnergiaReal_kWh;(*Ativo*)
		 PassoMesaForno:=101;

	101:xIniciaRelatorioProd:=TRUE;
		PassoMesaForno:=102;	
 
	102: xTamanhoCargaOk:=FALSE;		
		 xPortaEntradaForno:=FALSE;
		 xFornoCarregado:= TRUE;
		 xFornoComCarga:=TRUE;
		 xIniciaPausaResistencias:= TRUE;
		 xPausaHabilitaTesteEncoder:=TRUE;
		 xLigaConveccaoForno:= TRUE;
		 xVelocidade01VaivemForno:=TRUE;////////
		 xPosicao01VaivemForno:=TRUE;///////////
		 PassoMesaForno:=110;
		 
	110://IF 	xFimTempoPausaRoletes THEN
			PassoMesaForno:=120;
		//END_IF
		IF xPause THEN
			PassoPauseForno:=110;
			PassoMesaForno:=300;
		END_IF
		IF xAlarmeMotorForno THEN
			PassoAlmMesaForno:=110;
			PassoMesaForno:=400;
		END_IF
		
	120:IF ContadorMudaPos>=4 THEN
			 ContadorMudaPos:=0;
		END_IF
		PassoMesaForno:=121;
				
	121:xPausaHabilitaTesteEncoder:=FALSE;
		iVelocidadeMesaForno:= 1*iVelocidadeVaiVemMesaForno;(*Velocidade Vai Vem Forno*)
		PassoMesaForno:=122;

	122:xRecuoMesaForno:=TRUE;
		PassoMesaForno:=130;			
		
	130:PassoMesaForno:=135;
	
	135:IF NOT xliberaDescargaForno OR xAlarmePortaSaidaFornoAberta THEN
			IF (dValorEncoderForno<=dValorRecuoForno) THEN 
				PassoMesaForno:=140;
			END_IF	
			IF iVelocidadeMesaForno <> 1*iVelocidadeVaiVemMesaForno THEN
				PassoMesaForno:=121;
			END_IF
			IF xPause THEN
				PassoPauseForno:=121;
				PassoMesaForno:=300;
			END_IF
			IF xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno THEN
				PassoAlmMesaForno:=121;
				PassoMesaForno:=400;
			END_IF
		ELSE
			IF	(dValorEncoderForno<=dValEncoCargaForno - dValLiberaCargaForno) THEN
					PassoMesaForno:=156;
			END_IF	
			IF iVelocidadeMesaForno <> 1*iVelocidadeVaiVemMesaForno THEN
				PassoMesaForno:=121;
			END_IF
			IF xPause THEN
				PassoPauseForno:=121;
				PassoMesaForno:=300;
			END_IF
			IF xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno THEN
				PassoAlmMesaForno:=121;
				PassoMesaForno:=400;
			END_IF
		END_IF
		
	140:xRecuoMesaForno:=FALSE;
		PassoMesaForno:=141;
		
	141:xForceSaidadoVidro:=FALSE;
		PassoMesaForno:=145;
		
	145:iVelocidadeMesaForno:= iVelocidadeVaiVemMesaForno;(*Velocidade Vai Vem Forno*)
		PassoMesaForno:=146;
		
	146:xAvancoMesaForno:=TRUE;
		PassoMesaForno:=150;
		
	150:PassoMesaForno:=151;
		
	151:IF NOT xliberaDescargaForno OR xAlarmePortaSaidaFornoAberta THEN
			IF (dValorEncoderForno>=dValorAvancoForno) THEN
				PassoMesaForno:=155;
			END_IF
			IF iVelocidadeMesaForno <> 1*iVelocidadeVaiVemMesaForno THEN
				PassoMesaForno:=145;
			END_IF
			IF xPause THEN
				PassoPauseForno:=145;
				PassoMesaForno:=300;
			END_IF
			IF xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno THEN
				PassoAlmMesaForno:=145;
				PassoMesaForno:=400;
			END_IF
		ELSE
			IF	(dValorEncoderForno<=dValEncoCargaForno - dValLiberaCargaForno) THEN
				PassoMesaForno:=157;
			ELSE
				PassoMesaForno:=155;
			END_IF	
			IF iVelocidadeMesaForno <> 1*iVelocidadeVaiVemMesaForno THEN
				PassoMesaForno:=145;
			END_IF
			IF xPause THEN
				PassoPauseForno:=145;
				PassoMesaForno:=300;
			END_IF
			IF xAlarmeMotorForno OR xAlarmeGeralEncoderMeForno THEN
				PassoAlmMesaForno:=145;
				PassoMesaForno:=400;
			END_IF
		END_IF	
		
	155: xAvancoMesaForno:=FALSE;
		 ContadorMudaPos:=ContadorMudaPos+1;
		 PassoMesaForno:=120;
		 

	156:xRecuoMesaForno:=FALSE;
		xAvancoMesaForno:=TRUE;
		xForceSaidadoVidro:=FALSE;
		PassoMesaForno:=157;

	157:xForceSaidadoVidro:=FALSE;
		PassoMesaForno:=160;	 

	160://xForceSaidadoVidro:=FALSE;
		PassoMesaForno:=164;
		
	164:xAvancoMesaForno:=TRUE;
		PassoMesaForno:=165;
		
	165:iVelocidadeMesaForno:= iVelocidadeDescargaMesaForno;(*Velocidade Descarga Forno*)
		PassoMesaForno:=166;

	166:PassoMesaForno:=170;
		
	170:IF xDescarregandoForno THEN
			PassoMesaForno:=180;
		ELSE
			PassoMesaForno:=171;
		END_IF

	171:xAbreVenezVentPass:=TRUE;//-> TASK/T_VenezianaVentInfPass
		xPortaSaidaForno:=TRUE;
		xValvulaScanner:=TRUE;
		xDescarregandoForno:=TRUE;
		//xReajustaAlturaDuctosSup02:=TRUE;
		xFornoCarregado:= FALSE;
		xPulsoTrocaParamResfriador:=TRUE;
		xIniciaPausaResistencias:= FALSE;
		xLigaConveccaoForno:= FALSE;
		PassoMesaForno:=172;
		
	172:IF (dValorEncoderForno>=dValEncoCargaForno) AND xSensorPortaSaida THEN
			PassoMesaForno:=175;
		END_IF
		IF (dValorEncoderForno>=dValEncoCargaForno) AND NOT xSensorPortaSaida THEN
			PassoMesaForno:=173;
		END_IF
		IF xPause THEN
			xDescarregandoForno:=FALSE;
			xFornoCarregado:= TRUE;
			PassoPauseForno:=121;
			PassoMesaForno:=300;
		END_IF
		(*IF xAlarmeMeFornoParado THEN // Só funciona se resetar Este alarme
			xDescarregandoForno:=FALSE;
			xFornoCarregado:= TRUE;
			PassoMesaForno:=121;
		END_IF*)
		
	173: xDescarregandoForno:=FALSE;
		 xFornoCarregado:= TRUE;
		 xAvancoMesaForno:=FALSE;
		 PassoMesaForno:=120;
		
	175: //xValvulaScanner:=TRUE;
		 PassoMesaForno:=176;

	176: xFimTempoPausaRoletes:=FALSE;
		 xFimTempoAquecForno:=FALSE;
		 xFinalizaVaivemForno:=FALSE;
		 xFimTempoTrocaVelocidade:=FALSE;//////
		 xFimTempoTrocaPosicao:=FALSE;//////
		 xFimTempoPausaResistInf:=FALSE;
		 xFimTempoPausaResistSup:=FALSE;
		 xFimTempoPausa02ResistSup:=FALSE;
		 PassoVelVaivem:=0;////////
		 PassoPosVaivem:=0;////////
		 PassoMesaForno:=180;	
		
	180:IF (dValorEncoderForno>=dValEncoReferenciaResfriador) THEN
			xIniciaCargaResfriador:=TRUE;//-> TASK/MesaEntrada
			xIniciaCargaPassagem:=TRUE;//-> TASK/MesaEntrada
			PassoMesaForno:=181;
		END_IF
		IF xPause THEN
			PassoPauseForno:=164;
			PassoMesaForno:=300;
		END_IF
		IF xAlarmeMotorForno OR xAlarmeMotorResfriador OR xAlarmePortaSaidaFornoAberta OR xAlarmeGeralEncoderMeForno OR xAlarmeGeralEncoderMeResfriador THEN
			PassoAlmMesaForno:=164;
			PassoMesaForno:=400;
		END_IF
			
	181:IF (dValorEncoderForno>=dValEncoDescargaForno) THEN
			PassoMesaForno:=190;
		END_IF	
		IF xPause THEN
			PassoPauseForno:=164;
			PassoMesaForno:=300;
		END_IF
		IF xAlarmeMotorForno OR xAlarmeMotorResfriador OR xAlarmePortaSaidaFornoAberta OR xAlarmeGeralEncoderMeResfriador THEN
			PassoAlmMesaForno:=164;
			PassoMesaForno:=400;
		END_IF
		
	190:xFinalizaRelatorioProd:=TRUE;
		xDescarregandoForno:=FALSE;
		xFornoCheio:=FALSE;
		xFornoComCarga:=FALSE;
		xPortaSaidaForno:=FALSE;
		xValvulaScanner:=FALSE;
		xForceSaidadoVidro:=FALSE;
		xFimDescForIniStdBy:=TRUE;
		xResetPid:=TRUE;
		PassoMesaForno:=191;

	191:IF xCarregamentoHabilitado THEN
			xRecargaForno:=TRUE; //->TASK/MesaEntrada
			xDelayCargaForno:=TRUE; //->TASK/MesaEntrada
			PassoMesaForno:=0;	
		ELSE
			xFornoEmCicloComCarga:=FALSE;
			xDelayCargaForno:=TRUE; //->TASK/MesaEntrada
			xMesaFornoOn:=FALSE;
			PassoMesaForno:=0;	
		END_IF
					
		
	// Emergência Pausa/Reinicio	
	300:xAvancoMesaForno:=FALSE;
		xRecuoMesaForno:=FALSE;
		PassoMesaForno:=301;

	301:PassoMesaForno:=302;
	
	302:IF xRestart THEN
			PassoMesaForno:=303;
		END_IF
		
	303:PassoMesaForno:=PassoPauseForno;
		
		// Alarme Motor Parada/Reinicio
	400:xAvancoMesaForno:=FALSE;
		xRecuoMesaForno:=FALSE;
		PassoMesaForno:=401;

	401:PassoMesaForno:=402;
	
	402:IF (xRestart) AND iCanOpenInverMesaFornoStateOk  THEN
			PassoMesaForno:=PassoAlmMesaForno;
		END_IF


END_CASE

//Consumo de Energia por fornada
rConsumoCargaRel:= rConsumoEnergiaReal_kWh-rConsumoInicialCarga_kW;

TpSairForno(IN:=xBtSairForno , PT:=T#500MS , Q=>xSairForno , ET=> );
IF xBtSairForno THEN
	xBtSairForno:=0;
END_IF

IF xSairForno AND NOT xResfriadorCheio AND xFornoComCarga THEN
	xForceSaidadoVidro:=TRUE;
END_IF

// TEMPORIZADORES
TempoPausaRoletes(
	IniciaTempo:= 	xFornoCarregado, 
	AbortaTempo:= 	xSairForno OR xOperacaoManual, 
	SetPointTempo:= iTempoPausaRoletes, 
	FimTempo:= 		xFimTempoPausaRoletes, 
	TempoDecorrido=>iTempoPausaRoleteDecorrido, 
	TempoRestante=> iTempoPausaRoleteRestante);
	
TempoAquecimForno(
	IniciaTempo:= xFornoCarregado, 
	AbortaTempo:= xSairForno OR xOperacaoManual, 
	SetPointTempo:= iTempoAquecimForno, 
	FimTempo:= 		xFimTempoAquecForno, 
	TempoDecorrido=>iTempoAquecFornoDecorrido, 
	TempoRestante=> iTempoAquecFornoRestante);	

xFinalizaVaivemForno:=xFimTempoAquecForno;
xLigaCargaResfriador:=xFimTempoAquecForno;
xLigaCargaPassagem:=xFimTempoAquecForno;
xLigaVent01FimForno:=	xFimTempoAquecForno AND NOT xMotorVentilador01Ligado;
xLigaVent02FimForno:=	xFimTempoAquecForno AND NOT xMotorVentilador02Ligado;
xLigaVent03FimForno:=	xFimTempoAquecForno AND NOT xMotorVentilador03Ligado;
xLigaVent04FimForno:=	xFimTempoAquecForno AND NOT xMotorVentilador04Ligado;

/////////////////////////////////////////////////////
TempoTrocaVelocidade(
	IniciaTempo:= xFimTempoTrocaPosicao,(*xFornoCarregado,*) 
	AbortaTempo:= xSairForno OR xOperacaoManual, 
	SetPointTempo:= iTempoVelocidadeForno, 
	FimTempo:= xFimTempoTrocaVelocidade, 
	TempoDecorrido=> iTempoTrocaVelocidadeDecorrido, 
	TempoRestante=> );

TempoTrocaPosicao(
	IniciaTempo:= xFornoCarregado, 
	AbortaTempo:= xSairForno OR xOperacaoManual, 
	SetPointTempo:= iTempoPosicaoForno, 
	FimTempo:= xFimTempoTrocaPosicao, 
	TempoDecorrido=> iTempoTrocaPosicaoDecorrido, 
	TempoRestante=> );	
	
//STATUS
xFornoVazio:=NOT xFornoCheio; 
	
// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorMesaFornoAvanco:= xAvancoMesaForno;
xMotorMesaFornoRecuo:= xRecuoMesaForno;

InversorMesaForno.i_xAvanco:=xMotorMesaFornoAvanco;
InversorMesaForno.i_xRecuo:=xMotorMesaFornoRecuo;

// Velocidade
InversorMesaForno.i_iFreqRef:=iVelocidadeMesaForno;	

//------------------------------------------------------------------------\\


IF	uHoraRealTime=21 AND uMinutoRealTime=0 AND uSegundoRealTime=0 THEN
	uNumeroCargaRel:=0;
END_IF

ConversorPulMilim(
	dPulso:= 82071, 
	dMilimetro:= 6192, 
	dEntradaPulso01:= dTamanhoCarga,
	iSaidaMilimetro01=> iTamanhoCargaAtualForno );
	
	
IF xOperacaoManual THEN
	xLedStart:=FALSE;
	PassoIniciaForno:=0;
	PassoPauseIniForno:=0;
	PassoAlmIniForno:=0;
	PassoMesaForno:=0;
	PassoPauseForno:=0;
	PassoAlmMesaForno:=0;
	
	PassoVelVaivem:=0;////////
	PassoPosVaivem:=0;///////	
	ContadorMudaPos:=0;
	xIniciaCargaForno:=FALSE;
	xHomeEncoderForno:=FALSE;
	xCarregandoForno:=FALSE;
	xFornoCheio:=FALSE;
	xFornoEmCicloComCarga:=FALSE;
	xMesaFornoOn:=FALSE;
	xTamanhoCargaFora:=FALSE;
	xTamanhoCargaOk:=FALSE;
	xRetornandoForno:=FALSE;
	xFornoCarregado:= FALSE;
	xIniciaPausaResistencias:= FALSE;
	xLigaConveccaoForno:= FALSE;
	xFimTempoPausaRoletes:=FALSE;
	xFimTempoAquecForno:=FALSE;
	xFimTempoTrocaVelocidade:=FALSE;//////
	xFimTempoTrocaPosicao:=FALSE;//////
	xFinalizaVaivemForno:=FALSE;
	xFimTempoPausaResistInf:=FALSE;
	xFimTempoPausaResistSup:=FALSE;
	xFimTempoPausa02ResistSup:=FALSE;
	xDescarregandoForno:=FALSE;
	xIniciaRelatorioProd:= FALSE;
	xFinalizaRelatorioProd:= FALSE;
	TonParadaSemEnerIn:=FALSE;
	xTempoPausaRoletesOn:=FALSE;
	xFimCalculoCarga:=FALSE;
	xFornoComCarga:=FALSE;
	xPausaHabilitaTesteEncoder:=FALSE;
	xForceSaidadoVidro:=FALSE;
	xVelocidade01VaivemForno:=FALSE;//////	
	xPosicao01VaivemForno:=FALSE;/////////
	xAbreVenezVentPass:=FALSE;
	xValvulaScanner:=FALSE;
	
	xPortaEntradaForno:=FALSE;
	xPortaSaidaForno:=FALSE;

	
	xAvancoMesaForno:=FALSE;
	xRecuoMesaForno:=FALSE;
END_IF


xDesabFalhInvMesaForno:= NOT xFornoEmCicloComCarga;
