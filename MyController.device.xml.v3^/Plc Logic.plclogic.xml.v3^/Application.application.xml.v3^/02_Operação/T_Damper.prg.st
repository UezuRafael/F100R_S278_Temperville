__METADATA__
{
  "v3Meta": {
    "objectGuid": "063c721e-a743-42bd-9de6-f59fc90c320e",
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
PROGRAM T_Damper
VAR
	PulsoDamper: PulsoPositivo;
	xPulsoEntradaDamper: BOOL;
	xPulsoSaidaDamper: BOOL;
	xMudancadeDamper: BOOL;
	xValvulaDamperDifusorFino: BOOL;
END_VAR
__IMPLEMENTATION__
IF xValvulaDamperDifusor<>xBufferValvulaDamperDifusor THEN
	xMudancadeDamper:=TRUE;
ELSE
	xMudancadeDamper:=FALSE;
END_IF

IF (xMudancadeDamper AND NOT xResfriadorEmCiclo)  THEN
	xPulsoEntradaDamper:=TRUE;
END_IF

PulsoDamper(Entrada:=xPulsoEntradaDamper , SaidaPulsoPo=> xPulsoSaidaDamper);

IF xPulsoSaidaDamper THEN
	xValvulaDamperDifusorFino:=xBufferValvulaDamperDifusor;
END_IF

IF xPulsoEntradaDamper THEN
	xPulsoEntradaDamper:=FALSE;
END_IF

//Saída Damper
xValvulaDamperDifusor:=xValvulaDamperDifusorFino;

