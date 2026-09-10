__METADATA__
{
  "v3Meta": {
    "objectGuid": "3cb55294-125a-46e7-b087-31443fd29810",
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
PROGRAM Energia
VAR
	Double01: WORD_AS_DWORD;
	Double02: WORD_AS_DWORD;
	Double03: WORD_AS_DWORD;
	////////////////////////////////////////////////////////////////
	dConsumoEnergiaReal_kWh: DWORD;
	dConsumoEnergiaAparente_kVAh: DWORD;
	dConsumoEnergiaReativa_kVARh: DWORD;
	u0ConsumoEnergiaReal_kWh: WORD;
	u1ConsumoEnergiaReal_kWh: WORD;
	u0ConsumoEnergiaAparente_kVAh: WORD;
	u1ConsumoEnergiaAparente_kVAh: WORD;
	u0ConsumoEnergiaReativa_kVARh: WORD;
	u1ConsumoEnergiaReativa_kVARh: WORD;
	uPotenciaTotalReal_kW: UINT;
	uPotenciaTotalAparente_kVA: UINT;
	uPotenciaTotalReativa_kVAR: UINT;
	uFatorDePotenciaTotal: UINT;
	uTensaoFFMedia_V: UINT;
	uTensaoFNMedia_V: UINT;
	uCorrenteMedia_V: UINT;
	uFrequencia_Hz: UINT;
	uDemandaTotalReal_kW: UINT;
	uDemandaTotalAparente_kVA: UINT;
	uDemandaTotalReativa_kVAR: UINT;
	uDemandaMaximaReal_kW: UINT;
	uDemandaMaximaAparente_kVA: UINT;
	uDemandaMaximaReativa_kVAR: UINT;
	uCorrenteInstantFaseA_Amp: UINT;
	uCorrenteInstantFaseB_Amp: UINT;
	uCorrenteInstantFaseC_Amp: UINT;
	uCorrenteInstantNeutro_Amp: UINT;
	uCorrenteDemandaFaseA_Amp: UINT;
	uCorrenteDemandaFaseB_Amp: UINT;
	uCorrenteDemandaFaseC_Amp: UINT;
	uCorrenteMaximaDemandaFaseA_Amp: UINT;
	uCorrenteMaximaDemandaFaseB_Amp: UINT;
	uCorrenteMaximaDemandaFaseC_Amp: UINT;
	uTensaoFaseAB_V: UINT;
	uTensaoFaseBC_V: UINT;
	uTensaoFaseAC_V: UINT;
	uTensaoFaseAN_V: UINT;
	uTensaoFaseBN_V: UINT;
	uTensaoFaseCN_V: UINT;
	uPotenciaRealFaseA_kW: UINT;
	uPotenciaRealFaseB_kW: UINT;
	uPotenciaRealFaseC_kW: UINT;
	uPotenciaAparenteFaseA_kVA: UINT;
	uPotenciaAparenteFaseB_kVA: UINT;
	uPotenciaAparenteFaseC_kVA: UINT;
	uPotenciaReativaFaseA_kVAR: UINT;
	uPotenciaReativaFaseB_kVAR: UINT;
	uPotenciaReativaFaseC_kVAR: UINT;
	uCorrenteTHDFaseA: UINT;
	uCorrenteTHDFaseB: UINT;
	uCorrenteTHDFaseC: UINT;
	uCorrenteTHDNeutro: UINT;
	uTensaoTHDFaseAN: UINT;
	uTensaoTHDFaseBN: UINT;
	uTensaoTHDFaseCN: UINT;
	uTensaoTHDFaseAB: UINT;
	uTensaoTHDFaseBC: UINT;
	uTensaoTHDFaseAC: UINT;
	/// Valores minimos
	uPotenciaTotalRealMinima_kW: UINT;
	uPotenciaTotalAparenteMinima_kVA: UINT;
	uPotenciaTotalReativaMinima_kVAR: UINT;
	uFatorDePotenciaTotalMinima: UINT;
	uFrequenciaMinima_Hz: UINT;
	uCorrenteMinimaFaseA_Amp: UINT;
	uCorrenteMinimaFaseB_Amp: UINT;
	uCorrenteMinimaFaseC_Amp: UINT;
	uCorrenteMinimaNeutro_Amp: UINT;
	uTensaoMinimaFaseAN_V: UINT;
	uTensaoMinimaFaseBN_V: UINT;
	uTensaoMinimaFaseCN_V: UINT;
	uTensaoMinimaFaseAB_V: UINT;
	uTensaoMinimaFaseBC_V: UINT;
	uTensaoMinimaFaseAC_V: UINT;
	uCorrenteTHDMinimoFaseA: UINT;
	uCorrenteTHDMinimoFaseB: UINT;
	uCorrenteTHDMinimoFaseC: UINT;
	uCorrenteTHDMinimoNeutro: UINT;
	uTensaoTHDMinimoFaseAN: UINT;
	uTensaoTHDMinimoFaseBN: UINT;
	uTensaoTHDMinimoFaseCN: UINT;
	uTensaoTHDMinimoFaseAB: UINT;
	uTensaoTHDMinimoFaseBC: UINT;
	uTensaoTHDMinimoFaseAC: UINT;
	/// Valores Maximos
	uPotenciaTotalRealMaximo_kW: UINT;
	uPotenciaTotalAparenteMaximo_kVA: UINT;
	uPotenciaTotalReativaMaximo_kVAR: UINT;
	uFatorDePotenciaTotalMaximo: UINT;
	uFrequenciaMaxima_Hz: UINT;
	uCorrenteMaximoFaseA_Amp: UINT;
	uCorrenteMaximoFaseB_Amp: UINT;
	uCorrenteMaximoFaseC_Amp: UINT;
	uCorrenteMaximoNeutro_Amp: UINT;
	uTensaoMaximoFaseAN_V: UINT;
	uTensaoMaximoFaseBN_V: UINT;
	uTensaoMaximoFaseCN_V: UINT;
	uTensaoMaximoFaseAB_V: UINT;
	uTensaoMaximoFaseBC_V: UINT;
	uTensaoMaximoFaseAC_V: UINT;
	uCorrenteTHDMaximoFaseA: UINT;
	uCorrenteTHDMaximoFaseB: UINT;
	uCorrenteTHDMaximoFaseC: UINT;
	uCorrenteTHDMaximoNeutro: UINT;
	uTensaoTHDMaximoFaseAN: UINT;
	uTensaoTHDMaximoFaseBN: UINT;
	uTensaoTHDMaximoFaseCN: UINT;
	uTensaoTHDMaximoFaseAB: UINT;
	uTensaoTHDMaximoFaseBC: UINT;
	uTensaoTHDMaximoFaseAC: UINT;
END_VAR
__IMPLEMENTATION__


Double01(i_wLow:= u1ConsumoEnergiaReal_kWh, i_wHigh:= u0ConsumoEnergiaReal_kWh, q_dwOput=> dConsumoEnergiaReal_kWh);
Double02(i_wLow:= u1ConsumoEnergiaAparente_kVAh, i_wHigh:= u0ConsumoEnergiaAparente_kVAh, q_dwOput=> dConsumoEnergiaAparente_kVAh);
Double03(i_wLow:= u1ConsumoEnergiaReativa_kVARh, i_wHigh:= u0ConsumoEnergiaReativa_kVARh, q_dwOput=> dConsumoEnergiaReativa_kVARh);

rConsumoEnergiaReal_kWh			:=fEnergiaAtivaAcumulada/1000;//(DINT_TO_REAL(DWORD_TO_DINT(dConsumoEnergiaReal_kWh)))/10;
rConsumoEnergiaAparente_kVAh	:=fEnergiaAparenteAcumulada/1000;//(DINT_TO_REAL(DWORD_TO_DINT(dConsumoEnergiaAparente_kVAh)))/10;
rConsumoEnergiaReativa_kVARh	:=fEnergiaReativaAcumulada/1000;//(DINT_TO_REAL(DWORD_TO_DINT(dConsumoEnergiaReativa_kVARh)))/10;
rPotenciaTotalReal_kW			:=fPotenciaAtivaTotal;//(INT_TO_REAL(UINT_TO_INT(uPotenciaTotalReal_kW))); 
rPotenciaTotalAparente_kVA		:=(INT_TO_REAL(UINT_TO_INT(uPotenciaTotalAparente_kVA))); 
rPotenciaTotalReativa_kVAR 		:=(INT_TO_REAL(UINT_TO_INT(uPotenciaTotalReativa_kVAR)))/10; 
rFatorDePotenciaTotal 			:=fFatorPotenciaTotal;//(INT_TO_REAL(UINT_TO_INT(uFatorDePotenciaTotal)))/10000;
rTensaoFFMedia_V				:=fTensaoAvgLL;//(INT_TO_REAL(UINT_TO_INT(uTensaoFFMedia_V)))/10;
rTensaoFNMedia_V				:=fTensaoAvgLN;//(INT_TO_REAL(UINT_TO_INT(uTensaoFNMedia_V)))/10;
rCorrenteMedia_V				:=fCorrenteAvg;//(INT_TO_REAL(UINT_TO_INT(uCorrenteMedia_V)));
rFrequencia_Hz					:=fFrequencia;//(INT_TO_REAL(UINT_TO_INT(uFrequencia_Hz)))/100;
rDemandaTotalReal_kW			:=fUltimaDemanda;//(INT_TO_REAL(UINT_TO_INT(uDemandaTotalReal_kW)));
rDemandaTotalAparente_kVA		:=(INT_TO_REAL(UINT_TO_INT(uDemandaTotalAparente_kVA)));
rDemandaTotalReativa_kVAR		:=(INT_TO_REAL(UINT_TO_INT(uDemandaTotalReativa_kVAR)))/10;
rDemandaMaximaReal_kW			:=fPicoDemanda;//(INT_TO_REAL(UINT_TO_INT(uDemandaMaximaReal_kW)));
rDemandaMaximaAparente_kVA		:=(INT_TO_REAL(UINT_TO_INT(uDemandaMaximaAparente_kVA)))/10;
rDemandaMaximaReativa_kVAR		:=(INT_TO_REAL(UINT_TO_INT(uDemandaMaximaReativa_kVAR)))/10;
rCorrenteInstantFaseA_Amp		:=fCorrenteFaseA;//(INT_TO_REAL(UINT_TO_INT(uCorrenteInstantFaseA_Amp)))/1;
rCorrenteInstantFaseB_Amp 		:=fCorrenteFaseB;//(INT_TO_REAL(UINT_TO_INT(uCorrenteInstantFaseB_Amp)))/1;
rCorrenteInstantFaseC_Amp 		:=fCorrenteFaseC;//(INT_TO_REAL(UINT_TO_INT(uCorrenteInstantFaseC_Amp)))/1;
rCorrenteInstantNeutro_Amp 		:=fCorrenteNeutro;//(INT_TO_REAL(UINT_TO_INT(uCorrenteInstantNeutro_Amp)))/1;
rCorrenteDemandaFaseA_Amp		:=(INT_TO_REAL(UINT_TO_INT(uCorrenteDemandaFaseA_Amp)))/10;
rCorrenteDemandaFaseB_Amp		:=(INT_TO_REAL(UINT_TO_INT(uCorrenteDemandaFaseB_Amp)))/10; 			
rCorrenteDemandaFaseC_Amp		:=(INT_TO_REAL(UINT_TO_INT(uCorrenteDemandaFaseC_Amp)))/10; 			
rCorrenteMaximaDemandaFaseA_Amp	:=(INT_TO_REAL(UINT_TO_INT(uCorrenteMaximaDemandaFaseA_Amp)))/10; 	
rCorrenteMaximaDemandaFaseB_Amp	:=(INT_TO_REAL(UINT_TO_INT(uCorrenteMaximaDemandaFaseB_Amp)))/10; 	
rCorrenteMaximaDemandaFaseC_Amp	:=(INT_TO_REAL(UINT_TO_INT(uCorrenteMaximaDemandaFaseC_Amp)))/10; 	
rTensaoFaseAB_V					:=fTensaoAB;//(INT_TO_REAL(UINT_TO_INT(uTensaoFaseAB_V)))/10;	
rTensaoFaseBC_V					:=fTensaoBC;//(INT_TO_REAL(UINT_TO_INT(uTensaoFaseBC_V)))/10;	
rTensaoFaseAC_V					:=fTensaoCA;//(INT_TO_REAL(UINT_TO_INT(uTensaoFaseAC_V)))/10;	
rTensaoFaseAN_V					:=fTensaoAN;//(INT_TO_REAL(UINT_TO_INT(uTensaoFaseAN_V)))/10;	
rTensaoFaseBN_V					:=fTensaoBN;//(INT_TO_REAL(UINT_TO_INT(uTensaoFaseBN_V)))/10;	
rTensaoFaseCN_V					:=fTensaoCN;//(INT_TO_REAL(UINT_TO_INT(uTensaoFaseCN_V)))/10;	
rPotenciaRealFaseA_kW			:=(INT_TO_REAL(UINT_TO_INT(uPotenciaRealFaseA_kW)))/10;				
rPotenciaRealFaseB_kW			:=(INT_TO_REAL(UINT_TO_INT(uPotenciaRealFaseB_kW)))/10;				
rPotenciaRealFaseC_kW			:=(INT_TO_REAL(UINT_TO_INT(uPotenciaRealFaseC_kW)))/10;				
rPotenciaAparenteFaseA_kVA		:=(INT_TO_REAL(UINT_TO_INT(uPotenciaAparenteFaseA_kVA)))/10;				
rPotenciaAparenteFaseB_kVA		:=(INT_TO_REAL(UINT_TO_INT(uPotenciaAparenteFaseB_kVA)))/10;				
rPotenciaAparenteFaseC_kVA		:=(INT_TO_REAL(UINT_TO_INT(uPotenciaAparenteFaseC_kVA)))/10;				
rPotenciaReativaFaseA_kVAR		:=(INT_TO_REAL(UINT_TO_INT(uPotenciaReativaFaseA_kVAR)))/10;				
rPotenciaReativaFaseB_kVAR		:=(INT_TO_REAL(UINT_TO_INT(uPotenciaReativaFaseB_kVAR)))/10;				
rPotenciaReativaFaseC_kVAR		:=(INT_TO_REAL(UINT_TO_INT(uPotenciaReativaFaseC_kVAR)))/10;				
rCorrenteTHDFaseA				:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDFaseA)))/10;					
rCorrenteTHDFaseB				:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDFaseB)))/10;					
rCorrenteTHDFaseC				:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDFaseC)))/10;					
rCorrenteTHDNeutro				:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDNeutro)))/10;						
rTensaoTHDFaseAN				:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDFaseAN)))/10;						
rTensaoTHDFaseBN				:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDFaseBN)))/10;						
rTensaoTHDFaseCN				:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDFaseCN)))/10;						
rTensaoTHDFaseAB				:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDFaseAB)))/10;						
rTensaoTHDFaseBC				:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDFaseBC)))/10;						
rTensaoTHDFaseAC				:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDFaseAC)))/10;						

// Valores minimos

rPotenciaTotalRealMinima_kW 	:=(INT_TO_REAL(UINT_TO_INT(uPotenciaTotalRealMinima_kW)))/10;		
rPotenciaTotalAparenteMinima_kVA:=(INT_TO_REAL(UINT_TO_INT(uPotenciaTotalAparenteMinima_kVA)))/10;	
rPotenciaTotalReativaMinima_kVAR:=(INT_TO_REAL(UINT_TO_INT(uPotenciaTotalReativaMinima_kVAR)))/10; 	
rFatorDePotenciaTotalMinima 	:=(INT_TO_REAL(UINT_TO_INT(uFatorDePotenciaTotalMinima)))/10;
rFrequenciaMinima_Hz			:=(INT_TO_REAL(UINT_TO_INT(uFrequenciaMinima_Hz)))/10;
rCorrenteMinimaFaseA_Amp 		:=(INT_TO_REAL(UINT_TO_INT(uCorrenteMinimaFaseA_Amp)))/10;
rCorrenteMinimaFaseB_Amp 		:=(INT_TO_REAL(UINT_TO_INT(uCorrenteMinimaFaseB_Amp)))/10;
rCorrenteMinimaFaseC_Amp 		:=(INT_TO_REAL(UINT_TO_INT(uCorrenteMinimaFaseC_Amp)))/10;
rCorrenteMinimaNeutro_Amp 		:=(INT_TO_REAL(UINT_TO_INT(uCorrenteMinimaNeutro_Amp)))/10;
rTensaoMinimaFaseAN_V			:=(INT_TO_REAL(UINT_TO_INT(uTensaoMinimaFaseAN_V)))/10;
rTensaoMinimaFaseBN_V			:=(INT_TO_REAL(UINT_TO_INT(uTensaoMinimaFaseBN_V)))/10;
rTensaoMinimaFaseCN_V			:=(INT_TO_REAL(UINT_TO_INT(uTensaoMinimaFaseCN_V)))/10;
rTensaoMinimaFaseAB_V			:=(INT_TO_REAL(UINT_TO_INT(uTensaoMinimaFaseAB_V)))/10;
rTensaoMinimaFaseBC_V			:=(INT_TO_REAL(UINT_TO_INT(uTensaoMinimaFaseBC_V)))/10;
rTensaoMinimaFaseAC_V			:=(INT_TO_REAL(UINT_TO_INT(uTensaoMinimaFaseAC_V)))/10;
rCorrenteTHDMinimoFaseA			:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDMinimoFaseA)))/10;
rCorrenteTHDMinimoFaseB			:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDMinimoFaseB)))/10;
rCorrenteTHDMinimoFaseC			:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDMinimoFaseC)))/10;
rCorrenteTHDMinimoNeutro		:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDMinimoNeutro)))/10;
rTensaoTHDMinimoFaseAN			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMinimoFaseAN)))/10;
rTensaoTHDMinimoFaseBN			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMinimoFaseBN)))/10;
rTensaoTHDMinimoFaseCN			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMinimoFaseCN)))/10;
rTensaoTHDMinimoFaseAB			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMinimoFaseAB)))/10;
rTensaoTHDMinimoFaseBC			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMinimoFaseBC)))/10;
rTensaoTHDMinimoFaseAC			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMinimoFaseAC)))/10;

// Valores Maximos

rPotenciaTotalRealMaximo_kW 	:=(INT_TO_REAL(UINT_TO_INT(uPotenciaTotalRealMaximo_kW)))/10;		
rPotenciaTotalAparenteMaximo_kVA:=(INT_TO_REAL(UINT_TO_INT(uPotenciaTotalAparenteMaximo_kVA)))/10;	
rPotenciaTotalReativaMaximo_kVAR:=(INT_TO_REAL(UINT_TO_INT(uPotenciaTotalReativaMaximo_kVAR)))/10; 	
rFatorDePotenciaTotalMaximo 	:=(INT_TO_REAL(UINT_TO_INT(uFatorDePotenciaTotalMaximo)))/10;
rFrequenciaMaxima_Hz			:=(INT_TO_REAL(UINT_TO_INT(uFrequenciaMaxima_Hz)))/10;
rCorrenteMaximoFaseA_Amp 		:=fCorrenteMaximaFaseA;//(INT_TO_REAL(UINT_TO_INT(uCorrenteMaximoFaseA_Amp)))/10;
rCorrenteMaximoFaseB_Amp 		:=fCorrenteMaximaFaseB;//(INT_TO_REAL(UINT_TO_INT(uCorrenteMaximoFaseB_Amp)))/10;
rCorrenteMaximoFaseC_Amp 		:=fCorrenteMaximaFaseC;//(INT_TO_REAL(UINT_TO_INT(uCorrenteMaximoFaseC_Amp)))/10;
rCorrenteMaximoNeutro_Amp 		:=fCorrenteMaximaNeutro;//(INT_TO_REAL(UINT_TO_INT(uCorrenteMaximoNeutro_Amp)))/10;
rTensaoMaximoFaseAN_V			:=fTensaoMaximaAN;//(INT_TO_REAL(UINT_TO_INT(uTensaoMaximoFaseAN_V)))/10;
rTensaoMaximoFaseBN_V			:=fTensaoMaximaAN;//(INT_TO_REAL(UINT_TO_INT(uTensaoMaximoFaseBN_V)))/10;
rTensaoMaximoFaseCN_V			:=fTensaoMaximaAN;//(INT_TO_REAL(UINT_TO_INT(uTensaoMaximoFaseCN_V)))/10;
rTensaoMaximoFaseAB_V			:=fTensaoMaximaAB;//(INT_TO_REAL(UINT_TO_INT(uTensaoMaximoFaseAB_V)))/10;
rTensaoMaximoFaseBC_V			:=fTensaoMaximaBC;//(INT_TO_REAL(UINT_TO_INT(uTensaoMaximoFaseBC_V)))/10;
rTensaoMaximoFaseAC_V			:=fTensaoMaximaCA;//(INT_TO_REAL(UINT_TO_INT(uTensaoMaximoFaseAC_V)))/10;
rCorrenteTHDMaximoFaseA			:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDMaximoFaseA)))/10;
rCorrenteTHDMaximoFaseB			:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDMaximoFaseB)))/10;
rCorrenteTHDMaximoFaseC			:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDMaximoFaseC)))/10;
rCorrenteTHDMaximoNeutro		:=(INT_TO_REAL(UINT_TO_INT(uCorrenteTHDMaximoNeutro)))/10;
rTensaoTHDMaximoFaseAN			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMaximoFaseAN)))/10;
rTensaoTHDMaximoFaseBN			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMaximoFaseBN)))/10;
rTensaoTHDMaximoFaseCN			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMaximoFaseCN)))/10;
rTensaoTHDMaximoFaseAB			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMaximoFaseAB)))/10;
rTensaoTHDMaximoFaseBC			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMaximoFaseBC)))/10;
rTensaoTHDMaximoFaseAC			:=(INT_TO_REAL(UINT_TO_INT(uTensaoTHDMaximoFaseAC)))/10;

////////////////////////////////////////////////////////////////////////
