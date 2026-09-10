__METADATA__
{
  "v3Meta": {
    "objectGuid": "31f7d1ab-2f05-4e43-abfa-f8cd81fd7fde",
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
PROGRAM C_EspelhoSaida
VAR

END_VAR
__IMPLEMENTATION__
//TM262L10MESE8T - 0.1
xM0_1_DQ0:=TRUE ;// ByPass
xM0_1_DQ1:=xSinalLumVerm; //Vermelho 
xM0_1_DQ2:=xSinalLumAmar; //Amarelo
xM0_1_DQ3:=xSinalLumVerd; //Verde

//TM3XHSC202 - 0.2
xM0_2_DQ0:=xVentiladoresPainel;
xM0_2_DQ1:=xVentiladoresSsr;
xM0_2_DQ2:=xValvulaGradeEntrada;
xM0_2_DQ3:=xValvPortaEntradaForno;
xM0_2_DQ4:=xValvPortaSaidaForno;
xM0_2_DQ5:=xValvulaGradeSaida;
xM0_2_DQ6:=xValvulaDamperDifusor;
xM0_2_DQ7:=xLedCargaForno;
	
//TM3XHSC202 - 0.3
xM0_3_DQ0:=NOT xReleSeguranca;
xM0_3_DQ1:=xAlarmeSonoro;
xM0_3_DQ2:=xMotorOscilaResfr02Sup;// oscila sup
xM0_3_DQ3:=xMotorOscilaResfr02Inf;// oscila inf
xM0_3_DQ4:=FALSE;// RESERVA
xM0_3_DQ5:=FALSE;// RESERVA
xM0_3_DQ6:=FALSE;// RESERVA
xM0_3_DQ7:=FALSE;// RESERVA

//TM3DM24K - 3.1
xM3_1_DQ0:= FALSE;// RESERVA
xM3_1_DQ1:= FALSE;// RESERVA
xM3_1_DQ2:= FALSE;// RESERVA
xM3_1_DQ3:= xReleSsrConveccaoEnt;
xM3_1_DQ4:= xReleSsrInferior[1] OR xSaidaReleRampaPatamarInf[1];
xM3_1_DQ5:= xReleSsrInferior[2] OR xSaidaReleRampaPatamarInf[2];
xM3_1_DQ6:= xReleSsrInferior[3] OR xSaidaReleRampaPatamarInf[3];
xM3_1_DQ7:= xReleSsrInferior[4] OR xSaidaReleRampaPatamarInf[4];


//TM3DQ32TK - 3.3
xM3_3_DQ0:= xReleSsrInferior[5] OR xSaidaReleRampaPatamarInf[5]; // xReleSsrInferior[5]
xM3_3_DQ1:= xReleSsrInferior[6] OR xSaidaReleRampaPatamarInf[6]; // xReleSsrInferior[6]
xM3_3_DQ2:= xReleSsrInferior[7] OR xSaidaReleRampaPatamarInf[7]; // xReleSsrInferior[7]
xM3_3_DQ3:= xReleSsrInferior[8] OR xSaidaReleRampaPatamarInf[8]; // xReleSsrInferior[8]
xM3_3_DQ4:= xReleSsrInferior[9] OR xSaidaReleRampaPatamarInf[9]; // xReleSsrInferior[9]
xM3_3_DQ5:= xReleSsrInferior[10] OR xSaidaReleRampaPatamarInf[10];// xReleSsrInferior[10]
xM3_3_DQ6:= xReleSsrInferior[11] OR xSaidaReleRampaPatamarInf[11];// xReleSsrInferior[11]
xM3_3_DQ7:= xReleSsrInferior[12] OR xSaidaReleRampaPatamarInf[12];// xReleSsrInferior[12]
xM3_3_DQ8:= xReleSsrInferior[13] OR xSaidaReleRampaPatamarInf[13];// xReleSsrInferior[13]
xM3_3_DQ9:= xReleSsrInferior[14] OR xSaidaReleRampaPatamarInf[14];// xReleSsrInferior[14]
xM3_3_DQ10:=xReleSsrInferior[15] OR xSaidaReleRampaPatamarInf[15];// xReleSsrInferior[15]
xM3_3_DQ11:=xReleSsrInferior[16] OR xSaidaReleRampaPatamarInf[16];// xReleSsrInferior[16]
xM3_3_DQ12:=xReleSsrInferior[17] OR xSaidaReleRampaPatamarInf[17];// xReleSsrInferior[17]
xM3_3_DQ13:=xReleSsrInferior[18] OR xSaidaReleRampaPatamarInf[18];// xReleSsrInferior[18]
xM3_3_DQ14:=xReleSsrInferior[19] OR xSaidaReleRampaPatamarInf[19];// xReleSsrInferior[19]
xM3_3_DQ15:=xReleSsrInferior[20] OR xSaidaReleRampaPatamarInf[20];// xReleSsrInferior[20]
xM3_3_DQ16:=xReleSsrInferior[21] OR xSaidaReleRampaPatamarInf[21];// xReleSsrInferior[21]
xM3_3_DQ17:=xReleSsrInferior[22] OR xSaidaReleRampaPatamarInf[22];// xReleSsrInferior[22]
xM3_3_DQ18:=xReleSsrInferior[23] OR xSaidaReleRampaPatamarInf[23];// xReleSsrInferior[23]
xM3_3_DQ19:=xReleSsrInferior[24] OR xSaidaReleRampaPatamarInf[24];// xReleSsrInferior[24]
xM3_3_DQ20:=xReleSsrInferior[25] OR xSaidaReleRampaPatamarInf[25];// xReleSsrInferior[25]
xM3_3_DQ21:=xReleSsrInferior[26] OR xSaidaReleRampaPatamarInf[26];// xReleSsrInferior[26]
xM3_3_DQ22:=xReleSsrInferior[27] OR xSaidaReleRampaPatamarInf[27];// xReleSsrInferior[27]
xM3_3_DQ23:=xReleSsrInferior[28] OR xSaidaReleRampaPatamarInf[28];// xReleSsrInferior[28]
xM3_3_DQ24:=xReleSsrInferior[29] OR xSaidaReleRampaPatamarInf[29];// xReleSsrInferior[29]
xM3_3_DQ25:=xReleSsrInferior[30] OR xSaidaReleRampaPatamarInf[30];// xReleSsrInferior[30]
xM3_3_DQ26:=xReleSsrInferior[31] OR xSaidaReleRampaPatamarInf[31];// xReleSsrInferior[31]
xM3_3_DQ27:=xReleSsrInferior[32] OR xSaidaReleRampaPatamarInf[32];// xReleSsrInferior[32]
xM3_3_DQ28:=xReleSsrInferior[33] OR xSaidaReleRampaPatamarInf[33];// xReleSsrInferior[33]
xM3_3_DQ29:=xReleSsrInferior[34] OR xSaidaReleRampaPatamarInf[34];// xReleSsrInferior[34]
xM3_3_DQ30:=xReleSsrInferior[35] OR xSaidaReleRampaPatamarInf[35];// xReleSsrInferior[35]
xM3_3_DQ31:=xReleSsrInferior[36] OR xSaidaReleRampaPatamarInf[36];// xReleSsrInferior[36]
           

//TM3DQ32TK - 4.3
xM4_3_DQ0:= xReleSsrInferior[37] OR xSaidaReleRampaPatamarInf[37]; // xReleSsrInferior[37]
xM4_3_DQ1:= xReleSsrInferior[38] OR xSaidaReleRampaPatamarInf[38]; // xReleSsrInferior[38]
xM4_3_DQ2:= xReleSsrInferior[39] OR xSaidaReleRampaPatamarInf[39]; // xReleSsrInferior[39]
xM4_3_DQ3:= xReleSsrInferior[40] OR xSaidaReleRampaPatamarInf[40]; // xReleSsrInferior[40]
xM4_3_DQ4:= xReleSsrInferior[41] OR xSaidaReleRampaPatamarInf[41]; // xReleSsrInferior[41]
xM4_3_DQ5:= xReleSsrInferior[42] OR xSaidaReleRampaPatamarInf[42]; // xReleSsrInferior[42]
xM4_3_DQ6:= xReleSsrInferior[43] OR xSaidaReleRampaPatamarInf[43]; // xReleSsrInferior[43]
xM4_3_DQ7:= xReleSsrInferior[44] OR xSaidaReleRampaPatamarInf[44]; // xReleSsrInferior[44]
xM4_3_DQ8:= xReleSsrInferior[45] OR xSaidaReleRampaPatamarInf[45]; // xReleSsrInferior[45]
xM4_3_DQ9:= xReleSsrInferior[46] OR xSaidaReleRampaPatamarInf[46]; // xReleSsrInferior[46]
xM4_3_DQ10:=xReleSsrInferior[47] OR xSaidaReleRampaPatamarInf[47]; // xReleSsrInferior[47]
xM4_3_DQ11:=xReleSsrInferior[48] OR xSaidaReleRampaPatamarInf[48]; // xReleSsrInferior[48]
xM4_3_DQ12:=xReleSsrInferior[49] OR xSaidaReleRampaPatamarInf[49]; // xReleSsrInferior[49]
xM4_3_DQ13:=xReleSsrInferior[50] OR xSaidaReleRampaPatamarInf[50]; // xReleSsrInferior[50]
xM4_3_DQ14:=xReleSsrSuperior[1] OR xSaidaReleRampaPatamarSup[1]; // xReleSsrSuperior[1] - 51
xM4_3_DQ15:=xReleSsrSuperior[2] OR xSaidaReleRampaPatamarSup[2]; // xReleSsrSuperior[2] - 52
xM4_3_DQ16:=xReleSsrSuperior[3] OR xSaidaReleRampaPatamarSup[3]; // xReleSsrSuperior[3] - 53
xM4_3_DQ17:=xReleSsrSuperior[4] OR xSaidaReleRampaPatamarSup[4]; // xReleSsrSuperior[4] - 54
xM4_3_DQ18:=xReleSsrSuperior[5] OR xSaidaReleRampaPatamarSup[5]; // xReleSsrSuperior[5] - 55
xM4_3_DQ19:=xReleSsrSuperior[6] OR xSaidaReleRampaPatamarSup[6]; // xReleSsrSuperior[6] - 56
xM4_3_DQ20:=xReleSsrSuperior[7] OR xSaidaReleRampaPatamarSup[7]; // xReleSsrSuperior[7] - 57
xM4_3_DQ21:=xReleSsrSuperior[8] OR xSaidaReleRampaPatamarSup[8]; // xReleSsrSuperior[8] - 58
xM4_3_DQ22:=xReleSsrSuperior[9] OR xSaidaReleRampaPatamarSup[9]; // xReleSsrSuperior[9] - 59
xM4_3_DQ23:=xReleSsrSuperior[10] OR xSaidaReleRampaPatamarSup[10]; // xReleSsrSuperior[10] - 60
xM4_3_DQ24:=xReleSsrSuperior[11] OR xSaidaReleRampaPatamarSup[11]; // xReleSsrSuperior[11] - 61
xM4_3_DQ25:=xReleSsrSuperior[12] OR xSaidaReleRampaPatamarSup[12]; // xReleSsrSuperior[12] - 62
xM4_3_DQ26:=xReleSsrSuperior[13] OR xSaidaReleRampaPatamarSup[13]; // xReleSsrSuperior[13] - 63
xM4_3_DQ27:=xReleSsrSuperior[14] OR xSaidaReleRampaPatamarSup[14]; // xReleSsrSuperior[14] - 64
xM4_3_DQ28:=xReleSsrSuperior[15] OR xSaidaReleRampaPatamarSup[15]; // xReleSsrSuperior[15] - 65
xM4_3_DQ29:=xReleSsrSuperior[16] OR xSaidaReleRampaPatamarSup[16]; // xReleSsrSuperior[16] - 66
xM4_3_DQ30:=xReleSsrSuperior[17] OR xSaidaReleRampaPatamarSup[17]; // xReleSsrSuperior[17] - 67
xM4_3_DQ31:=xReleSsrSuperior[18] OR xSaidaReleRampaPatamarSup[18]; // xReleSsrSuperior[18] - 68
           
//TM3DQ32TK - 4.4
xM4_4_DQ0:= xReleSsrSuperior[19] OR xSaidaReleRampaPatamarSup[19]; // xReleSsrSuperior[19] - 69
xM4_4_DQ1:= xReleSsrSuperior[20] OR xSaidaReleRampaPatamarSup[20]; // xReleSsrSuperior[20] - 70
xM4_4_DQ2:= xReleSsrSuperior[21] OR xSaidaReleRampaPatamarSup[21]; // xReleSsrSuperior[21] - 71
xM4_4_DQ3:= xReleSsrSuperior[22] OR xSaidaReleRampaPatamarSup[22]; // xReleSsrSuperior[22] - 72
xM4_4_DQ4:= xReleSsrSuperior[23] OR xSaidaReleRampaPatamarSup[23]; // xReleSsrSuperior[23] - 73
xM4_4_DQ5:= xReleSsrSuperior[24] OR xSaidaReleRampaPatamarSup[24]; // xReleSsrSuperior[24] - 74
xM4_4_DQ6:= xReleSsrSuperior[25] OR xSaidaReleRampaPatamarSup[25]; // xReleSsrSuperior[25] - 75
xM4_4_DQ7:= xReleSsrSuperior[26] OR xSaidaReleRampaPatamarSup[26]; // xReleSsrSuperior[26] - 76
xM4_4_DQ8:= xReleSsrSuperior[27] OR xSaidaReleRampaPatamarSup[27]; // xReleSsrSuperior[27] - 77
xM4_4_DQ9:= xReleSsrSuperior[28] OR xSaidaReleRampaPatamarSup[28]; // xReleSsrSuperior[28] - 78
xM4_4_DQ10:=xReleSsrSuperior[29] OR xSaidaReleRampaPatamarSup[29]; // xReleSsrSuperior[29] - 79
xM4_4_DQ11:=xReleSsrSuperior[30] OR xSaidaReleRampaPatamarSup[30]; // xReleSsrSuperior[30] - 80
xM4_4_DQ12:=xReleSsrSuperior[31] OR xSaidaReleRampaPatamarSup[31]; // xReleSsrSuperior[31] - 81
xM4_4_DQ13:=xReleSsrSuperior[32] OR xSaidaReleRampaPatamarSup[32]; // xReleSsrSuperior[32] - 82
xM4_4_DQ14:=xReleSsrSuperior[33] OR xSaidaReleRampaPatamarSup[33]; // xReleSsrSuperior[33] - 83
xM4_4_DQ15:=xReleSsrSuperior[34] OR xSaidaReleRampaPatamarSup[34]; // xReleSsrSuperior[34] - 84
xM4_4_DQ16:=xReleSsrSuperior[35] OR xSaidaReleRampaPatamarSup[35]; // xReleSsrSuperior[35] - 85
xM4_4_DQ17:=xReleSsrSuperior[36] OR xSaidaReleRampaPatamarSup[36]; // xReleSsrSuperior[36] - 86
xM4_4_DQ18:=xReleSsrSuperior[37] OR xSaidaReleRampaPatamarSup[37]; // xReleSsrSuperior[37] - 87
xM4_4_DQ19:=xReleSsrSuperior[38] OR xSaidaReleRampaPatamarSup[38]; // xReleSsrSuperior[38] - 88
xM4_4_DQ20:=xReleSsrSuperior[39] OR xSaidaReleRampaPatamarSup[39]; // xReleSsrSuperior[39] - 89
xM4_4_DQ21:=xReleSsrSuperior[40] OR xSaidaReleRampaPatamarSup[40]; // xReleSsrSuperior[40] - 90
xM4_4_DQ22:=xReleSsrSuperior[41] OR xSaidaReleRampaPatamarSup[41]; // xReleSsrSuperior[41] - 91
xM4_4_DQ23:=xReleSsrSuperior[42] OR xSaidaReleRampaPatamarSup[42]; // xReleSsrSuperior[42] - 92
xM4_4_DQ24:=xReleSsrSuperior[43] OR xSaidaReleRampaPatamarSup[43]; // xReleSsrSuperior[43] - 93
xM4_4_DQ25:=xReleSsrSuperior[44] OR xSaidaReleRampaPatamarSup[44]; // xReleSsrSuperior[44] - 94
xM4_4_DQ26:=xReleSsrSuperior[45] OR xSaidaReleRampaPatamarSup[45]; // xReleSsrSuperior[45] - 95
xM4_4_DQ27:=xReleSsrSuperior[46] OR xSaidaReleRampaPatamarSup[46]; // xReleSsrSuperior[46] - 96
xM4_4_DQ28:=xReleSsrSuperior[47] OR xSaidaReleRampaPatamarSup[47]; // xReleSsrSuperior[47] - 97
xM4_4_DQ29:=xReleSsrSuperior[48] OR xSaidaReleRampaPatamarSup[48]; // xReleSsrSuperior[48] - 98
xM4_4_DQ30:=xReleSsrSuperior[49] OR xSaidaReleRampaPatamarSup[49]; // xReleSsrSuperior[49] - 99
xM4_4_DQ31:=xReleSsrSuperior[50] OR xSaidaReleRampaPatamarSup[50]; // xReleSsrSuperior[50] - 100


           



