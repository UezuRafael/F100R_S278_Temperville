__METADATA__
{
  "v3Meta": {
    "objectGuid": "c5f4c838-a4f9-4312-91bc-bbe51a799a96",
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
PROGRAM C_Teste_Entradas_Saidas
__IMPLEMENTATION__
// Imagens Entradas

//TM262L10MESE8T - 0.1

ImgTesteEntradas[1]:=	xM0_1_DI0;//xChCircuitoEmergenciaCC
ImgTesteEntradas[2]:=	xM0_1_DI1;//Reserva
ImgTesteEntradas[3]:=	xM0_1_DI2;//xSaidaNobreakOk
ImgTesteEntradas[4]:=	xM0_1_DI3;//xReleSeguranca

//TM3XHSC202 - 0.2
ImgTesteEntradas[5]:=	xM0_2_DI0;// ENCODER 
ImgTesteEntradas[6]:=	xM0_2_DI1;// ENCODER 
ImgTesteEntradas[7]:=	xM0_2_DI2;// ENCODER 
ImgTesteEntradas[8]:=	xM0_2_DI3;// ENCODER 
ImgTesteEntradas[9]:=	xM0_2_DI4;// ENCODER 
ImgTesteEntradas[10]:=	xM0_2_DI5;// ENCODER 
ImgTesteEntradas[11]:=	xM0_2_DI6;// ENCODER 
ImgTesteEntradas[12]:=	xM0_2_DI7;// ENCODER 
ImgTesteEntradas[13]:=	xM0_2_DI8;// ENCODER 
ImgTesteEntradas[14]:=	xM0_2_DI9;// ENCODER 

//TM3XHSC202 - 0.3
ImgTesteEntradas[15]:=	xM0_3_DI0;// ENCODER 	
ImgTesteEntradas[16]:=	xM0_3_DI1;// ENCODER 	
ImgTesteEntradas[17]:=	xM0_3_DI2;// ENCODER 	
ImgTesteEntradas[18]:=	xM0_3_DI3;// ENCODER 	
ImgTesteEntradas[19]:=	xM0_3_DI4;// ENCODER 	
ImgTesteEntradas[20]:=	xM0_3_DI5;// ENCODER 	
ImgTesteEntradas[21]:=	xM0_3_DI6;// ENCODER 	
ImgTesteEntradas[22]:=	xM0_3_DI7;// ENCODER 	
ImgTesteEntradas[23]:=	xM0_3_DI8;// ENCODER 	
ImgTesteEntradas[24]:=	xM0_3_DI9;// ENCODER 	


//TM3DI32K - 0.4
ImgTesteEntradas[25]:= 	xM0_4_DI0;	//xChAvancaMesaEntrada	
ImgTesteEntradas[26]:= 	xM0_4_DI1;	//xChRecuaMesaEntrada
ImgTesteEntradas[27]:= 	xM0_4_DI2;	//xSensorEntrada01
ImgTesteEntradas[28]:= 	xM0_4_DI3;	//xSensorEntrada02
ImgTesteEntradas[29]:= 	xM0_4_DI4;	//xSensorEntrada03
ImgTesteEntradas[30]:= 	xM0_4_DI5;	//xSensorEntrada04
ImgTesteEntradas[31]:= 	xM0_4_DI6;	//xSensorEntrada05
ImgTesteEntradas[32]:= 	xM0_4_DI7;  //xSensorEntrada06
ImgTesteEntradas[33]:= 	xM0_4_DI8;  //xSensorEntrada07
ImgTesteEntradas[34]:= 	xM0_4_DI9;  //xSensorEntrada08
ImgTesteEntradas[35]:= 	xM0_4_DI10; //xBtGradeEntrada
ImgTesteEntradas[36]:= 	xM0_4_DI11; //xBtHabilitaCarregamento	
ImgTesteEntradas[37]:= 	xM0_4_DI12; //xBt02Emergencia Mesa Entrada	
ImgTesteEntradas[38]:= 	xM0_4_DI13; //xSensorPortaEntrada 
ImgTesteEntradas[39]:= 	xM0_4_DI14; //xSensorPortaSaida   
ImgTesteEntradas[40]:= 	xM0_4_DI15; //xSensorAbertoForno   
ImgTesteEntradas[41]:=	xM0_4_DI16; //xSensorFechadoForno		
ImgTesteEntradas[42]:=	xM0_4_DI17; //xSensorAbertoResfriadorSup02					
ImgTesteEntradas[43]:=	xM0_4_DI18; //xSensorFechadoResfriadorSup02 			
ImgTesteEntradas[44]:=	xM0_4_DI19; //xFcMaximoSegResfriadorSup02				
ImgTesteEntradas[45]:=	xM0_4_DI20; //xFcMinimoSegResfriadorSup02						
ImgTesteEntradas[46]:=	xM0_4_DI21; //xChAbreDuctosResfriadorSup02			
ImgTesteEntradas[47]:=	xM0_4_DI22; //xBt03Emergencia Mesa Resfriador					
ImgTesteEntradas[48]:=	xM0_4_DI23; //xSensorDesligaMesaSaida					
ImgTesteEntradas[49]:=	xM0_4_DI24; //xSensorGradeSaidaUp	
ImgTesteEntradas[50]:=	xM0_4_DI25; //xBtGradeSaida		
ImgTesteEntradas[51]:=	xM0_4_DI26; //xChAvancaMesaSaida			
ImgTesteEntradas[52]:=	xM0_4_DI27; //xChRecuaMesaSaida				
ImgTesteEntradas[53]:=	xM0_4_DI28; //xBt04Emergencia Mesa Saída						
ImgTesteEntradas[54]:=	xM0_4_DI29; //xSensorPositivoGuilhotina02					
ImgTesteEntradas[55]:=	xM0_4_DI30; //xSensorNegativoGuilhotina02					
ImgTesteEntradas[56]:=	xM0_4_DI31; //xSensorZeroGuilhotina02					


//TM3DM24R - 3.1
ImgTesteEntradas[57]:= 	xM3_1_DI0;   //xChAutomaticoManual	
ImgTesteEntradas[58]:= xM3_1_DI1;   //xBt01CalaAlarme Mesa Controle	
ImgTesteEntradas[59]:= xM3_1_DI2;   //xBt01Emergencia Mesa Controle	
ImgTesteEntradas[60]:= xM3_1_DI3;   //xPressaoBaixaMediaRede	
ImgTesteEntradas[61]:= xM3_1_DI4;   //xPressaoMediaAltaRede	
ImgTesteEntradas[62]:= xM3_1_DI5;   //oscilantes	
ImgTesteEntradas[63]:= xM3_1_DI6;   //oscilantes	
ImgTesteEntradas[64]:= xM3_1_DI7;   //oscilantes	
ImgTesteEntradas[65]:= xM3_1_DI8;   //oscilantes	
ImgTesteEntradas[66]:= xM3_1_DI9;   //xRetornoSsr01ConveccaoEnt		
ImgTesteEntradas[67]:= xM3_1_DI10;  //xRetornoSsr02ConveccaoEnt		
ImgTesteEntradas[68]:= xM3_1_DI11;  //xRetornoSsr03ConveccaoEnt		
ImgTesteEntradas[69]:= xM3_1_DI12;  //Retorno Circuito Resist Inf 01	
ImgTesteEntradas[70]:= xM3_1_DI13;  //Retorno Circuito Resist Inf 02	
ImgTesteEntradas[71]:= xM3_1_DI14;  //Retorno Circuito Resist Inf 03
ImgTesteEntradas[72]:= xM3_1_DI15;  //Retorno Circuito Resist Inf 04


//TM3DI32K - 3.2
ImgTesteEntradas[73]:= xM3_2_DI0;   //Retorno Circuito Resist Inf 05
ImgTesteEntradas[74]:= xM3_2_DI1;   //Retorno Circuito Resist Inf 06	
ImgTesteEntradas[75]:= xM3_2_DI2;   //Retorno Circuito Resist Inf 07	
ImgTesteEntradas[76]:= xM3_2_DI3;   //Retorno Circuito Resist Inf 08	
ImgTesteEntradas[77]:= xM3_2_DI4;   //Retorno Circuito Resist Inf 09	
ImgTesteEntradas[78]:= xM3_2_DI5;   //Retorno Circuito Resist Inf 10	
ImgTesteEntradas[79]:= xM3_2_DI6;   //Retorno Circuito Resist Inf 11	
ImgTesteEntradas[80]:= xM3_2_DI7;   //Retorno Circuito Resist Inf 12	
ImgTesteEntradas[81]:= xM3_2_DI8;   //Retorno Circuito Resist Inf 13	
ImgTesteEntradas[82]:= xM3_2_DI9;   //Retorno Circuito Resist Inf 14	
ImgTesteEntradas[83]:= xM3_2_DI10;  //Retorno Circuito Resist Inf 15		
ImgTesteEntradas[84]:= xM3_2_DI11;  //Retorno Circuito Resist Inf 16		
ImgTesteEntradas[85]:= xM3_2_DI12;  //Retorno Circuito Resist Inf 17	
ImgTesteEntradas[86]:= xM3_2_DI13;  //Retorno Circuito Resist Inf 18	
ImgTesteEntradas[87]:= xM3_2_DI14;  //Retorno Circuito Resist Inf 19
ImgTesteEntradas[88]:= xM3_2_DI15;  //Retorno Circuito Resist Inf 20
ImgTesteEntradas[89]:= xM3_2_DI16;  //Retorno Circuito Resist Inf 21
ImgTesteEntradas[90]:= xM3_2_DI17;  //Retorno Circuito Resist Inf 22
ImgTesteEntradas[91]:= xM3_2_DI18;  //Retorno Circuito Resist Inf 23	
ImgTesteEntradas[92]:= xM3_2_DI19;  //Retorno Circuito Resist Inf 24	
ImgTesteEntradas[93]:= xM3_2_DI20;  //Retorno Circuito Resist Inf 25
ImgTesteEntradas[94]:= xM3_2_DI21;  //Retorno Circuito Resist Inf 26	
ImgTesteEntradas[95]:= xM3_2_DI22;  //Retorno Circuito Resist Inf 27
ImgTesteEntradas[96]:= xM3_2_DI23;  //Retorno Circuito Resist Inf 28
ImgTesteEntradas[97]:= xM3_2_DI24;  //Retorno Circuito Resist Inf 29
ImgTesteEntradas[98]:= xM3_2_DI25;  //Retorno Circuito Resist Inf 30
ImgTesteEntradas[99]:= xM3_2_DI26;  //Retorno Circuito Resist Inf 31
ImgTesteEntradas[100]:= xM3_2_DI27;  //Retorno Circuito Resist Inf 32
ImgTesteEntradas[101]:=	xM3_2_DI28;  //Retorno Circuito Resist Inf 33
ImgTesteEntradas[102]:=	xM3_2_DI29;  //Retorno Circuito Resist Inf 34
ImgTesteEntradas[103]:=	xM3_2_DI30;  //Retorno Circuito Resist Inf 35
ImgTesteEntradas[104]:=	xM3_2_DI31;  //Retorno Circuito Resist Inf 36

//TM3DI32K - 4.1
ImgTesteEntradas[105]:= xM4_1_DI0;   //Retorno Circuito Resist Inf 37		
ImgTesteEntradas[106]:= xM4_1_DI1;   //Retorno Circuito Resist Inf 38		
ImgTesteEntradas[107]:= xM4_1_DI2;   //Retorno Circuito Resist Inf 39		
ImgTesteEntradas[108]:= xM4_1_DI3;   //Retorno Circuito Resist Inf 40		
ImgTesteEntradas[109]:= xM4_1_DI4;   //Retorno Circuito Resist Inf 41		
ImgTesteEntradas[110]:= xM4_1_DI5;   //Retorno Circuito Resist Inf 42		
ImgTesteEntradas[111]:= xM4_1_DI6;   //Retorno Circuito Resist Inf 43		
ImgTesteEntradas[112]:= xM4_1_DI7;   //Retorno Circuito Resist Inf 44		
ImgTesteEntradas[113]:= xM4_1_DI8;   //Retorno Circuito Resist Inf 45	
ImgTesteEntradas[114]:= xM4_1_DI9;   //Retorno Circuito Resist Inf 46		
ImgTesteEntradas[115]:= xM4_1_DI10;  //Retorno Circuito Resist Inf 47		
ImgTesteEntradas[116]:= xM4_1_DI11;  //Retorno Circuito Resist Inf 48			
ImgTesteEntradas[117]:= xM4_1_DI12;  //Retorno Circuito Resist Inf 49		
ImgTesteEntradas[118]:= xM4_1_DI13;  //Retorno Circuito Resist Inf 50		
ImgTesteEntradas[119]:= xM4_1_DI14;  //Retorno Circuito Resist Sup 01 - 51
ImgTesteEntradas[120]:= xM4_1_DI15;  //Retorno Circuito Resist Sup 02 - 52
ImgTesteEntradas[121]:= xM4_1_DI16;  //Retorno Circuito Resist Sup 03 - 53
ImgTesteEntradas[122]:= xM4_1_DI17;  //Retorno Circuito Resist Sup 04 - 54
ImgTesteEntradas[123]:= xM4_1_DI18;  //Retorno Circuito Resist Sup 05 - 55	
ImgTesteEntradas[124]:= xM4_1_DI19;  //Retorno Circuito Resist Sup 06 - 56	
ImgTesteEntradas[125]:= xM4_1_DI20;  //Retorno Circuito Resist Sup 07 - 57
ImgTesteEntradas[126]:= xM4_1_DI21;  //Retorno Circuito Resist Sup 08 - 58	
ImgTesteEntradas[127]:= xM4_1_DI22;  //Retorno Circuito Resist Sup 09 - 59
ImgTesteEntradas[128]:= xM4_1_DI23;  //Retorno Circuito Resist Sup 10 - 60
ImgTesteEntradas[129]:= xM4_1_DI24;  //Retorno Circuito Resist Sup 11 - 61
ImgTesteEntradas[130]:= xM4_1_DI25;  //Retorno Circuito Resist Sup 12 - 62
ImgTesteEntradas[131]:= xM4_1_DI26;  //Retorno Circuito Resist Sup 13 - 63
ImgTesteEntradas[132]:= xM4_1_DI27;  //Retorno Circuito Resist Sup 14 - 64
ImgTesteEntradas[133]:=	xM4_1_DI28;  //Retorno Circuito Resist Sup 15 - 65
ImgTesteEntradas[134]:=	xM4_1_DI29;  //Retorno Circuito Resist Sup 16 - 66
ImgTesteEntradas[135]:=	xM4_1_DI30;  //Retorno Circuito Resist Sup 17 - 67
ImgTesteEntradas[136]:=	xM4_1_DI31;  //Retorno Circuito Resist Sup 18 - 68

//TM3DI32K - 4.2
ImgTesteEntradas[137]:= xM4_2_DI0;   //Retorno Circuito Resist Sup 19 - 69	
ImgTesteEntradas[138]:= xM4_2_DI1;   //Retorno Circuito Resist Sup 20 - 70	
ImgTesteEntradas[139]:= xM4_2_DI2;   //Retorno Circuito Resist Sup 21 - 71	
ImgTesteEntradas[140]:= xM4_2_DI3;   //Retorno Circuito Resist Sup 22 - 72	
ImgTesteEntradas[141]:= xM4_2_DI4;   //Retorno Circuito Resist Sup 23 - 73	
ImgTesteEntradas[142]:= xM4_2_DI5;   //Retorno Circuito Resist Sup 24 - 74	
ImgTesteEntradas[143]:= xM4_2_DI6;   //Retorno Circuito Resist Sup 25 - 75	
ImgTesteEntradas[144]:= xM4_2_DI7;   //Retorno Circuito Resist Sup 26 - 76	
ImgTesteEntradas[145]:= xM4_2_DI8;   //Retorno Circuito Resist Sup 27 - 77	
ImgTesteEntradas[146]:= xM4_2_DI9;   //Retorno Circuito Resist Sup 28 - 78		
ImgTesteEntradas[147]:= xM4_2_DI10;  //Retorno Circuito Resist Sup 29 - 79		
ImgTesteEntradas[148]:= xM4_2_DI11;  //Retorno Circuito Resist Sup 30 - 80		
ImgTesteEntradas[149]:= xM4_2_DI12;  //Retorno Circuito Resist Sup 31 - 81	
ImgTesteEntradas[150]:= xM4_2_DI13;  //Retorno Circuito Resist Sup 32 - 82	
ImgTesteEntradas[151]:= xM4_2_DI14;  //Retorno Circuito Resist Sup 33 - 83
ImgTesteEntradas[152]:= xM4_2_DI15;  //Retorno Circuito Resist Sup 34 - 84
ImgTesteEntradas[153]:= xM4_2_DI16;  //Retorno Circuito Resist Sup 35 - 85
ImgTesteEntradas[154]:= xM4_2_DI17;  //Retorno Circuito Resist Sup 36 - 86
ImgTesteEntradas[155]:= xM4_2_DI18;  //Retorno Circuito Resist Sup 37 - 87
ImgTesteEntradas[156]:= xM4_2_DI19;  //Retorno Circuito Resist Sup 38 - 88	
ImgTesteEntradas[157]:= xM4_2_DI20;  //Retorno Circuito Resist Sup 39 - 89
ImgTesteEntradas[158]:= xM4_2_DI21;  //Retorno Circuito Resist Sup 40 - 90	
ImgTesteEntradas[159]:= xM4_2_DI22;  //Retorno Circuito Resist Sup 41 - 91
ImgTesteEntradas[160]:= xM4_2_DI23;  //Retorno Circuito Resist Sup 42 - 92
ImgTesteEntradas[161]:= xM4_2_DI24;  //Retorno Circuito Resist Sup 43 - 93
ImgTesteEntradas[162]:= xM4_2_DI25;  //Retorno Circuito Resist Sup 44 - 94
ImgTesteEntradas[163]:= xM4_2_DI26;  //Retorno Circuito Resist Sup 45 - 95
ImgTesteEntradas[164]:= xM4_2_DI27;  //Retorno Circuito Resist Sup 46 - 96
ImgTesteEntradas[165]:=	xM4_2_DI28;  //Retorno Circuito Resist Sup 47 - 97
ImgTesteEntradas[166]:=	xM4_2_DI29;  //Retorno Circuito Resist Sup 48 - 98
ImgTesteEntradas[167]:=	xM4_2_DI30;  //Retorno Circuito Resist Sup 49 - 99
ImgTesteEntradas[168]:=	xM4_2_DI31;  //Retorno Circuito Resist Sup 50 - 100

ImgEncoder[1]:=dValorEncoderForno;
ImgEncoder[2]:=dValorEncoderResfriador;
ImgEncoder[3]:=dValorEncoderDuctosResfriadorSup01;
ImgEncoder[4]:=dValorEncoderDuctosResfriadorInf01;
ImgEncoder[5]:=dValorEncoderDuctosResfriadorSup02;
ImgEncoder[6]:=dValorEncoderDuctosResfriadorInf02;
ImgEncoder[7]:=dValorEncoderGuilhotinaResfriador01;
ImgEncoder[8]:=dValorEncoderGuilhotinaResfriador02;



//Force Saídas

//TM262L10MESE8T - 0.1
xM0_1_DQ0:=ForceTesteSaidas[1];	//ByPass
xM0_1_DQ1:=ForceTesteSaidas[2]; //Vermelho 
xM0_1_DQ2:=ForceTesteSaidas[3]; //Amarelo
xM0_1_DQ3:=ForceTesteSaidas[4]; //Verde

//TM3XHSC202 - 0.2
xM0_2_DQ0:=ForceTesteSaidas[5]; //xVentiladoresPainel;
xM0_2_DQ1:=ForceTesteSaidas[6]; //xVentiladoresSsr;
xM0_2_DQ2:=ForceTesteSaidas[7]; //xValvulaGradeEntrada;
xM0_2_DQ3:=ForceTesteSaidas[8]; //xValvPortaEntradaForno;
xM0_2_DQ4:=ForceTesteSaidas[9]; //xValvPortaSaidaForno;
xM0_2_DQ5:=ForceTesteSaidas[10]; //xValvulaGradeSaida;
xM0_2_DQ6:=ForceTesteSaidas[11]; //xValvulaDamperDifusor;
xM0_2_DQ7:=ForceTesteSaidas[12]; //xLedCargaForno;
	
//TM3XHSC202 - 0.3
xM0_3_DQ0:=ForceTesteSaidas[13]; //xReleSeguranca;
xM0_3_DQ1:=ForceTesteSaidas[14]; //xAlarmeSonoro;
xM0_3_DQ2:=ForceTesteSaidas[15]; //oscila sup;
xM0_3_DQ3:=ForceTesteSaidas[16]; //oscila sup;
xM0_3_DQ4:=ForceTesteSaidas[17]; //RESERVA;
xM0_3_DQ5:=ForceTesteSaidas[18]; //RESERVA;
xM0_3_DQ6:=ForceTesteSaidas[19]; //RESERVA;
xM0_3_DQ7:=ForceTesteSaidas[20]; //RESERVA;


//TM3DM24R- 3.1
xM3_1_DQ0:= ForceTesteSaidas[21]; // RESERVA
xM3_1_DQ1:= ForceTesteSaidas[22]; // RESERVA
xM3_1_DQ2:= ForceTesteSaidas[23]; // RESERVA
xM3_1_DQ3:= ForceTesteSaidas[24]; // Rele Convecção Forçada
xM3_1_DQ4:= ForceTesteSaidas[25]; // xReleSsrInferior[1]
xM3_1_DQ5:= ForceTesteSaidas[26]; // xReleSsrInferior[2]
xM3_1_DQ6:= ForceTesteSaidas[27]; // xReleSsrInferior[3]
xM3_1_DQ7:= ForceTesteSaidas[28]; // xReleSsrInferior[4]


//TM3DQ32TK - 3.3
xM3_3_DQ0:= ForceTesteSaidas[29]; // xReleSsrInferior[5]
xM3_3_DQ1:= ForceTesteSaidas[30]; // xReleSsrInferior[6]
xM3_3_DQ2:= ForceTesteSaidas[31]; // xReleSsrInferior[7]
xM3_3_DQ3:= ForceTesteSaidas[32]; // xReleSsrInferior[8]
xM3_3_DQ4:= ForceTesteSaidas[33]; // xReleSsrInferior[9]
xM3_3_DQ5:= ForceTesteSaidas[34]; // xReleSsrInferior[10]
xM3_3_DQ6:= ForceTesteSaidas[35]; // xReleSsrInferior[11]
xM3_3_DQ7:= ForceTesteSaidas[36]; // xReleSsrInferior[12]
xM3_3_DQ8:= ForceTesteSaidas[37]; // xReleSsrInferior[13]
xM3_3_DQ9:= ForceTesteSaidas[38]; // xReleSsrInferior[14]
xM3_3_DQ10:=ForceTesteSaidas[39]; // xReleSsrInferior[15]
xM3_3_DQ11:=ForceTesteSaidas[40]; // xReleSsrInferior[16]
xM3_3_DQ12:=ForceTesteSaidas[41]; // xReleSsrInferior[17]
xM3_3_DQ13:=ForceTesteSaidas[42]; // xReleSsrInferior[18]
xM3_3_DQ14:=ForceTesteSaidas[43]; // xReleSsrInferior[19]
xM3_3_DQ15:=ForceTesteSaidas[44]; // xReleSsrInferior[20]
xM3_3_DQ16:=ForceTesteSaidas[45]; // xReleSsrInferior[21]
xM3_3_DQ17:=ForceTesteSaidas[46]; // xReleSsrInferior[22]
xM3_3_DQ18:=ForceTesteSaidas[47]; // xReleSsrInferior[23]
xM3_3_DQ19:=ForceTesteSaidas[48]; // xReleSsrInferior[24]
xM3_3_DQ20:=ForceTesteSaidas[49]; // xReleSsrInferior[25]
xM3_3_DQ21:=ForceTesteSaidas[50]; // xReleSsrInferior[26]
xM3_3_DQ22:=ForceTesteSaidas[51]; // xReleSsrInferior[27]
xM3_3_DQ23:=ForceTesteSaidas[52]; // xReleSsrInferior[28]
xM3_3_DQ24:=ForceTesteSaidas[53]; // xReleSsrInferior[29]
xM3_3_DQ25:=ForceTesteSaidas[54]; // xReleSsrInferior[30]
xM3_3_DQ26:=ForceTesteSaidas[55]; // xReleSsrInferior[31]
xM3_3_DQ27:=ForceTesteSaidas[56]; // xReleSsrInferior[32]
xM3_3_DQ28:=ForceTesteSaidas[57]; // xReleSsrInferior[33]
xM3_3_DQ29:=ForceTesteSaidas[58]; // xReleSsrInferior[34]
xM3_3_DQ30:=ForceTesteSaidas[59]; // xReleSsrInferior[35]
xM3_3_DQ31:=ForceTesteSaidas[60]; // xReleSsrInferior[36]
           

//TM3DQ32TK - 4.3
xM4_3_DQ0:= ForceTesteSaidas[61]; // xReleSsrInferior[37]
xM4_3_DQ1:= ForceTesteSaidas[62]; // xReleSsrInferior[38]
xM4_3_DQ2:= ForceTesteSaidas[63]; // xReleSsrInferior[39]
xM4_3_DQ3:= ForceTesteSaidas[64]; // xReleSsrInferior[40]
xM4_3_DQ4:= ForceTesteSaidas[65]; // xReleSsrInferior[41]
xM4_3_DQ5:= ForceTesteSaidas[66]; // xReleSsrInferior[42]
xM4_3_DQ6:= ForceTesteSaidas[67]; // xReleSsrInferior[43]
xM4_3_DQ7:= ForceTesteSaidas[68]; // xReleSsrInferior[44]
xM4_3_DQ8:= ForceTesteSaidas[69]; // xReleSsrInferior[45]
xM4_3_DQ9:= ForceTesteSaidas[70]; // xReleSsrInferior[46]
xM4_3_DQ10:=ForceTesteSaidas[71]; // xReleSsrInferior[47]
xM4_3_DQ11:=ForceTesteSaidas[72]; // xReleSsrInferior[48]
xM4_3_DQ12:=ForceTesteSaidas[73]; // xReleSsrInferior[49]
xM4_3_DQ13:=ForceTesteSaidas[74]; // xReleSsrInferior[50]
xM4_3_DQ14:=ForceTesteSaidas[75]; // xReleSsrSuperior[1] - 51
xM4_3_DQ15:=ForceTesteSaidas[76]; // xReleSsrSuperior[2] - 52
xM4_3_DQ16:=ForceTesteSaidas[77]; // xReleSsrSuperior[3] - 53
xM4_3_DQ17:=ForceTesteSaidas[78]; // xReleSsrSuperior[4] - 54
xM4_3_DQ18:=ForceTesteSaidas[79]; // xReleSsrSuperior[5] - 55
xM4_3_DQ19:=ForceTesteSaidas[80]; // xReleSsrSuperior[6] - 56
xM4_3_DQ20:=ForceTesteSaidas[81]; // xReleSsrSuperior[7] - 57
xM4_3_DQ21:=ForceTesteSaidas[82]; // xReleSsrSuperior[8] - 58
xM4_3_DQ22:=ForceTesteSaidas[83]; // xReleSsrSuperior[9] - 59
xM4_3_DQ23:=ForceTesteSaidas[84]; // xReleSsrSuperior[10] - 60
xM4_3_DQ24:=ForceTesteSaidas[85]; // xReleSsrSuperior[11] - 61
xM4_3_DQ25:=ForceTesteSaidas[86]; // xReleSsrSuperior[12] - 62
xM4_3_DQ26:=ForceTesteSaidas[87]; // xReleSsrSuperior[13] - 63
xM4_3_DQ27:=ForceTesteSaidas[88]; // xReleSsrSuperior[14] - 64
xM4_3_DQ28:=ForceTesteSaidas[89]; // xReleSsrSuperior[15] - 65
xM4_3_DQ29:=ForceTesteSaidas[90]; // xReleSsrSuperior[16] - 66
xM4_3_DQ30:=ForceTesteSaidas[91]; // xReleSsrSuperior[17] - 67
xM4_3_DQ31:=ForceTesteSaidas[92]; // xReleSsrSuperior[18] - 68
           
//TM3DQ32TK - 4.4
xM4_4_DQ0:= ForceTesteSaidas[93]; // xReleSsrSuperior[19] - 69
xM4_4_DQ1:= ForceTesteSaidas[94]; // xReleSsrSuperior[20] - 70
xM4_4_DQ2:= ForceTesteSaidas[95]; // xReleSsrSuperior[21] - 71
xM4_4_DQ3:= ForceTesteSaidas[96]; // xReleSsrSuperior[22] - 72
xM4_4_DQ4:= ForceTesteSaidas[97]; // xReleSsrSuperior[23] - 73
xM4_4_DQ5:= ForceTesteSaidas[98]; // xReleSsrSuperior[24] - 74
xM4_4_DQ6:= ForceTesteSaidas[99]; // xReleSsrSuperior[25] - 75
xM4_4_DQ7:= ForceTesteSaidas[100]; // xReleSsrSuperior[26] - 76
xM4_4_DQ8:= ForceTesteSaidas[101]; // xReleSsrSuperior[27] - 77
xM4_4_DQ9:= ForceTesteSaidas[102]; // xReleSsrSuperior[28] - 78
xM4_4_DQ10:=ForceTesteSaidas[103]; // xReleSsrSuperior[29] - 79
xM4_4_DQ11:=ForceTesteSaidas[104]; // xReleSsrSuperior[30] - 80
xM4_4_DQ12:=ForceTesteSaidas[105]; // xReleSsrSuperior[31] - 81
xM4_4_DQ13:=ForceTesteSaidas[106]; // xReleSsrSuperior[32] - 82
xM4_4_DQ14:=ForceTesteSaidas[107]; // xReleSsrSuperior[33] - 83
xM4_4_DQ15:=ForceTesteSaidas[108]; // xReleSsrSuperior[34] - 84
xM4_4_DQ16:=ForceTesteSaidas[109]; // xReleSsrSuperior[35] - 85
xM4_4_DQ17:=ForceTesteSaidas[110]; // xReleSsrSuperior[36] - 86
xM4_4_DQ18:=ForceTesteSaidas[111]; // xReleSsrSuperior[37] - 87
xM4_4_DQ19:=ForceTesteSaidas[112]; // xReleSsrSuperior[38] - 88
xM4_4_DQ20:=ForceTesteSaidas[113]; // xReleSsrSuperior[39] - 89
xM4_4_DQ21:=ForceTesteSaidas[114]; // xReleSsrSuperior[40] - 90
xM4_4_DQ22:=ForceTesteSaidas[115]; // xReleSsrSuperior[41] - 91
xM4_4_DQ23:=ForceTesteSaidas[116]; // xReleSsrSuperior[42] - 92
xM4_4_DQ24:=ForceTesteSaidas[117]; // xReleSsrSuperior[43] - 93
xM4_4_DQ25:=ForceTesteSaidas[118]; // xReleSsrSuperior[44] - 94
xM4_4_DQ26:=ForceTesteSaidas[119]; // xReleSsrSuperior[45] - 95
xM4_4_DQ27:=ForceTesteSaidas[120]; // xReleSsrSuperior[46] - 96
xM4_4_DQ28:=ForceTesteSaidas[121]; // xReleSsrSuperior[47] - 97
xM4_4_DQ29:=ForceTesteSaidas[122]; // xReleSsrSuperior[48] - 98
xM4_4_DQ30:=ForceTesteSaidas[123]; // xReleSsrSuperior[49] - 99
xM4_4_DQ31:=ForceTesteSaidas[124]; // xReleSsrSuperior[50] - 100


           



