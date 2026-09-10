__METADATA__
{
  "v3Meta": {
    "objectGuid": "4fff632e-db7b-4896-9f7f-1eea91e5f75e",
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
PROGRAM A_TemperaturaGeral
VAR
	IndexGTI: INT;
	IndexGPI: INT;
	IndexGTS: INT;
	IndexGPS: INT;
	IndexGTIS: INT;
	IndexGPIS: INT;
	IndexGTSS: INT;
	IndexGPSS: INT;
END_VAR
__IMPLEMENTATION__
// ATUALIZAÇÃO DAS TEMPERATURAS E PERCENTAGENS PELA TEMPERATURA GERAL 

IF NOT xBloqueioCargaEnvioRec THEN
	// Temperaturas Inferiores
	IF rSetTemperaturaInferiorGeral <> rSetTemperaturaInferiorGeralAux THEN
		FOR IndexGTI:=1 TO iNumResistencias DO
			rSetTemperaturaInferior[IndexGTI]:=rSetTemperaturaInferiorGeral;
		END_FOR	
		rSetTemperaturaInferiorGeralAux:=rSetTemperaturaInferiorGeral;
	END_IF

	//Percentagens Inferiores
	IF rSetPorcentagemInferiorGeral <> rSetPorcentagemInferiorGeralAux THEN
		FOR IndexGPI:=1 TO iNumResistencias DO
			rSetPorcentagemInferior[IndexGPI]:=rSetPorcentagemInferiorGeral;
		END_FOR	
		rSetPorcentagemInferiorGeralAux:=rSetPorcentagemInferiorGeral;
	END_IF

	//Temperaturas Superiores
	IF rSetTemperaturaSuperiorGeral <> rSetTemperaturaSuperiorGeralAux THEN
		FOR IndexGTS:=1 TO iNumResistencias DO
			rSetTemperaturaSuperior[IndexGTS]:=rSetTemperaturaSuperiorGeral;
		END_FOR	
		rSetTemperaturaSuperiorGeralAux:=rSetTemperaturaSuperiorGeral;
	END_IF

	//Percentagens Superiores	
	IF rSetPorcentagemSuperiorGeral <> rSetPorcentagemSuperiorGeralAux THEN
		FOR IndexGPS:=1 TO iNumResistencias DO
			rSetPorcentagemSuperior[IndexGPS]:=rSetPorcentagemSuperiorGeral;
		END_FOR	
		rSetPorcentagemSuperiorGeralAux:=rSetPorcentagemSuperiorGeral;
	END_IF
END_IF


// INCREMENTA/DECREMENTA MESMO VALOR EM TODAS AS TEMPERATURAS

// Temperaturas Inferiores
	IF xBtHabIncremento THEN
		FOR IndexGTIS:=1 TO iNumResistencias DO
			rSetTemperaturaInferior[IndexGTIS]:=rSetTemperaturaInferior[IndexGTIS]+rIncrementoTemperInf;
			rSetPorcentagemInferior[IndexGTIS]:=rSetPorcentagemInferior[IndexGTIS]+rIncrementoPotenciaInf;
			rSetTemperaturaSuperior[IndexGTIS]:=rSetTemperaturaSuperior[IndexGTIS]+rIncrementoTemperSup; 
			rSetPorcentagemSuperior[IndexGTIS]:=rSetPorcentagemSuperior[IndexGTIS]+rIncrementoPotenciaSup;
		END_FOR	
		xBtHabIncremento:=FALSE;
	END_IF

	//IF xBtIncrTemperInfSub THEN
	//	FOR IndexGTIS:=1 TO iNumResistencias DO
	//		rSetTemperaturaInferior[IndexGTIS]:=rSetTemperaturaInferior[IndexGTIS]-rIncrementoTemper;
	//	END_FOR	
	//	xBtIncrTemperInfSub:=FALSE;
	//END_IF

// Percentagens Inferiores
	//IF xBtIncrPercentInfAdd THEN
	//	FOR IndexGPIS:=1 TO 25 DO
	//		rSetPorcentagemInferior[IndexGPIS]:=rSetPorcentagemInferior[IndexGPIS]+rIncrementoTemper;
	//	END_FOR	
	//	xBtIncrPercentInfAdd:=FALSE;
	//END_IF

	//IF xBtIncrPercentInfSub THEN
	//	FOR IndexGPIS:=1 TO 25 DO
	//		rSetPorcentagemInferior[IndexGPIS]:=rSetPorcentagemInferior[IndexGPIS]-rIncrementoTemper;
	//	END_FOR	
	//	xBtIncrPercentInfSub:=FALSE;
	//END_IF


	
// Temperaturas Superiores
	//IF xBtIncrTemperSupAdd THEN
	//	FOR IndexGTSS:=1 TO 25 DO
	//		rSetTemperaturaSuperior[IndexGTSS]:=rSetTemperaturaSuperior[IndexGTSS]+rIncrementoTemper;
	//	END_FOR	
	//	xBtIncrTemperSupAdd:=FALSE;
	//END_IF

	//IF xBtIncrTemperSupSub THEN
	//	FOR IndexGTSS:=1 TO 25 DO
	//		rSetTemperaturaSuperior[IndexGTSS]:=rSetTemperaturaSuperior[IndexGTSS]-rIncrementoTemper;
	//	END_FOR	
	//	xBtIncrTemperSupSub:=FALSE;
	//END_IF

// Percentagens Superiores
	//IF xBtIncrPercentSupAdd THEN
	//	FOR IndexGPSS:=1 TO 25 DO
	//		rSetPorcentagemSuperior[IndexGPSS]:=rSetPorcentagemSuperior[IndexGPSS]+rIncrementoTemper;
	//	END_FOR	
	//	xBtIncrPercentSupAdd:=FALSE;
	//END_IF

	//IF xBtIncrPercentSupSub THEN
	//	FOR IndexGPSS:=1 TO 25 DO
	//		rSetPorcentagemSuperior[IndexGPSS]:=rSetPorcentagemSuperior[IndexGPSS]-rIncrementoTemper;
	//	END_FOR	
	//	xBtIncrPercentSupSub:=FALSE;
	//END_IF

	
