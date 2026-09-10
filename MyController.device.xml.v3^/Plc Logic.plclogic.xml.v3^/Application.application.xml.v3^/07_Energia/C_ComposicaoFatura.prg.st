__METADATA__
{
  "v3Meta": {
    "objectGuid": "86eaa5b8-38f3-4fb4-a9de-56e5ad754859",
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
PROGRAM C_ComposicaoFatura
VAR
	TonHabilita: TON;
	xTonHabilitaIn: BOOL;
	xTonHabilitaQ: BOOL;
	xTonHabilitaPt: TIME;
	PulsoLeitura: PulsoPositivo;
	PulsoLeituraIn: BOOL;
	PulsoLeituraQ: BOOL;
	xIntervaloPonta: BOOL;
	xIntervaloFPonta: BOOL;
	xIntervaloFPonta01: BOOL;
	xIntervaloFPonta02: BOOL;
	xFimMes: BOOL;
	xFechaConta: BOOL;
	rDemandaInstantaneaReal_kW: REAL;
END_VAR
__IMPLEMENTATION__
(*LÓGICA DE COMPOSIÇÃO DA FATURA DE ENERGIA E ZERAMENTO DO MEDIDOR*)

// Dia da Leitura -> Fecha Fatura

IF uDiadaLeitura=uDiaRealTime THEN
	PulsoLeituraIn:=TRUE;
ELSE
	PulsoLeituraIn:=FALSE;
END_IF

PulsoLeitura(Entrada:=PulsoLeituraIn , SaidaPulsoPo=>PulsoLeituraQ );

IF PulsoLeituraQ THEN
	xFimMes:=TRUE;
END_IF

IF xFimMes THEN
	xFechaFatura:=1;
	xFimMes:=FALSE;
END_IF


(*-------------------------------------------------------------------------*)
xTonHabilitaIn:=TRUE;
TonHabilita(IN:=xTonHabilitaIn , PT:=T#300MS(*xTonHabilitaPt*) , Q=> xTonHabilitaQ, ET=> );


(*========= INTERVALOS DE PONTA E FORA PONTA =========*) 

IF uHoraRealTime>=uHoraPonta  AND uHoraRealTime<=uHoraFPonta THEN
	xIntervaloPonta:=TRUE;
	xIntervaloFPonta:=FALSE;
ELSE	
	xIntervaloFPonta:=TRUE;
	xIntervaloPonta:=FALSE;
END_IF



CASE PassoIntervalo OF
	//Seleção do Intervalo
		0: 	IF xIntervaloFPonta AND xTonHabilitaQ THEN
				PassoIntervalo:=5;
			END_IF
			IF xIntervaloPonta AND xTonHabilitaQ THEN
				PassoIntervalo:=50;
			END_IF
	// Consumos Fora Ponta		
		5:	rConsumoInicialFPonta_kW:=rConsumoEnergiaReal_kWh;(*Ativo*)
			rConsumoInicialFPonta_kVAR:=rConsumoEnergiaReativa_kVARh;(*Reativo*)
			PassoIntervalo:=10;
		
		10:	rConsumoInstantaneoFPonta_kW:=rConsumoEnergiaReal_kWh-rConsumoInicialFPonta_kW;(*Ativo*)
			rConsumoInstantAcumFPonta_kW:=rConsumoAcumuladoFPonta_kW+rConsumoInstantaneoFPonta_kW;(*Ativo*)
			rConsumoInstantaneoFPonta_kVAR:=rConsumoEnergiaReativa_kVARh-rConsumoInicialFPonta_kVAR;(*Reativo*)
			rConsumoInstantAcumFPonta_kVAR:=rConsumoAcumuladoFPonta_kVAR+rConsumoInstantaneoFPonta_kVAR;(*Reativo*)
			
			rDemandaInstantaneaReal_kW:=rDemandaTotalReal_kW;
			IF rDemandaInstantaneaReal_kW>rDemandaMaximaPeriodo_kW THEN
				rDemandaMaximaPeriodo_kW:=rDemandaInstantaneaReal_kW;
			END_IF
			
			IF rDemandaTotalReal_kW>rDemandaMaximaIntervalo THEN
				rDemandaMaximaIntervalo:=rDemandaTotalReal_kW;
			END_IF

			IF NOT xIntervaloFPonta AND xTonHabilitaQ THEN
				PassoIntervalo:=15;
			END_IF
			IF (xFechaFatura=1) AND xTonHabilitaQ THEN
				PassoIntervalo:=16;
			END_IF
			
		15:	rConsumoAcumuladoFPonta_kW:=rConsumoInstantAcumFPonta_kW;(*Ativo*)
			rConsumoAcumuladoFPonta_kVAR:=rConsumoInstantAcumFPonta_kVAR;(*Reativo*)
			rConsumoFPonta_kW:=rConsumoInstantaneoFPonta_kW;(*Ativo*)
			rConsumoFPonta_kVAR:=rConsumoInstantaneoFPonta_kVAR;(*Reativo*)
			rDemandaMaxUltimoPeriodo:=rDemandaMaximaPeriodo_kW;
			PassoIntervalo:=16;
	
		16:	PassoIntervalo:=20;


		18: rConsumoAcumuladoFPonta_kW:=rConsumoInstantAcumFPonta_kW;(*Ativo*)
			rConsumoAcumuladoFPonta_kVAR:=rConsumoInstantAcumFPonta_kVAR;(*Reativo*)
			rConsumoFPonta_kW:=rConsumoInstantaneoFPonta_kW;(*Ativo*)
			rConsumoFPonta_kVAR:=rConsumoInstantaneoFPonta_kVAR;(*Reativo*)
			//rDemandaMaxUltimoIntervalo:=rDemandaMaximaReal_kW;
			rDemandaMaxUltimoIntervalo:=rDemandaMaximaIntervalo;
			PassoIntervalo:=20;
			
		20:	rConsumoInstantaneoFPonta_kW:=0;(*Ativo*)
			rConsumoInstantaneoFPonta_kVAR:=0;(*Reativo*)
			rDemandaMaximaPeriodo_kW:=0;
			IF (xFechaFatura=1) THEN
				xFechaConta:=TRUE;
			END_IF
			PassoIntervalo:=0;
	// Consumos Ponta	
		50:	rConsumoInicialPonta_kW:=rConsumoEnergiaReal_kWh;(*Ativo*)
			rConsumoInicialPonta_kVAR:=rConsumoEnergiaReativa_kVARh;(*Reativo*)
			PassoIntervalo:=55;
		
		55:	rConsumoInstantaneoPonta_kW:=rConsumoEnergiaReal_kWh-rConsumoInicialPonta_kW;(*Ativo*)
			rConsumoInstantAcumPonta_kW:=rConsumoAcumuladoPonta_kW+rConsumoInstantaneoPonta_kW;(*Ativo*)
			rConsumoInstantaneoPonta_kVAR:=rConsumoEnergiaReativa_kVARh-rConsumoInicialPonta_kVAR;(*Reativo*)
			rConsumoInstantAcumPonta_kVAR:=rConsumoAcumuladoPonta_kVAR+rConsumoInstantaneoPonta_kVAR;(*Reativo*)
			
			rDemandaInstantaneaReal_kW:=rDemandaTotalReal_kW;
			IF rDemandaInstantaneaReal_kW>rDemandaMaximaPeriodo_kW THEN
				rDemandaMaximaPeriodo_kW:=rDemandaInstantaneaReal_kW;
			END_IF

			IF rDemandaTotalReal_kW>rDemandaMaximaIntervalo THEN
				rDemandaMaximaIntervalo:=rDemandaTotalReal_kW;
			END_IF

			IF NOT xIntervaloPonta AND xTonHabilitaQ THEN
				PassoIntervalo:=60;
			END_IF
			IF (xFechaFatura=1) AND xTonHabilitaQ THEN
				PassoIntervalo:=61;
			END_IF
			
		60:	rConsumoPonta_kW:=rConsumoInstantaneoPonta_kW;(*Ativo*)
			rConsumoAcumuladoPonta_kW:=rConsumoInstantAcumPonta_kW;(*Ativo*)
	      	rConsumoPonta_kVAR:=rConsumoInstantaneoPonta_kVAR;(*Reativo*)
			rConsumoAcumuladoPonta_kVAR:=rConsumoInstantAcumPonta_kVAR;(*Reativo*)
			rDemandaMaxUltimoPeriodo:=rDemandaMaximaPeriodo_kW;
			PassoIntervalo:=61;

		61:	PassoIntervalo:=65;

		63:	rConsumoPonta_kW:=rConsumoInstantaneoPonta_kW;(*Ativo*)
			rConsumoAcumuladoPonta_kW:=rConsumoInstantAcumPonta_kW;(*Ativo*)
	      	rConsumoPonta_kVAR:=rConsumoInstantaneoPonta_kVAR;(*Reativo*)
			rConsumoAcumuladoPonta_kVAR:=rConsumoInstantAcumPonta_kVAR;(*Reativo*)
			//rDemandaMaxUltimoIntervalo:=rDemandaMaximaReal_kW;
			rDemandaMaxUltimoIntervalo:=rDemandaMaximaIntervalo;
			PassoIntervalo:=65;
			
		65:	rConsumoInstantaneoPonta_kW:=0;(*Ativo*)
			rConsumoInstantaneoPonta_kVAR:=0;(*Reativo*)
			rDemandaMaximaPeriodo_kW:=0;
			IF (xFechaFatura=1) THEN
				xFechaConta:=TRUE;
			END_IF
			PassoIntervalo:=0;
END_CASE


// Fechamento da Tarifa Mensal
IF xFechaConta AND xTonHabilitaQ THEN
	 rEnergiaAtivaPonta_kWh			:=rConsumoAcumuladoPonta_kW;
	 rEnergiaAtivaFPonta_kWh		:=rConsumoAcumuladoFPonta_kW;
	 rEnergiaReativaPonta_kVar		:=rConsumoAcumuladoPonta_kVAR;
	 rEnergiaReativaFPonta_kVar		:=rConsumoAcumuladoFPonta_kVAR;
	 rDemandaEnergia_kW				:=rDemandaMaxUltimoIntervalo;
	 xFechaConta:=FALSE;
END_IF

IF xFaturaFechada=1 THEN // Vem do Supervisório
	bZeraAcumulado		:=TRUE;
	xCmdResetGeralPm	:=TRUE;
	xFaturaFechada		:=0;
END_IF




(*--------------------------------------------------------------------------------------------------------
(*--------------- Consumo Intervalo Diario -------*)
(*========= INTERVALOS FORA PONTA 01 e 02 =========*) 

IF uMinutoRealTime>=0 AND uMinutoRealTime<=uMinutoPonta THEN
	xIntervaloFPonta01:=TRUE;
	xIntervaloFPonta02:=FALSE;
ELSIF uMinutoRealTime>=uMinutoFPonta AND  uMinutoRealTime<59 THEN
	xIntervaloFPonta02:=TRUE;
	xIntervaloFPonta01:=FALSE;
ELSIF uMinutoRealTime>=uMinutoPonta AND uMinutoRealTime<=uMinutoFPonta THEN
	xIntervaloFPonta01:=FALSE;
	xIntervaloFPonta02:=FALSE;
END_IF


CASE PassoIntervaloDia OF
	
		0: 	IF xIntervaloFPonta01 AND xTonHabilitaQ THEN
				PassoIntervaloDia:=5;
			END_IF
			IF xIntervaloFPonta02 AND xTonHabilitaQ THEN
				PassoIntervaloDia:=50;
			END_IF
			
		5:	rConsumoInicialFPonta01:=rConsumoEnergiaReal_kWh;
			PassoIntervaloDia:=10;
		
		10:	rConsumoInstantaneoFPonta01:=rConsumoEnergiaReal_kWh-rConsumoInicialFPonta01;
			rConsumoInstantDiarioFPonta:=rConsumoInstantaneoFPonta01;
			IF NOT xIntervaloFPonta01 AND xTonHabilitaQ THEN
				PassoIntervaloDia:=15;
			END_IF
			
		15:	rConsumoFPonta01:=rConsumoInstantaneoFPonta01;
			PassoIntervaloDia:=20;
			
		20:	rConsumoInstantaneoFPonta01:=0;
			PassoIntervaloDia:=0;

		50:	rConsumoInicialFPonta02:=rConsumoEnergiaReal_kWh;
			PassoIntervaloDia:=55;
		
		55:	rConsumoInstantaneoFPonta02:=rConsumoEnergiaReal_kWh-rConsumoInicialFPonta02;
			rConsumoInstantDiarioFPonta:=rConsumoFPonta01+rConsumoInstantaneoFPonta02;
			IF NOT xIntervaloFPonta02 AND xTonHabilitaQ THEN
				PassoIntervaloDia:=60;
			END_IF
			
		60:	rConsumoFPonta02:=rConsumoInstantaneoFPonta02;
			PassoIntervaloDia:=65;
			
		65:	rConsumoInstantaneoFPonta02:=0;
			rConsumoInstantDiarioFPonta:=0;
			PassoIntervaloDia:=70;
			
		70:	rConsumoDiarioFPonta:=rConsumoFPonta01+rConsumoFPonta02;	
			rConsumoInicialFPonta01:=0;
			rConsumoInstantaneoFPonta01:=0;
			rConsumoFPonta01:=0;
			rConsumoInicialFPonta02:=0;
			rConsumoInstantaneoFPonta02:=0;
			rConsumoFPonta02:=0;
			PassoIntervaloDia:=0;
		
END_CASE
---------------------------------------------------------------------------------------------------------------*)
// ENERGIA CONSUMO DIÁRIO

rConsumoDiario:= rConsumoEnergiaReal_kWh-rConsumoDiarioInicial_kW;

IF	(uHoraRealTime=23 AND uMinutoRealTime=59 AND uSegundoRealTime=0) THEN
	rConsumoDiarioRel:=rConsumoDiario;
	xGrvRelatorioEnerg:=TRUE;
	
END_IF

IF	(uHoraRealTime=0 AND uMinutoRealTime=0 AND uSegundoRealTime=0)  THEN
	rConsumoDiarioInicial_kW:=rConsumoEnergiaReal_kWh;
	
END_IF


