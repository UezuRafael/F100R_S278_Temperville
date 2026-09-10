__METADATA__
{
  "v3Meta": {
    "objectGuid": "6545e559-eaf8-4450-a5d1-5c6d8b8a2ba0",
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
PROGRAM O_Motores
VAR
	PulsoPoCanMotorForno: TP;
	PulsoPoCanMotorFornoIn: BOOL;
	PulsoPoCanMotorFornoQ: BOOL;
	rFrequenciaMotorVentilador03Hz:REAL;
	rFrequenciaMotorVentilador03Rpm:REAL;
	rFrequenciaMotorVentilador01Hz:REAL;
	rFrequenciaMotorVentilador01Rpm:REAL;
END_VAR
__IMPLEMENTATION__
//Motor Mesa Entrada
xFalhaMotorEntrada:=InversorMesaEntrada.q_xFalha;
xMotorEntradaLigado:=InversorMesaEntrada.q_xOperando;
uAmperagemMotorMesaEntrada:= INT_TO_UINT (InversorMesaEntrada.q_iCorrente);
iFrequenciaMotorMesaEntrada:= InversorMesaEntrada.q_iFreqSaida;

//Motor Mesa Forno
xFalhaMotorForno:=InversorMesaForno.q_xFalha;
xMotorFornoLigado:=InversorMesaForno.q_xOperando;
uAmperagemMotorMesaForno:= INT_TO_UINT (InversorMesaForno.q_iCorrente);
iFrequenciaMotorMesaForno:= InversorMesaForno.q_iFreqSaida;

//Motor Mesa Têmpera de Passagem
xFalhaMotorPassagem:=InversorMesaPass.q_xFalha;
xMotorPassagemLigado:=InversorMesaPass.q_xOperando;
uAmperagemMotorMesaPassagem:= INT_TO_UINT (InversorMesaPass.q_iCorrente);
iFrequenciaMotorMesaPassagem:= InversorMesaPass.q_iFreqSaida;

//Motor Mesa Resfriamento
xFalhaMotorResfriador:=InversorMesaResfri.q_xFalha;
xMotorResfriadorLigado:=InversorMesaResfri.q_xOperando;
uAmperagemMotorMesaResfriamento:= INT_TO_UINT (InversorMesaResfri.q_iCorrente);
iFrequenciaMotorMesaResfriamento:= InversorMesaResfri.q_iFreqSaida;

//Motor Mesa Saída
xFalhaMotorSaida:=InversorMesaSaida.q_xFalha;
xMotorSaidaLigado:=InversorMesaSaida.q_xOperando;
uAmperagemMotorMesaSaida:=INT_TO_UINT (InversorMesaSaida.q_iCorrente);
iFrequenciaMotorMesaSaida:=InversorMesaSaida.q_iFreqSaida;

//Motor Dutos Resfriador Inferior 01
xFalhaMotorDifusorInf01:=InversorResfInf01.q_xFalha;
xMotorDifusorInf01Ligado:=InversorResfInf01.q_xOperando;
//xMotorDifusorInf01Direcao:=;
uAmperagemMotorDutosResfriadorInf01:=INT_TO_UINT (InversorResfInf01.q_iCorrente);
iFrequenciaMotorDutosResfriadorInf01:=InversorResfInf01.q_iFreqSaida;

//Motor Dutos Resfriador Superior 01
xFalhaMotorDifusorSup01:=InversorResfSup01.q_xFalha;
xMotorDifusorSup01Ligado:=InversorResfSup01.q_xOperando;
//xMotorDifusorSup01Direcao:=;
uAmperagemMotorDutosResfriadorSup01:=INT_TO_UINT (InversorResfSup01.q_iCorrente);
iFrequenciaMotorDutosResfriadorSup01:=InversorResfSup01.q_iFreqSaida;

//Motor Dutos Resfriador Inferior 02
xFalhaMotorDifusorInf02:=InversorResfInf02.q_xFalha;
xMotorDifusorInf02Ligado:=InversorResfInf02.q_xOperando;
//xMotorDifusorInf02Direcao:=;
uAmperagemMotorDutosResfriadorInf02:=INT_TO_UINT (InversorResfInf02.q_iCorrente);
iFrequenciaMotorDutosResfriadorInf02:=InversorResfInf02.q_iFreqSaida;

//Motor Dutos Resfriador Superior 02
xFalhaMotorDifusorSup02:=InversorResfSup02.q_xFalha;
xMotorDifusorSup02Ligado:=InversorResfSup02.q_xOperando;
//xMotorDifusorSup02Direcao:=;
uAmperagemMotorDutosResfriadorSup02:=INT_TO_UINT (InversorResfSup02.q_iCorrente);
iFrequenciaMotorDutosResfriadorSup02:=InversorResfSup02.q_iFreqSaida;

//Motor Guilhotina 01
xFalhaMotorGuilhotina01:=InversorGuilhot01.q_xFalha;
xMotorGuilhotina01Ligado:=InversorGuilhot01.q_xOperando;
//xMotorGuilhotina01Direcao:=;
uAmperagemMotorGuilhotina01:=INT_TO_UINT (InversorGuilhot01.q_iCorrente);
iFrequenciaMotorGuilhotina01:=InversorGuilhot01.q_iFreqSaida;

//Motor Guilhotina 01 Superior
xFalhaMotorGuilhotina01Sup:=InversorGuilhot01Sup.q_xFalha;
xMotorGuilhotina01SupLigado:=InversorGuilhot01Sup.q_xOperando;
uAmperagemMotorGuilhotina01Sup:=INT_TO_UINT (InversorGuilhot01Sup.q_iCorrente);
iFrequenciaMotorGuilhotina01Sup:=InversorGuilhot01Sup.q_iFreqSaida;

//Motor Guilhotina 01 Inferior
xFalhaMotorGuilhotina01Inf:=InversorGuilhot01Inf.q_xFalha;
xMotorGuilhotina01InfLigado:=InversorGuilhot01Inf.q_xOperando;
uAmperagemMotorGuilhotina01Inf:=INT_TO_UINT (InversorGuilhot01Inf.q_iCorrente);
iFrequenciaMotorGuilhotina01Inf:=InversorGuilhot01Inf.q_iFreqSaida;

//Motor Guilhotina 02
xFalhaMotorGuilhotina02:=InversorGuilhot02.q_xFalha;
xMotorGuilhotina02Ligado:=InversorGuilhot02.q_xOperando;
//xMotorGuilhotina02Direcao:=;
uAmperagemMotorGuilhotina02:=INT_TO_UINT (InversorGuilhot02.q_iCorrente);
iFrequenciaMotorGuilhotina02:=InversorGuilhot02.q_iFreqSaida;

// Motor Limpeza do Resfriador 02
//xFalhaMotorLimpResfr02:=;
//xMotorLimpResfr02Ligado:=;
////xMotorLimpResfr02Direcao:=;
//uAmperagemMotorLimpResfr02:=;
//iFrequenciaMotorLimpResfr02:=;

// Motor Elevação Caixa do Forno
//xFalhaMotorCaixaForno:=;
//xMotorCaixaFornoLigado:=;
////xMotorCaixaFornoDirecao:=;
//uAmperagemMotorCaixaForno:=;
//iFrequenciaMotorCaixaForno:=;

//Motor Ventilador 01
xFalhaMotorVentilador01:=xFalhaMotorVentilador01;//InversorVentila01.q_xFalha;
xMotorVentilador01Ligado:=xMotorVentilador01Ligado;//InversorVentila01.q_xOperando;
uAmperagemMotorVentilador01:=INT_TO_UINT (InversorVentila01.q_iCorrente);
//iFrequenciaMotorVentilador01:=iFrequenciaSaidaVentilador01/1;//InversorVentila01.q_iFreqSaida;

rFrequenciaMotorVentilador01Hz:=INT_TO_REAL(iFrequenciaSaidaVentilador01);
rFrequenciaMotorVentilador01Rpm:=((rFrequenciaMotorVentilador01Hz*1800)/60);
iFrequenciaMotorVentilador01:=REAL_TO_INT(rFrequenciaMotorVentilador01Rpm/10);

//Motor Ventilador 02
xFalhaMotorVentilador02:=InversorVentila02.q_xFalha;
xMotorVentilador02Ligado:=InversorVentila02.q_xOperando;
uAmperagemMotorVentilador02:=INT_TO_UINT (InversorVentila02.q_iCorrente);
iFrequenciaMotorVentilador02:=InversorVentila02.q_iFreqSaida;

//Motor Ventilador 03
xFalhaMotorVentilador03:=InversorVentila03.q_xFalha;
xMotorVentilador03Ligado:=InversorVentila03.q_xOperando;
uAmperagemMotorVentilador03:=INT_TO_UINT (InversorVentila03.q_iCorrente)*10;
//iFrequenciaMotorVentilador03:=InversorVentila03.q_iFreqSaida;

rFrequenciaMotorVentilador03Hz:=INT_TO_REAL(InversorVentila03.q_iFreqSaida);
rFrequenciaMotorVentilador03Rpm:=((rFrequenciaMotorVentilador03Hz*1787)/60);
iFrequenciaMotorVentilador03:=REAL_TO_INT(rFrequenciaMotorVentilador03Rpm/1);


//Motor Ventilador 04
xFalhaMotorVentilador04:=InversorVentila04.q_xFalha;
xMotorVentilador04Ligado:=InversorVentila04.q_xOperando;
uAmperagemMotorVentilador04:=INT_TO_UINT (InversorVentila04.q_iCorrente);
iFrequenciaMotorVentilador04:=InversorVentila04.q_iFreqSaida;


//Motor Ventilador Convecção Entrada
xFalhaMotorVentConvecEnt:=InversorConvecEnt.q_xFalha;
xMotorVentConvecEntLigado:=InversorConvecEnt.q_xOperando;
uAmperagemMotorVentConvec:=INT_TO_UINT (InversorConvecEnt.q_iCorrente);
iFrequenciaMotorVentConvec:=InversorConvecEnt.q_iFreqSaida;

//Motor Ventilador Convecção Saida
xFalhaMotorVentConvecSai:=InversorConvecSai.q_xFalha;
xMotorVentConvecSaiLigado:=InversorConvecSai.q_xOperando;
uAmperagemMotorVentConvecSai:=INT_TO_UINT (InversorConvecSai.q_iCorrente);
iFrequenciaMotorVentConvecSai:=InversorConvecSai.q_iFreqSaida;

//Reset Motores

InversorMesaEntrada.i_xReset:=bResetAlmGeral;
InversorMesaForno.i_xReset:=bResetAlmGeral OR PulsoPoCanMotorFornoQ;
//InversorMesaPass.i_xReset:=bResetAlmGeral;
InversorMesaResfri.i_xReset:=bResetAlmGeral;
InversorMesaSaida.i_xReset:=bResetAlmGeral;
//InversorResfSup01.i_xReset:=bResetAlmGeral;
//InversorResfInf01.i_xReset:=bResetAlmGeral;
InversorResfSup02.i_xReset:=bResetAlmGeral;
//InversorResfInf02.i_xReset:=bResetAlmGeral;
//InversorGuilhot01.i_xReset:=bResetAlmGeral;
InversorGuilhot02.i_xReset:=bResetAlmGeral;

InversorConvecEnt.i_xReset:=bResetAlmGeral; // Superior
//InversorConvecSai.i_xReset:=bResetAlmGeral; // Inferior
xResetVentilador01:=bResetAlmGeral;
InversorVentila03.i_xReset:=bResetAlmGeral;
//InversorGuilhot01Sup.i_xReset:=bResetAlmGeral;
//InversorGuilhot01Inf.i_xReset:=bResetAlmGeral;
InversorSobeDesceForno.i_xReset:=bResetAlmGeral;


// Alarmes motores Fora Rede

xAlarmeCofInverMesaEntra	:= NOT iCanOpenInverMesaEntraStateOk;   	//Adr:01
xAlarmeCofInverMesaForno	:= NOT iCanOpenInverMesaFornoStateOk;		//Adr:02
//xAlarmeCofInverMesaPass		:= NOT iCanOpenInverMesaPassStateOk;		
xAlarmeCofInverMesaResfr	:= NOT iCanOpenInverMesaResfrStateOk;   	//Adr:03
xAlarmeCofInverMesaSaida	:= NOT iCanOpenInverMesaSaidaStateOk;   	//Adr:04
//xAlarmeCofInverResfrSup01	:= NOT iCanOpenInverDuctResfrSup01StateOk;  
//xAlarmeCofInverGuilho01Sup	:= NOT iCanOpenInverGuilResfr01SupStateOk;	
//xAlarmeCofInverGuilho01Inf	:= NOT iCanOpenInverGuilResfr01InfStateOk;	
xAlarmeCofInverResfrSup02	:= NOT iCanOpenInverDuctResfrSup02StateOk;	//Adr:05
//xAlarmeCofInverResfrInf02	:= NOT iCanOpenInverDuctResfrInf02StateOk;	
//xAlarmeCofInverGuilho01		:= NOT iCanOpenInverGuilResfr01StateOk;	
xAlarmeCofInverGuilho02		:= NOT iCanOpenInverGuilResfr02StateOk;		//Adr:06
xAlarmeCofInverConvecEnt	:= NOT iCanOpenInverConvecEntStateOk;		//Adr:07
//xAlarmeCofInverConvecSai	:= NOT iCanOpenInverConvecSaiStateOk;		
xAlarmeCofInverCaixaForno	:= NOT iCanOpenInverCaixaFornoStateOk;		//Adr:08


xAlarmeCofInverVentila03	:= NOT iCanOpenInverVentila03StateOk;		//Adr:12

PulsoPoCanMotorFornoIn:=iCanOpenInverMesaFornoStateOk;
PulsoPoCanMotorForno(IN:= PulsoPoCanMotorFornoIn, PT:=T#1S , Q=> PulsoPoCanMotorFornoQ, ET=> );

(* VELOCIDADES SP5 *)

IF iVelMesaForno25<> 0 THEN
	InversorMesaEntrada.i_SP5:=REAL_TO_UINT(rVelMesaEntrada25);
	InversorMesaForno.i_SP5:=iVelMesaForno25;
	InversorMesaPass.i_SP5:=REAL_TO_UINT(rVelMesaPassagem25);
	InversorMesaResfri.i_SP5:=REAL_TO_UINT(rVelMesaResfriamento25);
	InversorMesaSaida.i_SP5:=REAL_TO_UINT(rVelMesaSaida25);
ELSIF iVelMesaForno35<> 0 THEN
	InversorMesaEntrada.i_SP5:=REAL_TO_UINT(rVelMesaEntrada35);
	InversorMesaForno.i_SP5:=iVelMesaForno35;
	InversorMesaPass.i_SP5:=REAL_TO_UINT(rVelMesaPassagem35);
	InversorMesaResfri.i_SP5:=REAL_TO_UINT(rVelMesaResfriamento35);
	InversorMesaSaida.i_SP5:=REAL_TO_UINT(rVelMesaSaida35);
ELSIF iVelMesaForno45<> 0 THEN
	InversorMesaEntrada.i_SP5:=REAL_TO_UINT(rVelMesaEntrada45);
	InversorMesaForno.i_SP5:=iVelMesaForno45;
	InversorMesaPass.i_SP5:=REAL_TO_UINT(rVelMesaPassagem45);
	InversorMesaResfri.i_SP5:=REAL_TO_UINT(rVelMesaResfriamento45);
	InversorMesaSaida.i_SP5:=REAL_TO_UINT(rVelMesaSaida45);
END_IF

(*IF rVelResfSup01=0 THEN
	rVelResfSup01:=600;
ELSE
	rVelResfSup01:=rVelResfSup01;
END_IF

IF rVelResfSup02=0 THEN
	rVelResfSup02:=600;
ELSE
	rVelResfSup02:=rVelResfSup02;
END_IF*)

InversorResfSup02.i_SP5:=REAL_TO_INT(rVelResfSup02);
InversorResfInf02.i_SP5:=REAL_TO_INT(rVelResfInf02);


(*IF rVelGuilhotina01Sup=0 THEN
	rVelGuilhotina01Sup:=600;
ELSE
	rVelGuilhotina01Sup:=rVelGuilhotina01Sup;
END_IF

IF rVelGuilhotina01Inf=0 THEN
	rVelGuilhotina01Inf:=600;
ELSE
	rVelGuilhotina01Inf:=rVelGuilhotina01Inf;
END_IF

IF rVelGuilhotina02=0 THEN
	rVelGuilhotina02:=600;
ELSE
	rVelGuilhotina02:=rVelGuilhotina02;
END_IF*)


InversorGuilhot01.i_SP5:=REAL_TO_INT(rVelGuilhotina01);
InversorGuilhot02.i_SP5:=REAL_TO_INT(rVelGuilhotina02);

