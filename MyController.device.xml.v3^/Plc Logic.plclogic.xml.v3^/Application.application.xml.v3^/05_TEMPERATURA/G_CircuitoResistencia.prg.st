__METADATA__
{
  "v3Meta": {
    "objectGuid": "80c81ce6-bf92-46ea-b5ee-ab15e8cb058e",
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
PROGRAM G_CircuitoResistencia
VAR
	Index: INT;
	StatusCircuitoInferior: ARRAY[1..60] OF StatCircuitoResist;
	StatusCircuitoSuperior: ARRAY[1..60] OF StatCircuitoResist;
END_VAR
__IMPLEMENTATION__

FOR Index:= 1 TO iNumResistencias DO
	xResistenciaInferior[Index]:=xRetornoSsrInferior[Index];
	(*StatusCircuitoInferior[Index](	iAmpLigada:= 4, 
									iAmperagem:= iAmperagemInferior[Index], 
									xSaidaRele:= xReleSsrInferior[Index], 
									xRetorRele:= xRetornoSsrInferior[Index], 
									xLigada=> xResistenciaInferior[Index], 
									xDeslig=> , 
									xReleAb=> , 
									xReleCc=> , 
									xResAbe=> xResistRompidaInferior[Index]);*)

	xResistenciaSuperior[Index]:=xRetornoSsrSuperior[Index];
	(*StatusCircuitoInferior[Index](	iAmpLigada:= 4, 
									iAmperagem:= iAmperagemSuperior[Index], 
									xSaidaRele:= xReleSsrSuperior[Index], 
									xRetorRele:= xRetornoSsrSuperior[Index], 
									xLigada=> xResistenciaSuperior[Index], 
									xDeslig=> , 
									xReleAb=> , 
									xReleCc=> , 
									xResAbe=> xResistRompidaSuperior[Index]);*)

END_FOR
