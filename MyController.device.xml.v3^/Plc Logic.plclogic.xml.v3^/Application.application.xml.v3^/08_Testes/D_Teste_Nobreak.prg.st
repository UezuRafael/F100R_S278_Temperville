__METADATA__
{
  "v3Meta": {
    "objectGuid": "fb44888f-5bfd-4f86-af9d-687dcd01ed43",
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
PROGRAM D_Teste_Nobreak
VAR
	xData: GetDateAndTime;
	xDia: UINT;
	uDiaSemana : UINT;
END_VAR
__IMPLEMENTATION__

iTempoTesteNobreak.PT := T#60S;
iTempoTesteNobreak(IN:= , PT:= , Q=> , ET=> );

xData(
	q_UIntYear=> 		, 
	q_UIntMonth=> 		, 
	q_UIntDay=> 		, 
	q_UIntHour=> 		, 
	q_UIntMinute=> 		, 
	q_UIntSecond=> 		, 
	q_UIntMSecond=> 	, 
	q_UIntDayOfWeek=> 	uDiaSemana, 
	q_UIntYday=> 		xDia);


IF uDiaSemana = 1 AND uStatusOperacao = 0 AND xDiaUltimoTeste OR NOT xSaidaNobreakOk THEN
	xTesteNobreakOK := FALSE;
END_IF

IF uDiaSemana <> 1 THEN
	xDiaUltimoTeste := TRUE;
END_IF

IF  uStatusOperacao = 0 AND xTesteNobreakOK = FALSE THEN	
	IF xOperacaoManual AND xMotorEntradaLigado  AND xMotorFornoLigado  AND xMotorResfriadorLigado AND xMotorSaidaLigado AND xSemEnergia  THEN
		iTempoTesteNobreak.IN := TRUE;
		iTempoTesteNobreakRestante := DINT_TO_INT(TIME_TO_DINT(iTempoTesteNobreak.PT)/1000) - DINT_TO_INT(TIME_TO_DINT(iTempoTesteNobreak.ET)/1000); 
		
			IF iTempoTesteNobreak.Q THEN
				xTesteNobreakOK := TRUE;
				xDiaUltimoTeste := FALSE;
				xIniciaTesteNobreak := FALSE;
				iTempoTesteNobreak.IN := FALSE;
			END_IF
	ELSE
		iTempoTesteNobreak.IN := FALSE;
	END_IF	
END_IF
