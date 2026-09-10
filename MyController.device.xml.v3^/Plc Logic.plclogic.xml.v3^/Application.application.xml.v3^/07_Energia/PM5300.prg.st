__METADATA__
{
  "v3Meta": {
    "objectGuid": "20bd912f-a003-48d9-b01d-8b2c0b135b8c",
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
PROGRAM PM5300
VAR
	/// 2999
	wCorrenteFaseA_W1: WORD;
	/// 3000
	wCorrenteFaseA_W0: WORD;
	/// 3001
	wCorrenteFaseB_W1: WORD;
	/// 3002
	wCorrenteFaseB_W0: WORD;
	/// 3003
	wCorrenteFaseC_W1: WORD;
	/// 3004
	wCorrenteFaseC_W0: WORD;
	/// 3005
	wCorrenteNeutro_W1: WORD;
	/// 3006
	wCorrenteNeutro_W0: WORD;
	/// 3007
	wCorrenteG_W1: WORD;
	/// 3008
	wCorrenteG_W0: WORD;
	/// 3009
	wCorrenteAvg_W1: WORD;
	/// 3010
	wCorrenteAvg_W0: WORD;
	/// 3019
	wTensaoAB_W1: WORD;
	/// 3020
	wTensaoAB_W0: WORD;
	/// 3021
	wTensaoBC_W1: WORD;
	/// 3022
	wTensaoBC_W0: WORD;
	/// 3023
	wTensaoCA_W1: WORD;
	/// 3024
	wTensaoCA_W0: WORD;
	/// 3025
	wTensaoAvgL_W1: WORD;
	/// 3026
	wTensaoAvgL_W0: WORD;
	/// 3027
	wTensaoAN_W1: WORD;
	/// 3028
	wTensaoAN_W0: WORD;
	/// 3029
	wTensaoBN_W1: WORD;
	/// 3030
	wTensaoBN_W0: WORD;
	/// 3031
	wTensaoCN_W1: WORD;
	/// 3032
	wTensaoCN_W0: WORD;
	/// 3035
	wTensaoAvgN_W1: WORD;
	/// 3036
	wTensaoAvgN_W0: WORD;
	///3059
	wPotenciaAtivaTotal_W1: WORD;
	///3060
	wPotenciaAtivaTotal_W0: WORD;
	///3083
	wFatorPotenciaTotal_W1: WORD;
	///3084
	wFatorPotenciaTotal_W0: WORD;
	///3109
	wFrequencia_W1: WORD;
	///3110
	wFrequencia_W0: WORD;
	///3762
	wUltimaDemanda_W1: WORD;
	///3763
	wUltimaDemanda_W0: WORD;
	///3764
	wAtualDemanda_W1: WORD;
	///3765
	wAtualDemanda_W0: WORD;
	///3766
	wPrevisaoDemanda_W1: WORD;
	///3767
	wPrevisaoDemanda_W0: WORD;
	///3768
	wPicoDemanda_W1: WORD;
	///3769
	wPicoDemanda_W0: WORD;
	///3203	
	wEnergiaAtivaAcumulada_W1_High: WORD;
	///3204
	wEnergiaAtivaAcumulada_W0_High: WORD;
	///3205	
	wEnergiaAtivaAcumulada_W1_Low: WORD;
	///3206
	wEnergiaAtivaAcumulada_W0_Low: WORD;
	///3219	
	wEnergiaReativaAcumulada_W1_High: WORD;
	///3220
	wEnergiaReativaAcumulada_W0_High: WORD;
	///3221	
	wEnergiaReativaAcumulada_W1_Low: WORD;
	///3222
	wEnergiaReativaAcumulada_W0_Low: WORD;
	///3235	
	wEnergiaAparenteAcumulada_W1_High: WORD;
	///3236
	wEnergiaAparenteAcumulada_W0_High: WORD;
	///3237	
	wEnergiaAparenteAcumulada_W1_Low: WORD;
	///3238
	wEnergiaAparenteAcumulada_W0_Low: WORD;
	lEnergiaAtivaAcumulada: LINT;
	lEnergiaReativaAcumulada: LINT;
	lEnergiaAparenteAcumulada: LINT;
	/// 27693
	wCorrenteMaximaFaseA_W1: WORD;
	wCorrenteMaximaFaseA_W0: WORD;
	wCorrenteMaximaFaseB_W1: WORD;
	wCorrenteMaximaFaseB_W0: WORD;
	wCorrenteMaximaFaseC_W1: WORD;
	wCorrenteMaximaFaseC_W0: WORD;
	wCorrenteMaximaNeutro_W1: WORD;
	wCorrenteMaximaNeutro_W0: WORD;
	wCorrenteMaximaG_W1: WORD;
	wCorrenteMaximaG_W0: WORD;
	wCorrenteMaximaAvg_W1: WORD;
	wCorrenteMaximaAvg_W0: WORD;
	wTensaoMaximaAB_W1: WORD;
	wTensaoMaximaAB_W0: WORD;
	wTensaoMaximaBC_W1: WORD;
	wTensaoMaximaBC_W0: WORD;
	wTensaoMaximaCA_W1: WORD;
	wTensaoMaximaCA_W0: WORD;
	wTensaoMaximaAvgL_W1: WORD;
	wTensaoMaximaAvgL_W0: WORD;
	wTensaoMaximaAN_W1: WORD;
	wTensaoMaximaAN_W0: WORD;
	wTensaoMaximaBN_W1: WORD;
	wTensaoMaximaBN_W0: WORD;
	wTensaoMaximaCN_W1: WORD;
	wTensaoMaximaCN_W0: WORD;
	wTensaoMaximaAvgN_W1: WORD;
	wTensaoMaximaAvgN_W0: WORD;
	wPotenciaAtivaTotalMaxima_W1: WORD;
	wPotenciaAtivaTotalMaxima_W0: WORD;
	EnergiaAtivaAcumulada: ConverLintReal;
	EnergiaReativaAcumulada: ConverLintReal;
	EnergiaAparenteAcumulada: ConverLintReal;
END_VAR
__IMPLEMENTATION__
(*fCorrenteFaseA:=Valor_Float(wCorrenteFaseA_W0, wCorrenteFaseA_W1);
fCorrenteFaseB:=Valor_Float(wCorrenteFaseB_W0, wCorrenteFaseB_W1);
fCorrenteFaseC:=Valor_Float(wCorrenteFaseC_W0, wCorrenteFaseC_W1);
fCorrenteNeutro:=Valor_Float(wCorrenteNeutro_W0, wCorrenteNeutro_W1);
fCorrenteG:=Valor_Float(wCorrenteG_W0, wCorrenteG_W1);
fCorrenteAvg:=Valor_Float(wCorrenteAvg_W0, wCorrenteAvg_W1);



fTensaoAB:=Valor_Float(WTensaoAB_W0, WTensaoAB_W1);
fTensaoBC:=Valor_Float(wTensaoBC_W0, wTensaoBC_W1);
fTensaoCA:=Valor_Float(wTensaoCA_W0, wTensaoCA_W1);
fTensaoAvgLL:=Valor_Float(wTensaoAvgL_W0, wTensaoAvgL_W1);
fTensaoAN:=Valor_Float(wTensaoAN_W0, wTensaoAN_W1);
fTensaoBN:=Valor_Float(wTensaoBN_W0, wTensaoBN_W1);
fTensaoCN:=Valor_Float(wTensaoCN_W0, wTensaoCN_W1);
fTensaoAvgLN:=Valor_Float(wTensaoAvgN_W0, wTensaoAvgN_W1);


fPotenciaAtivaTotal:=Valor_Float(wPotenciaAtivaTotal_W0, wPotenciaAtivaTotal_W1);

fFatorPotenciaTotal:=Valor_Float(wFatorPotenciaTotal_W0, wFatorPotenciaTotal_W1);

fFrequencia:=Valor_Float(wFrequencia_W0, wFrequencia_W1);

fUltimaDemanda:=Valor_Float(wUltimaDemanda_W0, wUltimaDemanda_W1);
fAtualDemanda:=Valor_Float(wAtualDemanda_W0, wAtualDemanda_W1);
fPrevisaoDemanda:=Valor_Float(wPrevisaoDemanda_W0, wPrevisaoDemanda_W1);
fPicoDemanda:=Valor_Float(wPicoDemanda_W0, wPicoDemanda_W1);
*)

wCorrenteFaseA_MW0 := MOVE(wCorrenteFaseA_W0); 
wCorrenteFaseA_MW1 := MOVE(wCorrenteFaseA_W1); 
wCorrenteFaseB_MW0 := MOVE(wCorrenteFaseB_W0); 
wCorrenteFaseB_MW1 := MOVE(wCorrenteFaseB_W1); 
wCorrenteFaseC_MW0 := MOVE(wCorrenteFaseC_W0); 
wCorrenteFaseC_MW1 := MOVE(wCorrenteFaseC_W1); 
wCorrenteNeutro_MW0	:= MOVE(wCorrenteNeutro_W0); 
wCorrenteNeutro_MW1	:= MOVE(wCorrenteNeutro_W1); 
wCorrenteG_MW0	:= MOVE(wCorrenteG_W0); 
wCorrenteG_MW1	:= MOVE(wCorrenteG_W1); 
wCorrenteAvg_MW0	:= MOVE(wCorrenteAvg_W0); 
wCorrenteAvg_MW1	:= MOVE(wCorrenteAvg_W1); 

wTensaoAB_MW0	:= MOVE(wTensaoAB_W0); 
wTensaoAB_MW1	:= MOVE(wTensaoAB_W1); 
wTensaoBC_MW0	:= MOVE(wTensaoBC_W0); 
wTensaoBC_MW1	:= MOVE(wTensaoBC_W1); 
wTensaoCA_MW0	:= MOVE(wTensaoCA_W0); 
wTensaoCA_MW1	:= MOVE(wTensaoCA_W1); 
wTensaoAvgL_MW0	:= MOVE(wTensaoAvgL_W0); 
wTensaoAvgL_MW1	:= MOVE(wTensaoAvgL_W1); 
wTensaoAN_MW0	:= MOVE(wTensaoAN_W0); 
wTensaoAN_MW1	:= MOVE(wTensaoAN_W1); 
wTensaoBN_MW0	:= MOVE(wTensaoBN_W0); 
wTensaoBN_MW1	:= MOVE(wTensaoBN_W1); 
wTensaoCN_MW0	:= MOVE(wTensaoCN_W0); 
wTensaoCN_MW1	:= MOVE(wTensaoCN_W1); 
wTensaoAvgN_MW0	:= MOVE(wTensaoAvgN_W0); 
wTensaoAvgN_MW1	:= MOVE(wTensaoAvgN_W1); 

wPotenciaAtivaTotal_MW0	:= MOVE(wPotenciaAtivaTotal_W0); 
wPotenciaAtivaTotal_MW1	:= MOVE(wPotenciaAtivaTotal_W1); 

wFatorPotenciaTotal_MW0	:= MOVE(wFatorPotenciaTotal_W0); 
wFatorPotenciaTotal_MW1	:= MOVE(wFatorPotenciaTotal_W1); 

wFrequencia_MW0	:= MOVE(wFrequencia_W0); 
wFrequencia_MW1	:= MOVE(wFrequencia_W1); 

wUltimaDemanda_MW0 := MOVE(wUltimaDemanda_W0); 
wUltimaDemanda_MW1 := MOVE(wUltimaDemanda_W1); 
wAtualDemanda_MW0 := MOVE(wAtualDemanda_W0); 
wAtualDemanda_MW1 := MOVE(wAtualDemanda_W1); 
wPrevisaoDemanda_MW0 := MOVE(wPrevisaoDemanda_W0); 
wPrevisaoDemanda_MW1 := MOVE(wPrevisaoDemanda_W1); 
wPicoDemanda_MW0 := MOVE(wPicoDemanda_W0); 
wPicoDemanda_MW1 := MOVE(wPicoDemanda_W1); 

// Valores INT64 
//Consumo Energia Ativa
wEnergiaAtivaAcumulada_MW0_High:= MOVE(wEnergiaAtivaAcumulada_W0_High); 
wEnergiaAtivaAcumulada_MW1_High:= MOVE(wEnergiaAtivaAcumulada_W1_High); 
wEnergiaAtivaAcumulada_MW0_Low:= MOVE(wEnergiaAtivaAcumulada_W0_Low); 
wEnergiaAtivaAcumulada_MW1_Low:= MOVE(wEnergiaAtivaAcumulada_W1_Low); 


EnergiaAtivaAcumulada(dValorLow:= dEnergiaAtivaAcumulada_D_Low, dValorHigh:= dEnergiaAtivaAcumulada_D_High, lValorOut=> lEnergiaAtivaAcumulada, rValorOut=>fEnergiaAtivaAcumulada );

//Consumo Energia Reativa
wEnergiaReativaAcumulada_MW0_High:= MOVE(wEnergiaReativaAcumulada_W0_High); 
wEnergiaReativaAcumulada_MW1_High:= MOVE(wEnergiaReativaAcumulada_W1_High); 
wEnergiaReativaAcumulada_MW0_Low:= MOVE(wEnergiaReativaAcumulada_W0_Low); 
wEnergiaReativaAcumulada_MW1_Low:= MOVE(wEnergiaReativaAcumulada_W1_Low); 


EnergiaReativaAcumulada(dValorLow:= dEnergiaReativaAcumulada_D_Low, dValorHigh:= dEnergiaReativaAcumulada_D_High, lValorOut=> lEnergiaReativaAcumulada, rValorOut=>fEnergiaReativaAcumulada );

//Consumo Energia Aparente
wEnergiaAparenteAcumulada_MW0_High:= MOVE(wEnergiaAparenteAcumulada_W0_High); 
wEnergiaAparenteAcumulada_MW1_High:= MOVE(wEnergiaAparenteAcumulada_W1_High); 
wEnergiaAparenteAcumulada_MW0_Low:= MOVE(wEnergiaAparenteAcumulada_W0_Low); 
wEnergiaAparenteAcumulada_MW1_Low:= MOVE(wEnergiaAparenteAcumulada_W1_Low); 


EnergiaAparenteAcumulada(dValorLow:= dEnergiaAparenteAcumulada_D_Low, dValorHigh:= dEnergiaAparenteAcumulada_D_High, lValorOut=> lEnergiaAparenteAcumulada, rValorOut=>fEnergiaAparenteAcumulada );


// MÁXIMOS
fCorrenteMaximaFaseA:=Valor_Float(wCorrenteMaximaFaseA_W0, wCorrenteMaximaFaseA_W1);
fCorrenteMaximaFaseB:=Valor_Float(wCorrenteMaximaFaseB_W0, wCorrenteMaximaFaseB_W1);
fCorrenteMaximaFaseC:=Valor_Float(wCorrenteMaximaFaseC_W0, wCorrenteMaximaFaseC_W1);
fCorrenteMaximaNeutro:=Valor_Float(wCorrenteMaximaNeutro_W0, wCorrenteMaximaNeutro_W1);
fCorrenteMaximaG:=Valor_Float(wCorrenteMaximaG_W0, wCorrenteMaximaG_W1);
fCorrenteMaximaAvg:=Valor_Float(wCorrenteMaximaAvg_W0, wCorrenteMaximaAvg_W1);

fTensaoMaximaAB:=Valor_Float(wTensaoMaximaAB_W0,wTensaoMaximaAB_W1);
fTensaoMaximaBC:=Valor_Float(wTensaoMaximaBC_W0,wTensaoMaximaBC_W1);
fTensaoMaximaCA:=Valor_Float(wTensaoMaximaCA_W0,wTensaoMaximaCA_W1);
fTensaoMaximaAvgL:=Valor_Float(wTensaoMaximaAvgL_W0,wTensaoMaximaAvgL_W1);
fTensaoMaximaAN:=Valor_Float(wTensaoMaximaAN_W0,wTensaoMaximaAN_W1);
fTensaoMaximaBN:=Valor_Float(wTensaoMaximaBN_W0,wTensaoMaximaBN_W1);
fTensaoMaximaCN:=Valor_Float(wTensaoMaximaCN_W0,wTensaoMaximaCN_W1);
fTensaoMaximaAvgN:=Valor_Float(wTensaoMaximaAvgN_W0,wTensaoMaximaAvgL_W1);

fPotenciaAtivaTotalMaxima:=Valor_Float(wPotenciaAtivaTotalMaxima_W0,wPotenciaAtivaTotalMaxima_W1);

(*------------------------------------------------------------------------
fFatorPotenciaTotal:= WORD_AS_REAL (wFatorPotenciaTotal_W1,wFatorPotenciaTotal_W0);

fUltimaDemanda:=WORD_AS_REAL(wUltimaDemanda_W1, wUltimaDemanda_W0);
fAtualDemanda:=WORD_AS_REAL(wAtualDemanda_W1, wAtualDemanda_W0);
fPrevisaoDemanda:=WORD_AS_REAL(wPrevisaoDemanda_W1, wPrevisaoDemanda_W0);
fPicoDemanda:=WORD_AS_REAL(wPicoDemanda_W1, wPicoDemanda_W0);
*)
