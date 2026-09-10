__METADATA__
{
  "v3Meta": {
    "objectGuid": "b5ee5670-adae-492c-99b7-ce7c18fab8b7",
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
FUNCTION_BLOCK Patamar
VAR_IN_OUT
	xIniciaPatamar: BOOL;
	xFimPatamar: BOOL;
	xResetBloco: BOOL;
END_VAR
VAR_INPUT
	rTemopar: REAL;
	rPatamar: REAL;
	rHisterese: REAL;
	rTempoPatamar: REAL;
	xDesabilitaZn: BOOL;
END_VAR
VAR_OUTPUT
	xSaida: BOOL;
	wStatusPatamar: WORD;
	rTempoPatamarDecorrido: REAL;
	rTempoPatamarRestante: REAL;
	rTempoFinal: REAL;
END_VAR
VAR
	PassoPatamar: INT;
	ControleTemperatura: FB_2points;
	stParametros: stPtPara;
	TempoPatamar: TON;
	TempoPatamarIn: BOOL;
	TempoPatamarQ: BOOL;
	TempoPatamarPt: TIME;
	TempoPatamarEt: TIME;
	tTempoCiclo: TIME;
	rTempoPatamarDecor: REAL;
END_VAR
__IMPLEMENTATION__
CASE PassoPatamar OF
	
	0:	IF xIniciaPatamar THEN
			PassoPatamar:=5;
		END_IF
		
	5:	xIniciaPatamar:=FALSE;
		IF (rTempoPatamar=0) (*OR (rTemopar > (rPatamar+5))*) OR xDesabilitaZn THEN
			PassoPatamar:=10;
		ELSE
			ControleTemperatura.i_xEn:=TRUE;
			wStatusPatamar:=1;
			TempoPatamarIn:=TRUE;
			TempoPatamarPt:=REAL_TO_TIME (rTempoPatamar*1000);
			IF TempoPatamarQ THEN
				PassoPatamar:=10;
			END_IF			
		END_IF
		
	10:	rTempoFinal:=rTempoPatamarDecor;
		PassoPatamar:=15;
		
	15:	xFimPatamar:=TRUE;
		wStatusPatamar:=2;
		TempoPatamarIn:=FALSE;
		ControleTemperatura.i_xEn:=FALSE;
		//PassoPatamar:=0;
		
END_CASE
TempoPatamar(IN:=TempoPatamarIn , PT:=TempoPatamarPt , Q=>TempoPatamarQ , ET=>TempoPatamarEt );
rTempoPatamarDecor:=(TIME_TO_REAL(TempoPatamarEt))/1000;
rTempoPatamarDecorrido:=rTempoPatamarDecor+(rTempoFinal);
rTempoPatamarRestante:=rTempoPatamar-rTempoPatamarDecorrido;


stParametros.rHyst:=	rHisterese;
stParametros.tCyclTime:=tTempoCiclo:=T#100MS;

ControleTemperatura(
	i_xEn:= , 
	i_rSp:= 		rPatamar, 
	i_rActVal:= 	rTemopar, 
	i_xManVal:= , 
	i_xManMode:= , 
	i_stPara:= 		stParametros, 
	i_xErrRst:= , 
	q_xEn=> , 
	q_xBusy=> , 
	q_xOput=> 		xSaida, 
	q_xErr=> , 
	q_uiErrId=> );
	
IF xResetBloco THEN
	xIniciaPatamar	:=FALSE;
	xFimPatamar		:=FALSE;
	//xResetBloco		:=FALSE;
	wStatusPatamar	:=0;
	TempoPatamarIn	:=FALSE;
	ControleTemperatura.i_xEn:=FALSE;
	PassoPatamar	:=0;
	rTempoFinal		:=0;
END_IF
