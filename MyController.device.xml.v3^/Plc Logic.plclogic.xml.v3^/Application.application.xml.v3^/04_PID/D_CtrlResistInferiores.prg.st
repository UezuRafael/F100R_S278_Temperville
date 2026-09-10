__METADATA__
{
  "v3Meta": {
    "objectGuid": "a49bfbc5-9cc3-47a5-bd35-9986ae0877bc",
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
PROGRAM D_CtrlResistInferiores
__IMPLEMENTATION__

// RESISTÊNCIAS INFERIORES
//SETOR 01 - INFERIOR	
// Setor 01 - Resistência 01
ControleInferiorSetor01(
	xLigaDesliga:= 		xLigaDeslResInferiores,//xLigaDesligaInfG01, ////
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[1],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[1], 
	rTermoparControle:= rTermoparInferiorControle[1], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[1],//rSetTemperaturaInferior[1], 
	rProcentagem:= 		rSetPorcentagemInferior[1], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[1], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[1],
	rTemperatura=> 		rTemperaturaInferiorSetor[1]);

// Setor 02 - Resistência 02	
ControleInferiorSetor02(
	xLigaDesliga:= 		xLigaDesligaInfG02, ////
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[2],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[2], 
	rTermoparControle:= rTermoparInferiorControle[2], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[2],//rSetTemperaturaInferior[2], 
	rProcentagem:= 		rSetPorcentagemInferior[2], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[2], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[2],
	rTemperatura=> 		rTemperaturaInferiorSetor[2]);

// Setor 03 - Resistência 03	
ControleInferiorSetor03(
	xLigaDesliga:= 		xLigaDesligaInfG01, ////
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[3],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[3], 
	rTermoparControle:= rTermoparInferiorControle[3], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[3],//rSetTemperaturaInferior[3], 
	rProcentagem:= 		rSetPorcentagemInferior[3], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[3], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[3],
	rTemperatura=> 		rTemperaturaInferiorSetor[3]);

// Setor 04 - Resistência 04	
ControleInferiorSetor04(
	xLigaDesliga:= 		xLigaDesligaInfG02, ////
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[4],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[4], 
	rTermoparControle:= rTermoparInferiorControle[4], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[4],//rSetTemperaturaInferior[4], 
	rProcentagem:= 		rSetPorcentagemInferior[4], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[4], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[4],
	rTemperatura=> 		rTemperaturaInferiorSetor[4]);

// Setor 05 - Resistência 05
ControleInferiorSetor05(
	xLigaDesliga:= 		xLigaDesligaInfG01,
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[5],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[5], 
	rTermoparControle:= rTermoparInferiorControle[5], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[5],//rSetTemperaturaInferior[5], 
	rProcentagem:= 		rSetPorcentagemInferior[5], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[5], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[5],
	rTemperatura=> 		rTemperaturaInferiorSetor[5]);
	
// Setor 06 - Resistência 06
ControleInferiorSetor06(
	xLigaDesliga:= 		xLigaDesligaInfG02,
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[6],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[6], 
	rTermoparControle:= rTermoparInferiorControle[6], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[6],//rSetTemperaturaInferior[6], 
	rProcentagem:= 		rSetPorcentagemInferior[6], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[6], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[6],
	rTemperatura=> 		rTemperaturaInferiorSetor[6]);

// Setor 07 - Resistência 07
ControleInferiorSetor07(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[7],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[7], 
	rTermoparControle:= rTermoparInferiorControle[7], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[7],//rSetTemperaturaInferior[7], 
	rProcentagem:= 		rSetPorcentagemInferior[7], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[7], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[7],
	rTemperatura=> 		rTemperaturaInferiorSetor[7]);

// Setor 08 - Resistência 08		
ControleInferiorSetor08(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[8],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[8], 
	rTermoparControle:= rTermoparInferiorControle[8], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[8],//rSetTemperaturaInferior[8], 
	rProcentagem:= 		rSetPorcentagemInferior[8], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[8], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[8],
	rTemperatura=> 		rTemperaturaInferiorSetor[8]);

// Setor 09 - Resistência 09
ControleInferiorSetor09(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[9],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[9], 
	rTermoparControle:= rTermoparInferiorControle[9], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[9],//rSetTemperaturaInferior[9], 
	rProcentagem:= 		rSetPorcentagemInferior[9], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[9], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[9],
	rTemperatura=> 		rTemperaturaInferiorSetor[9]);
	
// Setor 10 - Resistência 10
ControleInferiorSetor10(
	xLigaDesliga:= 		xLigaDeslResInferiores,//xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[10],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[10], 
	rTermoparControle:= rTermoparInferiorControle[10], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[10],//rSetTemperaturaInferior[10], 
	rProcentagem:= 		rSetPorcentagemInferior[10], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:=  50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[10], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[10],
	rTemperatura=> 		rTemperaturaInferiorSetor[10]);

// Setor 11 - Resistência 11
ControleInferiorSetor11(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[11],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[11], 
	rTermoparControle:= rTermoparInferiorControle[11], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[11],//rSetTemperaturaInferior[11], 
	rProcentagem:= 		rSetPorcentagemInferior[11], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[11], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[11],
	rTemperatura=> 		rTemperaturaInferiorSetor[11]);

// Setor 12 - Resistência 12	
ControleInferiorSetor12(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[12],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[12], 
	rTermoparControle:= rTermoparInferiorControle[12], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[12],//rSetTemperaturaInferior[12], 
	rProcentagem:= 		rSetPorcentagemInferior[12], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	20,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[12], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[12],
	rTemperatura=> 		rTemperaturaInferiorSetor[12]);

// Setor 13 - Resistência 13
ControleInferiorSetor13(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[13],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[13], 
	rTermoparControle:= rTermoparInferiorControle[13], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[13],//rSetTemperaturaInferior[13], 
	rProcentagem:= 		rSetPorcentagemInferior[13], 
	rGanhoPorporcionaKp	:= 	2,//Proporciona
	rGanhoIntegralKi	:= 	20,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[13], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[13],
	rTemperatura=> 		rTemperaturaInferiorSetor[13]);

// Setor 14 - Resistência 14
ControleInferiorSetor14(
	xLigaDesliga:= 		xLigaDesligaInfG01,
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[14],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[14], 
	rTermoparControle:= rTermoparInferiorControle[14], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[14],//rSetTemperaturaInferior[14], 
	rProcentagem:= 		rSetPorcentagemInferior[14], 
	rGanhoPorporcionaKp	:= 	2,//Proporciona
	rGanhoIntegralKi	:= 	20,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[14], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[14],
	rTemperatura=> 		rTemperaturaInferiorSetor[14]);	

// Setor 15 - Resistência 15
ControleInferiorSetor15(
	xLigaDesliga:= 		xLigaDesligaInfG02,
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[15],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[15], 
	rTermoparControle:= rTermoparInferiorControle[15], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[15],//rSetTemperaturaInferior[15], 
	rProcentagem:= 		rSetPorcentagemInferior[15], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[15], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[15],
	rTemperatura=> 		rTemperaturaInferiorSetor[15]);

// Setor 16 - Resistência 16
ControleInferiorSetor16(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[16],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[16], 
	rTermoparControle:= rTermoparInferiorControle[16], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[16],//rSetTemperaturaInferior[16], 
	rProcentagem:= 		rSetPorcentagemInferior[16], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[16], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[16],
	rTemperatura=> 		rTemperaturaInferiorSetor[16]);

// Setor 17 - Resistência 17
ControleInferiorSetor17(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[17],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[17], 
	rTermoparControle:= rTermoparInferiorControle[17], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[17],//rSetTemperaturaInferior[17], 
	rProcentagem:= 		rSetPorcentagemInferior[17], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[17], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[17],
	rTemperatura=> 		rTemperaturaInferiorSetor[17]);

// Setor 18 - Resistência 18
ControleInferiorSetor18(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[18],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[18], 
	rTermoparControle:= rTermoparInferiorControle[18], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[18],//rSetTemperaturaInferior[18], 
	rProcentagem:= 		rSetPorcentagemInferior[18], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[18], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[18],
	rTemperatura=> 		rTemperaturaInferiorSetor[18]);	

// Setor 19 - Resistência 19
ControleInferiorSetor19(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[19],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[19], 
	rTermoparControle:= rTermoparInferiorControle[19], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[19],//rSetTemperaturaInferior[19], 
	rProcentagem:= 		rSetPorcentagemInferior[19], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[19], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[19],
	rTemperatura=> 		rTemperaturaInferiorSetor[19]);

// Setor 20 - Resistência 20
ControleInferiorSetor20(
	xLigaDesliga:= 		xLigaDeslResInferiores,//xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[20],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[20], 
	rTermoparControle:= rTermoparInferiorControle[20], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[20],//rSetTemperaturaInferior[20], 
	rProcentagem:= 		rSetPorcentagemInferior[20], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[20], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[20],
	rTemperatura=> 		rTemperaturaInferiorSetor[20]);	
	
// Setor 21 - Resistência 21
ControleInferiorSetor21(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[21],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[21], 
	rTermoparControle:= rTermoparInferiorControle[21], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[21],//rSetTemperaturaInferior[21], 
	rProcentagem:= 		rSetPorcentagemInferior[21], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[21], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[21],
	rTemperatura=> 		rTemperaturaInferiorSetor[21]);	
	
// Setor 22 - Resistência 22
ControleInferiorSetor22(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[22],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[22], 
	rTermoparControle:= rTermoparInferiorControle[22], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[22],//rSetTemperaturaInferior[22], 
	rProcentagem:= 		rSetPorcentagemInferior[22], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[22], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[22],
	rTemperatura=> 		rTemperaturaInferiorSetor[22]);	
	
// Setor 23 - Resistência 23
ControleInferiorSetor23(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[23],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[23], 
	rTermoparControle:= rTermoparInferiorControle[23], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[23],//rSetTemperaturaInferior[23], 
	rProcentagem:= 		rSetPorcentagemInferior[23], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[23], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[23],
	rTemperatura=> 		rTemperaturaInferiorSetor[23]);
	
// Setor 24 - Resistência 24
ControleInferiorSetor24(
	xLigaDesliga:= 		xLigaDeslResInferiores,//xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[24],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[24], 
	rTermoparControle:= rTermoparInferiorControle[24], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[24],//rSetTemperaturaInferior[24], 
	rProcentagem:= 		rSetPorcentagemInferior[24], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[24], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[24],
	rTemperatura=> 		rTemperaturaInferiorSetor[24]);
	
// Setor 25 - Resistência 25
ControleInferiorSetor25(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[25],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[25], 
	rTermoparControle:= rTermoparInferiorControle[25], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[25],//rSetTemperaturaInferior[25], 
	rProcentagem:= 		rSetPorcentagemInferior[25], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[25], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[25],
	rTemperatura=> 		rTemperaturaInferiorSetor[25]);

// Setor 26 - Resistência 26
ControleInferiorSetor26(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[26],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[26], 
	rTermoparControle:= rTermoparInferiorControle[26], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[26],//rSetTemperaturaInferior[26], 
	rProcentagem:= 		rSetPorcentagemInferior[26], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[26], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[26],
	rTemperatura=> 		rTemperaturaInferiorSetor[26]);
	
// Setor 27 - Resistência 27
ControleInferiorSetor27(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[27],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[27], 
	rTermoparControle:= rTermoparInferiorControle[27], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[27],//rSetTemperaturaInferior[27], 
	rProcentagem:= 		rSetPorcentagemInferior[27], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[27], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[27],
	rTemperatura=> 		rTemperaturaInferiorSetor[27]);

// Setor 28 - Resistência 28
ControleInferiorSetor28(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[28],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[28], 
	rTermoparControle:= rTermoparInferiorControle[28], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[28],//rSetTemperaturaInferior[28], 
	rProcentagem:= 		rSetPorcentagemInferior[28], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[28], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[28],
	rTemperatura=> 		rTemperaturaInferiorSetor[28]);
	
// Setor 29 - Resistência 29
ControleInferiorSetor29(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[29],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[29], 
	rTermoparControle:= rTermoparInferiorControle[29], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[29],//rSetTemperaturaInferior[29], 
	rProcentagem:= 		rSetPorcentagemInferior[29], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[29], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[29],
	rTemperatura=> 		rTemperaturaInferiorSetor[29]);
	
// Setor 30 - Resistência 30
ControleInferiorSetor30(
	xLigaDesliga:= 		xLigaDeslResInferiores,//xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[30],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[30], 
	rTermoparControle:= rTermoparInferiorControle[30], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[30],//rSetTemperaturaInferior[30], 
	rProcentagem:= 		rSetPorcentagemInferior[30], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[30], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[30],
	rTemperatura=> 		rTemperaturaInferiorSetor[30]);
	
// Setor 31 - Resistência 31
ControleInferiorSetor31(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[31],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[31], 
	rTermoparControle:= rTermoparInferiorControle[31], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[31],//rSetTemperaturaInferior[31], 
	rProcentagem:= 		rSetPorcentagemInferior[31], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[31], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[31],
	rTemperatura=> 		rTemperaturaInferiorSetor[31]);
	

// Setor 32 - Resistência 32
ControleInferiorSetor32(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[32],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[32], 
	rTermoparControle:= rTermoparInferiorControle[32], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[32],//rSetTemperaturaInferior[32], 
	rProcentagem:= 		rSetPorcentagemInferior[32], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[32], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[32],
	rTemperatura=> 		rTemperaturaInferiorSetor[32]);
	
// Setor 33 - Resistência 33
ControleInferiorSetor33(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[33],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[33], 
	rTermoparControle:= rTermoparInferiorControle[33], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[33],//rSetTemperaturaInferior[33], 
	rProcentagem:= 		rSetPorcentagemInferior[33], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[33], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[33],
	rTemperatura=> 		rTemperaturaInferiorSetor[33]);
	
	// Setor 34 - Resistência 34
ControleInferiorSetor34(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[34],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[34], 
	rTermoparControle:= rTermoparInferiorControle[34], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[34],//rSetTemperaturaInferior[34], 
	rProcentagem:= 		rSetPorcentagemInferior[34], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[34], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[34],
	rTemperatura=> 		rTemperaturaInferiorSetor[34]);
	
// Setor 35 - Resistência 35
ControleInferiorSetor35(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[35],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[35], 
	rTermoparControle:= rTermoparInferiorControle[35], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[35],//rSetTemperaturaInferior[35], 
	rProcentagem:= 		rSetPorcentagemInferior[35], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[35], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[35],
	rTemperatura=> 		rTemperaturaInferiorSetor[35]);
	
// Setor 36 - Resistência 36
ControleInferiorSetor36(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[36],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[36], 
	rTermoparControle:= rTermoparInferiorControle[36], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[36],//rSetTemperaturaInferior[36], 
	rProcentagem:= 		rSetPorcentagemInferior[36], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[36], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[36],
	rTemperatura=> 		rTemperaturaInferiorSetor[36]);

// Setor 37 - Resistência 37
ControleInferiorSetor37(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[37],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[37], 
	rTermoparControle:= rTermoparInferiorControle[37], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[37],//rSetTemperaturaInferior[37], 
	rProcentagem:= 		rSetPorcentagemInferior[37], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[37], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[37],
	rTemperatura=> 		rTemperaturaInferiorSetor[37]);
	
// Setor 38 - Resistência 38
ControleInferiorSetor38(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[38],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[38], 
	rTermoparControle:= rTermoparInferiorControle[38], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[38],//rSetTemperaturaInferior[38], 
	rProcentagem:= 		rSetPorcentagemInferior[38], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[38], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[38],
	rTemperatura=> 		rTemperaturaInferiorSetor[38]);
	
// Setor 39 - Resistência 39
ControleInferiorSetor39(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[39],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[39], 
	rTermoparControle:= rTermoparInferiorControle[39], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[39],//rSetTemperaturaInferior[39], 
	rProcentagem:= 		rSetPorcentagemInferior[39], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[39], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[39],
	rTemperatura=> 		rTemperaturaInferiorSetor[39]);
	
// Setor 40 - Resistência 40
ControleInferiorSetor40(
	xLigaDesliga:= 		xLigaDeslResInferiores,//xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[40],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[40], 
	rTermoparControle:= rTermoparInferiorControle[40], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[40],//rSetTemperaturaInferior[40], 
	rProcentagem:= 		rSetPorcentagemInferior[40], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[40], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[40],
	rTemperatura=> 		rTemperaturaInferiorSetor[40]);
	
// Setor 41 - Resistência 41 
ControleInferiorSetor41(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[41],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[41], 
	rTermoparControle:= rTermoparInferiorControle[41], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[41],//rSetTemperaturaInferior[41], 
	rProcentagem:= 		rSetPorcentagemInferior[41], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[41], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[41],
	rTemperatura=> 		rTemperaturaInferiorSetor[41]);
	
// Setor 42 - Resistência 42
ControleInferiorSetor42(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[42],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[42], 
	rTermoparControle:= rTermoparInferiorControle[42], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[42],//rSetTemperaturaInferior[42], 
	rProcentagem:= 		rSetPorcentagemInferior[42], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[42], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[42],
	rTemperatura=> 		rTemperaturaInferiorSetor[42]);
	
// Setor 43 - Resistência 43 
ControleInferiorSetor43(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[43],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[43], 
	rTermoparControle:= rTermoparInferiorControle[43], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[43],//rSetTemperaturaInferior[43], 
	rProcentagem:= 		rSetPorcentagemInferior[43], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[43], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[43],
	rTemperatura=> 		rTemperaturaInferiorSetor[43]);
	
// Setor 44 - Resistência 44
ControleInferiorSetor44(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[44],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[44], 
	rTermoparControle:= rTermoparInferiorControle[44], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[44],//rSetTemperaturaInferior[44], 
	rProcentagem:= 		rSetPorcentagemInferior[44], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[44], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[44],
	rTemperatura=> 		rTemperaturaInferiorSetor[44]);
	
// Setor 45 - Resistência 45 
ControleInferiorSetor45(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[45],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[45], 
	rTermoparControle:= rTermoparInferiorControle[45], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[45],//rSetTemperaturaInferior[45], 
	rProcentagem:= 		rSetPorcentagemInferior[45], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[45], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[45],
	rTemperatura=> 		rTemperaturaInferiorSetor[45]);
	
// Setor 46 - Resistência 46 
ControleInferiorSetor46(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[46],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[46], 
	rTermoparControle:= rTermoparInferiorControle[46], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[46],//rSetTemperaturaInferior[46], 
	rProcentagem:= 		rSetPorcentagemInferior[46], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[46], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[46],
	rTemperatura=> 		rTemperaturaInferiorSetor[46]);
	
// Setor 47 - Resistência 47 
ControleInferiorSetor47(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[47],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[47], 
	rTermoparControle:= rTermoparInferiorControle[47], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[47],//rSetTemperaturaInferior[47], 
	rProcentagem:= 		rSetPorcentagemInferior[47], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[47], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[47],
	rTemperatura=> 		rTemperaturaInferiorSetor[47]);
	
// Setor 48 - Resistência 48 
ControleInferiorSetor48(
	xLigaDesliga:= 		xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[48],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[48], 
	rTermoparControle:= rTermoparInferiorControle[48], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[48],//rSetTemperaturaInferior[48], 
	rProcentagem:= 		rSetPorcentagemInferior[48], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[48], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[48],
	rTemperatura=> 		rTemperaturaInferiorSetor[48]);
	
// Setor 49 - Resistência 49 
ControleInferiorSetor49(
	xLigaDesliga:= 		xLigaDesligaInfG01, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[49],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[49], 
	rTermoparControle:= rTermoparInferiorControle[49], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[49],//rSetTemperaturaInferior[49], 
	rProcentagem:= 		rSetPorcentagemInferior[49], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[49], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[49],
	rTemperatura=> 		rTemperaturaInferiorSetor[49]);
	
	// Setor 50 - Resistência 50 
ControleInferiorSetor50(
	xLigaDesliga:= 		xLigaDeslResInferiores,//xLigaDesligaInfG02, 
	xHabilitaControle:= xHabilitaBlocosControleInferior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaInferior[50],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparInferiorLeitura[50], 
	rTermoparControle:= rTermoparInferiorControle[50], 
	rSetTemperatura:= 	rSetPointTemperaturaInferior[50],//rSetTemperaturaInferior[50], 
	rProcentagem:= 		rSetPorcentagemInferior[50], 
	rGanhoPorporcionaKp	:= 	10,//Proporciona
	rGanhoIntegralKi	:= 	50,//Integal
	rGanhoDerivativoKd	:= 	0,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrInferior[50], 
	xTemperaturaOk=>	xTemperaturaInfeirorOk[50],
	rTemperatura=> 		rTemperaturaInferiorSetor[50]);
	
	
