__METADATA__
{
  "v3Meta": {
    "objectGuid": "d66c892d-2223-4cc2-980d-9e644f3e04d2",
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
PROGRAM B_EspelhoEntradas
VAR

END_VAR
__IMPLEMENTATION__
//TM262L10MESE8T - 0.1

ImgTesteEntradas[1]:=   xChCircuitoEmergenciaCC	:= xM0_1_DI0;//xChCircuitoEmergenciaCC
ImgTesteEntradas[2]:=   xChHabDesabCircuitoCC := xM0_1_DI1;//Reserva
ImgTesteEntradas[3]:=   xSaidaNobreakOk:= 	xM0_1_DI2;//xSaidaNobreakOk
ImgTesteEntradas[4]:=	xReleSeguranca:=	xM0_1_DI3;//xReleSeguranca

xInvVentilador01Habilitado:=true;//xM0_1_DI1;

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
ImgTesteEntradas[25]:= 	xChAvancaMesaEntrada	:= xM0_4_DI0;	//xChAvancaMesaEntrada	
ImgTesteEntradas[26]:= 	xChRecuaMesaEntrada		:= xM0_4_DI1;	//xChRecuaMesaEntrada
ImgTesteEntradas[27]:= 	xSensorEntrada01		:= xM0_4_DI2;	//xSensorEntrada01
ImgTesteEntradas[28]:= 	xSensorEntrada02		:= xM0_4_DI3;	//xSensorEntrada02
ImgTesteEntradas[29]:= 	xSensorEntrada03		:= xM0_4_DI4;	//xSensorEntrada03
ImgTesteEntradas[30]:= 	xSensorEntrada04		:= xM0_4_DI5;	//xSensorEntrada04
ImgTesteEntradas[31]:= 	xSensorEntrada05		:= xM0_4_DI6;	//xSensorEntrada05
ImgTesteEntradas[32]:= 	xSensorEntrada06		:= xM0_4_DI7;  //xSensorEntrada06
ImgTesteEntradas[33]:= 	xSensorEntrada07		:= xM0_4_DI8;  //xSensorEntrada07
ImgTesteEntradas[34]:= 	xSensorEntrada08		:= xM0_4_DI9;  //xSensorEntrada08
ImgTesteEntradas[35]:= 	xBtGradeEntrada			:= xM0_4_DI10; //xBtGradeEntrada
ImgTesteEntradas[36]:= 	xBtHabilitaCarregamento	:= xM0_4_DI11; //xBtHabilitaCarregamento	
ImgTesteEntradas[37]:= 	xBt02Emergencia			:= xM0_4_DI12; //xBt02Emergencia Mesa Entrada	
ImgTesteEntradas[38]:= 	xSensorPortaEntrada		:= xM0_4_DI13; //xSensorPortaEntrada 
ImgTesteEntradas[39]:= 	xSensorPortaSaida		:=	xM0_4_DI14; //xSensorPortaSaida   
ImgTesteEntradas[40]:= 	xM0_4_DI15; //xSensorAbertoForno  
ImgTesteEntradas[41]:=	xM0_4_DI16; //xSensorFechadoForno
ImgTesteEntradas[42]:=	xSensorAbertoResfriadorSup02:= xM0_4_DI17; //xSensorAbertoResfriadorSup02					
ImgTesteEntradas[43]:=	xSensorFechadoResfriadorSup02:= xM0_4_DI18; //xSensorFechadoResfriadorSup02 			
ImgTesteEntradas[44]:=	xFcMaximoSegResfriadorSup02:= xM0_4_DI19; //xFcMaximoSegResfriadorSup02				
ImgTesteEntradas[45]:=	xFcMinimoSegResfriadorSup02:= xM0_4_DI20; //xFcMinimoSegResfriadorSup02						
ImgTesteEntradas[46]:=	xChAbreDuctosResfriadorSup02:= xM0_4_DI21; //xChAbreDuctosResfriadorSup02			
ImgTesteEntradas[47]:=	xBt03Emergencia			:= xM0_4_DI22; //xBt03Emergencia Mesa Resfriador					
ImgTesteEntradas[48]:=	xSensorDesligaMesaSaida	:= xM0_4_DI23; //xSensorDesligaMesaSaida					
ImgTesteEntradas[49]:=	xSensorGradeSaidaUp		:= xM0_4_DI24; //xSensorGradeSaidaUp	
ImgTesteEntradas[50]:=	xBtGradeSaida			:=	xM0_4_DI25;  //	xBtGradeSaida	
ImgTesteEntradas[51]:=	xChAvancaMesaSaida		:= xM0_4_DI26; //xChAvancaMesaSaida			
ImgTesteEntradas[52]:=	xChRecuaMesaSaida		:=	xM0_4_DI27; //xChRecuaMesaSaida				
ImgTesteEntradas[53]:=	xBt04Emergencia			:= xM0_4_DI28; //xBt04Emergencia Mesa Saída					
ImgTesteEntradas[54]:=	xSensorPositivoGuilhotina02:= xM0_4_DI29; //xSensorPositivoGuilhotina02					
ImgTesteEntradas[55]:=	xSensorNegativoGuilhotina02:=xM0_4_DI30; //xSensorNegativoGuilhotina02					
ImgTesteEntradas[56]:=	xSensorZeroGuilhotina02	:= xM0_4_DI31; //xSensorZeroGuilhotina02					


//TM3DI32K - 3.1
ImgTesteEntradas[57]:= 	xChAutomaticoManual:= xM3_1_DI0;   //xChAutomaticoManual	
ImgTesteEntradas[58]:= xBt01CalaAlarme:= xM3_1_DI1;   //xBt01CalaAlarme Mesa Controle	
ImgTesteEntradas[59]:= xBt01Emergencia:= xM3_1_DI2;   //xBt01Emergencia Mesa Controle	
ImgTesteEntradas[60]:= xPressaoBaixaMediaRede:= xM3_1_DI3;   //xPressaoBaixaMediaRede	
ImgTesteEntradas[61]:= xPressaoMediaAltaRede:=	xM3_1_DI4;   //xPressaoMediaAltaRede	
ImgTesteEntradas[62]:= xKaMotorOscilaResfr02Sup:= xM3_1_DI5;   //oscilantes	
ImgTesteEntradas[63]:= xKaMotorOscilaResfr02Inf:= xM3_1_DI6;   //oscilantes	
ImgTesteEntradas[64]:= xSensorOscilaResfr02Sup:= xM3_1_DI7;   //oscilantes	
ImgTesteEntradas[65]:= xSensorOscilaResfr02Inf:= xM3_1_DI8;   //oscilantes	
ImgTesteEntradas[66]:= xRetornoSsr01ConveccaoEnt:=	xM3_1_DI9;   //xRetornoSsr01ConveccaoEnt		
ImgTesteEntradas[67]:= xRetornoSsr02ConveccaoEnt:=	xM3_1_DI10;  //xRetornoSsr02ConveccaoEnt		
ImgTesteEntradas[68]:= xRetornoSsr03ConveccaoEnt:=	xM3_1_DI11;  //xRetornoSsr03ConveccaoEnt		
ImgTesteEntradas[69]:= xRetornoSsrInferior[1]:= xM3_1_DI12;  //Retorno Circuito Resist Inf 01	
ImgTesteEntradas[70]:= xRetornoSsrInferior[2]:= xM3_1_DI13;  //Retorno Circuito Resist Inf 02	
ImgTesteEntradas[71]:= xRetornoSsrInferior[3]:= xM3_1_DI14;  //Retorno Circuito Resist Inf 03
ImgTesteEntradas[72]:= xRetornoSsrInferior[4]:= xM3_1_DI15;  //Retorno Circuito Resist Inf 04

//TM3DI32K - 3.2
ImgTesteEntradas[73]:= xRetornoSsrInferior[5]:= xM3_2_DI0;   //Retorno Circuito Resist Inf 05	
ImgTesteEntradas[74]:= xRetornoSsrInferior[6]:= xM3_2_DI1;   //Retorno Circuito Resist Inf 06	
ImgTesteEntradas[75]:= xRetornoSsrInferior[7]:= xM3_2_DI2;   //Retorno Circuito Resist Inf 07	
ImgTesteEntradas[76]:= xRetornoSsrInferior[8]:= xM3_2_DI3;   //Retorno Circuito Resist Inf 08	
ImgTesteEntradas[77]:= xRetornoSsrInferior[9]:= xM3_2_DI4;   //Retorno Circuito Resist Inf 09	
ImgTesteEntradas[78]:= xRetornoSsrInferior[10]:= xM3_2_DI5;   //Retorno Circuito Resist Inf 10	
ImgTesteEntradas[79]:= xRetornoSsrInferior[11]:= xM3_2_DI6;   //Retorno Circuito Resist Inf 11	
ImgTesteEntradas[80]:= xRetornoSsrInferior[12]:= xM3_2_DI7;   //Retorno Circuito Resist Inf 12	
ImgTesteEntradas[81]:= xRetornoSsrInferior[13]:= xM3_2_DI8;   //Retorno Circuito Resist Inf 13	
ImgTesteEntradas[82]:= xRetornoSsrInferior[14]:= xM3_2_DI9;   //Retorno Circuito Resist Inf 14	
ImgTesteEntradas[83]:= xRetornoSsrInferior[15]:= xM3_2_DI10;  //Retorno Circuito Resist Inf 15		
ImgTesteEntradas[84]:= xRetornoSsrInferior[16]:= xM3_2_DI11;  //Retorno Circuito Resist Inf 16		
ImgTesteEntradas[85]:= xRetornoSsrInferior[17]:= xM3_2_DI12;  //Retorno Circuito Resist Inf 17	
ImgTesteEntradas[86]:= xRetornoSsrInferior[18]:= xM3_2_DI13;  //Retorno Circuito Resist Inf 18	
ImgTesteEntradas[87]:= xRetornoSsrInferior[19]:= xM3_2_DI14;  //Retorno Circuito Resist Inf 19
ImgTesteEntradas[88]:= xRetornoSsrInferior[20]:= xM3_2_DI15;  //Retorno Circuito Resist Inf 20
ImgTesteEntradas[89]:= xRetornoSsrInferior[21]:= xM3_2_DI16;  //Retorno Circuito Resist Inf 21
ImgTesteEntradas[90]:= xRetornoSsrInferior[22]:= xM3_2_DI17;  //Retorno Circuito Resist Inf 22
ImgTesteEntradas[91]:= xRetornoSsrInferior[23]:= xM3_2_DI18;  //Retorno Circuito Resist Inf 23	
ImgTesteEntradas[92]:= xRetornoSsrInferior[24]:= xM3_2_DI19;  //Retorno Circuito Resist Inf 24	
ImgTesteEntradas[93]:= xRetornoSsrInferior[25]:= xM3_2_DI20;  //Retorno Circuito Resist Inf 25
ImgTesteEntradas[94]:= xRetornoSsrInferior[26]:= xM3_2_DI21;  //Retorno Circuito Resist Inf 26	
ImgTesteEntradas[95]:= xRetornoSsrInferior[27]:= xM3_2_DI22;  //Retorno Circuito Resist Inf 27
ImgTesteEntradas[96]:= xRetornoSsrInferior[28]:= xM3_2_DI23;  //Retorno Circuito Resist Inf 28
ImgTesteEntradas[97]:= xRetornoSsrInferior[29]:= xM3_2_DI24;  //Retorno Circuito Resist Inf 29
ImgTesteEntradas[98]:= xRetornoSsrInferior[30]:= xM3_2_DI25;  //Retorno Circuito Resist Inf 30
ImgTesteEntradas[99]:= xRetornoSsrInferior[31]:= xM3_2_DI26;  //Retorno Circuito Resist Inf 31
ImgTesteEntradas[100]:= xRetornoSsrInferior[32]:= xM3_2_DI27;  //Retorno Circuito Resist Inf 32
ImgTesteEntradas[101]:=	xRetornoSsrInferior[33]:= xM3_2_DI28;  //Retorno Circuito Resist Inf 33
ImgTesteEntradas[102]:=	xRetornoSsrInferior[34]:= xM3_2_DI29;  //Retorno Circuito Resist Inf 34
ImgTesteEntradas[103]:=	xRetornoSsrInferior[35]:= xM3_2_DI30;  //Retorno Circuito Resist Inf 35
ImgTesteEntradas[104]:=	xRetornoSsrInferior[36]:= xM3_2_DI31;  //Retorno Circuito Resist Inf 36

//TM3DI32K - 4.1
ImgTesteEntradas[105]:=	xRetornoSsrInferior[37]:= xM4_1_DI0;   //Retorno Circuito Resist Inf 37	
ImgTesteEntradas[106]:=	xRetornoSsrInferior[38]:= xM4_1_DI1;   //Retorno Circuito Resist Inf 38	
ImgTesteEntradas[107]:=	xRetornoSsrInferior[39]:= xM4_1_DI2;   //Retorno Circuito Resist Inf 39	
ImgTesteEntradas[108]:=	xRetornoSsrInferior[40]:= xM4_1_DI3;   //Retorno Circuito Resist Inf 40	
ImgTesteEntradas[109]:=	xRetornoSsrInferior[41]:= xM4_1_DI4;   //Retorno Circuito Resist Inf 41	
ImgTesteEntradas[110]:=	xRetornoSsrInferior[42]:= xM4_1_DI5;   //Retorno Circuito Resist Inf 42	
ImgTesteEntradas[111]:=	xRetornoSsrInferior[43]:= xM4_1_DI6;   //Retorno Circuito Resist Inf 43	
ImgTesteEntradas[112]:=	xRetornoSsrInferior[44]:= xM4_1_DI7;   //Retorno Circuito Resist Inf 44	
ImgTesteEntradas[113]:=	xRetornoSsrInferior[45]:= xM4_1_DI8;   //Retorno Circuito Resist Inf 45
ImgTesteEntradas[114]:=	xRetornoSsrInferior[46]:= xM4_1_DI9;   //Retorno Circuito Resist Inf 46
ImgTesteEntradas[115]:=	xRetornoSsrInferior[47]:= xM4_1_DI10;  //Retorno Circuito Resist Inf 47	
ImgTesteEntradas[116]:=	xRetornoSsrInferior[48]:= xM4_1_DI11;  //Retorno Circuito Resist Inf 48		
ImgTesteEntradas[117]:=	xRetornoSsrInferior[49]:= xM4_1_DI12;  //Retorno Circuito Resist Inf 49	
ImgTesteEntradas[118]:= xRetornoSsrInferior[50]:= xM4_1_DI13;  //Retorno Circuito Resist Inf 50	
ImgTesteEntradas[119]:= xRetornoSsrSuperior[1]:= xM4_1_DI14;  //Retorno Circuito Resist Sup 01 - 51
ImgTesteEntradas[120]:= xRetornoSsrSuperior[2]:= xM4_1_DI15;  //Retorno Circuito Resist Sup 02 - 52
ImgTesteEntradas[121]:= xRetornoSsrSuperior[3]:= xM4_1_DI16;  //Retorno Circuito Resist Sup 03 - 53
ImgTesteEntradas[122]:= xRetornoSsrSuperior[4]:= xM4_1_DI17;  //Retorno Circuito Resist Sup 04 - 54
ImgTesteEntradas[123]:= xRetornoSsrSuperior[5]:= xM4_1_DI18;  //Retorno Circuito Resist Sup 05 - 55
ImgTesteEntradas[124]:= xRetornoSsrSuperior[6]:= xM4_1_DI19;  //Retorno Circuito Resist Sup 06 - 56	
ImgTesteEntradas[125]:= xRetornoSsrSuperior[7]:= xM4_1_DI20;  //Retorno Circuito Resist Sup 07 - 57
ImgTesteEntradas[126]:= xRetornoSsrSuperior[8]:= xM4_1_DI21;  //Retorno Circuito Resist Sup 08 - 58
ImgTesteEntradas[127]:= xRetornoSsrSuperior[9]:= xM4_1_DI22;  //Retorno Circuito Resist Sup 09 - 59
ImgTesteEntradas[128]:= xRetornoSsrSuperior[10]:= xM4_1_DI23;  //Retorno Circuito Resist Sup 10 - 60
ImgTesteEntradas[129]:= xRetornoSsrSuperior[11]:= xM4_1_DI24;  //Retorno Circuito Resist Sup 11 - 61
ImgTesteEntradas[130]:= xRetornoSsrSuperior[12]:= xM4_1_DI25;  //Retorno Circuito Resist Sup 12 - 62
ImgTesteEntradas[131]:= xRetornoSsrSuperior[13]:= xM4_1_DI26;  //Retorno Circuito Resist Sup 13 - 63
ImgTesteEntradas[132]:= xRetornoSsrSuperior[14]:= xM4_1_DI27;  //Retorno Circuito Resist Sup 14 - 64
ImgTesteEntradas[133]:=	xRetornoSsrSuperior[15]:= xM4_1_DI28;  //Retorno Circuito Resist Sup 15 - 65
ImgTesteEntradas[134]:=	xRetornoSsrSuperior[16]:= xM4_1_DI29;  //Retorno Circuito Resist Sup 16 - 66
ImgTesteEntradas[135]:=	xRetornoSsrSuperior[17]:= xM4_1_DI30;  //Retorno Circuito Resist Sup 17 - 67
ImgTesteEntradas[136]:=	xRetornoSsrSuperior[18]:= xM4_1_DI31;  //Retorno Circuito Resist Sup 18 - 68

//TM3DI32K - 4.2
ImgTesteEntradas[137]:= xRetornoSsrSuperior[19]:= xM4_2_DI0;   //Retorno Circuito Resist Sup 19	- 69
ImgTesteEntradas[138]:= xRetornoSsrSuperior[20]:= xM4_2_DI1;   //Retorno Circuito Resist Sup 20	- 70	
ImgTesteEntradas[139]:= xRetornoSsrSuperior[21]:= xM4_2_DI2;   //Retorno Circuito Resist Sup 21	- 71
ImgTesteEntradas[140]:= xRetornoSsrSuperior[22]:= xM4_2_DI3;   //Retorno Circuito Resist Sup 22	- 72
ImgTesteEntradas[141]:= xRetornoSsrSuperior[23]:= xM4_2_DI4;   //Retorno Circuito Resist Sup 23	- 73
ImgTesteEntradas[142]:= xRetornoSsrSuperior[24]:= xM4_2_DI5;   //Retorno Circuito Resist Sup 24	- 74
ImgTesteEntradas[143]:= xRetornoSsrSuperior[25]:= xM4_2_DI6;   //Retorno Circuito Resist Sup 25	- 75
ImgTesteEntradas[144]:= xRetornoSsrSuperior[26]:= xM4_2_DI7;   //Retorno Circuito Resist Sup 26	- 76
ImgTesteEntradas[145]:= xRetornoSsrSuperior[27]:= xM4_2_DI8;   //Retorno Circuito Resist Sup 27	- 77
ImgTesteEntradas[146]:= xRetornoSsrSuperior[28]:= xM4_2_DI9;   //Retorno Circuito Resist Sup 28 - 78
ImgTesteEntradas[147]:= xRetornoSsrSuperior[29]:= xM4_2_DI10;  //Retorno Circuito Resist Sup 29	- 79
ImgTesteEntradas[148]:= xRetornoSsrSuperior[30]:= xM4_2_DI11;  //Retorno Circuito Resist Sup 30	- 80	
ImgTesteEntradas[149]:= xRetornoSsrSuperior[31]:= xM4_2_DI12;  //Retorno Circuito Resist Sup 31	- 81
ImgTesteEntradas[150]:= xRetornoSsrSuperior[32]:= xM4_2_DI13;  //Retorno Circuito Resist Sup 32	- 82
ImgTesteEntradas[151]:= xRetornoSsrSuperior[33]:= xM4_2_DI14;  //Retorno Circuito Resist Sup 33 - 83
ImgTesteEntradas[152]:= xRetornoSsrSuperior[34]:= xM4_2_DI15;  //Retorno Circuito Resist Sup 34 - 84
ImgTesteEntradas[153]:= xRetornoSsrSuperior[35]:= xM4_2_DI16;  //Retorno Circuito Resist Sup 35 - 85
ImgTesteEntradas[154]:= xRetornoSsrSuperior[36]:= xM4_2_DI17;  //Retorno Circuito Resist Sup 36 - 86
ImgTesteEntradas[155]:= xRetornoSsrSuperior[37]:= xM4_2_DI18;  //Retorno Circuito Resist Sup 37	- 87
ImgTesteEntradas[156]:= xRetornoSsrSuperior[38]:= xM4_2_DI19;  //Retorno Circuito Resist Sup 38	- 88
ImgTesteEntradas[157]:= xRetornoSsrSuperior[39]:= xM4_2_DI20;  //Retorno Circuito Resist Sup 39 - 89
ImgTesteEntradas[158]:= xRetornoSsrSuperior[40]:= xM4_2_DI21;  //Retorno Circuito Resist Sup 40	- 90
ImgTesteEntradas[159]:= xRetornoSsrSuperior[41]:= xM4_2_DI22;  //Retorno Circuito Resist Sup 41 - 91
ImgTesteEntradas[160]:= xRetornoSsrSuperior[42]:= xM4_2_DI23;  //Retorno Circuito Resist Sup 42 - 92
ImgTesteEntradas[161]:= xRetornoSsrSuperior[43]:= xM4_2_DI24;  //Retorno Circuito Resist Sup 43 - 93
ImgTesteEntradas[162]:= xRetornoSsrSuperior[44]:= xM4_2_DI25;  //Retorno Circuito Resist Sup 44 - 94
ImgTesteEntradas[163]:= xRetornoSsrSuperior[45]:= xM4_2_DI26;  //Retorno Circuito Resist Sup 45 - 95
ImgTesteEntradas[164]:= xRetornoSsrSuperior[46]:= xM4_2_DI27;  //Retorno Circuito Resist Sup 46 - 96
ImgTesteEntradas[165]:=	xRetornoSsrSuperior[47]:= xM4_2_DI28;  //Retorno Circuito Resist Sup 47 - 97
ImgTesteEntradas[166]:=	xRetornoSsrSuperior[48]:= xM4_2_DI29;  //Retorno Circuito Resist Sup 48 - 98
ImgTesteEntradas[167]:=	xRetornoSsrSuperior[49]:= xM4_2_DI30;  //Retorno Circuito Resist Sup 49 - 99
ImgTesteEntradas[168]:=	xRetornoSsrSuperior[50]:= xM4_2_DI31;  //Retorno Circuito Resist Sup 50 - 100


ImgEncoder[1]:=dValorEncoderForno;
ImgEncoder[2]:=dValorEncoderResfriador;
ImgEncoder[3]:=dValorEncoderDuctosResfriadorSup01;
ImgEncoder[4]:=dValorEncoderDuctosResfriadorInf01;
ImgEncoder[5]:=dValorEncoderDuctosResfriadorSup02;
ImgEncoder[6]:=dValorEncoderDuctosResfriadorInf02;
ImgEncoder[7]:=dValorEncoderGuilhotinaResfriador01;
ImgEncoder[8]:=dValorEncoderGuilhotinaResfriador02;


