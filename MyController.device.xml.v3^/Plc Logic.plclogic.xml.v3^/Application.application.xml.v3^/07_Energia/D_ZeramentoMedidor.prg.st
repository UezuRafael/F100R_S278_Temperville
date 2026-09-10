__METADATA__
{
  "v3Meta": {
    "objectGuid": "fae0f202-7eae-498e-b4b2-d81acdb43e5c",
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
PROGRAM D_ZeramentoMedidor
VAR
	///Passo da Execução Reset Medidor de Energia
	PassoResetPm: INT;
	uResetValoresPM: UINT;
	xTriggerResetPM: BOOL;
	TonReset: TON;
	xTonResetIn: BOOL;
	xTonResetQ: BOOL;
	xTonResePt: TIME := TIME#2s0ms;
END_VAR
__IMPLEMENTATION__
//Zeramento do Valores do Medidor
CASE PassoResetPm OF
	
		0:	IF xCmdResetGeralPm THEN
				uResetValoresPM:=14255;
				PassoResetPm:=1;
			END_IF
			
		1: IF uResetValoresPM=14255 THEN
				PassoResetPm:=3;
			END_IF
	
		3:	xTonResetIn:=TRUE;
			IF	xTonResetQ THEN
					PassoResetPm:=5;
			END_IF
			
		5:	xTonResetIn:=FALSE;
			xTriggerResetPM:=TRUE;	
			PassoResetPm:=7;
			
		7:	xTonResetIn:=TRUE;
			IF	xTonResetQ THEN
					PassoResetPm:=10;
			END_IF
			
		10: xTonResetIn:=FALSE;
			xTriggerResetPM:=FALSE;
			uResetValoresPM:=30078;
			PassoResetPm:=11;
			
		11: IF uResetValoresPM=30078 THEN
				PassoResetPm:=13;
			END_IF

		13:	xTonResetIn:=TRUE;
			IF	xTonResetQ THEN
					PassoResetPm:=15;
			END_IF
			
		15:	xTonResetIn:=FALSE;
			xTriggerResetPM:=TRUE;
			PassoResetPm:=17;
			
		17:	xTonResetIn:=TRUE;
			IF	xTonResetQ AND rConsumoEnergiaReal_kWh=0 THEN
					PassoResetPm:=20;
			END_IF
		
		20:	xTonResetIn:=FALSE;
			xTriggerResetPM:=FALSE;
			uResetValoresPM:=21212;
			PassoResetPm:=21;
			
		21: IF uResetValoresPM=21212 THEN
				PassoResetPm:=23;
			END_IF
	
		23:	xTonResetIn:=TRUE;
			IF	xTonResetQ THEN
					PassoResetPm:=25;
			END_IF
			
		25:	xTonResetIn:=FALSE;
			xTriggerResetPM:=TRUE;
			PassoResetPm:=27;	

		27:	xTonResetIn:=TRUE;
			IF	xTonResetQ THEN
					PassoResetPm:=30;
			END_IF	
	
		30:	xTonResetIn:=FALSE;
			xTriggerResetPM:=FALSE;
			uResetValoresPM:=10001;
			PassoResetPm:=31;
		
		31: IF uResetValoresPM=10001 THEN
				PassoResetPm:=33;
			END_IF

		33:	xTonResetIn:=TRUE;
			IF	xTonResetQ THEN
					PassoResetPm:=35;
			END_IF
			
		35:	xTonResetIn:=FALSE;
			xTriggerResetPM:=TRUE;
			PassoResetPm:=37;		

		37:	xTonResetIn:=TRUE;
			IF	xTonResetQ THEN
					PassoResetPm:=40;
			END_IF	

		40:	xTonResetIn:=FALSE;
			xTriggerResetPM:=FALSE;
			uResetValoresPM:=0;
			bZeraAcumulado:=TRUE;
			xCmdResetGeralPm:=FALSE;
			PassoResetPm:=0;
			
END_CASE
TonReset(IN:= xTonResetIn, PT:=T#2S(*xTonResePt*) , Q=> xTonResetQ, ET=> );


// Zeramento das Memorias Acumuladas
IF bZeraAcumulado THEN
	PassoIntervalo				:=0;

	rConsumoInicialFPonta_kW	:=0;
	rConsumoInstantaneoFPonta_kW:=0;
	rConsumoFPonta_kW			:=0;
	rConsumoInstantAcumFPonta_kW:=0;
	rConsumoAcumuladoFPonta_kW	:=0;

	rConsumoInicialPonta_kW		:=0;
	rConsumoInstantaneoPonta_kW	:=0;
	rConsumoPonta_kW			:=0;
	rConsumoInstantAcumPonta_kW	:=0;
	rConsumoAcumuladoPonta_kW	:=0;
	
	rConsumoInicialFPonta_kVAR	:=0;
	rConsumoInstantaneoFPonta_kVAR:=0;
	rConsumoFPonta_kVAR			:=0;
	rConsumoInstantAcumFPonta_kVAR:=0;
	rConsumoAcumuladoFPonta_kVAR:=0;

	rConsumoInicialPonta_kVAR	:=0;
	rConsumoInstantaneoPonta_kVAR:=0;
	rConsumoPonta_kVAR			:=0;
	rConsumoInstantAcumPonta_kVAR:=0;
	rConsumoAcumuladoPonta_kVAR	:=0;

//	rConsumoInicialFPonta01		:=0;
//	rConsumoInstantaneoFPonta01	:=0;
//	rConsumoFPonta01			:=0;

//	rConsumoInicialFPonta02		:=0;
//	rConsumoInstantaneoFPonta02	:=0;
//	rConsumoFPonta02			:=0;

	rConsumoDiarioFPonta		:=0;
	//xFaturaFechada				:=0;
	bZeraAcumulado				:=FALSE;
END_IF

