__METADATA__
{
  "v3Meta": {
    "objectGuid": "70e79e0c-4ec7-40f4-b718-9b2f0f4e689c",
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
FUNCTION_BLOCK Rampa
VAR_IN_OUT
	xIniciaRampa: BOOL;
	xFimRampa: BOOL;
	xResetBloco: BOOL;
END_VAR
VAR_INPUT
	rTemopar: REAL;
	rTempMedia: REAL;
	rPatamar: REAL;
	rTempoRampa: REAL;
	xDesabilitaZn: BOOL;
	xFimTotRampa: BOOL;
END_VAR
VAR_OUTPUT
	xSaida: BOOL;
	wStatusRampa: WORD;
	rTempoRampaDecorrido: REAL;
	rTempoRampaRestante: REAL;
	rTempoFinal: REAL;
	rSpTemperaturaUp: REAL;
END_VAR
VAR
	rSomaDegrau: REAL;
	PassoRampa: INT;
	PassoRampaInto: INT;
	TempoRealRampa: TON;
	TempoRealRampaIn: BOOL;
	TempoRealRampaPt: TIME;
	TempoRealRampaQ: BOOL;
	TempoRealRampaEt: TIME;
	TempoIntegracao: TON;
	TempoIntegracaoIn: BOOL;
	TempoIntegracaoPt: TIME;
	TempoIntegracaoQ: BOOL;
	TempoIntegracaoEt: TIME;
	TempoCiclo: TON;
	TempoCicloIn: BOOL;
	TempoCicloPt: TIME;
	TempoCicloQ: BOOL;
	TempoCicloEt: TIME;
	rDegrau: REAL;
	rDxTemperatura: REAL;
	rTempoIntegracao: REAL;
	tTempoCiclo: TIME := TIME#100ms;
	xIniciaTempoCiclo: BOOL;
	rTempoRampaDecor: REAL;
	tTempoIntegracao: TIME;
	rDxTempoIntegracao: REAL;
	rDxTempoRampa: REAL;
	rTempoSubCiclo: REAL;
END_VAR
__IMPLEMENTATION__

TempoRealRampaPt:=REAL_TO_TIME((rTempoRampa+((rTempoRampa*20)/100))*1000);

CASE PassoRampa OF

	0: IF xIniciaRampa THEN
			PassoRampa:=1;
	   END_IF	

	1: 	xIniciaRampa:=FALSE;
		IF (rTemopar < rPatamar) OR xDesabilitaZn THEN
			wStatusRampa:=1;
			TempoRealRampaIn:=TRUE;
			rDegrau:=0.1;
			rDxTemperatura:= rPatamar-rTemopar;
			PassoRampa:=2;
		ELSE
		PassoRampa:=10;
		END_IF
			
	2:	rDxTempoRampa:=((rTempoRampa)*0.1);
		rTempoIntegracao:=rDxTempoRampa/rDxTemperatura;
	   	PassoRampa:=3;
	   
	3:rSpTemperaturaUp:=rTemopar;
	   PassoRampa:=4;

	4: xSaida:=TRUE;
		PassoRampa:=5;
		 
	5:	IF rSpTemperaturaUp <= rPatamar AND NOT xDesabilitaZn THEN
			rSpTemperaturaUp:=rSpTemperaturaUp+rDegrau;
			PassoRampa:=6;
		ELSE
			PassoRampa:=10;
		END_IF;
		

	6: TempoIntegracaoIn:=TRUE;
		rDxTempoIntegracao:=(rTempoIntegracao*1000);
		rTempoSubCiclo:=rDxTempoIntegracao-50;
		tTempoIntegracao:=REAL_TO_TIME (rTempoSubCiclo);
	 	TempoIntegracaoPt:=tTempoIntegracao;
		IF NOT TempoIntegracaoQ THEN
				CASE PassoRampaInto OF
					
					0:	xIniciaTempoCiclo:=TRUE;
						PassoRampaInto:=2;
						
					2:	xIniciaTempoCiclo:=FALSE;
						TempoCicloIn:=TRUE;
						TempoCicloPt:=tTempoCiclo;
						IF TempoIntegracaoQ THEN
		   					PassoRampaInto:=3;
	   					END_IF
						
					3:	TempoCicloIn:=FALSE;
						IF rTemopar< rSpTemperaturaUp THEN
							PassoRampaInto:=4;
						END_IF
						IF rTemopar >= rSpTemperaturaUp THEN
							PassoRampaInto:=5;
						END_IF
						//IF rTemopar >= rPatamar THEN
						//	PassoRampa:=10;
						//END_IF 
					
					4:	xSaida:=TRUE;
						IF rTempoRampaRestante <=10 THEN
							PassoRampa:=12;
						ELSE
							PassoRampaInto:=0;
						END_IF
						//PassoRampaInto:=0;
		
					5:	xSaida:=FALSE;
						PassoRampaInto:=0;
	
				END_CASE
		END_IF
				
	   	IF TempoIntegracaoQ THEN
		   	PassoRampa:=7;
			rSomaDegrau:=rSomaDegrau+rDegrau;
			//PassoRampa:=5;
	   	END_IF

	7: TempoIntegracaoIn:=FALSE;
		IF rTempoRampaRestante <=10 THEN
			PassoRampa:=12;
		ELSE
			IF rTemopar< rSpTemperaturaUp THEN
				PassoRampa:=8;
			END_IF
			IF rTemopar >= rSpTemperaturaUp THEN
				PassoRampa:=9;
			END_IF
			IF (*rTempMedia*)rTemopar  >= rPatamar THEN
				PassoRampa:=10;
			END_IF 
		END_IF
			
			
	12:	IF ((*rTempMedia*)rTemopar < rPatamar) AND NOT xDesabilitaZn THEN
			xSaida:=TRUE;
		END_IF
		IF	((*rTempMedia*)rTemopar >= rPatamar) AND NOT xDesabilitaZn THEN
			PassoRampa:=10;
		END_IF
		IF xDesabilitaZn THEN
			PassoRampa:=10;
		END_IF

	8:	xSaida:=TRUE;
		PassoRampa:=5;
		
	9:	xSaida:=FALSE;
		PassoRampa:=5;
		
	10:	xSaida:=FALSE;
		rTempoFinal:=rTempoRampaDecor;
		PassoRampa:=11;							
		
	11:	xFimRampa:=TRUE;
		wStatusRampa:=2;
		TempoRealRampaIn:=FALSE;
		IF (rTemopar < rPatamar) AND NOT xDesabilitaZn THEN
			xSaida:=TRUE;
		ELSE
			xSaida:=FALSE;
		END_IF
		IF xFimTotRampa THEN
			PassoRampa:=20;	
		END_IF
		
	20: xSaida:=FALSE;
		
		//PassoRampaInto:=0;							
		
		
END_CASE
TempoIntegracao(IN:=TempoIntegracaoIn , PT:=TempoIntegracaoPt , Q=>TempoIntegracaoQ , ET=> );
TempoRealRampa(IN:=TempoRealRampaIn , PT:=TempoRealRampaPt , Q=> , ET=>TempoRealRampaEt );
rTempoRampaDecor:=(TIME_TO_REAL(TempoRealRampaEt))/1000;
rTempoRampaRestante:=rTempoRampa-rTempoRampaDecorrido;

rTempoRampaDecorrido:=rTempoRampaDecor+(rTempoFinal);

IF xResetBloco THEN
	xIniciaRampa	:=FALSE;
	xFimRampa		:=FALSE;
	//xResetBloco		:=FALSE;
	wStatusRampa	:=0;
	xSaida			:=FALSE;
	TempoRealRampaIn:=FALSE;
	TempoIntegracaoIn:=FALSE;
	TempoCicloIn	:=FALSE;
	PassoRampa		:=0;
	PassoRampaInto	:=0;
	rTempoFinal		:=0;
END_IF
