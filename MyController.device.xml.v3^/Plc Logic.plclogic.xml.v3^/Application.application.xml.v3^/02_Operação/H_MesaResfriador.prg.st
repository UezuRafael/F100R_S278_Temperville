__METADATA__
{
  "v3Meta": {
    "objectGuid": "748b0c46-4a61-43c3-9087-cf9d0c26e4c6",
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
PROGRAM H_MesaResfriador
VAR
	///Passo da Execução da Movimentação do Resfriador
	PassoMesaResfriador: INT;
	PassoPauseResfriador: INT;
	PassoAlmMesaResfriador: INT;
	PassoManualResfriador: INT;
	///Blocos Nativos
	TpSairResfriamento: TP;
	TpSomDescarga: TP;
	TonMotorSaidaOff: TON;
	///Bloco Conta Tempo de Permanecia no Resfriador
	TempoResfriamento: Temporizador;
	///Bloco Calcula Posições de Paradas da Carga
	CalculosMesaResfriador: CalculosResfriador;
	///Bloco Converte Milimetro em Pulsos
	ConversorMilimPul: MmConversorPulso;
	///Bloco Converte Pulsos em Milimetros
	ConversorPulMilim: PulsoConversorMm;
	///Bloco Seleciona Pulsos para Vidro Fino ou Grosso
	SelecaoPulsos: BlocoSelecaoEspessura;
	iVelocidadeMesaResfriador: INT;
	///Variaveis que Habilitam o Inicio do Ciclo de Resfriamento
	///Variáveis Booleanas Auxiliares
	xFimTempoResfriamento: BOOL;
	xFinalizaVaivemResfriador: BOOL;
	///Variáveis inteiras Auxiliares
	dValEncoVelMinResfriador: DINT;
	dValEncoCargaResfriador: DINT;
	dValEncoAvancoResfriador: DINT;
	dValEncoRecuoResfriador: DINT;
	dValEncoDescargaResfriador: DINT;
	iValorCargaResfriador: INT;
	iValorOscilacaoResfriador: INT;
	iValorDescargaResfriador: INT;
	iTamanhoAreaUtilResfriador: INT;
	iValMilimetroVelMinResfriador: INT;
	iValMilimetroCargaResfriador: INT;
	iValMilimetroAvancoResfriador: INT;
	iValMilimetroRecuoResfriador: INT;
	iValMilimetroDescargaResfriador: INT;
	dTamanhoCargaResfriador: DINT;
	xSairResfriamento: BOOL;
	xSairFornoResfriamento: BOOL;
	xAlarmeTempoMotorSaida: BOOL;
	xDesablePausaMesaResfriamento: BOOL;
END_VAR
__IMPLEMENTATION__
// Direcao de Rotação da Mesa do Resfriamento

xAvancandMesaResfriador:=NOT xMotorMesaResfriadorDirecao AND xMotorResfriadorLigado;
xRecuandoMesaResfriador:=xMotorMesaResfriadorDirecao AND xMotorResfriadorLigado;



//SELEÇÃO DOS PARAMETROS PELA ESPESSURA DO VIDRO
SelecaoPulsos(
	xSelecao:= xEspessuraVidroFinoResfriador, 	
	iEntrada0101:= iValorCargaResfriadorVidroFin, 
	iEntrada0102:= iValorCargaResfriadorVidroGro, 
	iEntrada0201:= iValorOscilacaoResfriadorVidroFin, 
	iEntrada0202:= iValorOscilacaoResfriadorVidroGro, 
	iEntrada0301:= iValorDescargaResfriadorVidroFin, 
	iEntrada0302:= iValorDescargaResfriadorVidroGro, 
	iEntrada0401:= iTamanhoAreaUtilResfriadorVidroFin,
	iEntrada0402:= iTamanhoAreaUtilResfriadorVidroGro,
	iSaida01=> iValorCargaResfriador, 
	iSaida02=> iValorOscilacaoResfriador, 
	iSaida03=> iValorDescargaResfriador,
	iSaida04=> iTamanhoAreaUtilResfriador);

// CALCULOS DE POSICIONAMENTO
IF iVelocidadeDescargaMesadoForno>4500 THEN
	iValorVelMinimaResfriador:=550;
ELSE
	iValorVelMinimaResfriador:=350;
END_IF

CalculosMesaResfriador(
	DistanciaVelMinResfriador:= iValorVelMinimaResfriador, 
	DistanciaCargaResfriador:= iValorCargaResfriador, 
	DistanciaOscilacaoResfriador:= iValorOscilacaoResfriador, 
	DistanciaDescargaResfriador:= iValorDescargaResfriador, 
	TamanhoAreaUtil:=iTamanhoAreaUtilResfriador,///////
	TamanhoCarga:=iTamanhoCargaAtualResfriador,///////
	SetPointVelMinCarga=> iValMilimetroVelMinResfriador, 
	SetPointCargaResfriador=> iValMilimetroCargaResfriador, 
	SetPointDescargaResfriador=> iValMilimetroDescargaResfriador, 
	SetPointAvancaVaiVemResfriador=> iValMilimetroAvancoResfriador, 
	SetPointRecuaVaiVemResfriador=> iValMilimetroRecuoResfriador);
	
// CONVERSÃO MILIMETROS EM PULSOS

ConversorMilimPul(
	dPulso:= 111325, 
	dMilimetro:= 6100, 
	iEntrMilimetro01:= iValMilimetroVelMinResfriador, 
	iEntrMilimetro02:= iValMilimetroCargaResfriador, 
	iEntrMilimetro03:= iValMilimetroDescargaResfriador, 
	iEntrMilimetro04:= iValMilimetroAvancoResfriador, 
	iEntrMilimetro05:= iValMilimetroRecuoResfriador, 
	iEntrMilimetro06:= iTamanhoCargaAtualResfriador, 
	dSaidaPulso01=> dValEncoVelMinResfriador, 
	dSaidaPulso02=> dValEncoCargaResfriador, 
	dSaidaPulso03=> dValEncoDescargaResfriador, 
	dSaidaPulso04=> dValEncoAvancoResfriador, 
	dSaidaPulso05=> dValEncoRecuoResfriador, 
	dSaidaPulso06=> dTamanhoCargaResfriador);

// Velovidade do Vai Vem;

iVelocidadeVaiVemMesaResfriador:=iVelocidadeVaiVemResfriador/10;//////////////////////////////
	
// MOVIMENTAÇÃO DA MESA DO RESFRIADOR
CASE PassoMesaResfriador OF
	
		0:	IF xLigaCargaResfriador THEN
				PassoMesaResfriador:=1;
			END_IF
			
		1:	xMesaResfriadorOn:=TRUE;
			xDesablePausaMesaResfriamento:=TRUE;
			IF xPause THEN
				PassoPauseResfriador:=1;
				PassoMesaResfriador:=300;
				xLigaCargaResfriador:=TRUE;
			ELSIF xAlarmeMotorResfriador THEN
				PassoAlmMesaResfriador:=1;
				PassoMesaResfriador:=400;
			ELSE
				PassoMesaResfriador:=2;
			END_IF

		2:	//xIniciaCargaResfriador:=FALSE;
			iVelocidadeMesaResfriador:= iVelocidadeCargaMesaResfriador;(*Velocidade Carga Resfriador*)
			PassoMesaResfriador:=3;

		3: 	xHomeEncoderResfriador:=TRUE;
			PassoMesaResfriador:=7;
			
		7:	xAvancoMesaResfriador:=TRUE;
			PassoMesaResfriador:=9;
			
		9:	xHomeEncoderResfriador:=FALSE;
			PassoMesaResfriador:=10;
	
		10:	xLigaCargaResfriador:=FALSE;
			IF xIniciaCargaResfriador THEN				
				PassoMesaResfriador:=11;
			END_IF
			IF xPause THEN
				PassoPauseResfriador:=1;
				PassoMesaResfriador:=300;
				xLigaCargaResfriador:=TRUE;
			END_IF
			IF xAlarmeMotorResfriador THEN
				PassoAlmMesaResfriador:=1;
				PassoMesaResfriador:=400;
			END_IF

	
			
		11:	xHomeEncoderResfriador:=TRUE;
			PassoMesaResfriador:=12;
			
		12:PassoMesaResfriador:=13;

		13:xHomeEncoderResfriador:=FALSE;
			PassoMesaResfriador:=20;
		
		20:	xIniciaCargaResfriador:=FALSE;
			xCarregandoResfriador:=TRUE;
			xResfriadorEmCiclo:=TRUE;
			iTamanhoCargaAtualResfriador:=iTamanhoCargaAtualForno;
			PassoMesaResfriador:=23;
			
		21:	xAvancoMesaResfriador:=TRUE;
			PassoMesaResfriador:=23;

			
		23:	IF (dValorEncoderResfriador>=dValEncoVelMinResfriador) THEN
				PassoMesaResfriador:=29;
			END_IF
			(*IF xCancelaCargaResfriamento THEN
				PassoMesaResfriador:=25;
			END_IF*)
			IF xPause THEN
				PassoPauseResfriador:=21;
				PassoMesaResfriador:=300;
			END_IF
			IF xAlarmeMotorResfriador OR xAlarmeMotorForno OR xAlarmeGeralEncoderMeResfriador OR xAlarmePortaSaidaFornoAberta THEN
				PassoAlmMesaResfriador:=21;
				PassoMesaResfriador:=400;
			END_IF

		25:	xCancelaCargaResfriamento:=FALSE;
			xCarregandoResfriador:=FALSE;
			xResfriadorEmCiclo:=FALSE;
			PassoMesaResfriador:=10;
			
		28:	xAvancoMesaResfriador:=TRUE;
			PassoMesaResfriador:=29;

		29:	iVelocidadeMesaResfriador:= iVelMinCargaResfriador;(*Velocidade Minima Carga Resfriador*)
			PassoMesaResfriador:=30;
		
		30: PassoMesaResfriador:=40;
			xDesligaVentilador01	:=TRUE;	//-> TASK/M_Ventilador01 - (*Alterado Tempera de passagem *)
			xFimDescargaMesaPass:=TRUE;

		40: IF (dValorEncoderResfriador>=dValEncoCargaResfriador) THEN
				PassoMesaResfriador:=50;
			END_IF
			IF xPause THEN
				PassoPauseResfriador:=28;
				PassoMesaResfriador:=300;
			END_IF
			IF xAlarmeMotorResfriador OR xAlarmeGeralEncoderMeResfriador THEN
				PassoAlmMesaResfriador:=28;
				PassoMesaResfriador:=400;
			END_IF

		50: xCarregandoResfriador:=FALSE;
			xResfriadorCarregado:= TRUE;
			xResfriadorCheio:=TRUE;
			xInicioPrimeiroEstagio:=TRUE;
			xReajustaAlturaDuctosInf01:=TRUE;(* Alterado para tempera de passagem *)
			xReajustaAlturaDuctosSup01:=TRUE;(* Alterado para tempera de passagem *)
			//xDesligaVentilador01	:=TRUE;	//-> TASK/M_Ventilador01 - (*Alterado Tempera de passagem *)
			xDesligaVentilador02	:=TRUE;	//-> TASK/M_Ventilador02 - (*Alterado Tempera de passagem *)
			xFechVenezVentPass		:=TRUE; //-> TASK/T_VenezianaVentInfPass
			PassoMesaResfriador:=55;
		
		55: xAvancoMesaResfriador:=FALSE;
			PassoMesaResfriador:=60;
			
		60:	iVelocidadeMesaResfriador:= 1*iVelocidadeVaiVemMesaResfriador;(*-Velocidade VaiVem Resfriador*)
			PassoMesaResfriador:=61;
			
		61:	xRecuoMesaResfriador:=TRUE;
			PassoMesaResfriador:=62;			
			
		62:	xDesablePausaMesaResfriamento:=FALSE;
			PassoMesaResfriador:=70;
		
		70: IF NOT xFinalizaVaivemResfriador THEN
				IF (dValorEncoderResfriador<=dValEncoRecuoResfriador) THEN
					PassoMesaResfriador:=80;
				END_IF
				IF iVelocidadeMesaResfriador <> 1*iVelocidadeVaiVemMesaResfriador THEN
					PassoMesaResfriador:=60;
				END_IF
				IF xPause THEN
					PassoPauseResfriador:=60;
					PassoMesaResfriador:=300;
				END_IF			
				IF xAlarmeMotorResfriador OR xAlarmeGeralEncoderMeResfriador THEN
					PassoAlmMesaResfriador:=60;
					PassoMesaResfriador:=400;
				END_IF
			ELSE 
				xPausaMesaResfrimento:=FALSE;
				xDesablePausaMesaResfriamento:=TRUE;
				PassoMesaResfriador:=115;
			END_IF
			

		80:	xRecuoMesaResfriador:=FALSE;
			PassoMesaResfriador:=90;
		
		90:iVelocidadeMesaResfriador:= iVelocidadeVaiVemMesaResfriador;(*-Velocidade VaiVem Resfriador*)
			PassoMesaResfriador:=91;
	
		91:	xAvancoMesaResfriador:=TRUE;
			PassoMesaResfriador:=100;
		
		100:PassoMesaResfriador:=101;
		
		101:IF NOT xFinalizaVaivemResfriador THEN
				IF (dValorEncoderResfriador>=dValEncoAvancoResfriador) THEN
					PassoMesaResfriador:=110;
				END_IF
				IF iVelocidadeMesaResfriador <> iVelocidadeVaiVemMesaResfriador THEN
					PassoMesaResfriador:=90;
				END_IF
				IF xPause THEN
					PassoPauseResfriador:=90;
					PassoMesaResfriador:=300;
				END_IF		
				IF xAlarmeMotorResfriador OR xAlarmeGeralEncoderMeResfriador THEN
					PassoAlmMesaResfriador:=90;
					PassoMesaResfriador:=400;
				END_IF
			ELSE
				xPausaMesaResfrimento:=FALSE;
				xDesablePausaMesaResfriamento:=TRUE;
				PassoMesaResfriador:=120;
			END_IF
		
		110: xAvancoMesaResfriador:=FALSE;
			 PassoMesaResfriador:=60;

		
		115:xRecuoMesaResfriador:=FALSE;
			PassoMesaResfriador:=116;

		116:xAvancoMesaResfriador:=TRUE;
			PassoMesaResfriador:=120;

		120:PassoMesaResfriador:=130;
		
		130:iVelocidadeMesaResfriador:= iVelocidadeDescargaMesaResfriador;(*-Velocidade Descarga Resfriador*)
			PassoMesaResfriador:=140;
		
		140: IF xDescarregandoResfriador THEN
				 PassoMesaResfriador:=150;
			 ELSE
				 PassoMesaResfriador:=141;
			 END_IF
		
		141:xDescarregandoResfriador:=TRUE;
			xInicioDescargaMesaSaida:=TRUE;
			//xDesligaVentilador01		:=TRUE;	//-> TASK/M_Ventilador01 - (*Alterado Tempera de passagem *)
			//xDesligaVentilador02		:=TRUE;	//-> TASK/M_Ventilador02 - (*Alterado Tempera de passagem *)
			xDesligaVentilador03		:=TRUE;	//-> TASK/M_Ventilador03
			//xDesligaVentilador04		:=TRUE;	//-> TASK/M_Ventilador04
			xFimTrocaEstagiosResfriador:=TRUE; //-> TASK/EstagiosResfriador
			xDesceGradeMesaSaida:=TRUE;
			xReajustaAlturaDuctosSup02:=TRUE;; // ->TASK/J_DuctosResfriadorSup02
			xResfriadorCarregado:= FALSE;
			xFimTempoResfriamento:=FALSE;
			xFinalizaVaivemResfriador:=FALSE;
			iContaCargasResfriamento:=iContaCargasResfriamento+1;
			PassoMesaResfriador:=150;
		
		150:IF (dValorEncoderResfriador>=dValEncoDescargaResfriador) THEN
				PassoMesaResfriador:=155;
			END_IF	
			IF xPause THEN
				PassoPauseResfriador:=130;
				PassoMesaResfriador:=300;
			END_IF			
			IF xAlarmeMotorResfriador OR xAlarmeMotorSaida (*xAlarmeTempoMotorSaida*) OR xAlarmeGeralEncoderMeResfriador THEN
				PassoAlmMesaResfriador:=130;
				PassoMesaResfriador:=400;
			END_IF

		155: xFimDescargaMesaSaida:=TRUE;  //->TASK/MesaSaida
			 PassoMesaResfriador:=156;
			 
		156: xAvancoMesaResfriador:=FALSE;
			 PassoMesaResfriador:=160;

		160:xDescarregandoResfriador:=FALSE;
			xMesaResfriadorOn:=FALSE;
			xResfriadorEmCiclo:=FALSE;
			xDesabJogMesaSaida:=FALSE;//->TASK/MesaSaida
			//xFimDescargaMesaSaida:=TRUE;  //->TASK/MesaSaida
			//xFimTrocaEstagiosResfriador:=TRUE; //-> TASK/EstagiosResfriador
			xResfriadorCheio:=FALSE;
			iTamanhoCargaAtualResfriador:=0;
			PassoMesaResfriador:=170;	
			
		170://xReajustaAlturaDuctosInf01:=TRUE;
			//xReajustaAlturaDuctosSup01:=TRUE;
			xReajustaAlturaDuctosInf02:=TRUE;
			//xReajustaAlturaDuctosSup02:=TRUE;
			xDesablePausaMesaResfriamento:=FALSE;
			PassoMesaResfriador:=0;	
			
		// Emergência Pausa/Reinicio
		300:xAvancoMesaResfriador:=FALSE;
			xRecuoMesaResfriador:=FALSE;
			PassoMesaResfriador:=301;
	
		301:PassoMesaResfriador:=302;
		
		302:IF xRestart THEN
				PassoMesaResfriador:=303;
			END_IF
			
		303:PassoMesaResfriador:=PassoPauseResfriador;
	
		// Alarme Motor Parada/Reinicio
	400:xAvancoMesaResfriador:=FALSE;
		xRecuoMesaResfriador:=FALSE;
		PassoMesaResfriador:=401;

	401:PassoMesaResfriador:=402;
	
	402:IF (xRestart) AND iCanOpenInverMesaResfrStateOk  THEN
			PassoMesaResfriador:=PassoAlmMesaResfriador;
		END_IF
END_CASE
	

//Comando Sair forno foi acionado com carga no Resfriamento	
IF xResfriadorCarregado AND xSairForno THEN 
	xSairFornoResfriamento:=TRUE;
END_IF
	
TpSairResfriamento(IN:=xBtSairResfriamento OR xSairFornoResfriamento , PT:=T#500MS , Q=>xSairResfriamento , ET=> );
IF xBtSairResfriamento THEN
	xBtSairResfriamento:=FALSE;
	xSairResfriamentoEventos:=TRUE;
END_IF
IF xSairFornoResfriamento THEN
	xSairFornoResfriamento:=FALSE;
END_IF

// TEMPORIZADORES
	
TempoResfriamento(
	IniciaTempo:= xResfriadorCarregado, 
	AbortaTempo:= xSairResfriamento OR xOperacaoManual, 
	SetPointTempo:= iTempoResfriamento, 
	FimTempo:= 		xFimTempoResfriamento, 
	TempoDecorrido=>iTempoResfriamentoDecorrido, 
	TempoRestante=> iTempoResfriamentoRestante);	

xFinalizaVaivemResfriador:=xFimTempoResfriamento;

TpSomDescarga(IN:= xFimTempoResfriamento, PT:=T#5S , Q=>xSomDescarga , ET=> );

IF (iTempoResfriamentoRestante <= 2) and xResfriadorCheio THEN
	xDesabJogMesaSaida:=TRUE;//->TASK/MesaSaida
END_IF

//STATUS
xResfriadorVazio:=NOT xResfriadorCheio; 

xPausaResfrChAbreSupAcionanda:=(xPausaMesaResfrimento AND NOT xDesablePausaMesaResfriamento);
// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorMesaResfriadorAvanco:= xAvancoMesaResfriador;// AND NOT (xPausaResfrChAbreSupAcionanda);
xMotorMesaResfriadorRecuo:= xRecuoMesaResfriador;// AND NOT (xPausaResfrChAbreSupAcionanda);

InversorMesaResfri.i_xAvanco:=xMotorMesaResfriadorAvanco;
InversorMesaResfri.i_xRecuo:=xMotorMesaResfriadorRecuo;

// Velocidade
InversorMesaResfri.i_iFreqRef:=iVelocidadeMesaResfriador;	

//---------------------------------------------------------------------------------\\

IF xOperacaoManual THEN
	PassoMesaResfriador:=0;
	PassoPauseResfriador:=0;
	PassoAlmMesaResfriador:=0;
	xLigaCargaResfriador:=FALSE;
	xIniciaCargaResfriador:=FALSE;
	xCarregandoResfriador:=FALSE;
	xMesaResfriadorOn:=FALSE;
	xResfriadorEmCiclo:=FALSE;
	xCancelaCargaResfriamento:=FALSE;
	xResfriadorCarregado:= FALSE;
	xDescarregandoResfriador:=FALSE;
	xInicioDescargaMesaSaida:=FALSE;
	xFimTempoResfriamento:=FALSE;
	xFinalizaVaivemResfriador:=FALSE;
	xFimTempoResfriamento:=FALSE;
	xBtSairResfriamento:=FALSE;
	xSairFornoResfriamento:=FALSE;
	xPulsoTrocaParamResfriador:=FALSE;
	xResfriadorCheio:=FALSE;
	iTamanhoCargaAtualResfriador:=0;
	xDesabJogMesaSaida:=FALSE;
	xFechVenezVentPass		:=FALSE;
	
	xAvancoMesaResfriador:=FALSE;
	xRecuoMesaResfriador:=FALSE;
	xDesablePausaMesaResfriamento:=FALSE;
END_IF

	
IF	uHoraRealTime=0 AND uMinutoRealTime=0 AND uSegundoRealTime=0 THEN
	iContaCargasResfriamento:=0;
END_IF

// Tempo para ligar Motor da Saida ou gerar Alarme
TonMotorSaidaOff(IN:=xInicioDescargaMesaSaida AND NOT xMotorSaidaLigado, PT:= T#300MS , Q=> xAlarmeTempoMotorSaida , ET=> );
