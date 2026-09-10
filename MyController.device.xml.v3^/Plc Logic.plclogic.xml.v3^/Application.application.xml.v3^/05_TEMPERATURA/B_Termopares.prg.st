__METADATA__
{
  "v3Meta": {
    "objectGuid": "447a1a9e-d8cc-4b03-bb6f-47f69fb3c09b",
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
PROGRAM B_Termopares
VAR
	AlmTermoparesModulo01: AlarmeTM3TI8T;
	AlmTermoparesModulo02: AlarmeTM3TI8T;
	AlmTermoparesModulo03: AlarmeTM3TI8T;
	AlmTermoparesModulo04: AlarmeTM3TI8T;
	AlmTermoparesModulo05: AlarmeTM3TI8T;
	AlmTermoparesModulo06: AlarmeTM3TI8T;
	AlmTermoparesModulo07: AlarmeTM3TI8T;
	AlmTermoparesModulo08: AlarmeTM3TI8T;
	AlmTermoparesModulo09: AlarmeTM3TI8T;
	AlmTermoparesModulo10: AlarmeTM3TI8T;
	AlmTermoparesModulo11: AlarmeTM3TI8T;
	AlmTermoparesModulo12: AlarmeTM3TI8T;
	AlmTermoparesModulo13: AlarmeTM3TI8T;
	Index: INT;
	TermoparAbertoInferior: ARRAY[1..60] OF BOOL;
	TermoparAbertoSuperior: ARRAY[1..60] OF BOOL;
	TermoAbertoInferiorFisico: ARRAY[1..60] OF AlarmeTermopar;
	TermoAbertoSuperiorFisico: ARRAY[1..60] OF AlarmeTermopar;
	TermoAbertoInferiorLogico: ARRAY[1..60] OF AlarmeTermopar;
	TermoAbertoSuperiorLogico: ARRAY[1..60] OF AlarmeTermopar;
	xAlarmeTermoparAbertoInferiorSon: ARRAY[1..60] OF BOOL;
	xAlarmeTermoparAbertoSuperiorSon: ARRAY[1..60] OF BOOL;
	TemperaturaExcessoInferiorFisico: ARRAY[1..60] OF AlarmeTemperatura;
	TemperaturaExcessoSuperiorFisico: ARRAY[1..60] OF AlarmeTemperatura;
	TemperaturaExcessoInferiorLogico: ARRAY[1..60] OF AlarmeTemperatura;
	TemperaturaExcessoSuperiorLogico: ARRAY[1..60] OF AlarmeTemperatura;
	xAlarmeTemperaturaExcedeuInferiorSon: ARRAY[1..60] OF BOOL;
	xAlarmeTemperaturaExcedeuSuperiorSon: ARRAY[1..60] OF BOOL;
	/// Variavies de conversao de 25 p 7 termopares	
	TermoparAbertoInferiorAux: ARRAY[1..60] OF BOOL;
	TermoparAbertoLogicoInfAux: ARRAY[1..60] OF BOOL;
	TermoparInferiorAux: ARRAY[1..60] OF INT;
	TermoparLogicoInferiorAux: ARRAY[1..60] OF REAL;
	AlmTermoBitsSoma: INT;
	AlmTermoSonBitsSoma: INT;
	IndexSomaInf: INT;
	IndexSomaSup: INT;
	dSomaTempLogicasInferiores: DINT;
	dSomaTempLogicasSuperiores: DINT;
	
	TermoAbertoConveccaoEntrada:  AlarmeTermopar;
	TemperaturaExcessoConvecEntr: AlarmeTemperatura;
	TermoAbertoConveccaoSaida:  AlarmeTermopar;
	TemperaturaExcessoConvecSai: AlarmeTemperatura;
END_VAR
__IMPLEMENTATION__

AlmTermoparesModulo01(
	inAlarmeInput01:= ibModule_1_IBStatusIW0, 
	inAlarmeInput02:= ibModule_1_IBStatusIW1, 
	inAlarmeInput03:= ibModule_1_IBStatusIW2, 
	inAlarmeInput04:= ibModule_1_IBStatusIW3, 
	inAlarmeInput05:= ibModule_1_IBStatusIW4, 
	inAlarmeInput06:= ibModule_1_IBStatusIW5, 
	inAlarmeInput07:= ibModule_1_IBStatusIW6, 
	inAlarmeInput08:= ibModule_1_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoInferior[1], 
	OutAlarmeInput02=> TermoparAbertoInferior[2], 
	OutAlarmeInput03=> TermoparAbertoInferior[3], 
	OutAlarmeInput04=> TermoparAbertoInferior[4], 
	OutAlarmeInput05=> TermoparAbertoInferior[5], 
	OutAlarmeInput06=> TermoparAbertoInferior[6], 
	OutAlarmeInput07=> TermoparAbertoInferior[7], 
	OutAlarmeInput08=> TermoparAbertoInferior[8]);

AlmTermoparesModulo02(
	inAlarmeInput01:= ibModule_2_IBStatusIW0, 
	inAlarmeInput02:= ibModule_2_IBStatusIW1, 
	inAlarmeInput03:= ibModule_2_IBStatusIW2, 
	inAlarmeInput04:= ibModule_2_IBStatusIW3, 
	inAlarmeInput05:= ibModule_2_IBStatusIW4, 
	inAlarmeInput06:= ibModule_2_IBStatusIW5, 
	inAlarmeInput07:= ibModule_2_IBStatusIW6, 
	inAlarmeInput08:= ibModule_2_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoInferior[9], 
	OutAlarmeInput02=> TermoparAbertoInferior[10], 
	OutAlarmeInput03=> TermoparAbertoInferior[11], 
	OutAlarmeInput04=> TermoparAbertoInferior[12], 
	OutAlarmeInput05=> TermoparAbertoInferior[13], 
	OutAlarmeInput06=> TermoparAbertoInferior[14], 
	OutAlarmeInput07=> TermoparAbertoInferior[15], 
	OutAlarmeInput08=> TermoparAbertoInferior[16]);
	
AlmTermoparesModulo03(
	inAlarmeInput01:= ibModule_3_IBStatusIW0, 
	inAlarmeInput02:= ibModule_3_IBStatusIW1, 
	inAlarmeInput03:= ibModule_3_IBStatusIW2, 
	inAlarmeInput04:= ibModule_3_IBStatusIW3, 
	inAlarmeInput05:= ibModule_3_IBStatusIW4, 
	inAlarmeInput06:= ibModule_3_IBStatusIW5, 
	inAlarmeInput07:= ibModule_3_IBStatusIW6, 
	inAlarmeInput08:= ibModule_3_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoInferior[17], 
	OutAlarmeInput02=> TermoparAbertoInferior[18], 
	OutAlarmeInput03=> TermoparAbertoInferior[19], 
	OutAlarmeInput04=> TermoparAbertoInferior[20], 
	OutAlarmeInput05=> TermoparAbertoInferior[21], 
	OutAlarmeInput06=> TermoparAbertoInferior[22], 
	OutAlarmeInput07=> TermoparAbertoInferior[23], 
	OutAlarmeInput08=> TermoparAbertoInferior[24]);
	
AlmTermoparesModulo04(
	inAlarmeInput01:= ibModule_4_IBStatusIW0, 
	inAlarmeInput02:= ibModule_4_IBStatusIW1, 
	inAlarmeInput03:= ibModule_4_IBStatusIW2, 
	inAlarmeInput04:= ibModule_4_IBStatusIW3, 
	inAlarmeInput05:= ibModule_4_IBStatusIW4, 
	inAlarmeInput06:= ibModule_4_IBStatusIW5, 
	inAlarmeInput07:= ibModule_4_IBStatusIW6, 
	inAlarmeInput08:= ibModule_4_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoInferior[25], 
	OutAlarmeInput02=> TermoparAbertoInferior[26], 
	OutAlarmeInput03=> TermoparAbertoInferior[27], 
	OutAlarmeInput04=> TermoparAbertoInferior[28], 
	OutAlarmeInput05=> TermoparAbertoInferior[29], 
	OutAlarmeInput06=> TermoparAbertoInferior[30], 
	OutAlarmeInput07=> TermoparAbertoInferior[31], 
	OutAlarmeInput08=> TermoparAbertoInferior[32]);

AlmTermoparesModulo05(
	inAlarmeInput01:= ibModule_5_IBStatusIW0, 
	inAlarmeInput02:= ibModule_5_IBStatusIW1, 
	inAlarmeInput03:= ibModule_5_IBStatusIW2, 
	inAlarmeInput04:= ibModule_5_IBStatusIW3, 
	inAlarmeInput05:= ibModule_5_IBStatusIW4, 
	inAlarmeInput06:= ibModule_5_IBStatusIW5, 
	inAlarmeInput07:= ibModule_5_IBStatusIW6, 
	inAlarmeInput08:= ibModule_5_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoInferior[33], 
	OutAlarmeInput02=> TermoparAbertoInferior[34], 
	OutAlarmeInput03=> TermoparAbertoInferior[35], 
	OutAlarmeInput04=> TermoparAbertoInferior[36], 
	OutAlarmeInput05=> TermoparAbertoInferior[37], 
	OutAlarmeInput06=> TermoparAbertoInferior[38], 
	OutAlarmeInput07=> TermoparAbertoInferior[39], 
	OutAlarmeInput08=> TermoparAbertoInferior[40]);

AlmTermoparesModulo06(
	inAlarmeInput01:= ibModule_6_IBStatusIW0, 
	inAlarmeInput02:= ibModule_6_IBStatusIW1, 
	inAlarmeInput03:= ibModule_6_IBStatusIW2, 
	inAlarmeInput04:= ibModule_6_IBStatusIW3, 
	inAlarmeInput05:= ibModule_6_IBStatusIW4, 
	inAlarmeInput06:= ibModule_6_IBStatusIW5, 
	inAlarmeInput07:= ibModule_6_IBStatusIW6, 
	inAlarmeInput08:= ibModule_6_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoInferior[41], 
	OutAlarmeInput02=> TermoparAbertoInferior[42], 
	OutAlarmeInput03=> TermoparAbertoInferior[43], 
	OutAlarmeInput04=> TermoparAbertoInferior[44], 
	OutAlarmeInput05=> TermoparAbertoInferior[45], 
	OutAlarmeInput06=> TermoparAbertoInferior[46], 
	OutAlarmeInput07=> TermoparAbertoInferior[47], 
	OutAlarmeInput08=> TermoparAbertoInferior[48]);

AlmTermoparesModulo07(
	inAlarmeInput01:= ibModule_7_IBStatusIW0, 
	inAlarmeInput02:= ibModule_7_IBStatusIW1, 
	inAlarmeInput03:= ibModule_7_IBStatusIW2, 
	inAlarmeInput04:= ibModule_7_IBStatusIW3, 
	inAlarmeInput05:= ibModule_7_IBStatusIW4, 
	inAlarmeInput06:= ibModule_7_IBStatusIW5, 
	inAlarmeInput07:= ibModule_7_IBStatusIW6, 
	inAlarmeInput08:= ibModule_7_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoInferior[49], 
	OutAlarmeInput02=> TermoparAbertoInferior[50], 
	OutAlarmeInput03=> TermoparAbertoSuperior[1], 
	OutAlarmeInput04=> TermoparAbertoSuperior[2], 
	OutAlarmeInput05=> TermoparAbertoSuperior[3], 
	OutAlarmeInput06=> TermoparAbertoSuperior[4], 
	OutAlarmeInput07=> TermoparAbertoSuperior[5], 
	OutAlarmeInput08=> TermoparAbertoSuperior[6]);

AlmTermoparesModulo08(
	inAlarmeInput01:= ibModule_8_IBStatusIW0, 
	inAlarmeInput02:= ibModule_8_IBStatusIW1, 
	inAlarmeInput03:= ibModule_8_IBStatusIW2, 
	inAlarmeInput04:= ibModule_8_IBStatusIW3, 
	inAlarmeInput05:= ibModule_8_IBStatusIW4, 
	inAlarmeInput06:= ibModule_8_IBStatusIW5, 
	inAlarmeInput07:= ibModule_8_IBStatusIW6, 
	inAlarmeInput08:= ibModule_8_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoSuperior[7], 
	OutAlarmeInput02=> TermoparAbertoSuperior[8], 
	OutAlarmeInput03=> TermoparAbertoSuperior[9], 
	OutAlarmeInput04=> TermoparAbertoSuperior[10], 
	OutAlarmeInput05=> TermoparAbertoSuperior[11], 
	OutAlarmeInput06=> TermoparAbertoSuperior[12], 
	OutAlarmeInput07=> TermoparAbertoSuperior[13], 
	OutAlarmeInput08=> TermoparAbertoSuperior[14]);
	
AlmTermoparesModulo09(
	inAlarmeInput01:= ibModule_9_IBStatusIW0, 
	inAlarmeInput02:= ibModule_9_IBStatusIW1, 
	inAlarmeInput03:= ibModule_9_IBStatusIW2, 
	inAlarmeInput04:= ibModule_9_IBStatusIW3, 
	inAlarmeInput05:= ibModule_9_IBStatusIW4, 
	inAlarmeInput06:= ibModule_9_IBStatusIW5, 
	inAlarmeInput07:= ibModule_9_IBStatusIW6, 
	inAlarmeInput08:= ibModule_9_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoSuperior[15], 
	OutAlarmeInput02=> TermoparAbertoSuperior[16], 
	OutAlarmeInput03=> TermoparAbertoSuperior[17], 
	OutAlarmeInput04=> TermoparAbertoSuperior[18], 
	OutAlarmeInput05=> TermoparAbertoSuperior[19], 
	OutAlarmeInput06=> TermoparAbertoSuperior[20], 
	OutAlarmeInput07=> TermoparAbertoSuperior[21], 
	OutAlarmeInput08=> TermoparAbertoSuperior[22]);

AlmTermoparesModulo10(
	inAlarmeInput01:= ibModule_10_IBStatusIW0, 
	inAlarmeInput02:= ibModule_10_IBStatusIW1, 
	inAlarmeInput03:= ibModule_10_IBStatusIW2, 
	inAlarmeInput04:= ibModule_10_IBStatusIW3, 
	inAlarmeInput05:= ibModule_10_IBStatusIW4, 
	inAlarmeInput06:= ibModule_10_IBStatusIW5, 
	inAlarmeInput07:= ibModule_10_IBStatusIW6, 
	inAlarmeInput08:= ibModule_10_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoSuperior[23], 
	OutAlarmeInput02=> TermoparAbertoSuperior[24], 
	OutAlarmeInput03=> TermoparAbertoSuperior[25], 
	OutAlarmeInput04=> TermoparAbertoSuperior[26], 
	OutAlarmeInput05=> TermoparAbertoSuperior[27], 
	OutAlarmeInput06=> TermoparAbertoSuperior[28], 
	OutAlarmeInput07=> TermoparAbertoSuperior[29], 
	OutAlarmeInput08=> TermoparAbertoSuperior[30]);
	
AlmTermoparesModulo11(
	inAlarmeInput01:= ibModule_11_IBStatusIW0, 
	inAlarmeInput02:= ibModule_11_IBStatusIW1, 
	inAlarmeInput03:= ibModule_11_IBStatusIW2, 
	inAlarmeInput04:= ibModule_11_IBStatusIW3, 
	inAlarmeInput05:= ibModule_11_IBStatusIW4, 
	inAlarmeInput06:= ibModule_11_IBStatusIW5, 
	inAlarmeInput07:= ibModule_11_IBStatusIW6, 
	inAlarmeInput08:= ibModule_11_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoSuperior[31], 
	OutAlarmeInput02=> TermoparAbertoSuperior[32], 
	OutAlarmeInput03=> TermoparAbertoSuperior[33], 
	OutAlarmeInput04=> TermoparAbertoSuperior[34], 
	OutAlarmeInput05=> TermoparAbertoSuperior[35], 
	OutAlarmeInput06=> TermoparAbertoSuperior[36], 
	OutAlarmeInput07=> TermoparAbertoSuperior[37], 
	OutAlarmeInput08=> TermoparAbertoSuperior[38]);
	
AlmTermoparesModulo12(
	inAlarmeInput01:= ibModule_12_IBStatusIW0, 
	inAlarmeInput02:= ibModule_12_IBStatusIW1, 
	inAlarmeInput03:= ibModule_12_IBStatusIW2, 
	inAlarmeInput04:= ibModule_12_IBStatusIW3, 
	inAlarmeInput05:= ibModule_12_IBStatusIW4, 
	inAlarmeInput06:= ibModule_12_IBStatusIW5, 
	inAlarmeInput07:= ibModule_12_IBStatusIW6, 
	inAlarmeInput08:= ibModule_12_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoSuperior[39], 
	OutAlarmeInput02=> TermoparAbertoSuperior[40], 
	OutAlarmeInput03=> TermoparAbertoSuperior[41], 
	OutAlarmeInput04=> TermoparAbertoSuperior[42], 
	OutAlarmeInput05=> TermoparAbertoSuperior[43], 
	OutAlarmeInput06=> TermoparAbertoSuperior[44], 
	OutAlarmeInput07=> TermoparAbertoSuperior[45], 
	OutAlarmeInput08=> TermoparAbertoSuperior[46]);

AlmTermoparesModulo13(
	inAlarmeInput01:= ibModule_13_IBStatusIW0, 
	inAlarmeInput02:= ibModule_13_IBStatusIW1, 
	inAlarmeInput03:= ibModule_13_IBStatusIW2, 
	inAlarmeInput04:= ibModule_13_IBStatusIW3, 
	inAlarmeInput05:= ibModule_13_IBStatusIW4, 
	inAlarmeInput06:= ibModule_13_IBStatusIW5, 
	inAlarmeInput07:= ibModule_13_IBStatusIW6, 
	inAlarmeInput08:= ibModule_13_IBStatusIW7, 
	OutAlarmeInput01=> TermoparAbertoSuperior[47], 
	OutAlarmeInput02=> TermoparAbertoSuperior[48], 
	OutAlarmeInput03=> TermoparAbertoSuperior[49], 
	OutAlarmeInput04=> TermoparAbertoSuperior[50], 
	OutAlarmeInput05=> Termopar01PainelAberto, 
	OutAlarmeInput06=> Termopar02PainelAberto, 
	OutAlarmeInput07=> TermoparConvecEntAberto, 
	OutAlarmeInput08=> );

//TermoparConvecAberto
	
// Conversão dos 25 p/ 7 termopares inferiores

TermoparAbertoInferiorAux[1]:=TermoparAbertoInferior[1];
TermoparAbertoInferiorAux[2]:=TermoparAbertoInferior[2];
TermoparAbertoInferiorAux[3]:=TermoparAbertoInferior[3];
TermoparAbertoInferiorAux[4]:=TermoparAbertoInferior[4];
TermoparAbertoInferiorAux[5]:=TermoparAbertoInferior[5];
TermoparAbertoInferiorAux[6]:=TermoparAbertoInferior[6];
TermoparAbertoInferiorAux[7]:=TermoparAbertoInferior[7];
TermoparAbertoInferiorAux[8]:=TermoparAbertoInferior[8];
TermoparAbertoInferiorAux[9]:=TermoparAbertoInferior[9];
TermoparAbertoInferiorAux[10]:=TermoparAbertoInferior[10];
TermoparAbertoInferiorAux[11]:=TermoparAbertoInferior[11];
TermoparAbertoInferiorAux[12]:=TermoparAbertoInferior[12];
TermoparAbertoInferiorAux[13]:=TermoparAbertoInferior[13];
TermoparAbertoInferiorAux[14]:=TermoparAbertoInferior[14];
TermoparAbertoInferiorAux[15]:=TermoparAbertoInferior[15];
TermoparAbertoInferiorAux[16]:=TermoparAbertoInferior[16];
TermoparAbertoInferiorAux[17]:=TermoparAbertoInferior[17];
TermoparAbertoInferiorAux[18]:=TermoparAbertoInferior[18];
TermoparAbertoInferiorAux[19]:=TermoparAbertoInferior[19];
TermoparAbertoInferiorAux[20]:=TermoparAbertoInferior[20];
TermoparAbertoInferiorAux[21]:=TermoparAbertoInferior[21];
TermoparAbertoInferiorAux[22]:=TermoparAbertoInferior[22];
TermoparAbertoInferiorAux[23]:=TermoparAbertoInferior[23];
TermoparAbertoInferiorAux[24]:=TermoparAbertoInferior[24];
TermoparAbertoInferiorAux[25]:=TermoparAbertoInferior[25];
TermoparAbertoInferiorAux[26]:=TermoparAbertoInferior[26];
TermoparAbertoInferiorAux[27]:=TermoparAbertoInferior[27];
TermoparAbertoInferiorAux[28]:=TermoparAbertoInferior[28];
TermoparAbertoInferiorAux[29]:=TermoparAbertoInferior[29];
TermoparAbertoInferiorAux[30]:=TermoparAbertoInferior[30];
TermoparAbertoInferiorAux[31]:=TermoparAbertoInferior[31];
TermoparAbertoInferiorAux[32]:=TermoparAbertoInferior[32];
TermoparAbertoInferiorAux[33]:=TermoparAbertoInferior[33];
TermoparAbertoInferiorAux[34]:=TermoparAbertoInferior[34];
TermoparAbertoInferiorAux[35]:=TermoparAbertoInferior[35];
TermoparAbertoInferiorAux[36]:=TermoparAbertoInferior[36];
TermoparAbertoInferiorAux[37]:=TermoparAbertoInferior[37];
TermoparAbertoInferiorAux[38]:=TermoparAbertoInferior[38];
TermoparAbertoInferiorAux[39]:=TermoparAbertoInferior[39];
TermoparAbertoInferiorAux[40]:=TermoparAbertoInferior[40];
TermoparAbertoInferiorAux[41]:=TermoparAbertoInferior[41];
TermoparAbertoInferiorAux[42]:=TermoparAbertoInferior[42];
TermoparAbertoInferiorAux[43]:=TermoparAbertoInferior[43];
TermoparAbertoInferiorAux[44]:=TermoparAbertoInferior[44];
TermoparAbertoInferiorAux[45]:=TermoparAbertoInferior[45];
TermoparAbertoInferiorAux[46]:=TermoparAbertoInferior[46];
TermoparAbertoInferiorAux[47]:=TermoparAbertoInferior[47];
TermoparAbertoInferiorAux[48]:=TermoparAbertoInferior[48];
TermoparAbertoInferiorAux[49]:=TermoparAbertoInferior[49];
TermoparAbertoInferiorAux[50]:=TermoparAbertoInferior[50];

TermoparAbertoLogicoInfAux[1]:=TermoparAbertoLogicoInf[1];
TermoparAbertoLogicoInfAux[2]:=TermoparAbertoLogicoInf[2];
TermoparAbertoLogicoInfAux[3]:=TermoparAbertoLogicoInf[3];
TermoparAbertoLogicoInfAux[4]:=TermoparAbertoLogicoInf[4];
TermoparAbertoLogicoInfAux[5]:=TermoparAbertoLogicoInf[5];
TermoparAbertoLogicoInfAux[6]:=TermoparAbertoLogicoInf[6];
TermoparAbertoLogicoInfAux[7]:=TermoparAbertoLogicoInf[7];
TermoparAbertoLogicoInfAux[8]:=TermoparAbertoLogicoInf[8];
TermoparAbertoLogicoInfAux[9]:=TermoparAbertoLogicoInf[9];
TermoparAbertoLogicoInfAux[10]:=TermoparAbertoLogicoInf[10];
TermoparAbertoLogicoInfAux[11]:=TermoparAbertoLogicoInf[11];
TermoparAbertoLogicoInfAux[12]:=TermoparAbertoLogicoInf[12];
TermoparAbertoLogicoInfAux[13]:=TermoparAbertoLogicoInf[13];
TermoparAbertoLogicoInfAux[14]:=TermoparAbertoLogicoInf[14];
TermoparAbertoLogicoInfAux[15]:=TermoparAbertoLogicoInf[15];
TermoparAbertoLogicoInfAux[16]:=TermoparAbertoLogicoInf[16];
TermoparAbertoLogicoInfAux[17]:=TermoparAbertoLogicoInf[17];
TermoparAbertoLogicoInfAux[18]:=TermoparAbertoLogicoInf[18];
TermoparAbertoLogicoInfAux[19]:=TermoparAbertoLogicoInf[19];
TermoparAbertoLogicoInfAux[20]:=TermoparAbertoLogicoInf[20];
TermoparAbertoLogicoInfAux[21]:=TermoparAbertoLogicoInf[21];
TermoparAbertoLogicoInfAux[22]:=TermoparAbertoLogicoInf[22];
TermoparAbertoLogicoInfAux[23]:=TermoparAbertoLogicoInf[23];
TermoparAbertoLogicoInfAux[24]:=TermoparAbertoLogicoInf[24];
TermoparAbertoLogicoInfAux[25]:=TermoparAbertoLogicoInf[25];
TermoparAbertoLogicoInfAux[26]:=TermoparAbertoLogicoInf[26];
TermoparAbertoLogicoInfAux[27]:=TermoparAbertoLogicoInf[27];
TermoparAbertoLogicoInfAux[28]:=TermoparAbertoLogicoInf[28];
TermoparAbertoLogicoInfAux[29]:=TermoparAbertoLogicoInf[29];
TermoparAbertoLogicoInfAux[30]:=TermoparAbertoLogicoInf[30];
TermoparAbertoLogicoInfAux[31]:=TermoparAbertoLogicoInf[31];
TermoparAbertoLogicoInfAux[32]:=TermoparAbertoLogicoInf[32];
TermoparAbertoLogicoInfAux[33]:=TermoparAbertoLogicoInf[33];
TermoparAbertoLogicoInfAux[34]:=TermoparAbertoLogicoInf[34];
TermoparAbertoLogicoInfAux[35]:=TermoparAbertoLogicoInf[35];
TermoparAbertoLogicoInfAux[36]:=TermoparAbertoLogicoInf[36];
TermoparAbertoLogicoInfAux[37]:=TermoparAbertoLogicoInf[37];
TermoparAbertoLogicoInfAux[38]:=TermoparAbertoLogicoInf[38];
TermoparAbertoLogicoInfAux[39]:=TermoparAbertoLogicoInf[39];
TermoparAbertoLogicoInfAux[40]:=TermoparAbertoLogicoInf[40];
TermoparAbertoLogicoInfAux[41]:=TermoparAbertoLogicoInf[41];
TermoparAbertoLogicoInfAux[42]:=TermoparAbertoLogicoInf[42];
TermoparAbertoLogicoInfAux[43]:=TermoparAbertoLogicoInf[43];
TermoparAbertoLogicoInfAux[44]:=TermoparAbertoLogicoInf[44];
TermoparAbertoLogicoInfAux[45]:=TermoparAbertoLogicoInf[45];
TermoparAbertoLogicoInfAux[46]:=TermoparAbertoLogicoInf[46];
TermoparAbertoLogicoInfAux[47]:=TermoparAbertoLogicoInf[47];
TermoparAbertoLogicoInfAux[48]:=TermoparAbertoLogicoInf[48];
TermoparAbertoLogicoInfAux[49]:=TermoparAbertoLogicoInf[49];
TermoparAbertoLogicoInfAux[50]:=TermoparAbertoLogicoInf[50];

TermoparInferiorAux[1]:=TermoparInferior[1];
TermoparInferiorAux[2]:=TermoparInferior[2];
TermoparInferiorAux[3]:=TermoparInferior[3];
TermoparInferiorAux[4]:=TermoparInferior[4];
TermoparInferiorAux[5]:=TermoparInferior[5];
TermoparInferiorAux[6]:=TermoparInferior[6];
TermoparInferiorAux[7]:=TermoparInferior[7];
TermoparInferiorAux[8]:=TermoparInferior[8];
TermoparInferiorAux[9]:=TermoparInferior[9];
TermoparInferiorAux[10]:=TermoparInferior[10];
TermoparInferiorAux[11]:=TermoparInferior[11];
TermoparInferiorAux[12]:=TermoparInferior[12];
TermoparInferiorAux[13]:=TermoparInferior[13];
TermoparInferiorAux[14]:=TermoparInferior[14];
TermoparInferiorAux[15]:=TermoparInferior[15];
TermoparInferiorAux[16]:=TermoparInferior[16];
TermoparInferiorAux[17]:=TermoparInferior[17];
TermoparInferiorAux[18]:=TermoparInferior[18];
TermoparInferiorAux[19]:=TermoparInferior[19];
TermoparInferiorAux[20]:=TermoparInferior[20];
TermoparInferiorAux[21]:=TermoparInferior[21];
TermoparInferiorAux[22]:=TermoparInferior[22];
TermoparInferiorAux[23]:=TermoparInferior[23];
TermoparInferiorAux[24]:=TermoparInferior[24];
TermoparInferiorAux[25]:=TermoparInferior[25];
TermoparInferiorAux[26]:=TermoparInferior[26];
TermoparInferiorAux[27]:=TermoparInferior[27];
TermoparInferiorAux[28]:=TermoparInferior[28];
TermoparInferiorAux[29]:=TermoparInferior[29];
TermoparInferiorAux[30]:=TermoparInferior[30];
TermoparInferiorAux[31]:=TermoparInferior[31];
TermoparInferiorAux[32]:=TermoparInferior[32];
TermoparInferiorAux[33]:=TermoparInferior[33];
TermoparInferiorAux[34]:=TermoparInferior[34];
TermoparInferiorAux[35]:=TermoparInferior[35];
TermoparInferiorAux[36]:=TermoparInferior[36];
TermoparInferiorAux[37]:=TermoparInferior[37];
TermoparInferiorAux[38]:=TermoparInferior[38];
TermoparInferiorAux[39]:=TermoparInferior[39];
TermoparInferiorAux[40]:=TermoparInferior[40];
TermoparInferiorAux[41]:=TermoparInferior[41];
TermoparInferiorAux[42]:=TermoparInferior[42];
TermoparInferiorAux[43]:=TermoparInferior[43];
TermoparInferiorAux[44]:=TermoparInferior[44];
TermoparInferiorAux[45]:=TermoparInferior[45];
TermoparInferiorAux[46]:=TermoparInferior[46];
TermoparInferiorAux[47]:=TermoparInferior[47];
TermoparInferiorAux[48]:=TermoparInferior[48];
TermoparInferiorAux[49]:=TermoparInferior[49];
TermoparInferiorAux[50]:=TermoparInferior[50];


TermoparLogicoInferiorAux[1]:=TermoparLogicoInferior[1];
TermoparLogicoInferiorAux[2]:=TermoparLogicoInferior[2];
TermoparLogicoInferiorAux[3]:=TermoparLogicoInferior[3];
TermoparLogicoInferiorAux[4]:=TermoparLogicoInferior[4];
TermoparLogicoInferiorAux[5]:=TermoparLogicoInferior[5];
TermoparLogicoInferiorAux[6]:=TermoparLogicoInferior[6];
TermoparLogicoInferiorAux[7]:=TermoparLogicoInferior[7];
TermoparLogicoInferiorAux[8]:=TermoparLogicoInferior[8];
TermoparLogicoInferiorAux[9]:=TermoparLogicoInferior[9];
TermoparLogicoInferiorAux[10]:=TermoparLogicoInferior[10];
TermoparLogicoInferiorAux[11]:=TermoparLogicoInferior[11];
TermoparLogicoInferiorAux[12]:=TermoparLogicoInferior[12];
TermoparLogicoInferiorAux[13]:=TermoparLogicoInferior[13];
TermoparLogicoInferiorAux[14]:=TermoparLogicoInferior[14];
TermoparLogicoInferiorAux[15]:=TermoparLogicoInferior[15];
TermoparLogicoInferiorAux[16]:=TermoparLogicoInferior[16];
TermoparLogicoInferiorAux[17]:=TermoparLogicoInferior[17];
TermoparLogicoInferiorAux[18]:=TermoparLogicoInferior[18];
TermoparLogicoInferiorAux[19]:=TermoparLogicoInferior[19];
TermoparLogicoInferiorAux[20]:=TermoparLogicoInferior[20];
TermoparLogicoInferiorAux[21]:=TermoparLogicoInferior[21];
TermoparLogicoInferiorAux[22]:=TermoparLogicoInferior[22];
TermoparLogicoInferiorAux[23]:=TermoparLogicoInferior[23];
TermoparLogicoInferiorAux[24]:=TermoparLogicoInferior[24];
TermoparLogicoInferiorAux[25]:=TermoparLogicoInferior[25];
TermoparLogicoInferiorAux[26]:=TermoparLogicoInferior[26];
TermoparLogicoInferiorAux[27]:=TermoparLogicoInferior[27];
TermoparLogicoInferiorAux[28]:=TermoparLogicoInferior[28];
TermoparLogicoInferiorAux[29]:=TermoparLogicoInferior[29];
TermoparLogicoInferiorAux[30]:=TermoparLogicoInferior[30];
TermoparLogicoInferiorAux[31]:=TermoparLogicoInferior[31];
TermoparLogicoInferiorAux[32]:=TermoparLogicoInferior[32];
TermoparLogicoInferiorAux[33]:=TermoparLogicoInferior[33];
TermoparLogicoInferiorAux[34]:=TermoparLogicoInferior[34];
TermoparLogicoInferiorAux[35]:=TermoparLogicoInferior[35];
TermoparLogicoInferiorAux[36]:=TermoparLogicoInferior[36];
TermoparLogicoInferiorAux[37]:=TermoparLogicoInferior[37];
TermoparLogicoInferiorAux[38]:=TermoparLogicoInferior[38];
TermoparLogicoInferiorAux[39]:=TermoparLogicoInferior[39];
TermoparLogicoInferiorAux[40]:=TermoparLogicoInferior[40];
TermoparLogicoInferiorAux[41]:=TermoparLogicoInferior[41];
TermoparLogicoInferiorAux[42]:=TermoparLogicoInferior[42];
TermoparLogicoInferiorAux[43]:=TermoparLogicoInferior[43];
TermoparLogicoInferiorAux[44]:=TermoparLogicoInferior[44];
TermoparLogicoInferiorAux[45]:=TermoparLogicoInferior[45];
TermoparLogicoInferiorAux[46]:=TermoparLogicoInferior[46];
TermoparLogicoInferiorAux[47]:=TermoparLogicoInferior[47];
TermoparLogicoInferiorAux[48]:=TermoparLogicoInferior[48];
TermoparLogicoInferiorAux[49]:=TermoparLogicoInferior[49];
TermoparLogicoInferiorAux[50]:=TermoparLogicoInferior[50];

AlmTermoBitsSoma:=0;
AlmTermoSonBitsSoma:=0;
FOR Index:= 1 TO iNumResistencias DO
	// Alarme Termopar Aberto - Termopar Fisico 
	TermoAbertoInferiorFisico[Index](
		Termopar:= TermoparAbertoInferiorAux[Index], 
		ResetAlarm:= bResetAlmGeral, 
		TermoparAberto=> AlmTermoparAbertoInferior[Index], 
		AlarmeSonTermopar=> xAlarmeTermoparAbertoInferiorSon[Index]);
		
	TermoAbertoSuperiorFisico[Index](
		Termopar:= TermoparAbertoSuperior[Index], 
		ResetAlarm:= bResetAlmGeral, 
		TermoparAberto=> AlmTermoparAbertoSuperior[Index], 
		AlarmeSonTermopar=> xAlarmeTermoparAbertoSuperiorSon[Index]);
		
	// Alarme Termopar Aberto - Termopar Lógico
	TermoAbertoInferiorLogico[Index](
		Termopar:= TermoparAbertoLogicoInfAux[Index], 
		ResetAlarm:= bResetAlmGeral, 
		TermoparAberto=> AlmTermoparAbertoLogicoInf[Index], 
		AlarmeSonTermopar=> );
		
	TermoAbertoSuperiorLogico[Index](
		Termopar:= TermoparAbertoLogicoSup[Index], 
		ResetAlarm:= bResetAlmGeral, 
		TermoparAberto=> AlmTermoparAbertoLogicoSup[Index], 
		AlarmeSonTermopar=> );

	
	// Alarme Termopar Excesso de Temperatura - Termopar Fisico 	
	TemperaturaExcessoInferiorFisico[Index](
		TermoparAtual:= 	TermoparInferiorAux[Index], 
		TemperaturaMax:= 	7300, 
		ResetAlarm:= 		bResetAlmGeral, 
		TermoparAlmTemperatura=> AlmTemperaturaExcedeuInferior[Index], 
		AlarmeSonAlmTemperatura=> xAlarmeTemperaturaExcedeuInferiorSon[Index]);

	TemperaturaExcessoSuperiorFisico[Index](
		TermoparAtual:= 	TermoparSuperior[Index], 
		TemperaturaMax:= 	7300, 
		ResetAlarm:= 		bResetAlmGeral, 
		TermoparAlmTemperatura=> AlmTemperaturaExcedeuSuperior[Index], 
		AlarmeSonAlmTemperatura=> xAlarmeTemperaturaExcedeuSuperiorSon[Index]);
		
	// Alarme Termopar Excesso de Temperatura - Termopar Lógico	
	TemperaturaExcessoInferiorLogico[Index](
		TermoparAtual:= 	TermoparLogicoInferiorAux[Index], 
		TemperaturaMax:= 	7300, 
		ResetAlarm:= 		bResetAlmGeral, 
		TermoparAlmTemperatura=> AlmTemperaturaExcedeuLogicoInf[Index], 
		AlarmeSonAlmTemperatura=> );

	TemperaturaExcessoSuperiorLogico[Index](
		TermoparAtual:= 	TermoparLogicoSuperior[Index], 
		TemperaturaMax:= 	7300, 
		ResetAlarm:= 		bResetAlmGeral, 
		TermoparAlmTemperatura=> AlmTemperaturaExcedeuLogicoSup[Index], 
		AlarmeSonAlmTemperatura=> );
		
		AlmTermoBitsSoma:= AlmTermoBitsSoma+ BOOL_TO_INT (AlmTermoparAbertoInferior[Index])+ BOOL_TO_INT (AlmTermoparAbertoSuperior[Index])+ BOOL_TO_INT (AlmTemperaturaExcedeuInferior[Index])+ BOOL_TO_INT (AlmTemperaturaExcedeuSuperior[Index]);
	    AlmTermoSonBitsSoma:= AlmTermoSonBitsSoma+ BOOL_TO_INT (xAlarmeTermoparAbertoInferiorSon[Index])+ BOOL_TO_INT (xAlarmeTermoparAbertoSuperiorSon[Index])+ BOOL_TO_INT (xAlarmeTemperaturaExcedeuInferiorSon[Index])+ BOOL_TO_INT (xAlarmeTemperaturaExcedeuSuperiorSon[Index]);

END_FOR
xAlarmesTermopares:= AlmTermoBitsSoma>=1;
xAlarmesTermoparesSon:= AlmTermoSonBitsSoma>=1;

// Médias das Temperaturas 
//Inferiores
dSomaTempLogicasInferiores:=0;
FOR IndexSomaInf:=1 TO iNumResistencias DO
	dSomaTempLogicasInferiores:= dSomaTempLogicasInferiores + INT_TO_DINT (TermoparLogicoInferior[IndexSomaInf]);
END_FOR
rMediaLogiaTempInferior:= ((DINT_TO_REAL(dSomaTempLogicasInferiores))/10)/iNumResistencias;

//Superiores
dSomaTempLogicasSuperiores:=0;
FOR IndexSomaSup:=1 TO iNumResistencias DO
	dSomaTempLogicasSuperiores:= dSomaTempLogicasSuperiores + INT_TO_DINT (TermoparLogicoSuperior[IndexSomaSup]);
END_FOR
rMediaLogiaTempSuperior:= ((DINT_TO_REAL(dSomaTempLogicasSuperiores))/10)/iNumResistencias;

rMediaLogicaTemperaturaTotal:=(rMediaLogiaTempInferior+rMediaLogiaTempSuperior)/2;

// TERMOPAR CONVECCÇÃO ENTRADA

	TermoAbertoConveccaoEntrada(
		Termopar:= TermoparConvecEntAberto, 
		ResetAlarm:= bResetAlmGeral, 
		TermoparAberto=> xAlmTermoparAbertoConvecEntSin, 
		AlarmeSonTermopar=> xAlmTermoparAbertoConvecEntSon);

	TemperaturaExcessoConvecEntr(
		TermoparAtual:= 	TermoparConveccaoEnt, 
		TemperaturaMax:= 	7300, 
		ResetAlarm:= 		bResetAlmGeral, 
		TermoparAlmTemperatura=> xAlmTemperExcedeuConvecEntSin, 
		AlarmeSonAlmTemperatura=> xAlmTemperExcedeuConvecEntSon);
		
	// TERMOPAR CONVECCÇÃO SAÍDA

	TermoAbertoConveccaoSaida(
		Termopar:= TermoparConvecSaiAberto, 
		ResetAlarm:= bResetAlmGeral, 
		TermoparAberto=> xAlmTermoparAbertoConvecSaiSin, 
		AlarmeSonTermopar=> xAlmTermoparAbertoConvecSaiSon);

	TemperaturaExcessoConvecSai(
		TermoparAtual:= 	TermoparConveccaoSai, 
		TemperaturaMax:= 	7300, 
		ResetAlarm:= 		bResetAlmGeral, 
		TermoparAlmTemperatura=> xAlmTemperExcedeuConvecSaiSin, 
		AlarmeSonAlmTemperatura=> xAlmTemperExcedeuConvecSaiSon);
