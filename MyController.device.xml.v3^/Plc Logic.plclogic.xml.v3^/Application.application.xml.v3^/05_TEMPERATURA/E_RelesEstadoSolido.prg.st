__METADATA__
{
  "v3Meta": {
    "objectGuid": "af61f7eb-ae3b-4f17-b0ee-8d6d4588b759",
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
PROGRAM E_RelesEstadoSolido
VAR
	Index: INT;
	ReleDefeitoInferior: ARRAY[1..60] OF AlarmeRelesSsr;
	ReleDefeitoSuperior: ARRAY[1..60] OF AlarmeRelesSsr;
	xAlarmeSsrInferiorSon: ARRAY[1..60] OF BOOL;
	xAlarmeSsrSuperiorSon: ARRAY[1..60] OF BOOL;
	AlmSsrBitSoma: INT;
	AlmSsrSonBitSoma: INT;
END_VAR
__IMPLEMENTATION__

AlmSsrBitSoma:=0;
AlmSsrSonBitSoma:=0;
FOR Index:= 1 TO iNumResistencias DO
ReleDefeitoInferior[Index](
	RetornoReleSsr:= 	xResistenciaInferior[Index], 
	ResistRompida:= 	xResistRompidaInferior[Index], 
	ReleSsr:= 			xReleSsrInferior[Index] OR xSaidaReleRampaPatamarInf[Index], 
	ResetAlarm:= 		bResetAlmGeral, 
	AlarmeSsrAberto=> 	xAlarmeSsrInferiorAberto[Index], 
	AlarmeSsrFechado=>	xAlarmeSsrInferiorFechado[Index] , 
	AlarmeSonoro=> 		xAlarmeSsrInferiorSon[Index]);
	
ReleDefeitoSuperior[Index](
	RetornoReleSsr:= 	xResistenciaSuperior[Index], 
	ResistRompida:= 	xResistRompidaSuperior[Index], 
	ReleSsr:= 			xReleSsrSuperior[Index] OR xSaidaReleRampaPatamarSup[Index], 
	ResetAlarm:= 		bResetAlmGeral, 
	AlarmeSsrAberto=> 	xAlarmeSsrSuperiorAberto[Index], 
	AlarmeSsrFechado=>	xAlarmeSsrSuperiorFechado[Index],
	AlarmeSonoro=> 		xAlarmeSsrSuperiorSon[Index]);
	
	AlmSsrBitSoma:=AlmSsrBitSoma + BOOL_TO_INT (xAlarmeSsrInferiorAberto[Index]) + BOOL_TO_INT (xAlarmeSsrInferiorFechado[Index]) + BOOL_TO_INT (xAlarmeSsrSuperiorAberto[Index]) + BOOL_TO_INT (xAlarmeSsrSuperiorFechado[Index]);
	AlmSsrSonBitSoma:=AlmSsrSonBitSoma + BOOL_TO_INT (xAlarmeSsrInferiorSon[Index]) + BOOL_TO_INT (xAlarmeSsrSuperiorSon[Index]);
	
END_FOR
xAlarmesSSr:=AlmSsrBitSoma>=1;
xAlarmesSSrSon:=AlmSsrSonBitSoma>=1;


