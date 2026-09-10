__METADATA__
{
  "v3Meta": {
    "objectGuid": "be7c5095-453b-4f09-8bac-30ba29ea5f83",
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
PROGRAM B_RampaPatamar
VAR
	PassoRampaPat: INT;
	xIniciaRampa01: BOOL;
	xIniciaRampa02: BOOL;
	xIniciaRampa03: BOOL;
	xIniciaPatamar01: BOOL;
	xIniciaPatamar02: BOOL;
	xIniciaPatamar03: BOOL;
	xFimRampa01: BOOL;
	xFimRampa02: BOOL;
	xFimRampa03: BOOL;
	xFimPatamar01: BOOL;
	xFimPatamar02: BOOL;
	xFimPatamar03: BOOL;
	xFimRampaAquecimento: BOOL;
	rTempoTotalAquecimento: REAL;
	wStatusRampaAquecimento: WORD;
	rTempoFinalRampa01: REAL;
	rTempoFinalRampa02: REAL;
	rTempoFinalRampa03: REAL;
	rTempoFinalPatamar01: REAL;
	rTempoFinalPatamar02: REAL;
	rTempoFinalPatamar03: REAL;
	wStatusRampa01: WORD;
	wStatusRampa02: WORD;
	wStatusRampa03: WORD;
	wStatusPatamar01: WORD;
	wStatusPatamar02: WORD;
	wStatusPatamar03: WORD;
	///rHisterese01: REAL;
	///rHisterese02: REAL;
	///rHisterese03: REAL;
	/// Parametros de Entrada
	xIniciaAquecimentoRampa: BOOL;
	rTemperaturaPatamar01: REAL;
	rTemperaturaPatamar02: REAL;
	rTemperaturaPatamar03: REAL;
	rTempoPatamar01: REAL;
	rTempoPatamar02: REAL;
	rTempoPatamar03: REAL;
	rTempoTotalAquecimentoProgramado: REAL;
	///////////////////////////////////////////////////////////
	Index: INT;
	IndexR01: INT;
	IndexR02: INT;
	IndexR03: INT;
	IndexP01: INT;
	IndexP02: INT;
	IndexP03: INT;
	IndexT: INT;
	IndexTl: INT;
	TermoparRampa: ARRAY[1..100] OF INT;
	TermoparRampaInf: ARRAY[1..50] OF INT;
	TermoparRampaSup: ARRAY[1..50] OF INT;
	fbRampa01: ARRAY[1..100] OF Rampa;
	///fbRampa02: ARRAY [1..100] OF Rampa;	
	///fbRampa03: ARRAY [1..100] OF Rampa;
	fbPatamar01: ARRAY[1..100] OF Patamar;
	///fbPatamar02: ARRAY [1..100] OF Patamar;
	///fbPatamar03: ARRAY [1..100] OF Patamar;
	rTempoRampa01Decor: REAL;
	rTempoRampa02Decor: REAL;
	rTempoRampa03Decor: REAL;
	rTempoPatamar01Decor: REAL;
	rTempoPatamar02Decor: REAL;
	rTempoPatamar03Decor: REAL;
	rTempoRampa01Decorrido: REAL;
	rTempoRampa02Decorrido: REAL;
	rTempoRampa03Decorrido: REAL;
	rTempoPatamar01Decorrido: REAL;
	rTempoPatamar02Decorrido: REAL;
	rTempoPatamar03Decorrido: REAL;
	rTempoAquecimentoDecorrido: REAL;
	TempoRealRampa01: TON;
	TempoRealRampa01In: BOOL;
	TempoRealRampa01Pt: TIME;
	TempoRealRampa01Et: TIME;
	TempoRealRampa01Q: BOOL;
	TempoRealRampa02: TON;
	TempoRealRampa02In: BOOL;
	TempoRealRampa02Pt: TIME;
	TempoRealRampa02Et: TIME;
	TempoRealRampa02Q: BOOL;
	TempoRealRampa03: TON;
	TempoRealRampa03In: BOOL;
	TempoRealRampa03Pt: TIME;
	TempoRealRampa03Et: TIME;
	TempoRealRampa03Q: BOOL;
	TempoRealPatamar01: TON;
	TempoRealPatamar01In: BOOL;
	TempoRealPatamar01Pt: TIME;
	TempoRealPatamar01Et: TIME;
	TempoRealPatamar01Q: BOOL;
	TempoRealPatamar02: TON;
	TempoRealPatamar02In: BOOL;
	TempoRealPatamar02Pt: TIME;
	TempoRealPatamar02Et: TIME;
	TempoRealPatamar02Q: BOOL;
	TempoRealPatamar03: TON;
	TempoRealPatamar03In: BOOL;
	TempoRealPatamar03Pt: TIME;
	TempoRealPatamar03Et: TIME;
	TempoRealPatamar03Q: BOOL;
	xFimRampa001: ARRAY[1..100] OF BOOL;
	///xFimRampa002: ARRAY [1..100] OF BOOL;
	///xFimRampa003: ARRAY [1..100] OF BOOL;	
	xFimPatamar001: ARRAY[1..100] OF BOOL;
	///xFimPatamar002: ARRAY [1..100] OF BOOL;
	///xFimPatamar003: ARRAY [1..100] OF BOOL;	
	xIniciaRampa001: ARRAY[1..100] OF BOOL;
	///xIniciaRampa002: ARRAY [1..100] OF BOOL;
	///xIniciaRampa003: ARRAY [1..100] OF BOOL;
	xIniciaPatamar001: ARRAY[1..100] OF BOOL;
	///xIniciaPatamar002: ARRAY [1..100] OF BOOL;
	///xIniciaPatamar003: ARRAY [1..100] OF BOOL;
	xSaidaRampa01: ARRAY[1..100] OF BOOL;
	///xSaidaRampa02: ARRAY [1..100] OF BOOL;
	///xSaidaRampa03: ARRAY [1..100] OF BOOL;
	xSaidaPatamar01: ARRAY[1..100] OF BOOL;
	///xSaidaPatamar02: ARRAY [1..100] OF BOOL;
	///xSaidaPatamar03: ARRAY [1..100] OF BOOL;
	xSaidaReleRampPatam: ARRAY[1..100] OF BOOL;
	xFimRampa01Soma: INT;
	xFimRampa02Soma: INT;
	xFimRampa03Soma: INT;
	xFimPatamar01Soma: INT;
	xFimPatamar02Soma: INT;
	xFimPatamar03Soma: INT;
	Trp01: blink;
	xAlternaSetorRampa: BOOL;
	PulsoLigaResistencias: PulsoPositivo;
	xPulsoDataHoraProgOk: BOOL;
	rConsumoInicialAquec_kW: REAL;
	
	xDesligaRampaForno: BOOL;		
	xFornoEmRampa	: BOOL ;
END_VAR
__IMPLEMENTATION__
// Seleção do Tipo de Aquecimento Rampa/Patamar ou Receita

IF xBtSelAqueceRampaReceita THEN
	xAqueceRampaPatamar:=TRUE;
	xAqueceReceita:=FALSE;
	xBtSelAqueceRapidoLento:=FALSE;
ELSE
	xAqueceRampaPatamar:=FALSE;
	xAqueceReceita:=TRUE;
END_IF

IF xAqueceRampaPatamar THEN 
	uStatusSelAquecimento:=1;
END_IF
IF xAqueceReceita AND xAqueceRapido THEN 
	uStatusSelAquecimento:=2;
END_IF
IF xAqueceReceita AND xAqueceLento THEN 
	uStatusSelAquecimento:=3;
END_IF

// Ligamento pela Programação Horaria

PulsoLigaResistencias(Entrada:=xDataHoraProgOk , SaidaPulsoPo=>xPulsoDataHoraProgOk );

// Aquecimento por Rampa e Patamar


IF xBtLigaAquecimentoRampa THEN
	rTempoRampa03 := rRampaPrincipal;	
	xBtLigaResRampa:=TRUE;
	//xBtLigaAquecimentoRampa:=FALSE;
END_IF

IF xBtLigaAquecimentoRampa OR xPulsoDataHoraProgOk THEN
	xIniciaAquecimentoRampa:=TRUE;
	xBtLigaAquecimentoRampa:=FALSE;	
END_IF

IF rTempoRampa03<1800 THEN
	rTempoRampa03:=1800;
ELSE
	rTempoRampa03:=rTempoRampa03;
END_IF

// RAMPA PATAMAR GERAL

CASE PassoRampaPat OF
// Inicio Aquecimento	
	0:	IF xIniciaAquecimentoRampa THEN
			IndexR01:= 1;
			PassoRampaPat:=5;
		END_IF
// Rampa 01		
	5:	xIniciaAquecimentoRampa:=FALSE;
		xIniciaRelatorioAquecRampa:=TRUE;
		xResistenciasLigadas:=TRUE;
		xFornoEmRampa:=TRUE;
		xCmdIniciaCiclo:=TRUE;
		wStatusRampaAquecimento:=1;
		uStatusAquecimento:=1;// Aquecendo
		wStatusRampa01:=1;
		TempoRealRampa01Pt:=T#24H;
		TempoRealRampa01In:=TRUE;
		xIniciaRampa01:=TRUE;
		FOR IndexR01:= 1 TO iNumeroResistencias DO
			xIniciaRampa001[IndexR01]:=xIniciaRampa01;
		END_FOR
		rConsumoInicialAquec_kW:=rConsumoEnergiaReal_kWh;(*Ativo*)

		PassoRampaPat:=6;
		
		
	6:	xIniciaRampa01:=FALSE;
		IF xFimRampa01 THEN (* Fim da Rampa de todos os termopares *)
			PassoRampaPat:=7;
		END_IF
	
	7:	rTempoFinalRampa01:=rTempoRampa01Decor;
		wStatusRampa01:=2;
		PassoRampaPat:=8;
		
	8:	TempoRealRampa01In:=FALSE;
		PassoRampaPat:=9;
		
// Patamar 01
	9:	IndexP01:= 1;
		PassoRampaPat:=10;
		
	10:	xIniciaPatamar01:=TRUE;
		wStatusPatamar01:=1;
		TempoRealPatamar01Pt:=T#24H;
		TempoRealPatamar01In:=TRUE;
		FOR IndexP01:= 1 TO iNumeroResistencias DO
			xIniciaPatamar001[IndexP01]:=xIniciaPatamar01;
		END_FOR
		PassoRampaPat:=11;
		
	11:	xIniciaPatamar01:=FALSE;
		IF xFimPatamar01 THEN (* Fim Patamar 01*)
			PassoRampaPat:=12;
		END_IF

	12:	rTempoFinalPatamar01:=rTempoPatamar01Decor;
		wStatusPatamar01:=2;
		PassoRampaPat:=13;
		
	13:	TempoRealPatamar01In:=FALSE;
		PassoRampaPat:=34;//14;		
(*	
// Rampa 02
	14:	IndexR02:= 1;
		PassoRampaPat:=15;	

	15:	xIniciaRampa02:=TRUE;
		wStatusRampa02:=1;
		TempoRealRampa02Pt:=T#24H;
		TempoRealRampa02In:=TRUE;
		FOR IndexR02:= 1 TO iNumeroResistencias DO
			xIniciaRampa002[IndexR02]:=xIniciaRampa02;
		END_FOR
		PassoRampaPat:=16;

	16: xIniciaRampa02:=FALSE;
		IF xFimRampa02 THEN
			PassoRampaPat:=17;
		END_IF

	17:	rTempoFinalRampa02:=rTempoRampa02Decor;
		wStatusRampa02:=2;
		PassoRampaPat:=18;
		
	18:	TempoRealRampa02In:=FALSE;
		PassoRampaPat:=19;

// Patamar 02
	19:	IndexP02:= 1;
		PassoRampaPat:=20;

	20:	xIniciaPatamar02:=TRUE;
		wStatusPatamar02:=1;
		TempoRealPatamar02Pt:=T#24H;
		TempoRealPatamar02In:=TRUE;
		FOR IndexP02:= 1 TO iNumeroResistencias DO
			xIniciaPatamar002[IndexP02]:=xIniciaPatamar02;
		END_FOR
		PassoRampaPat:=21;

	21:	xIniciaPatamar02:=FALSE;
		IF xFimPatamar02 THEN
			PassoRampaPat:=22;
		END_IF

	22:	rTempoFinalPatamar02:=rTempoPatamar02Decor;
		wStatusPatamar02:=2;
		PassoRampaPat:=23;
		
	23:	TempoRealPatamar02In:=FALSE;
		PassoRampaPat:=25;			
		
// Rampa 03		
	24:	IndexR03:= 1;
		PassoRampaPat:=25;
	
	25:	xIniciaRampa03:=TRUE;
		wStatusRampa03:=1;
		TempoRealRampa03Pt:=T#24H;
		TempoRealRampa03In:=TRUE;
		FOR IndexR03:= 1 TO iNumeroResistencias DO
			xIniciaRampa003[IndexR03]:=xIniciaRampa03;
		END_FOR
		PassoRampaPat:=26;

	26:	xIniciaRampa03:=FALSE;
		IF xFimRampa03 THEN
			PassoRampaPat:=27;
		END_IF
			
	27:	rTempoFinalRampa03:=rTempoRampa03Decor;
		wStatusRampa03:=2;
		PassoRampaPat:=28;
		
	28:	TempoRealRampa03In:=FALSE;
		PassoRampaPat:=29;

// Patamar 03
	29: IndexP03:= 1;
		PassoRampaPat:=30;
	
	30:	xIniciaPatamar03:=TRUE;
		wStatusPatamar03:=1;
		TempoRealPatamar03Pt:=T#24H;
		TempoRealPatamar03In:=TRUE;
		FOR IndexP03:= 1 TO iNumeroResistencias DO
			xIniciaPatamar001[IndexP03]:=xIniciaPatamar01;
		END_FOR
		PassoRampaPat:=31;

	31:	xIniciaPatamar03:=FALSE;
		IF xFimPatamar03 THEN
			PassoRampaPat:=32;
		END_IF

	32:	rTempoFinalPatamar03:=rTempoPatamar03Decor;
		wStatusPatamar03:=2;
		PassoRampaPat:=33;
		
	33:	TempoRealPatamar03In:=FALSE;
		PassoRampaPat:=34;*)			

// Fim Aquecimento
	34:	xFornoEmRampa:=FALSE;
		xFinalizaRelatorioAquecRampa:=TRUE;
		PassoRampaPat:=35;
		
	35:	xFimRampaAquecimento:=TRUE;
		xFimAquecimento:=TRUE;
		LigaInfPorAquecimentoRampa:=FALSE; // inclusão 19/08/2020
		LigaSupPorAquecimentoRampa:=FALSE; // inclusão 19/08/2020
		rTempoTotalAquecimento:=rTempoAquecimentoDecorrido;
		wStatusRampaAquecimento:=2;//QUENTE
		uStatusAquecimento:=2;
		//PassoRampaPat:=0;
	
END_CASE

//Consumo de Energia por Aquecimento
rConsumoAquecRel:= rConsumoEnergiaReal_kWh-rConsumoInicialAquec_kW;


TempoRealRampa01(IN:=TempoRealRampa01In , PT:=TempoRealRampa01Pt , Q=> TempoRealRampa01Q, ET=>TempoRealRampa01Et );
//TempoRealRampa02(IN:=TempoRealRampa02In , PT:=TempoRealRampa02Pt , Q=> TempoRealRampa02Q, ET=>TempoRealRampa02Et );
//TempoRealRampa03(IN:=TempoRealRampa03In , PT:=TempoRealRampa03Pt , Q=> TempoRealRampa03Q, ET=>TempoRealRampa03Et );
rTempoRampa01Decor:=(TIME_TO_REAL(TempoRealRampa01Et))/1000;
//rTempoRampa02Decor:=(TIME_TO_REAL(TempoRealRampa02Et))/1000;
//rTempoRampa03Decor:=(TIME_TO_REAL(TempoRealRampa03Et))/1000;
rTempoRampa01Decorrido:=rTempoRampa01Decor+(rTempoFinalRampa01);
//rTempoRampa02Decorrido:=rTempoRampa02Decor+(rTempoFinalRampa02);
//rTempoRampa03Decorrido:=rTempoRampa03Decor+(rTempoFinalRampa03);

TempoRealPatamar01(IN:=TempoRealPatamar01In , PT:=TempoRealPatamar01Pt , Q=> TempoRealPatamar01Q, ET=>TempoRealPatamar01Et );
//TempoRealPatamar02(IN:=TempoRealPatamar02In , PT:=TempoRealPatamar02Pt , Q=> TempoRealPatamar02Q, ET=>TempoRealPatamar02Et );
//TempoRealPatamar03(IN:=TempoRealPatamar03In , PT:=TempoRealPatamar03Pt , Q=> TempoRealPatamar03Q, ET=>TempoRealPatamar03Et );
rTempoPatamar01Decor:=(TIME_TO_REAL(TempoRealPatamar01Et))/1000;
//rTempoPatamar02Decor:=(TIME_TO_REAL(TempoRealPatamar02Et))/1000;
//rTempoPatamar03Decor:=(TIME_TO_REAL(TempoRealPatamar03Et))/1000;
rTempoPatamar01Decorrido:=rTempoPatamar01Decor+(rTempoFinalPatamar01);
//rTempoPatamar02Decorrido:=rTempoPatamar02Decor+(rTempoFinalPatamar02);
//rTempoPatamar03Decorrido:=rTempoPatamar03Decor+(rTempoFinalPatamar03);

rTempoAquecimentoDecorrido:=rTempoRampa01Decorrido+rTempoPatamar01Decorrido+rTempoRampa02Decorrido+rTempoPatamar02Decorrido+rTempoRampa03Decorrido+rTempoPatamar03Decorrido;
rTempoTotalAquecimentoProgramado:=rTempoRampa01+rTempoRampa02+rTempoRampa03+rTempoPatamar01+rTempoPatamar02+rTempoPatamar03;


xFimRampa01Soma:=0;
xFimRampa02Soma:=0;
xFimRampa03Soma:=0;
xFimPatamar01Soma:=0;
xFimPatamar02Soma:=0;
xFimPatamar03Soma:=0;

// Artificio para adaptar a Rampa de Aquecimento ao Forno Com diferença no numero de setores Inferior e Superior
TermoparRampaInf[1]:=TermoparLogicoInferior[1];
TermoparRampaInf[2]:=TermoparLogicoInferior[2];
TermoparRampaInf[3]:=TermoparLogicoInferior[3];
TermoparRampaInf[4]:=TermoparLogicoInferior[4];
TermoparRampaInf[5]:=TermoparLogicoInferior[5];
TermoparRampaInf[6]:=TermoparLogicoInferior[6];
TermoparRampaInf[7]:=TermoparLogicoInferior[7];
TermoparRampaInf[8]:=TermoparLogicoInferior[8];
TermoparRampaInf[9]:=TermoparLogicoInferior[9];
TermoparRampaInf[10]:=TermoparLogicoInferior[10];
TermoparRampaInf[11]:=TermoparLogicoInferior[11];
TermoparRampaInf[12]:=TermoparLogicoInferior[12];
TermoparRampaInf[13]:=TermoparLogicoInferior[13];
TermoparRampaInf[14]:=TermoparLogicoInferior[14];
TermoparRampaInf[15]:=TermoparLogicoInferior[15];
TermoparRampaInf[16]:=TermoparLogicoInferior[16];
TermoparRampaInf[17]:=TermoparLogicoInferior[17];
TermoparRampaInf[18]:=TermoparLogicoInferior[18];
TermoparRampaInf[19]:=TermoparLogicoInferior[19];
TermoparRampaInf[20]:=TermoparLogicoInferior[20];
TermoparRampaInf[21]:=TermoparLogicoInferior[21];
TermoparRampaInf[22]:=TermoparLogicoInferior[22];
TermoparRampaInf[23]:=TermoparLogicoInferior[23];
TermoparRampaInf[24]:=TermoparLogicoInferior[24];
TermoparRampaInf[25]:=TermoparLogicoInferior[25];
TermoparRampaInf[26]:=TermoparLogicoInferior[26];
TermoparRampaInf[27]:=TermoparLogicoInferior[27];
TermoparRampaInf[28]:=TermoparLogicoInferior[28];
TermoparRampaInf[29]:=TermoparLogicoInferior[29];
TermoparRampaInf[30]:=TermoparLogicoInferior[30];
TermoparRampaInf[31]:=TermoparLogicoInferior[31];
TermoparRampaInf[32]:=TermoparLogicoInferior[32];
TermoparRampaInf[33]:=TermoparLogicoInferior[33];
TermoparRampaInf[34]:=TermoparLogicoInferior[34];
TermoparRampaInf[35]:=TermoparLogicoInferior[35];
TermoparRampaInf[36]:=TermoparLogicoInferior[36];
TermoparRampaInf[37]:=TermoparLogicoInferior[37];
TermoparRampaInf[38]:=TermoparLogicoInferior[38];
TermoparRampaInf[39]:=TermoparLogicoInferior[39];
TermoparRampaInf[40]:=TermoparLogicoInferior[40];
TermoparRampaInf[41]:=TermoparLogicoInferior[41];
TermoparRampaInf[42]:=TermoparLogicoInferior[42];
TermoparRampaInf[43]:=TermoparLogicoInferior[43];
TermoparRampaInf[44]:=TermoparLogicoInferior[44];
TermoparRampaInf[45]:=TermoparLogicoInferior[45];
TermoparRampaInf[46]:=TermoparLogicoInferior[46];
TermoparRampaInf[47]:=TermoparLogicoInferior[47];
TermoparRampaInf[48]:=TermoparLogicoInferior[48];
TermoparRampaInf[49]:=TermoparLogicoInferior[49];
TermoparRampaInf[50]:=TermoparLogicoInferior[50];

TermoparRampaSup[1]:=TermoparLogicoSuperior[1];
TermoparRampaSup[2]:=TermoparLogicoSuperior[2];
TermoparRampaSup[3]:=TermoparLogicoSuperior[3];
TermoparRampaSup[4]:=TermoparLogicoSuperior[4];
TermoparRampaSup[5]:=TermoparLogicoSuperior[5];
TermoparRampaSup[6]:=TermoparLogicoSuperior[6];
TermoparRampaSup[7]:=TermoparLogicoSuperior[7];
TermoparRampaSup[8]:=TermoparLogicoSuperior[8];
TermoparRampaSup[9]:=TermoparLogicoSuperior[9];
TermoparRampaSup[10]:=TermoparLogicoSuperior[10];
TermoparRampaSup[11]:=TermoparLogicoSuperior[11];
TermoparRampaSup[12]:=TermoparLogicoSuperior[12];
TermoparRampaSup[13]:=TermoparLogicoSuperior[13];
TermoparRampaSup[14]:=TermoparLogicoSuperior[14];
TermoparRampaSup[15]:=TermoparLogicoSuperior[15];
TermoparRampaSup[16]:=TermoparLogicoSuperior[16];
TermoparRampaSup[17]:=TermoparLogicoSuperior[17];
TermoparRampaSup[18]:=TermoparLogicoSuperior[18];
TermoparRampaSup[19]:=TermoparLogicoSuperior[19];
TermoparRampaSup[20]:=TermoparLogicoSuperior[20];
TermoparRampaSup[21]:=TermoparLogicoSuperior[21];
TermoparRampaSup[22]:=TermoparLogicoSuperior[22];
TermoparRampaSup[23]:=TermoparLogicoSuperior[23];
TermoparRampaSup[24]:=TermoparLogicoSuperior[24];
TermoparRampaSup[25]:=TermoparLogicoSuperior[25];
TermoparRampaSup[26]:=TermoparLogicoSuperior[26];
TermoparRampaSup[27]:=TermoparLogicoSuperior[27];
TermoparRampaSup[28]:=TermoparLogicoSuperior[28];
TermoparRampaSup[29]:=TermoparLogicoSuperior[29];
TermoparRampaSup[30]:=TermoparLogicoSuperior[30];
TermoparRampaSup[31]:=TermoparLogicoSuperior[31];
TermoparRampaSup[32]:=TermoparLogicoSuperior[32];
TermoparRampaSup[33]:=TermoparLogicoSuperior[33];
TermoparRampaSup[34]:=TermoparLogicoSuperior[34];
TermoparRampaSup[35]:=TermoparLogicoSuperior[35];
TermoparRampaSup[36]:=TermoparLogicoSuperior[36];
TermoparRampaSup[37]:=TermoparLogicoSuperior[37];
TermoparRampaSup[38]:=TermoparLogicoSuperior[38];
TermoparRampaSup[39]:=TermoparLogicoSuperior[39];
TermoparRampaSup[40]:=TermoparLogicoSuperior[40];
TermoparRampaSup[41]:=TermoparLogicoSuperior[41];
TermoparRampaSup[42]:=TermoparLogicoSuperior[42];
TermoparRampaSup[43]:=TermoparLogicoSuperior[43];
TermoparRampaSup[44]:=TermoparLogicoSuperior[44];
TermoparRampaSup[45]:=TermoparLogicoSuperior[45];
TermoparRampaSup[46]:=TermoparLogicoSuperior[46];
TermoparRampaSup[47]:=TermoparLogicoSuperior[47];
TermoparRampaSup[48]:=TermoparLogicoSuperior[48];
TermoparRampaSup[49]:=TermoparLogicoSuperior[49];
TermoparRampaSup[50]:=TermoparLogicoSuperior[50];

//--------------------------------------------------------------------------------------------------------------
FOR IndexT:= 1 TO iNumResistencias DO
	TermoparRampa[IndexT]:=TermoparRampaInf[IndexT];
	TermoparRampa[IndexT+iNumResistencias]:=TermoparRampaSup[IndexT];
END_FOR

FOR Index:= 1 TO iNumeroResistencias DO

// Rampa 01

	xIniciaRampa001[Index]:=xIniciaRampa01;

fbRampa01[Index](
	rTemopar:= 		(INT_TO_REAL(TermoparRampa[Index]))/10, 
	rTempMedia:=	rMediaLogicaTemperaturaTotal,
	rPatamar:= 		rSetTemperaturaRampa,//0,
	rTempoRampa:= 	rTempoRampa03,//1, 
	xDesabilitaZn:= NOT xResistenciaHabilitada[Index],
	xFimTotRampa:= 	xFimRampa01,
	xIniciaRampa:= 	xIniciaRampa001[Index], 
	xFimRampa:= 	xFimRampa001[Index], 
	xResetBloco:= 	xDesligaRampaForno, 
	xSaida=> 		xSaidaRampa01[Index] );

xFimRampa01Soma:= xFimRampa01Soma+ BOOL_TO_INT (xFimRampa001[Index]);

// Patamar 01
	xIniciaPatamar001[Index]:=xIniciaPatamar01;
	
fbPatamar01[Index](
	rTemopar:= 		(INT_TO_REAL(TermoparRampa[Index]))/10, 
	rPatamar:= 		rSetTemperaturaRampa,//0,
	rHisterese:= 	0.1, 
	rTempoPatamar:= 1,
	xDesabilitaZn:= NOT xResistenciaHabilitada[Index], 
	xIniciaPatamar:= xIniciaPatamar001[Index], 
	xFimPatamar:= 	xFimPatamar001[Index], 
	xResetBloco:= 	xDesligaRampaForno, 
	xSaida=> 		xSaidaPatamar01[Index]);
	
xFimPatamar01Soma:= xFimPatamar01Soma+ BOOL_TO_INT (xFimPatamar001[Index]);	
(*
// Rampa 02
	xIniciaRampa002[Index]:=xIniciaRampa02;

fbRampa02[Index](
	rTemopar:= 		(INT_TO_REAL(TermoparRampa[Index]))/10, 
	rTempMedia:=	rMediaLogicaTemperaturaTotal,
	rPatamar:= 		0,
	rTempoRampa:= 	1,
	xDesabilitaZn:= NOT xResistenciaHabilitada[Index], 
	xFimTotRampa:=  xFimRampa02,
	xIniciaRampa:= 	xIniciaRampa002[Index], 
	xFimRampa:= 	xFimRampa002[Index], 
	xResetBloco:= 	xBtDesligaAquecimento, 
	xSaida=> 		xSaidaRampa02[Index] );

xFimRampa02Soma:= xFimRampa02Soma+ BOOL_TO_INT (xFimRampa002[Index]);

// Patamar 02

	xIniciaPatamar002[Index]:=xIniciaPatamar02;
	
fbPatamar02[Index](
	rTemopar:= 		(INT_TO_REAL(TermoparRampa[Index]))/10, 
	rPatamar:= 		0,
	rHisterese:= 	0.1, 
	rTempoPatamar:= 1,
	xDesabilitaZn:= NOT xResistenciaHabilitada[Index], 
	xIniciaPatamar:= xIniciaPatamar002[Index], 
	xFimPatamar:= 	xFimPatamar002[Index], 
	xResetBloco:= 	xBtDesligaAquecimento, 
	xSaida=> 		xSaidaPatamar02[Index]);
	
xFimPatamar02Soma:= xFimPatamar02Soma+ BOOL_TO_INT (xFimPatamar002[Index]);	

// Rampa 03
	xIniciaRampa003[Index]:=xIniciaRampa03;

fbRampa03[Index](
	rTemopar:= 		(INT_TO_REAL(TermoparRampa[Index]))/10, 
	rTempMedia:=	rMediaLogicaTemperaturaTotal,
	rPatamar:= 		rSetTemperaturaInferiorGeral,
	rTempoRampa:= 	rTempoRampa03, 
	xDesabilitaZn:= NOT xResistenciaHabilitada[Index], 
	xFimTotRampa:=  xFimRampa03,
	xIniciaRampa:= 	xIniciaRampa003[Index], 
	xFimRampa:= 	xFimRampa003[Index], 
	xResetBloco:= 	xBtDesligaAquecimento, 
	xSaida=> 		xSaidaRampa03[Index] );

xFimRampa03Soma:= xFimRampa03Soma+ BOOL_TO_INT (xFimRampa003[Index]);

// Patamar 03

	xIniciaPatamar003[Index]:=xIniciaPatamar03;
	
fbPatamar03[Index](
	rTemopar:= 		(INT_TO_REAL(TermoparRampa[Index]))/10, 
	rPatamar:= 		rSetTemperaturaInferiorGeral,
	rHisterese:= 	0.1, 
	rTempoPatamar:= 1,//rTempoPatamar03, 
	xDesabilitaZn:= NOT xResistenciaHabilitada[Index], 
	xIniciaPatamar:= xIniciaPatamar003[Index], 
	xFimPatamar:= 	xFimPatamar003[Index], 
	xResetBloco:= 	xBtDesligaAquecimento, 
	xSaida=> 		xSaidaPatamar03[Index]);
	
xFimPatamar03Soma:= xFimPatamar03Soma+ BOOL_TO_INT (xFimPatamar003[Index]);	
*)
xSaidaReleRampPatam[Index]:=xSaidaRampa01[Index] (*OR xSaidaRampa02[Index] OR xSaidaRampa03[Index]*) OR xSaidaPatamar01[Index] (*OR xSaidaPatamar02[Index] OR xSaidaPatamar03[Index]*);

END_FOR

xFimRampa01:= xFimRampa01Soma=iNumeroResistencias;
//xFimRampa02:= xFimRampa02Soma=iNumeroResistencias;
//xFimRampa03:= xFimRampa03Soma=iNumeroResistencias;
xFimPatamar01:= xFimPatamar01Soma=iNumeroResistencias;
//xFimPatamar02:= xFimPatamar02Soma=iNumeroResistencias;
//xFimPatamar03:= xFimPatamar03Soma=iNumeroResistencias;

//Fim da Rampa de Aquecimento

xDesligaRampaForno:=xBtDesligaAquecimento  OR xSemEnergia OR xOperacaoManual OR xTempoDesligaResistQ OR xBtEmergencia;
IF xDesligaRampaForno AND xFornoEmRampa THEN
	xFinalizaRelatorioAquecRampa:=TRUE;
END_IF

IF xDesligaRampaForno THEN
	    xIniciaAquecimentoRampa:=FALSE;
		xFimRampaAquecimento:=FALSE;
		xIniciaRampa01:=FALSE;
		TempoRealRampa01In:=FALSE;
		TempoRealRampa02In:=FALSE;
		TempoRealRampa03In:=FALSE;
		TempoRealPatamar01In:=FALSE;
		TempoRealPatamar02In:=FALSE;
		TempoRealPatamar03In:=FALSE;
		rTempoTotalAquecimento:=0;
		rTempoFinalRampa01:=0;
		rTempoFinalRampa02:=0;
		rTempoFinalRampa03:=0;
		rTempoFinalPatamar01:=0;
		rTempoFinalPatamar02:=0;
		rTempoFinalPatamar03:=0;
		wStatusRampaAquecimento:=0;
		wStatusRampa01:=0;
		wStatusRampa02:=0;
		wStatusRampa03:=0;
		wStatusPatamar01:=0;
		wStatusPatamar02:=0;
		wStatusPatamar03:=0;
		PassoRampaPat:=0;
		xFornoEmRampa:=FALSE;
		xBtLigaAquecimento:=FALSE;
END_IF

LigaInfPorAquecimentoRampa:=xFimRampaAquecimento;
LigaSupPorAquecimentoRampa:=xFimRampaAquecimento;



// Tempo de Alternancia entre Zonas
Trp01(ENABLE:= TRUE, TIMELOW:= T#1S, TIMEHIGH:= T#1S, OUT=> xAlternaSetorRampa );

xSaidaReleRampaPatamarInf[1]:= xSaidaReleRampPatam[1] AND xResistenciaHabilitadaInferior[1] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[2]:= xSaidaReleRampPatam[2] AND xResistenciaHabilitadaInferior[2] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[3]:= xSaidaReleRampPatam[3] AND xResistenciaHabilitadaInferior[3] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[4]:= xSaidaReleRampPatam[4] AND xResistenciaHabilitadaInferior[4] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[5]:= xSaidaReleRampPatam[5] AND xResistenciaHabilitadaInferior[5] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[6]:= xSaidaReleRampPatam[6] AND xResistenciaHabilitadaInferior[6] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[7]:= xSaidaReleRampPatam[7] AND xResistenciaHabilitadaInferior[7] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[8]:= xSaidaReleRampPatam[8] AND xResistenciaHabilitadaInferior[8] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[9]:= xSaidaReleRampPatam[9] AND xResistenciaHabilitadaInferior[9] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[10]:= xSaidaReleRampPatam[10] AND xResistenciaHabilitadaInferior[10] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[11]:= xSaidaReleRampPatam[11] AND xResistenciaHabilitadaInferior[11] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[12]:= xSaidaReleRampPatam[12] AND xResistenciaHabilitadaInferior[12] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[13]:= xSaidaReleRampPatam[13] AND xResistenciaHabilitadaInferior[13] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[14]:= xSaidaReleRampPatam[14] AND xResistenciaHabilitadaInferior[14] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[15]:= xSaidaReleRampPatam[15] AND xResistenciaHabilitadaInferior[15] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[16]:= xSaidaReleRampPatam[16] AND xResistenciaHabilitadaInferior[16] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[17]:= xSaidaReleRampPatam[17] AND xResistenciaHabilitadaInferior[17] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[18]:= xSaidaReleRampPatam[18] AND xResistenciaHabilitadaInferior[18] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[19]:= xSaidaReleRampPatam[19] AND xResistenciaHabilitadaInferior[19] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[20]:= xSaidaReleRampPatam[20] AND xResistenciaHabilitadaInferior[20] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[21]:= xSaidaReleRampPatam[21] AND xResistenciaHabilitadaInferior[21] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[22]:= xSaidaReleRampPatam[22] AND xResistenciaHabilitadaInferior[22] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[23]:= xSaidaReleRampPatam[23] AND xResistenciaHabilitadaInferior[23] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[24]:= xSaidaReleRampPatam[24] AND xResistenciaHabilitadaInferior[24] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[25]:= xSaidaReleRampPatam[25] AND xResistenciaHabilitadaInferior[25] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[26]:= xSaidaReleRampPatam[26] AND xResistenciaHabilitadaInferior[26] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[27]:= xSaidaReleRampPatam[27] AND xResistenciaHabilitadaInferior[27] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[28]:= xSaidaReleRampPatam[28] AND xResistenciaHabilitadaInferior[28] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[29]:= xSaidaReleRampPatam[29] AND xResistenciaHabilitadaInferior[29] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[30]:= xSaidaReleRampPatam[30] AND xResistenciaHabilitadaInferior[30] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[31]:= xSaidaReleRampPatam[31] AND xResistenciaHabilitadaInferior[31] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[32]:= xSaidaReleRampPatam[32] AND xResistenciaHabilitadaInferior[32] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[33]:= xSaidaReleRampPatam[33] AND xResistenciaHabilitadaInferior[33] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[34]:= xSaidaReleRampPatam[34] AND xResistenciaHabilitadaInferior[34] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[35]:= xSaidaReleRampPatam[35] AND xResistenciaHabilitadaInferior[35] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[36]:= xSaidaReleRampPatam[36] AND xResistenciaHabilitadaInferior[36] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[37]:= xSaidaReleRampPatam[37] AND xResistenciaHabilitadaInferior[37] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[38]:= xSaidaReleRampPatam[38] AND xResistenciaHabilitadaInferior[38] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[39]:= xSaidaReleRampPatam[39] AND xResistenciaHabilitadaInferior[39] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[40]:= xSaidaReleRampPatam[40] AND xResistenciaHabilitadaInferior[40] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[41]:= xSaidaReleRampPatam[41] AND xResistenciaHabilitadaInferior[41] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[42]:= xSaidaReleRampPatam[42] AND xResistenciaHabilitadaInferior[42] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[43]:= xSaidaReleRampPatam[43] AND xResistenciaHabilitadaInferior[43] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[44]:= xSaidaReleRampPatam[44] AND xResistenciaHabilitadaInferior[44] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[45]:= xSaidaReleRampPatam[45] AND xResistenciaHabilitadaInferior[45] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[46]:= xSaidaReleRampPatam[46] AND xResistenciaHabilitadaInferior[46] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[47]:= xSaidaReleRampPatam[47] AND xResistenciaHabilitadaInferior[47] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[48]:= xSaidaReleRampPatam[48] AND xResistenciaHabilitadaInferior[48] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[49]:= xSaidaReleRampPatam[49] AND xResistenciaHabilitadaInferior[49] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarInf[50]:= xSaidaReleRampPatam[50] AND xResistenciaHabilitadaInferior[50] AND NOT xAlternaSetorRampa;

xSaidaReleRampaPatamarSup[1]:= xSaidaReleRampPatam[1+iNumResistencias] AND xResistenciaHabilitadaSuperior[1] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[2]:= xSaidaReleRampPatam[2+iNumResistencias] AND xResistenciaHabilitadaSuperior[2] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[3]:= xSaidaReleRampPatam[3+iNumResistencias] AND xResistenciaHabilitadaSuperior[3] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[4]:= xSaidaReleRampPatam[4+iNumResistencias] AND xResistenciaHabilitadaSuperior[4] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[5]:= xSaidaReleRampPatam[5+iNumResistencias] AND xResistenciaHabilitadaSuperior[5] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[6]:= xSaidaReleRampPatam[6+iNumResistencias] AND xResistenciaHabilitadaSuperior[6] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[7]:= xSaidaReleRampPatam[7+iNumResistencias] AND xResistenciaHabilitadaSuperior[7] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[8]:= xSaidaReleRampPatam[8+iNumResistencias] AND xResistenciaHabilitadaSuperior[8] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[9]:= xSaidaReleRampPatam[9+iNumResistencias] AND xResistenciaHabilitadaSuperior[9] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[10]:= xSaidaReleRampPatam[10+iNumResistencias] AND xResistenciaHabilitadaSuperior[10] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[11]:= xSaidaReleRampPatam[11+iNumResistencias] AND xResistenciaHabilitadaSuperior[11] AND xALternaSetorRampa;
xSaidaReleRampaPatamarSup[12]:= xSaidaReleRampPatam[12+iNumResistencias] AND xResistenciaHabilitadaSuperior[12] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[13]:= xSaidaReleRampPatam[13+iNumResistencias] AND xResistenciaHabilitadaSuperior[13] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[14]:= xSaidaReleRampPatam[14+iNumResistencias] AND xResistenciaHabilitadaSuperior[14] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[15]:= xSaidaReleRampPatam[15+iNumResistencias] AND xResistenciaHabilitadaSuperior[15] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[16]:= xSaidaReleRampPatam[16+iNumResistencias] AND xResistenciaHabilitadaSuperior[16] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[17]:= xSaidaReleRampPatam[17+iNumResistencias] AND xResistenciaHabilitadaSuperior[17] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[18]:= xSaidaReleRampPatam[18+iNumResistencias] AND xResistenciaHabilitadaSuperior[18] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[19]:= xSaidaReleRampPatam[19+iNumResistencias] AND xResistenciaHabilitadaSuperior[19] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[20]:= xSaidaReleRampPatam[20+iNumResistencias] AND xResistenciaHabilitadaSuperior[20] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[21]:= xSaidaReleRampPatam[21+iNumResistencias] AND xResistenciaHabilitadaSuperior[21] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[22]:= xSaidaReleRampPatam[22+iNumResistencias] AND xResistenciaHabilitadaSuperior[22] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[23]:= xSaidaReleRampPatam[23+iNumResistencias] AND xResistenciaHabilitadaSuperior[23] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[24]:= xSaidaReleRampPatam[24+iNumResistencias] AND xResistenciaHabilitadaSuperior[24] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[25]:= xSaidaReleRampPatam[25+iNumResistencias] AND xResistenciaHabilitadaSuperior[25] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[26]:= xSaidaReleRampPatam[26+iNumResistencias] AND xResistenciaHabilitadaSuperior[26] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[27]:= xSaidaReleRampPatam[27+iNumResistencias] AND xResistenciaHabilitadaSuperior[27] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[28]:= xSaidaReleRampPatam[28+iNumResistencias] AND xResistenciaHabilitadaSuperior[28] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[29]:= xSaidaReleRampPatam[29+iNumResistencias] AND xResistenciaHabilitadaSuperior[29] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[30]:= xSaidaReleRampPatam[30+iNumResistencias] AND xResistenciaHabilitadaSuperior[30] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[31]:= xSaidaReleRampPatam[31+iNumResistencias] AND xResistenciaHabilitadaSuperior[31] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[32]:= xSaidaReleRampPatam[32+iNumResistencias] AND xResistenciaHabilitadaSuperior[32] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[33]:= xSaidaReleRampPatam[33+iNumResistencias] AND xResistenciaHabilitadaSuperior[33] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[34]:= xSaidaReleRampPatam[34+iNumResistencias] AND xResistenciaHabilitadaSuperior[34] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[35]:= xSaidaReleRampPatam[35+iNumResistencias] AND xResistenciaHabilitadaSuperior[35] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[36]:= xSaidaReleRampPatam[36+iNumResistencias] AND xResistenciaHabilitadaSuperior[36] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[37]:= xSaidaReleRampPatam[37+iNumResistencias] AND xResistenciaHabilitadaSuperior[37] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[38]:= xSaidaReleRampPatam[38+iNumResistencias] AND xResistenciaHabilitadaSuperior[38] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[39]:= xSaidaReleRampPatam[39+iNumResistencias] AND xResistenciaHabilitadaSuperior[39] AND  xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[40]:= xSaidaReleRampPatam[40+iNumResistencias] AND xResistenciaHabilitadaSuperior[40] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[41]:= xSaidaReleRampPatam[41+iNumResistencias] AND xResistenciaHabilitadaSuperior[41] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[42]:= xSaidaReleRampPatam[42+iNumResistencias] AND xResistenciaHabilitadaSuperior[42] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[43]:= xSaidaReleRampPatam[43+iNumResistencias] AND xResistenciaHabilitadaSuperior[43] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[44]:= xSaidaReleRampPatam[44+iNumResistencias] AND xResistenciaHabilitadaSuperior[44] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[45]:= xSaidaReleRampPatam[45+iNumResistencias] AND xResistenciaHabilitadaSuperior[45] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[46]:= xSaidaReleRampPatam[46+iNumResistencias] AND xResistenciaHabilitadaSuperior[46] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[47]:= xSaidaReleRampPatam[47+iNumResistencias] AND xResistenciaHabilitadaSuperior[47] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[48]:= xSaidaReleRampPatam[48+iNumResistencias] AND xResistenciaHabilitadaSuperior[48] AND xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[49]:= xSaidaReleRampPatam[49+iNumResistencias] AND xResistenciaHabilitadaSuperior[49] AND NOT xAlternaSetorRampa;
xSaidaReleRampaPatamarSup[50]:= xSaidaReleRampPatam[50+iNumResistencias] AND xResistenciaHabilitadaSuperior[50] AND xAlternaSetorRampa;

(* ------------------ ESCRITA DA RECEITA ----------------------------*)

IF iHabilitaEscritaReceitaAquec=1 THEN
	iEscreverReceitaAquecim:=1;
	iHabilitaEscritaReceitaAquec:=0;
END_IF

IF iEscreverReceitaAquecim=1 THEN

	iReceitaAquecimEscritaOk:=1;
	iEscreverReceitaAquecim:=0;

	xReceitaAqiecimCarregadaOk:=TRUE;	
		
END_IF

