__METADATA__
{
  "v3Meta": {
    "objectGuid": "651fbec5-5399-4289-a0a1-cca536aad167",
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
PROGRAM N_MesaBasculante
VAR
	PassoMesaBasculEnt: INT;
	PassoPauseBasculEnt: INT;
	PassoAlmBasculEnt: INT;
	TonAbreBraco: TON;
	TonAbreBracoIn: BOOL;
	TonAbreBracoQ: BOOL;
	TonFechaBraco: TON;
	TonFechaBracoIn: BOOL;
	TonFechaBracoQ: BOOL;
	xBascEntradaRecuada: BOOL;
	xBascEntradaAvancada: BOOL;
	xBascEntradaRecuando: BOOL;
	xBascEntradaAvancando: BOOL;
	xMeBascEntrAvanco: BOOL;
	xMeBascEntrRecuo: BOOL;
END_VAR
__IMPLEMENTATION__
(*---------------- ENTRADAS ---------------*)
(* xBtAvancMesaBascul = Botão Levanta Mesa*)
(* xBtRecuoMesaBascul = Botão Abaixa Mesa*)
(* xS01PistPneumRecuado = Sensor Pistão Pneumático Recuado*)
(* xS02PistPneumAvancad = Sensor Pistão Pneumático Atuado*)
(* xS03PistHidraulRecuado = Sensor Pistão Hidraulico Recuado*)
(* xS04PistHidraulAvancad = Sensor Pistão Hidraulico Avanção*)
(* xS05NivelaSubida = Sensor Pistão Hidraulico Nivela Inferior*)
(* xS06NivelaDescida = Sensor Pistão Hidraulico Nivela Superior*)


(*----------------- SAÍDAS -----------------*)
(* xValvulaAbreBraco=  Válvula Acionamento do Pistão Pneumático Abertura do Braço*)
(* xValvulaFechBraco=  Válvula Acionamento do Pistão Pneumático Fechamento do Braço*)
(* xValvulaAvancPneum = Válvula Acionamento do Pistão Pneumático Sobe Mesa*)
(* xValvulaRecuaPneum = Válvula Acionamento do Pistão Pneumático Sobe Mesa*)
(* xValvulaAvancHidra = Válvula Acionamento do Pistão Avanço Hidraulico*)
(* xValvulaRecuoHidra = Válvula Acionamento do Pistão Recuo Hidraulico*)
(* xMotorBombaHidraulica = Acionamento Bomba Hidraulica*)

IF xValvulaGradeEntrada THEN
	

CASE PassoMesaBasculEnt OF
	
	0: IF xBtAvancMesaBascul THEN
			PassoMesaBasculEnt:=1;			
		END_IF
		IF xBtRecuoMesaBascul THEN
			PassoMesaBasculEnt:=3;		
		END_IF
		
	1:	IF xS01PistPneumRecuado AND xS03PistHidraulRecuado THEN
			PassoMesaBasculEnt:=5;
		ELSE
			PassoMesaBasculEnt:=0;
		END_IF
		
	3:	IF NOT xS01PistPneumRecuado AND NOT xS03PistHidraulRecuado THEN
			PassoMesaBasculEnt:=4;
		ELSE
			PassoMesaBasculEnt:=0;
		END_IF
		
	4:	xValvulaRecuoHidra:=TRUE;
		IF xS06NivelaDescida THEN
			PassoMesaBasculEnt:=60;
		END_IF
		IF xS05NivelaSubida THEN
			PassoMesaBasculEnt:=0;
		END_IF
		
	5:	xValvulaAbreBraco:=TRUE;
		TonAbreBracoIn:=TRUE;
		xMeBascEntrAvanco:=TRUE;
		PassoMesaBasculEnt:=10;		
		
	10:	IF 	TonAbreBracoQ THEN
			PassoMesaBasculEnt:=15;	
		END_IF
		IF	xBtRecuoMesaBascul THEN
			PassoMesaBasculEnt:=11;	
		END_IF
		
	11: xValvulaAbreBraco:=FALSE;
		TonAbreBracoIn:=FALSE;
		PassoMesaBasculEnt:=12;
		
	12:	xMeBascEntrAvanco:=FALSE;
		xMeBascEntrRecuo:=TRUE;	
		xValvulaFechBraco:=TRUE;
		TonFechaBracoIn:=TRUE;
		PassoMesaBasculEnt:=13;

	13:IF TonFechaBracoQ OR xBtAvancMesaBascul THEN
			PassoMesaBasculEnt:=14;
		END_IF
				
	14:	xValvulaFechBraco:=FALSE;
		TonFechaBracoIn:=FALSE;
		xMeBascEntrAvanco:=FALSE;
		xMeBascEntrRecuo:=FALSE;	
		PassoMesaBasculEnt:=0;	
	
	15:	xValvulaAbreBraco:=FALSE;
		TonAbreBracoIn:=FALSE;
		PassoMesaBasculEnt:=20;				
		
	20:	xValvulaAvancHidra:=xBtAvancMesaBascul;
		IF	xS05NivelaSubida THEN
			PassoMesaBasculEnt:=25;
		END_IF
		IF	xBtRecuoMesaBascul THEN
			PassoMesaBasculEnt:=12;	
		END_IF
		
	25:	xValvulaAvancHidra:=xBtAvancMesaBascul;
		xValvulaAvancPneum:=TRUE;
		PassoMesaBasculEnt:=30;
		
	30:	xValvulaAvancHidra:=xBtAvancMesaBascul;
		IF	xS02PistPneumAvancad THEN
			PassoMesaBasculEnt:=35;
		END_IF
		
	35:	xValvulaAvancPneum:=FALSE;
		PassoMesaBasculEnt:=40;
		
	40:	xValvulaAvancHidra:=xBtAvancMesaBascul;
		IF	xS04PistHidraulAvancad THEN
			PassoMesaBasculEnt:=45;
		END_IF
		IF xBtRecuoMesaBascul THEN
			PassoMesaBasculEnt:=50;
		END_IF
	
	45:	xValvulaAvancHidra:=FALSE;
		xMeBascEntrAvanco:=FALSE;
		PassoMesaBasculEnt:=50;
		
	50:	IF xBtRecuoMesaBascul THEN
			PassoMesaBasculEnt:=52;
		END_IF
		
	52:	xMeBascEntrAvanco:=FALSE;
		xMeBascEntrRecuo:=TRUE;
		PassoMesaBasculEnt:=55;
	
	55:	xValvulaRecuoHidra:=xBtRecuoMesaBascul;
		IF	xS06NivelaDescida THEN
			PassoMesaBasculEnt:=60;
		END_IF
		IF xBtAvancMesaBascul THEN
			PassoMesaBasculEnt:=56;
		END_IF
		
	56:	xMeBascEntrAvanco:=TRUE;
		xMeBascEntrRecuo:=FALSE;
		PassoMesaBasculEnt:=40;
	
	60:	xValvulaRecuoHidra:=TRUE;
		xValvulaFechBraco:=TRUE;
		TonFechaBracoIn:=TRUE;
		PassoMesaBasculEnt:=65;

	65:	IF	xS03PistHidraulRecuado THEN
			xValvulaRecuoHidra:=FALSE;
		END_IF
		IF	TonFechaBracoQ THEN
			PassoMesaBasculEnt:=70;
		END_IF
		
	70:	xValvulaFechBraco:=FALSE;
		TonFechaBracoIn:=FALSE;
		PassoMesaBasculEnt:=75;	
		
	75:	xValvulaRecuaPneum:=TRUE;
		PassoMesaBasculEnt:=80;	

	80:	IF xS01PistPneumRecuado THEN
			xValvulaRecuaPneum:=FALSE;
		END_IF
		IF	xS03PistHidraulRecuado THEN
			xValvulaRecuoHidra:=FALSE;
		END_IF	
		IF 	xS01PistPneumRecuado AND xS03PistHidraulRecuado THEN
			PassoMesaBasculEnt:=81;	
		END_IF	
		
	81:	xMeBascEntrRecuo:=FALSE;
		PassoMesaBasculEnt:=0;	
		
END_CASE
END_IF

TonAbreBraco(IN:= TonAbreBracoIn, PT:=T#10S , Q=> TonAbreBracoQ, ET=> );
TonFechaBraco(IN:= TonFechaBracoIn, PT:=T#10S , Q=> TonFechaBracoQ, ET=> );

IF xS01PistPneumRecuado AND xS03PistHidraulRecuado THEN
	xBascEntradaRecuada:=TRUE;
ELSE
	xBascEntradaRecuada:=FALSE;
END_IF

IF xS02PistPneumAvancad AND xS04PistHidraulAvancad THEN
	xBascEntradaAvancada:=TRUE;
ELSE
	xBascEntradaAvancada:=FALSE;	
END_IF

xBascEntradaAvancando:=xMeBascEntrAvanco;
xBascEntradaRecuando:=xMeBascEntrRecuo;

IF xBascEntradaRecuada THEN
	iStatusBasculanteEntrada:=1;
END_IF
IF xBascEntradaAvancando THEN
	iStatusBasculanteEntrada:=2;	
END_IF
IF xBascEntradaAvancada THEN
	iStatusBasculanteEntrada:=3;	
END_IF
IF xBascEntradaRecuando THEN
	iStatusBasculanteEntrada:=4;	
END_IF
