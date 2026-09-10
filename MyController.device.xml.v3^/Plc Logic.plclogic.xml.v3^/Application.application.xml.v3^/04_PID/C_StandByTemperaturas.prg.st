__METADATA__
{
  "v3Meta": {
    "objectGuid": "bc911709-f0a1-4a4e-a12b-31d0787fb20f",
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
PROGRAM C_StandByTemperaturas
VAR
	Index: INT;
	IndexGTI: INT;
	IndexGPI: INT;
	IndexGTS: INT;
	IndexGPS: INT;
	rSpInferiorStandby: REAL;
	rSpSuperiorStandby: REAL;
	xSetTempStandyByCiclo: BOOL;
	xTonSetTemperStdBy: BOOL;
	TonSetTemperStdBy: TON;
	xTonSetTemperStdByIn: BOOL;
	xTonSetTemperStdByQ: BOOL;
	tTonSetTemperStdByPt: TIME;
	tTonSetTemperStdByEt: TIME;
	xAbortaStandByCiclo: BOOL;
	rSetTemperaturaInferiorGeralAux: REAL;
	rSetTemperaturaSuperiorGeralAux: REAL;
	rSetPorcentagemInferiorGeralAux: REAL;
	rSetPorcentagemSuperiorGeralAux: REAL;
END_VAR
__IMPLEMENTATION__

//xAbortaStandByCiclo:=BtAbortaStandByCiclo;

IF BtAbortaStandByCiclo THEN
	xAbortaStandByCiclo:=TRUE;
END_IF

IF 	xFimDescForIniStdBy OR xSetTempStandyByInicio THEN
	xTonSetTemperStdBy:=TRUE;
	xFimDescForIniStdBy:=FALSE;
	xSetTempStandyByInicio:=FALSE;
	xAbortaStandByCiclo:=FALSE;//
END_IF
	
IF 	xTonSetTemperStdBy AND NOT xAbortaStandByCiclo and not xStdByTemperaturaDesabilit THEN
	xTonSetTemperStdByIn := TRUE;
ELSE
	xTonSetTemperStdByIn := FALSE;
END_IF;

tTonSetTemperStdByPt:=DINT_TO_TIME (INT_TO_DINT(iTempoIniStdByTemperatura)*1000);

TonSetTemperStdBy(IN:= xTonSetTemperStdByIn, PT:=tTonSetTemperStdByPt , Q=> xTonSetTemperStdByQ, ET=>tTonSetTemperStdByEt );

iTempoStdByTemperDecorrido:=DINT_TO_INT(TIME_TO_DINT (tTonSetTemperStdByEt)/1000);	


IF iTempoIniStdByTemperatura<>0 THEN
	xStdByTemperaturaHabilitado:=TRUE;
ELSE
	xStdByTemperaturaHabilitado:=FALSE;
END_IF

xStdByTemperaturaDesabilit:= NOT xStdByTemperaturaHabilitado;

xSetTempStandyByCiclo:=xTonSetTemperStdByQ;
xImgSetTempStandByCiclo:=xSetTempStandyByCiclo;

IF xStartCargaForno OR xOperacaoManual OR xFornoEmEspera THEN
	xTonSetTemperStdBy:=FALSE;
	xStartCargaForno:=FALSE;
END_IF

IF BtAbortaStandByCiclo THEN
	BtAbortaStandByCiclo:=FALSE;
END_IF



rSpInferiorStandby:=rSetPointInferiorStandby;
rSpSuperiorStandby:=rSetPointSuperiorStandby;

FOR Index:=1 TO iNumResistencias DO
	IF xSetTempStandyByCiclo THEN
		rSetPointTemperaturaInferior[Index]:=rSpInferiorStandby;
		rSetPointTemperaturaSuperior[Index]:=rSpSuperiorStandby;
	ELSE
		rSetPointTemperaturaInferior[Index]:=rSetTemperaturaInferior[Index];
		rSetPointTemperaturaSuperior[Index]:=rSetTemperaturaSuperior[Index];
	END_IF;
END_FOR



