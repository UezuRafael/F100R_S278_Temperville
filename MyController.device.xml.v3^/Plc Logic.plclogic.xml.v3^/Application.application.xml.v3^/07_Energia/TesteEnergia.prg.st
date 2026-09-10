__METADATA__
{
  "v3Meta": {
    "objectGuid": "ec768bfe-0199-48e3-bc15-c8d1e996a810",
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
PROGRAM TesteEnergia
VAR
	///Consumo Ativo
	ContadorConsumo: CTU;
	xContadorCu: BOOL;
	xContadorRst: BOOL;
	///wContadorCv				: WORD;	
	ClockConsumo: BLINK;
	xClockConsumoIn: BOOL;
	BloqContador: BOOL;
	rConsumoEnergiaReal: REAL;
	///Consumo Reativo
	ContadorConsumoVa: CTU;
	xContadorVaCu: BOOL;
	xContadorVaRst: BOOL;
	///wContadorCv				: WORD;	
	ClockConsumoVa: BLINK;
	xClockConsumoVaIn: BOOL;
	BloqContadorVa: BOOL;
	rConsumoEnergiaReativaReal: REAL;
	TonHabilit: TON;
	xTonHabilitIn: BOOL;
	xTonHabilitQ: BOOL;
	xIntervaloFPont: BOOL;
	xIntervaloPont: BOOL;
	LeituraDemand: REAL;
	///xFimMes: BOOL;
	///
	///
	///	rMesFatura: INT;
	///	rAnoFatura: INT;
	///parametros permanentes
	PassoInterval: INT;
	xSelecaoIntervalo: BOOL;
	wContadorCv: WORD;
	wContadorVaCv: WORD;
	///Energia Ativa 
	rConsumoInicialFPont: REAL;
	rConsumoInstantaneoFPont: REAL;
	rConsumoAcumuladoFPont: REAL;
	rConsumoInstantAcumFPont: REAL;
	rConsumoFPont: REAL;
	rConsumoInicialPont: REAL;
	rConsumoInstantaneoPont: REAL;
	rConsumoAcumuladoPont: REAL;
	rConsumoInstantAcumPont: REAL;
	rConsumoPont: REAL;
	///Energia Reativa 
	rConsumoInicialFPontVa: REAL;
	rConsumoInstantaneoFPontVa: REAL;
	rConsumoAcumuladoFPontVa: REAL;
	rConsumoInstantAcumFPontVa: REAL;
	rConsumoFPontVa: REAL;
	rConsumoInicialPontVa: REAL;
	rConsumoInstantaneoPontVa: REAL;
	rConsumoAcumuladoPontVa: REAL;
	rConsumoInstantAcumPontVa: REAL;
	rConsumoPontVa: REAL;
	///Demanda
	rDemandMaxima: REAL;
	rDemandInstantanea: REAL;
	xHabilitaPm: BOOL;
END_VAR
__IMPLEMENTATION__
rDemandInstantanea:=LeituraDemand;
IF rDemandInstantanea>rDemandMaxima AND NOT xHabilitaPm THEN
	rDemandMaxima:=rDemandInstantanea;
END_IF

(*IF xFimMes THEN
	rMesFatura:=rMesFatura;
	rAnoFatura:=rAnoFatura;
	xFechaFatura:=1;
	xFimMes:=FALSE;
	xHabilitaPm:=TRUE;
END_IF

IF xFaturaFechada=1 THEN
	xContadorRst:=TRUE;
END_IF*)

ClockConsumo.ENABLE:= NOT xHabilitaPm;
ClockConsumoVa.ENABLE:= NOT xHabilitaPm;
//Consumo Ativo

ClockConsumo(ENABLE:= , TIMELOW:=T#1S , TIMEHIGH:=T#1S , OUT=> xContadorCu);
	
IF xContadorCu AND NOT BloqContador THEN
	wContadorCv:=wContadorCv+1;
	BloqContador:=TRUE;
END_IF
	
IF NOT xContadorCu  THEN
	BloqContador:=FALSE;
END_IF

rConsumoEnergiaReal:= WORD_TO_REAL ((wContadorCv))/10;

//Consumo Reativo
ClockConsumoVa(ENABLE:= , TIMELOW:=T#3S , TIMEHIGH:=T#3S , OUT=> xContadorVaCu);
	
IF xContadorVaCu AND NOT BloqContadorVa THEN
	wContadorVaCv:=wContadorVaCv+1;
	BloqContadorVa:=TRUE;
END_IF
	
IF NOT xContadorVaCu  THEN
	BloqContadorVa:=FALSE;
END_IF

rConsumoEnergiaReativaReal:= WORD_TO_REAL ((wContadorVaCv))/10;


/////////////////////////////////////////////////////////////

IF xSelecaoIntervalo THEN
	xIntervaloPont:=TRUE;
	xIntervaloFPont:=FALSE;
ELSE	
	xIntervaloFPont:=TRUE;
	xIntervaloPont:=FALSE;
END_IF

xTonHabilitIn:=TRUE;
TonHabilit(IN:=xTonHabilitIn , PT:=T#300MS , Q=> xTonHabilitQ, ET=> );

CASE PassoInterval OF
	
		0: 	IF xIntervaloFPont AND xTonHabilitQ THEN
				PassoInterval:=5;
			END_IF
			IF xIntervaloPont AND xTonHabilitQ THEN
				PassoInterval:=50;
			END_IF
			
		5:	rConsumoInicialFPont:=rConsumoEnergiaReal;(*Ativa*)
			rConsumoInicialFPontVa:=rConsumoEnergiaReativaReal;(*Reativa*)
			PassoInterval:=10;
		
		10:	rConsumoInstantaneoFPont:=rConsumoEnergiaReal-rConsumoInicialFPont;(*Ativa*)
			rConsumoInstantAcumFPont:=rConsumoAcumuladoFPont+rConsumoInstantaneoFPont;(*Ativa*)
			rConsumoInstantaneoFPontVa:=rConsumoEnergiaReativaReal-rConsumoInicialFPontVa;(*Reativa*)
			rConsumoInstantAcumFPontVa:=rConsumoAcumuladoFPontVa+rConsumoInstantaneoFPontVa;(*Reativa*)
			IF (NOT xIntervaloFPont OR (xFechaFatura=1)) AND xTonHabilitQ THEN
				PassoInterval:=15;
			END_IF
			
		15:	rConsumoFPont:=rConsumoInstantaneoFPont;(*Ativo*)
			rConsumoAcumuladoFPont:=rConsumoInstantAcumFPont;(*Ativo*)
			rConsumoFPontVa:=rConsumoInstantaneoFPontVa;(*Reativo*)
			rConsumoAcumuladoFPontVa:=rConsumoInstantAcumFPontVa;(*Reativo*)
			PassoInterval:=20;
			
		20:	rConsumoInstantaneoFPont:=0;(*Ativo*)
			rConsumoInstantaneoFPontVa:=0;(*Reativo*)
			PassoInterval:=0;

		50:	rConsumoInicialPont:=rConsumoEnergiaReal;(*Ativo*)
			rConsumoInicialPontVa:=rConsumoEnergiaReativaReal;(*Reativo*)
			PassoInterval:=55;
		
		55:	rConsumoInstantaneoPont:=rConsumoEnergiaReal-rConsumoInicialPont;(*Ativo*)
			rConsumoInstantAcumPont:=rConsumoAcumuladoPont+rConsumoInstantaneoPont;(*Ativo*)
			rConsumoInstantaneoPontVa:=rConsumoEnergiaReativaReal-rConsumoInicialPontVa;(*Reativo*)
			rConsumoInstantAcumPontVa:=rConsumoAcumuladoPontVa+rConsumoInstantaneoPontVa;(*Reativo*)
			IF (NOT xIntervaloPont OR (xFechaFatura=1))AND xTonHabilitQ THEN
				PassoInterval:=60;
			END_IF
			
		60:	rConsumoPont:=rConsumoInstantaneoPont;(*Ativo*)
			rConsumoAcumuladoPont:=rConsumoInstantAcumPont;(*Ativo*)
			rConsumoPontVa:=rConsumoInstantaneoPontVa;(*Reativo*)
			rConsumoAcumuladoPontVa:=rConsumoInstantAcumPontVa;(*Reativo*)
			PassoInterval:=65;
			
		65:	rConsumoInstantaneoPont:=0;(*Ativo*)
			rConsumoInstantaneoPont:=0;(*Reativo*)		
			PassoInterval:=0;
END_CASE

IF xContadorRst THEN
	rConsumoInicialFPont	:=0 ;	
	rConsumoInstantaneoFPont:=0 ;
	rConsumoAcumuladoFPont	:=0 ;
	rConsumoInstantAcumFPont:=0 ;
	rConsumoFPont			:=0 ;

	rConsumoInicialPont		:=0 ;	
	rConsumoInstantaneoPont	:=0 ;
	rConsumoAcumuladoPont	:=0 ;
	rConsumoInstantAcumPont	:=0 ;
	rConsumoPont			:=0 ;	
	wContadorCv				:=0 ;
	xContadorRst			:=0 ;
	
	rConsumoInicialFPontVa	:=0 ;	
	rConsumoInstantaneoFPontVa:=0 ;
	rConsumoAcumuladoFPontVa	:=0 ;
	rConsumoInstantAcumFPontVa:=0 ;
	rConsumoFPontVa			:=0 ;

	rConsumoInicialPontVa		:=0 ;	
	rConsumoInstantaneoPontVa	:=0 ;
	rConsumoAcumuladoPontVa	:=0 ;
	rConsumoInstantAcumPontVa	:=0 ;
	rConsumoPontVa			:=0 ;	
	wContadorVaCv				:=0 ;
	xContadorVaRst			:=0 ;
	
	rDemandMaxima				:=0;
	rDemandInstantanea			:=0;
	xHabilitaPm					:=FALSE;
	//xFaturaFechada				:=0;
	xContadorRst				:=FALSE;
END_IF
