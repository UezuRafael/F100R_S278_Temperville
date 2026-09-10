__METADATA__
{
  "v3Meta": {
    "objectGuid": "82872a90-58b3-47e4-9588-f34a605855d0",
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
PROGRAM D_CtrlResistSuperiores
__IMPLEMENTATION__

// RESISTÊNCIAS SUPERIORES
// Setor 51 - Resistência 51
//FiltroTermoparSup01(rDadoEntrada:= rTermoparSuperiorControle[1], rDadoSaida=>ControleSuperiorSetor01.rTermoparControle );	

ControleSuperiorSetor01(
	xLigaDesliga:= 		xLigaDesligaSupG01, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[1],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[1], 
	rTermoparControle:= rTermoparSuperiorControle[1], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[1],//rSetTemperaturaSuperior[1], 
	rProcentagem:= 		rSetPorcentagemSuperior[1], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[1], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[1],
	rTemperatura=> 		rTemperaturaSuperiorSetor[1]);
	
// Setor 52 - Resistência 52	
//FiltroTermoparSup02(rDadoEntrada:= rTermoparSuperiorControle[2], rDadoSaida=>ControleSuperiorSetor02.rTermoparControle );	

ControleSuperiorSetor02(
	xLigaDesliga:= 		xLigaDesligaSupG02, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[2],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[2], 
	rTermoparControle:= rTermoparSuperiorControle[2], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[2],//rSetTemperaturaSuperior[2], 
	rProcentagem:= 		rSetPorcentagemSuperior[2], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[2], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[2],
	rTemperatura=> 		rTemperaturaSuperiorSetor[2]);

// Setor 53 - Resistência 53	
//FiltroTermoparSup03(rDadoEntrada:= rTermoparSuperiorControle[3], rDadoSaida=>ControleSuperiorSetor03.rTermoparControle );	

ControleSuperiorSetor03(
	xLigaDesliga:= 		xLigaDesligaSupG01, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[3],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[3], 
	rTermoparControle:= rTermoparSuperiorControle[3], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[3],//rSetTemperaturaSuperior[3], 
	rProcentagem:= 		rSetPorcentagemSuperior[3], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[3], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[3],
	rTemperatura=> 		rTemperaturaSuperiorSetor[3]);

// Setor 54 - Resistência 54
//FiltroTermoparSup04(rDadoEntrada:= rTermoparSuperiorControle[4], rDadoSaida=>ControleSuperiorSetor04.rTermoparControle );	

ControleSuperiorSetor04(
	xLigaDesliga:= 		xLigaDesligaSupG02, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[4],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[4], 
	rTermoparControle:= rTermoparSuperiorControle[4], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[4],//rSetTemperaturaSuperior[4], 
	rProcentagem:= 		rSetPorcentagemSuperior[4], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[4], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[4],
	rTemperatura=> 		rTemperaturaSuperiorSetor[4]);

// Setor 55 - Resistência 55	
//FiltroTermoparSup05(rDadoEntrada:= rTermoparSuperiorControle[5], rDadoSaida=>ControleSuperiorSetor05.rTermoparControle );	

ControleSuperiorSetor05(
	xLigaDesliga:= 		xLigaDesligaSupG01, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[5],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[5], 
	rTermoparControle:= rTermoparSuperiorControle[5], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[5],//rSetTemperaturaSuperior[5], 
	rProcentagem:= 		rSetPorcentagemSuperior[5], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[5], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[5],
	rTemperatura=> 		rTemperaturaSuperiorSetor[5]);
	
// Setor 56 - Resistência 56
//FiltroTermoparSup06(rDadoEntrada:= rTermoparSuperiorControle[6], rDadoSaida=>ControleSuperiorSetor06.rTermoparControle );	

ControleSuperiorSetor06(
	xLigaDesliga:= 		xLigaDesligaSupG02, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[6],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[6], 
	rTermoparControle:= rTermoparSuperiorControle[6], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[6],//rSetTemperaturaSuperior[6], 
	rProcentagem:= 		rSetPorcentagemSuperior[6], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[6], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[6],
	rTemperatura=> 		rTemperaturaSuperiorSetor[6]);

// Setor 57 - Resistência 57
//FiltroTermoparSup07(rDadoEntrada:= rTermoparSuperiorControle[7], rDadoSaida=>ControleSuperiorSetor07.rTermoparControle );	

ControleSuperiorSetor07(
	xLigaDesliga:= 		xLigaDesligaSupG01, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[7],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[7], 
	rTermoparControle:= rTermoparSuperiorControle[7], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[7],//rSetTemperaturaSuperior[7], 
	rProcentagem:= 		rSetPorcentagemSuperior[7], 
	rGanhoPorporcionaKp	:= 	3,//Proporciona
	rGanhoIntegralKi	:= 	0.5,//Integal
	rGanhoDerivativoKd	:= 	3,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[7], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[7],
	rTemperatura=> 		rTemperaturaSuperiorSetor[7]);

// Setor 58 - Resistência 58	
//FiltroTermoparSup08(rDadoEntrada:= rTermoparSuperiorControle[8], rDadoSaida=>ControleSuperiorSetor08.rTermoparControle );	

ControleSuperiorSetor08(
	xLigaDesliga:= 		xLigaDesligaSupG02, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[8],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[8], 
	rTermoparControle:= rTermoparSuperiorControle[8], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[8],//rSetTemperaturaSuperior[8], 
	rProcentagem:= 		rSetPorcentagemSuperior[8], 
	rGanhoPorporcionaKp	:= 	2,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	2,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[8], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[8],
	rTemperatura=> 		rTemperaturaSuperiorSetor[8]);

// Setor 59 - Resistência 59
//FiltroTermoparSup09(rDadoEntrada:= rTermoparSuperiorControle[9], rDadoSaida=>ControleSuperiorSetor09.rTermoparControle );	

ControleSuperiorSetor09(
	xLigaDesliga:= 		xLigaDesligaSupG01, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[9],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[9], 
	rTermoparControle:= rTermoparSuperiorControle[9], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[9],//rSetTemperaturaSuperior[9], 
	rProcentagem:= 		rSetPorcentagemSuperior[9], 
	rGanhoPorporcionaKp	:= 	3,//Proporciona
	rGanhoIntegralKi	:= 	0.5,//Integal
	rGanhoDerivativoKd	:= 	3,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[9], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[9],
	rTemperatura=> 		rTemperaturaSuperiorSetor[9]);

// Setor 60 - Resistência 60
//FiltroTermoparSup10(rDadoEntrada:= rTermoparSuperiorControle[10], rDadoSaida=>ControleSuperiorSetor10.rTermoparControle );	

ControleSuperiorSetor10(
	xLigaDesliga:= 		xLigaDesligaSupG02, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[10],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[10], 
	rTermoparControle:= rTermoparSuperiorControle[10], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[10],//rSetTemperaturaSuperior[10], 
	rProcentagem:= 		rSetPorcentagemSuperior[10], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[10], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[10],
	rTemperatura=> 		rTemperaturaSuperiorSetor[10]);

// Setor 61 - Resistência 61
//FiltroTermoparSup11(rDadoEntrada:= rTermoparSuperiorControle[11], rDadoSaida=>ControleSuperiorSetor11.rTermoparControle );	

ControleSuperiorSetor11(
	xLigaDesliga:= 		xLigaDesligaSupG02, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[11],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[11], 
	rTermoparControle:= rTermoparSuperiorControle[11], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[11],//rSetTemperaturaSuperior[11], 
	rProcentagem:= 		rSetPorcentagemSuperior[11], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[11], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[11],
	rTemperatura=> 		rTemperaturaSuperiorSetor[11]);

// Setor 62 - Resistência 62
//FiltroTermoparSup12(rDadoEntrada:= rTermoparSuperiorControle[12], rDadoSaida=>ControleSuperiorSetor12.rTermoparControle );	

ControleSuperiorSetor12(
	xLigaDesliga:= 		xLigaDesligaSupG01, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[12],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[12], 
	rTermoparControle:= rTermoparSuperiorControle[12], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[12],//rSetTemperaturaSuperior[12], 
	rProcentagem:= 		rSetPorcentagemSuperior[12], 
	rGanhoPorporcionaKp	:= 	3,//Proporciona
	rGanhoIntegralKi	:= 	0.5,//Integal
	rGanhoDerivativoKd	:= 	3,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[12], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[12],
	rTemperatura=> 		rTemperaturaSuperiorSetor[12]);

// Setor 63 - Resistência 63	
//FiltroTermoparSup13(rDadoEntrada:= rTermoparSuperiorControle[13], rDadoSaida=>ControleSuperiorSetor13.rTermoparControle );	

ControleSuperiorSetor13(
	xLigaDesliga:= 		xLigaDesligaSupG02, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[13],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[13], 
	rTermoparControle:= rTermoparSuperiorControle[13], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[13],//rSetTemperaturaSuperior[13], 
	rProcentagem:= 		rSetPorcentagemSuperior[13], 
	rGanhoPorporcionaKp	:= 	2,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	2,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[13], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[13],
	rTemperatura=> 		rTemperaturaSuperiorSetor[13]);
	
// Setor 64 - Resistência 64
//FiltroTermoparSup14(rDadoEntrada:= rTermoparSuperiorControle[14], rDadoSaida=>ControleSuperiorSetor14.rTermoparControle );	

ControleSuperiorSetor14(
	xLigaDesliga:= 		xLigaDesligaSupG01, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[14],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[14], 
	rTermoparControle:= rTermoparSuperiorControle[14], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[14],//rSetTemperaturaSuperior[14], 
	rProcentagem:= 		rSetPorcentagemSuperior[14], 
	rGanhoPorporcionaKp	:= 	2,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	2,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[14], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[14],
	rTemperatura=> 		rTemperaturaSuperiorSetor[14]);	

// Setor 65 - Resistência 65
//FiltroTermoparSup15(rDadoEntrada:= rTermoparSuperiorControle[15], rDadoSaida=>ControleSuperiorSetor15.rTermoparControle );	

ControleSuperiorSetor15(
	xLigaDesliga:= 		xLigaDesligaSupG02, 
	xHabilitaControle:= xHabilitaBlocosControleSuperior, 
	xForceResistencia:= FALSE, 
	xHabilitaResistencia:=xResistenciaHabilitadaSuperior[15],
	AlarmeResistencia:=	,
	xRstTemperaturaOk:=	,
	xFornoComCarga:=	xFornoComCarga,
	rTermoparLeitura:= 	rTermoparSuperiorLeitura[15], 
	rTermoparControle:= rTermoparSuperiorControle[15], 
	rSetTemperatura:= 	rSetPointTemperaturaSuperior[15],//rSetTemperaturaSuperior[15], 
	rProcentagem:= 		rSetPorcentagemSuperior[15], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm=> 			xReleSsrSuperior[15], 
	xTemperaturaOk=>	xTemperaturaSupeirorOk[15],
	rTemperatura=> 		rTemperaturaSuperiorSetor[15]);
	
// Setor 66 - Resistência 66
//FiltroTermoparSup16(rDadoEntrada:= rTermoparSuperiorControle[16], rDadoSaida=>ControleSuperiorSetor16.rTermoparControle );	

ControleSuperiorSetor16(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[16],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[16], 
	rTermoparControle	:= 	rTermoparSuperiorControle[16], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[16],//rSetTemperaturaSuperior[16], 
	rProcentagem		:= 	rSetPorcentagemSuperior[16], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[16], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[16],
	rTemperatura		=>	rTemperaturaSuperiorSetor[16]);
	
// Setor 67 - Resistência 67
//FiltroTermoparSup17(rDadoEntrada:= rTermoparSuperiorControle[17], rDadoSaida=>ControleSuperiorSetor17.rTermoparControle );	

ControleSuperiorSetor17(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[17],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[17], 
	rTermoparControle	:= 	rTermoparSuperiorControle[17], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[17],//rSetTemperaturaSuperior[17], 
	rProcentagem		:= 	rSetPorcentagemSuperior[17], 
	rGanhoPorporcionaKp	:= 	2,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	2,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[17], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[17],
	rTemperatura		=>	rTemperaturaSuperiorSetor[17]);
	
// Setor 68 - Resistência 68
//FiltroTermoparSup18(rDadoEntrada:= rTermoparSuperiorControle[18], rDadoSaida=>ControleSuperiorSetor18.rTermoparControle );	

ControleSuperiorSetor18(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[18],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[18], 
	rTermoparControle	:= 	rTermoparSuperiorControle[18], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[18],//rSetTemperaturaSuperior[18], 
	rProcentagem		:= 	rSetPorcentagemSuperior[18], 
	rGanhoPorporcionaKp	:= 	2,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	2,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[18], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[18],
	rTemperatura		=>	rTemperaturaSuperiorSetor[18]);

// Setor 69 - Resistência 69
//FiltroTermoparSup19(rDadoEntrada:= rTermoparSuperiorControle[19], rDadoSaida=>ControleSuperiorSetor19.rTermoparControle );	

ControleSuperiorSetor19(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[19],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[19], 
	rTermoparControle	:= 	rTermoparSuperiorControle[19], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[19],//rSetTemperaturaSuperior[19], 
	rProcentagem		:= 	rSetPorcentagemSuperior[19], 
	rGanhoPorporcionaKp	:= 	2,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	2,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[19], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[19],
	rTemperatura		=>	rTemperaturaSuperiorSetor[19]);

// Setor 70 - Resistência 70
//FiltroTermoparSup20(rDadoEntrada:= rTermoparSuperiorControle[20], rDadoSaida=>ControleSuperiorSetor20.rTermoparControle );	

ControleSuperiorSetor20(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[20],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[20], 
	rTermoparControle	:= 	rTermoparSuperiorControle[20], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[20],//rSetTemperaturaSuperior[20], 
	rProcentagem		:= 	rSetPorcentagemSuperior[20], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	0.1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[20], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[20],
	rTemperatura		=>	rTemperaturaSuperiorSetor[20]);
	
// Setor 71 - Resistência 71
//FiltroTermoparSup21(rDadoEntrada:= rTermoparSuperiorControle[21], rDadoSaida=>ControleSuperiorSetor21.rTermoparControle );	

ControleSuperiorSetor21(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[21],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[21], 
	rTermoparControle	:= 	rTermoparSuperiorControle[21], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[21],//rSetTemperaturaSuperior[21], 
	rProcentagem		:= 	rSetPorcentagemSuperior[21], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[21], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[21],
	rTemperatura		=>	rTemperaturaSuperiorSetor[21]);
	
// Setor 72 - Resistência 72
//FiltroTermoparSup22(rDadoEntrada:= rTermoparSuperiorControle[22], rDadoSaida=>ControleSuperiorSetor22.rTermoparControle );	

ControleSuperiorSetor22(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[22],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[22], 
	rTermoparControle	:= 	rTermoparSuperiorControle[22], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[22],//rSetTemperaturaSuperior[22], 
	rProcentagem		:= 	rSetPorcentagemSuperior[22], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[22], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[22],
	rTemperatura		=>	rTemperaturaSuperiorSetor[22]);
	
// Setor 73 - Resistência 73
//FiltroTermoparSup23(rDadoEntrada:= rTermoparSuperiorControle[23], rDadoSaida=>ControleSuperiorSetor23.rTermoparControle );	

ControleSuperiorSetor23(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[23],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[23], 
	rTermoparControle	:= 	rTermoparSuperiorControle[23], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[23],//rSetTemperaturaSuperior[23], 
	rProcentagem		:= 	rSetPorcentagemSuperior[23], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[23], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[23],
	rTemperatura		=>	rTemperaturaSuperiorSetor[23]);	
	
// Setor 74 - Resistência 74
//FiltroTermoparSup24(rDadoEntrada:= rTermoparSuperiorControle[24], rDadoSaida=>ControleSuperiorSetor24.rTermoparControle );	

ControleSuperiorSetor24(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[24],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[24], 
	rTermoparControle	:= 	rTermoparSuperiorControle[24], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[24],
	rProcentagem		:= 	rSetPorcentagemSuperior[24], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[24], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[24],
	rTemperatura		=>	rTemperaturaSuperiorSetor[24]);
	
// Setor 75 - Resistência 75
//FiltroTermoparSup25(rDadoEntrada:= rTermoparSuperiorControle[25], rDadoSaida=>ControleSuperiorSetor25.rTermoparControle );	

ControleSuperiorSetor25(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[25],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[25], 
	rTermoparControle	:= 	rTermoparSuperiorControle[25], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[25],//rSetTemperaturaSuperior[25], 
	rProcentagem		:= 	rSetPorcentagemSuperior[25], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[25], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[25],
	rTemperatura		=>	rTemperaturaSuperiorSetor[25]);	
	
// Setor 76 - Resistência 76
//FiltroTermoparSup26(rDadoEntrada:= rTermoparSuperiorControle[26], rDadoSaida=>ControleSuperiorSetor26.rTermoparControle );	

ControleSuperiorSetor26(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[26],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[26], 
	rTermoparControle	:= 	rTermoparSuperiorControle[26], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[26],//rSetTemperaturaSuperior[26], 
	rProcentagem		:= 	rSetPorcentagemSuperior[26], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[26], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[26],
	rTemperatura		=>	rTemperaturaSuperiorSetor[26]);
	
// Setor 77 - Resistência 77
//FiltroTermoparSup27(rDadoEntrada:= rTermoparSuperiorControle[27], rDadoSaida=>ControleSuperiorSetor27.rTermoparControle );	

ControleSuperiorSetor27(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[27],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[27], 
	rTermoparControle	:= 	rTermoparSuperiorControle[27], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[27],//rSetTemperaturaSuperior[27], 
	rProcentagem		:= 	rSetPorcentagemSuperior[27], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[27], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[27],
	rTemperatura		=>	rTemperaturaSuperiorSetor[27]);	
	
// Setor 78 - Resistência 78
//FiltroTermoparSup28(rDadoEntrada:= rTermoparSuperiorControle[28], rDadoSaida=>ControleSuperiorSetor28.rTermoparControle );	

ControleSuperiorSetor28(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[28],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[28], 
	rTermoparControle	:= 	rTermoparSuperiorControle[28], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[28],//rSetTemperaturaSuperior[28], 
	rProcentagem		:= 	rSetPorcentagemSuperior[28], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[28], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[28],
	rTemperatura		=>	rTemperaturaSuperiorSetor[28]);
	
// Setor 79 - Resistência 79
//FiltroTermoparSup29(rDadoEntrada:= rTermoparSuperiorControle[29], rDadoSaida=>ControleSuperiorSetor29.rTermoparControle );	

ControleSuperiorSetor29(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[29],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[29], 
	rTermoparControle	:= 	rTermoparSuperiorControle[29], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[29],//rSetTemperaturaSuperior[29], 
	rProcentagem		:= 	rSetPorcentagemSuperior[29], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[29], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[29],
	rTemperatura		=>	rTemperaturaSuperiorSetor[29]);	
	
// Setor 80 - Resistência 80
//FiltroTermoparSup30(rDadoEntrada:= rTermoparSuperiorControle[30], rDadoSaida=>ControleSuperiorSetor30.rTermoparControle );	

ControleSuperiorSetor30(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[30],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[30], 
	rTermoparControle	:= 	rTermoparSuperiorControle[30], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[30],//rSetTemperaturaSuperior[30], 
	rProcentagem		:= 	rSetPorcentagemSuperior[30], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[30], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[30],
	rTemperatura		=>	rTemperaturaSuperiorSetor[30]);
	
// Setor 81 - Resistência 81
//FiltroTermoparSup31(rDadoEntrada:= rTermoparSuperiorControle[31], rDadoSaida=>ControleSuperiorSetor31.rTermoparControle );	

ControleSuperiorSetor31(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[31],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[31], 
	rTermoparControle	:= 	rTermoparSuperiorControle[31], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[31],//rSetTemperaturaSuperior[31], 
	rProcentagem		:= 	rSetPorcentagemSuperior[31], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[31], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[31],
	rTemperatura		=>	rTemperaturaSuperiorSetor[31]);	
	
// Setor 82 - Resistência 82
//FiltroTermoparSup32(rDadoEntrada:= rTermoparSuperiorControle[32], rDadoSaida=>ControleSuperiorSetor32.rTermoparControle );	

ControleSuperiorSetor32(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[32],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[32], 
	rTermoparControle	:= 	rTermoparSuperiorControle[32], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[32],//rSetTemperaturaSuperior[32], 
	rProcentagem		:= 	rSetPorcentagemSuperior[32], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[32], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[32],
	rTemperatura		=>	rTemperaturaSuperiorSetor[32]);
	
// Setor 83 - Resistência 83
//FiltroTermoparSup33(rDadoEntrada:= rTermoparSuperiorControle[33], rDadoSaida=>ControleSuperiorSetor33.rTermoparControle );	

ControleSuperiorSetor33(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[33],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[33], 
	rTermoparControle	:= 	rTermoparSuperiorControle[33], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[33],//rSetTemperaturaSuperior[33], 
	rProcentagem		:= 	rSetPorcentagemSuperior[33], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[33], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[33],
	rTemperatura		=>	rTemperaturaSuperiorSetor[33]);	
	
// Setor 84 - Resistência 84
//FiltroTermoparSup34(rDadoEntrada:= rTermoparSuperiorControle[34], rDadoSaida=>ControleSuperiorSetor34.rTermoparControle );	

ControleSuperiorSetor34(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[34],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[34], 
	rTermoparControle	:= 	rTermoparSuperiorControle[34], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[34],//rSetTemperaturaSuperior[34], 
	rProcentagem		:= 	rSetPorcentagemSuperior[34], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[34], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[34],
	rTemperatura		=>	rTemperaturaSuperiorSetor[34]);
	
// Setor 85 - Resistência 85
//FiltroTermoparSup35(rDadoEntrada:= rTermoparSuperiorControle[35], rDadoSaida=>ControleSuperiorSetor35.rTermoparControle );	

ControleSuperiorSetor35(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[35],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[35], 
	rTermoparControle	:= 	rTermoparSuperiorControle[35], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[35],//rSetTemperaturaSuperior[35], 
	rProcentagem		:= 	rSetPorcentagemSuperior[35], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[35], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[35],
	rTemperatura		=>	rTemperaturaSuperiorSetor[35]);	
		
// Setor 86 - Resistência 86
//FiltroTermoparSup36(rDadoEntrada:= rTermoparSuperiorControle[36], rDadoSaida=>ControleSuperiorSetor36.rTermoparControle );	

ControleSuperiorSetor36(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[36],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[36], 
	rTermoparControle	:= 	rTermoparSuperiorControle[36], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[36],//rSetTemperaturaSuperior[36], 
	rProcentagem		:= 	rSetPorcentagemSuperior[36], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[36], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[36],
	rTemperatura		=>	rTemperaturaSuperiorSetor[36]);
	
// Setor 87 - Resistência 87
//FiltroTermoparSup37(rDadoEntrada:= rTermoparSuperiorControle[37], rDadoSaida=>ControleSuperiorSetor37.rTermoparControle );	

ControleSuperiorSetor37(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[37],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[37], 
	rTermoparControle	:= 	rTermoparSuperiorControle[37], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[37],//rSetTemperaturaSuperior[37], 
	rProcentagem		:= 	rSetPorcentagemSuperior[37], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[37], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[37],
	rTemperatura		=>	rTemperaturaSuperiorSetor[37]);	
		
	
// Setor 88 - Resistência 88
//FiltroTermoparSup38(rDadoEntrada:= rTermoparSuperiorControle[38], rDadoSaida=>ControleSuperiorSetor38.rTermoparControle );	

ControleSuperiorSetor38(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[38],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[38], 
	rTermoparControle	:= 	rTermoparSuperiorControle[38], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[38],//rSetTemperaturaSuperior[38], 
	rProcentagem		:= 	rSetPorcentagemSuperior[38], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[38], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[38],
	rTemperatura		=>	rTemperaturaSuperiorSetor[38]);
	

	
// Setor 89 - Resistência 89
//FiltroTermoparSup39(rDadoEntrada:= rTermoparSuperiorControle[39], rDadoSaida=>ControleSuperiorSetor39.rTermoparControle );	

ControleSuperiorSetor39(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[39],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[39], 
	rTermoparControle	:= 	rTermoparSuperiorControle[39], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[39],//rSetTemperaturaSuperior[39], 
	rProcentagem		:= 	rSetPorcentagemSuperior[39], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[39], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[39],
	rTemperatura		=>	rTemperaturaSuperiorSetor[39]);	
		
	
// Setor 90 - Resistência 90
//FiltroTermoparSup40(rDadoEntrada:= rTermoparSuperiorControle[40], rDadoSaida=>ControleSuperiorSetor40.rTermoparControle );	

ControleSuperiorSetor40(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[40],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[40], 
	rTermoparControle	:= 	rTermoparSuperiorControle[40], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[40],//rSetTemperaturaSuperior[40], 
	rProcentagem		:= 	rSetPorcentagemSuperior[40], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[40], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[40],
	rTemperatura		=>	rTemperaturaSuperiorSetor[40]);
	
// Setor 91 - Resistência 91
//FiltroTermoparSup41(rDadoEntrada:= rTermoparSuperiorControle[41], rDadoSaida=>ControleSuperiorSetor41.rTermoparControle );	

ControleSuperiorSetor41(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[41],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[41], 
	rTermoparControle	:= 	rTermoparSuperiorControle[41], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[41],//rSetTemperaturaSuperior[41], 
	rProcentagem		:= 	rSetPorcentagemSuperior[41], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[41], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[41],
	rTemperatura		=>	rTemperaturaSuperiorSetor[41]);	
		
	
// Setor 92 - Resistência 92
//FiltroTermoparSup42(rDadoEntrada:= rTermoparSuperiorControle[42], rDadoSaida=>ControleSuperiorSetor42.rTermoparControle );	

ControleSuperiorSetor42(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[42],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[42], 
	rTermoparControle	:= 	rTermoparSuperiorControle[42], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[42],//rSetTemperaturaSuperior[42], 
	rProcentagem		:= 	rSetPorcentagemSuperior[42], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[42], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[42],
	rTemperatura		=>	rTemperaturaSuperiorSetor[42]);
	
// Setor 93 - Resistência 93
//FiltroTermoparSup43(rDadoEntrada:= rTermoparSuperiorControle[43], rDadoSaida=>ControleSuperiorSetor43.rTermoparControle );	

ControleSuperiorSetor43(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[43],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[43], 
	rTermoparControle	:= 	rTermoparSuperiorControle[43], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[43],//rSetTemperaturaSuperior[43], 
	rProcentagem		:= 	rSetPorcentagemSuperior[43], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[43], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[43],
	rTemperatura		=>	rTemperaturaSuperiorSetor[43]);	

// Setor 94 - Resistência 94
//FiltroTermoparSup44(rDadoEntrada:= rTermoparSuperiorControle[44], rDadoSaida=>ControleSuperiorSetor44.rTermoparControle );	

ControleSuperiorSetor44(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[44],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[44], 
	rTermoparControle	:= 	rTermoparSuperiorControle[44], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[44],//rSetTemperaturaSuperior[44], 
	rProcentagem		:= 	rSetPorcentagemSuperior[44], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[44], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[44],
	rTemperatura		=>	rTemperaturaSuperiorSetor[44]);
	
// Setor 95 - Resistência 95
//FiltroTermoparSup45(rDadoEntrada:= rTermoparSuperiorControle[45], rDadoSaida=>ControleSuperiorSetor45.rTermoparControle );	

ControleSuperiorSetor45(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[45],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[45], 
	rTermoparControle	:= 	rTermoparSuperiorControle[45], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[45],//rSetTemperaturaSuperior[45], 
	rProcentagem		:= 	rSetPorcentagemSuperior[45], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[45], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[45],
	rTemperatura		=>	rTemperaturaSuperiorSetor[45]);	
		
// Setor 96 - Resistência 96
//FiltroTermoparSup46(rDadoEntrada:= rTermoparSuperiorControle[46], rDadoSaida=>ControleSuperiorSetor46.rTermoparControle );	

ControleSuperiorSetor46(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[46],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[46], 
	rTermoparControle	:= 	rTermoparSuperiorControle[46], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[46],//rSetTemperaturaSuperior[46], 
	rProcentagem		:= 	rSetPorcentagemSuperior[46], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[46], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[46],
	rTemperatura		=>	rTemperaturaSuperiorSetor[46]);	
		
// Setor 97 - Resistência 97
//FiltroTermoparSup47(rDadoEntrada:= rTermoparSuperiorControle[47], rDadoSaida=>ControleSuperiorSetor47.rTermoparControle );	

ControleSuperiorSetor47(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[47],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[47], 
	rTermoparControle	:= 	rTermoparSuperiorControle[47], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[47],//rSetTemperaturaSuperior[47], 
	rProcentagem		:= 	rSetPorcentagemSuperior[47], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[47], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[47],
	rTemperatura		=>	rTemperaturaSuperiorSetor[47]);	
		
// Setor 98 - Resistência 98
//FiltroTermoparSup48(rDadoEntrada:= rTermoparSuperiorControle[48], rDadoSaida=>ControleSuperiorSetor48.rTermoparControle );	

ControleSuperiorSetor48(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[48],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[48], 
	rTermoparControle	:= 	rTermoparSuperiorControle[48], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[48],//rSetTemperaturaSuperior[48], 
	rProcentagem		:= 	rSetPorcentagemSuperior[48], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[48], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[48],
	rTemperatura		=>	rTemperaturaSuperiorSetor[48]);	
		
// Setor 99 - Resistência 99
//FiltroTermoparSup49(rDadoEntrada:= rTermoparSuperiorControle[49], rDadoSaida=>ControleSuperiorSetor49.rTermoparControle );	

ControleSuperiorSetor49(
	xLigaDesliga		:= 	xLigaDesligaSupG01, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[49],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[49], 
	rTermoparControle	:= 	rTermoparSuperiorControle[49], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[49],//rSetTemperaturaSuperior[49], 
	rProcentagem		:= 	rSetPorcentagemSuperior[49], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[49], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[49],
	rTemperatura		=>	rTemperaturaSuperiorSetor[49]);	
	
// Setor 100 - Resistência 100
//FiltroTermoparSup50(rDadoEntrada:= rTermoparSuperiorControle[50], rDadoSaida=>ControleSuperiorSetor50.rTermoparControle );	

ControleSuperiorSetor50(
	xLigaDesliga		:= 	xLigaDesligaSupG02, 
	xHabilitaControle	:= 	xHabilitaBlocosControleSuperior, 
	xForceResistencia	:= 	FALSE, 
	xHabilitaResistencia:=	xResistenciaHabilitadaSuperior[50],
	AlarmeResistencia	:=	,
	xRstTemperaturaOk	:=	,
	xFornoComCarga		:=	xFornoComCarga,
	rTermoparLeitura	:= 	rTermoparSuperiorLeitura[50], 
	rTermoparControle	:= 	rTermoparSuperiorControle[50], 
	rSetTemperatura		:= 	rSetPointTemperaturaSuperior[50],//rSetTemperaturaSuperior[50], 
	rProcentagem		:= 	rSetPorcentagemSuperior[50], 
	rGanhoPorporcionaKp	:= 	1,//Proporciona
	rGanhoIntegralKi	:= 	0.8,//Integal
	rGanhoDerivativoKd	:= 	1,//Derivativo
	rTempoCiclo			:=	101,
	xresetPidBlk		:= xResetPid,
	SaidaPwm			=> 	xReleSsrSuperior[50], 
	xTemperaturaOk		=>	xTemperaturaSupeirorOk[50],
	rTemperatura		=>	rTemperaturaSuperiorSetor[50]);	
	
	IF 	xResetPid then
		xResetPid:=FALSE;
	END_IF
