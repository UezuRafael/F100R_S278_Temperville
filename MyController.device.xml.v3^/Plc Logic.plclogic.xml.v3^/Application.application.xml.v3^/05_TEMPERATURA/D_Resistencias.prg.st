__METADATA__
{
  "v3Meta": {
    "objectGuid": "a6f700ae-c033-4399-83d2-f27c777d9c24",
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
PROGRAM D_Resistencias
VAR
	Index: INT;
	ResistRompInferior: ARRAY[1..60] OF AlarmeResistencia;
	ResistRompSuperior: ARRAY[1..60] OF AlarmeResistencia;
	xAlarmeResRompInferiorSon: ARRAY[1..60] OF BOOL;
	xAlarmeResRompSuperiorSon: ARRAY[1..60] OF BOOL;
END_VAR
__IMPLEMENTATION__
// Lógica para identificar resistência Rompida



FOR Index:= 1 TO iNumResistencias DO
ResistRompInferior[Index](	ResistRompida:= 		xResistRompidaInferior[Index], 
							ResetAlarm:= 			bResetAlmGeral, 
							AlarmeResistRompida=> 	xAlarmeResistRompidaInferior[Index], 
							AlarmeSonoro=> 			xAlarmeResRompInferiorSon[Index]);	

ResistRompSuperior[Index](	ResistRompida:= 		xResistRompidaSuperior[Index], 
							ResetAlarm:= 			bResetAlmGeral, 
							AlarmeResistRompida=> 	xAlarmeResistRompidaSuperior[Index], 
							AlarmeSonoro=> 			xAlarmeResRompSuperiorSon[Index]);

END_FOR
