__METADATA__
{
  "v3Meta": {
    "objectGuid": "335e8aca-1508-465c-a7e7-d669de431bfa",
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
PROGRAM C_Alarmes
VAR
	IndexAlm01: INT;
	AlmValvPortaEntrada: AlarmeValvula1vNeg;
	AlmValvPortaSaida: AlarmeValvula1vNeg;
	AlmGradeEntrada: AlarmeValvula1v;
	AlmGradeSaida: AlarmeValvula1v;
	TpAlmMotorSom: ARRAY[1..25] OF TP;
	TpAlmMotorSomIn: ARRAY[1..25] OF BOOL;
	TpAlmMotorSomQ: ARRAY[1..25] OF BOOL;
	AlmMotorSom: ARRAY[1..25] OF BOOL;
	AlarmeSom: TimerGeneration;
	AlarmeLum: TimerGeneration;
	xAlarmeSomEnable: BOOL;
	xAlarmeSomOut: BOOL;
	xAlarmeLumEnable: BOOL;
	xAlarmeLumOut: BOOL;
	TpRstSuper: TP;
	TpRstSuperiN: BOOL;
	TpRstSuperQ: BOOL;
	xAlarmeSonPortaEntradaForno: BOOL;
	xAlarmeSonPortaSaidaForno: BOOL;
	xAlarmeSonValvulaGradeEntrada: BOOL;
	xAlarmeSonValvulaGradeSaida: BOOL;
	xAlarmeGeralEncoder: BOOL;
	xAlarmeSonoroEncoderGeral: BOOL;
	xAlarmeGeralMotorParado: BOOL;
	xAlarmeSonoroMotorParadoGeral: BOOL;
	AlmMotoresBitsSoma: INT;
	AlmMotoresSonBitsSoma: INT;
END_VAR
__IMPLEMENTATION__
AlmMotoresBitsSoma:=0;
AlmMotoresSonBitsSoma:=0;
FOR IndexAlm01:=1 TO 50 DO
	xAlarmesResistenciasGeralInferior[IndexAlm01]:=xAlarmeSsrInferiorFechado[IndexAlm01] OR xAlarmeSsrInferiorAberto[IndexAlm01] OR (*xAlarmeResistRompidaInferior[IndexAlm01]*) xFalhaForcadaInferior[IndexAlm01] OR xAlarmeResistForceInferior[IndexAlm01] OR AlmTermoparAbertoLogicoInf[IndexAlm01] OR AlmTemperaturaExcedeuLogicoInf[IndexAlm01];	
	xAlarmesResistenciasGeralSuperior[IndexAlm01]:=xAlarmeSsrSuperiorFechado[IndexAlm01] OR xAlarmeSsrSuperiorAberto[IndexAlm01] OR (*xAlarmeResistRompidaSuperior[IndexAlm01]*) xFalhaForcadaSuperior[IndexAlm01] OR xAlarmeResistForceSuperior[IndexAlm01] OR AlmTermoparAbertoLogicoSup[IndexAlm01] OR AlmTemperaturaExcedeuLogicoSup[IndexAlm01];	

	
	AlmMotoresBitsSoma:= AlmMotoresBitsSoma+ BOOL_TO_INT (AlmMotor[IndexAlm01]);
 
	TpAlmMotorSomIn[IndexAlm01]:=AlmMotor[IndexAlm01];
	TpAlmMotorSom[IndexAlm01](IN:=TpAlmMotorSomIn[IndexAlm01] , PT:=T#1S , Q=>TpAlmMotorSomQ[IndexAlm01] , ET=> );
	IF TpAlmMotorSomQ[IndexAlm01] THEN
		AlmMotorSom[IndexAlm01]:=TRUE;
	END_IF
	IF	bResetAlmGeral or xResetErro THEN
		AlmMotorSom[IndexAlm01]:=FALSE;
		AlmMotoresSonBitsSoma:=0;
		
	END_IF
	AlmMotoresSonBitsSoma:= AlmMotoresSonBitsSoma+ BOOL_TO_INT (AlmMotorSom[IndexAlm01]);

	xAlarmesTestesResistenciasInferiores[IndexAlm01]:=xTesteResistenciaInferiorFlh[IndexAlm01] OR xFalhaForcadaInferior[IndexAlm01] OR xAlarmeResistForceInferior[IndexAlm01];
	xAlarmesTestesResistenciasSuperiores[IndexAlm01]:=xTesteResistenciaSuperiorFlh[IndexAlm01] OR xFalhaForcadaSuperior[IndexAlm01] OR xAlarmeResistForceSuperior[IndexAlm01];

END_FOR;
xAlarmesMotores:= AlmMotoresBitsSoma>=1;
xAlarmesMotoresSon:= AlmMotoresSonBitsSoma>=1;

TpRstSuper(IN:=BtResetAlarmesGerais , PT:=T#500MS , Q=> TpRstSuperQ, ET=> );

bResetAlmGeral:=TpRstSuperQ OR xBtCalaAlarme ;
xBotaoResetaDrives:=TpRstSuperQ OR xBtCalaAlarme ;

IF BtResetAlarmesGerais THEN
	BtResetAlarmesGerais:=FALSE;
END_IF
//Alarmes de Motores

xAlarmeMotorEntrada	:=(xFalhaMotorEntrada OR xAlarmeCofInverMesaEntra);//AND NOT xPausaEmergenciaTof;
xAlarmeMotorForno	:=(xFalhaMotorForno OR xAlarmeCofInverMesaForno);//AND NOT xPausaEmergenciaTof;
xAlarmeMotorPass	:=(xFalhaMotorPassagem );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorResfriador:=(xFalhaMotorResfriador OR xAlarmeCofInverMesaResfr);//AND NOT xPausaEmergenciaTof;
xAlarmeMotorSaida	:=(xFalhaMotorSaida OR xAlarmeCofInverMesaSaida);//AND NOT xPausaEmergenciaTof;
xAlarmeMotorDifusorInf01:=(xFalhaMotorDifusorInf01 );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorDifusorSup01:=(xFalhaMotorDifusorSup01 );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorDifusorInf02:=(xFalhaMotorDifusorInf02 );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorDifusorSup02:=(xFalhaMotorDifusorSup02 OR xAlarmeCofInverResfrSup02);//AND NOT xPausaEmergenciaTof;
xAlarmeMotorGuilhotina01:=(xFalhaMotorGuilhotina01 );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorGuilhotina02:=(xFalhaMotorGuilhotina02 OR xAlarmeCofInverGuilho02);//AND NOT xPausaEmergenciaTof;
xAlarmeMotorLimpResfr02:=(xFalhaMotorLimpResfr02 );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorCaixaForno:=(xFalhaMotorCaixaForno OR xAlarmeCofInverCaixaForno);//AND NOT xPausaEmergenciaTof;
xAlarmeMotorVentilador01:=(xFalhaMotorVentilador01 );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorVentilador02:=(xFalhaMotorVentilador02 );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorVentilador03:=(xFalhaMotorVentilador03 OR xAlarmeCofInverVentila03);//AND NOT xPausaEmergenciaTof;
xAlarmeMotorVentilador04:=(xFalhaMotorVentilador04 );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorVentConvecEnt:=(xFalhaMotorVentConvecEnt OR xAlarmeCofInverConvecEnt);//AND NOT xPausaEmergenciaTof;
xAlarmeMotorVentConvecSai:=(xFalhaMotorVentConvecSai );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorGuilhotina01Sup:=(xFalhaMotorGuilhotina01Sup );//AND NOT xPausaEmergenciaTof;
xAlarmeMotorGuilhotina01Inf:=(xFalhaMotorGuilhotina01Inf );//AND NOT xPausaEmergenciaTof;

	
AlmMotor[1]:=xAlarmeMotorEntrada;
AlmMotor[2]:=AlmMotor[2];
AlmMotor[3]:=xAlarmeMotorForno;
AlmMotor[4]:=xAlarmeMotorPass;
AlmMotor[5]:=xAlarmeMotorResfriador;
AlmMotor[6]:=xAlarmeMotorSaida;
AlmMotor[7]:=xAlarmeMotorDifusorSup01;
AlmMotor[8]:=xAlarmeMotorDifusorInf01;
AlmMotor[9]:=xAlarmeMotorDifusorSup02;
AlmMotor[10]:=xAlarmeMotorDifusorInf02;
AlmMotor[11]:=xAlarmeMotorGuilhotina01;
AlmMotor[12]:=xAlarmeMotorGuilhotina02;
AlmMotor[13]:=AlmMotor[13];
AlmMotor[14]:=xAlarmeMotorCaixaForno;
AlmMotor[15]:=xAlarmeMotorVentilador01;
AlmMotor[16]:=xAlarmeMotorVentilador02;
AlmMotor[17]:=xAlarmeMotorVentilador03;
AlmMotor[18]:=xAlarmeMotorVentilador04;
AlmMotor[19]:=xAlarmeMotorBombaHidraulica;
AlmMotor[20]:=xAlarmeMotorVentConvecEnt;
AlmMotor[21]:=xAlarmeMotorVentConvecSai;
AlmMotor[22]:=xAlarmeMotorGuilhotina01Sup;
AlmMotor[23]:=xAlarmeMotorGuilhotina01Inf;
AlmMotor[24]:=xAlarmeMotorOscilaSup02;
AlmMotor[25]:=xAlarmeMotorOscilaInf02;

//Alarmes de Válvula

xSensorPortaEntradaAberta:=xSensorPortaEntrada;
xSensorPortaEntradaFechada:= NOT xSensorPortaEntrada;

AlmValvPortaEntrada(
	SensorValvAberta:= xSensorPortaEntradaAberta , 
	SensorValvFechad:= xSensorPortaEntradaFechada, 
	AcionamentoValvula:= xValvPortaEntradaForno,// OR xOperacaoManual, 
	ResetAlarm:=bResetAlmGeral OR xOperacaoManual,
	TempoAberto:= T#1500MS,
	TempoFechad:= T#1500MS,
	AlarmeValvAberta=> xAlarmePortaEntradaFornoAberta, //Porta não Abriu
	AlarmeValvFechada=> xAlarmePortaEntradaFornoFechada, // Porta não Fechou
	AlarmeSonoro=> xAlarmeSonPortaEntradaForno);

xAlarmePortaEntradaForno:=xAlarmePortaEntradaFornoAberta OR xAlarmePortaEntradaFornoFechada;

xSensorPortaSaidaAberta:=xSensorPortaSaida;
xSensorPortaSaidaFechada:= NOT xSensorPortaSaida;
	
AlmValvPortaSaida(
	SensorValvAberta:= xSensorPortaSaidaAberta , 
	SensorValvFechad:= xSensorPortaSaidaFechada, 
	AcionamentoValvula:= xValvPortaSaidaForno,// OR xOperacaoManual, 
	ResetAlarm:=bResetAlmGeral OR xOperacaoManual,
	TempoAberto:= T#2500MS,
	TempoFechad:= T#2000MS,
	AlarmeValvAberta=> xAlarmePortaSaidaFornoAberta, //Porta não Abriu
	AlarmeValvFechada=> xAlarmePortaSaidaFornoFechada, // Porta não Fechou
	AlarmeSonoro=> xAlarmeSonPortaSaidaForno);

xAlarmePortaSaidaForno:=xAlarmePortaSaidaFornoAberta OR xAlarmePortaSaidaFornoFechada;

// Alarme Grade Mesa de Entrada	

xSensorGradeEntradaDown:= NOT xSensorGradeEntradaUp;

(*
AlmGradeEntrada(
	SensorValvAberta:= xSensorGradeEntradaUp, 
	SensorValvFechad:= xSensorGradeEntradaDown, 
	AcionamentoValvula:= xValvulaGradeEntrada, 
	ResetAlarm:=bResetAlmGeral,
	TempoAberto:= T#2000MS,
	TempoFechad:= T#2000MS,
	AlarmeValvAberta=> xAlarmeValvulaGradeEntradaUp, 
	AlarmeValvFechada=> xAlarmeValvulaGradeEntradaDown, 
	AlarmeSonoro=>xAlarmeSonValvulaGradeEntrada);
*)	
xAlarmeValvulaGradeEntrada:= xAlarmeValvulaGradeEntradaUp OR xAlarmeValvulaGradeEntradaDown;
	
// Alarme Grade Mesa de Saída	

xSensorGradeSaidaDown:= NOT xSensorGradeSaidaUp;

AlmGradeSaida(
	SensorValvAberta:= xSensorGradeSaidaUp, 
	SensorValvFechad:= xSensorGradeSaidaDown, 
	AcionamentoValvula:= xValvulaGradeSaida, 
	ResetAlarm:=bResetAlmGeral,
	TempoAberto:= T#5000MS,
	TempoFechad:= T#4000MS,
	AlarmeValvAberta=> xAlarmeValvulaGradeSaidaUp, 
	AlarmeValvFechada=> xAlarmeValvulaGradeSaidaDown, 
	AlarmeSonoro=> xAlarmeSonValvulaGradeSaida);

xAlarmeValvulaGradeSaida:= xAlarmeValvulaGradeSaidaUp OR xAlarmeValvulaGradeSaidaDown;

AlmValvAberta[1]:=xAlarmePortaEntradaFornoAberta;
AlmValvAberta[2]:=xAlarmePortaSaidaFornoAberta;
AlmValvAberta[3]:=xAlarmeValvulaGradeEntradaUp;
AlmValvAberta[4]:=xAlarmeValvulaGradeSaidaUp;
AlmValvAberta[5]:=AlmValvAberta[5];
AlmValvAberta[6]:=AlmValvAberta[6];
AlmValvAberta[7]:=AlmValvAberta[7];
AlmValvAberta[8]:=AlmValvAberta[8];
AlmValvAberta[9]:=AlmValvAberta[9];
AlmValvAberta[10]:=AlmValvAberta[10];

AlmValvFechada[1]:=xAlarmePortaEntradaFornoFechada;
AlmValvFechada[2]:=xAlarmePortaSaidaFornoFechada;
AlmValvFechada[3]:=xAlarmeValvulaGradeEntradaDown;
AlmValvFechada[4]:=xAlarmeValvulaGradeSaidaDown;
AlmValvFechada[5]:=AlmValvFechada[5];
AlmValvFechada[6]:=AlmValvFechada[6];
AlmValvFechada[7]:=AlmValvFechada[7];
AlmValvFechada[8]:=AlmValvFechada[8];
AlmValvFechada[9]:=AlmValvFechada[9];
AlmValvFechada[10]:=AlmValvFechada[10];


//Alarmes Gerais
AlmGeral[1]:=xAlarmePressaoArBaixaRede;
AlmGeral[2]:=xAlarmePressaoArAltaRede;
AlmGeral[3]:=xAlmNobreak;
AlmGeral[4]:=xSemEnergia;
AlmGeral[5]:=xLimpVidroForaPosicao;
AlmGeral[6]:=xAlmDisjGeral;
AlmGeral[7]:=xAlmDisjResist;
AlmGeral[8]:=xAlarmePressaoArBaixaMaq;
AlmGeral[9]:=xAlarmePressaoArAltaMaq;
AlmGeral[10]:=AlmGeral[10];

// Alarmes de Encoder
xAlarmeGeralEncoder:= xAlarmeGeralEncoderMeForno OR xAlarmeGeralEncoderMeResfriador (*OR xAlarmeGeralEncoderDuResfriadorSup01 OR xAlarmeGeralEncoderDuResfriadorInf01*) OR xAlarmeGeralEncoderDuResfriadorSup02 (*OR xAlarmeGeralEncoderDuResfriadorInf02 OR xAlarmeGeralEncoderGuiResfriador01*) OR xAlarmeGeralEncoderGuiResfriador02;
xAlarmeSonoroEncoderGeral:= xAlarmeSonoroEncoderMeForno OR xAlarmeSonoroEncoderMeResfriador (*OR xAlarmeSonoroEncoderDuResfriadorSup01 OR xAlarmeSonoroEncoderDuResfriadorInf01*) OR xAlarmeSonoroEncoderDuResfriadorSup02 (*OR xAlarmeSonoroEncoderDuResfriadorInf02 OR xAlarmeSonoroEncoderGuiResfriador01*) OR xAlarmeSonoroEncoderGuiResfriador02;

AlmEncoder[1]:=AlmEncoder[1];
AlmEncoder[2]:=xAlarmeGeralEncoderMeForno;
AlmEncoder[3]:=xAlarmeGeralEncoderMeResfriador;
AlmEncoder[4]:=xAlarmeGeralEncoderDuResfriadorSup01;
AlmEncoder[5]:=FALSE;//xAlarmeGeralEncoderDuResfriadorInf01;
AlmEncoder[6]:=xAlarmeGeralEncoderDuResfriadorSup02;
AlmEncoder[7]:=xAlarmeGeralEncoderDuResfriadorInf02;
AlmEncoder[8]:=xAlarmeGeralEncoderGuiResfriador01;
AlmEncoder[9]:=xAlarmeGeralEncoderGuiResfriador02;
AlmEncoder[10]:=FALSE;


// Alarmes Motor Parado por Falha Desconhecida

xAlarmeGeralMotorParado:=  xAlarmeMeFornoParado OR xAlarmeMeResfrParado;
xAlarmeSonoroMotorParadoGeral:= xAlarmeMeFornoParadoSom OR xAlarmeMeResfrParadoSom;

AlmMotorParado[1]:=AlmMotorParado[1];
AlmMotorParado[2]:=xAlarmeMeFornoParado;
AlmMotorParado[3]:=xAlarmeMeResfrParado;
AlmMotorParado[4]:=AlmMotorParado[4];
AlmMotorParado[5]:=AlmMotorParado[5];
AlmMotorParado[6]:=AlmMotorParado[6];
AlmMotorParado[7]:=AlmMotorParado[7];
AlmMotorParado[8]:=AlmMotorParado[8];
AlmMotorParado[9]:=AlmMotorParado[9];
AlmMotorParado[10]:=AlmMotorParado[10];


//Alerta Luminoso e Sonoro de Alarme

xAlarmeLumEnable:=xAlarmePortaEntradaForno OR xAlarmePortaSaidaForno OR xAlarmeValvulaGradeEntrada OR xAlarmeValvulaGradeSaida OR xAlarmesTermopares OR xAlarmesSSr OR xAlarmesMotores OR xAlarmePressaoArRede OR xAlarmePressaoArMaq OR xAlmNobreak OR xSemEnergia OR xAlmDisjGeral OR xAlmDisjResist OR xAlarmeGeralEncoder OR xAlarmeGeralMotorParado OR xLimpVidroForaPosicao OR xAlarmeSsrConvecEntSin OR xAlmTermoparAbertoConvecEntSin OR xAlmTemperExcedeuConvecEntSin;
AlarmeLum(ENABLE:=xAlarmeLumEnable , TIMELOW:=T#1S , TIMEHIGH:=T#1S , OUT=>xAlarmeLumOut );
//xAlarmeLuminoso:=xAlarmeLumOut OR xBtEmergencia OR NOT xReleSeguranca;
xSinalLumAmar:=xAlarmeLumOut;
xSinalLumVerm:=xBtEmergencia OR NOT xReleSeguranca OR xLedMotFornoStop;
xSinalLumVerd:= NOT xSinalLumVerm AND xLedMaqEmCiclo;

xAlarmeSomEnable:=xAlarmeSonPortaEntradaForno OR xAlarmeSonPortaSaidaForno OR xAlarmeSonValvulaGradeSaida OR xAlarmeSonValvulaGradeEntrada OR xAlarmesTermoparesSon OR xAlarmesSSrSon OR xAlarmesMotoresSon OR xAlarmePressaoArRedeSom OR xAlarmePressaoArMaqSom OR xAlmNobreakSom OR xAlmSomSemEnergia OR xAlmDisjGeralSom OR xAlmDisjResistSom OR xAlarmeSonoroEncoderGeral OR xAlarmeSonoroMotorParadoGeral OR xLimpVidroForaPosicaoSon OR xAlarmeSsrConvecEntSon OR xAlmTermoparAbertoConvecEntSon OR xAlmTemperExcedeuConvecEntSon;
AlarmeSom(ENABLE:=xAlarmeSomEnable , TIMELOW:=T#1S , TIMEHIGH:=T#1S , OUT=>xAlarmeSomOut );

xAlarmeSonoro:= (xAlarmeSomOut OR xSomDescarga OR xSomSemEnergia AND NOT xMotorCaixaFornoLigado) OR xAlertaSomCxForno;



