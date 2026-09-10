__METADATA__
{
  "v3Meta": {
    "objectGuid": "61dffea8-8e83-42b8-a05e-0acefefc6941",
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
PROGRAM D_AnimaGeralResistencias
VAR
	Index: INT;
END_VAR
__IMPLEMENTATION__



FOR Index:=1 TO iNumResistencias DO

//xAlarmesResistenciasGeral[Index]:=xAlarmeSsrInferiorFechado[Index] OR xAlarmeSsrInferiorAberto[Index] OR xAlarmeResistRompidaInferior[Index] OR AlmTermoparAbertoLogicoInf[Index] OR AlmTemperaturaExcedeuLogicoInf[Index];	
//Inferior
	IF NOT xResistenciaHabilitadaInferior[Index] AND NOT xAlarmesResistenciasGeralInferior[Index] THEN
			iAnimaResistenciaInferior[Index]:=0;(*Resistência Desabilitada*)
	END_IF	
	IF NOT xResistenciaInferior[Index] AND xResistenciaHabilitadaInferior[Index]THEN
			iAnimaResistenciaInferior[Index]:=1;(*Resistência Desligada*)
	END_IF
	IF xResistenciaInferior[Index] AND xResistenciaHabilitadaInferior[Index]THEN
			iAnimaResistenciaInferior[Index]:=2; (*Resistência Ligada*)
	END_IF
	IF xFalhaForcadaInferior[Index] OR  xAlarmesResistenciasGeralInferior[Index] (*xAlarmeResistForceSuperior[Index]*) THEN
			iAnimaResistenciaInferior[Index]:=3; (*Resistência Alarme*)
	END_IF
	
	IF AlmTermoparAbertoLogicoInf[Index] OR AlmTemperaturaExcedeuLogicoInf[Index] THEN
			iAnimaResistenciaInferior[Index]:=4; (*Termopar Alarme*)
	END_IF

	IF xResistenciaForcadaInferior[Index] AND ValorAmperagemResistenciaInferior[Index]>5 (*xResistenciaInferior[Index]*)  (*AND xResistenciaHabilitadaInferior[Index]*) THEN
			iAnimaResistenciaInferior[Index]:=5; (*Resistência Forçada*)
	END_IF

//Superior
	IF NOT xResistenciaHabilitadaSuperior[Index] AND NOT xAlarmesResistenciasGeralSuperior[Index] THEN
			iAnimaResistenciaSuperior[Index]:=0;(*Resistência Desabilitada*)
	END_IF	
	IF NOT xResistenciaSuperior[Index] AND xResistenciaHabilitadaSuperior[Index]THEN
			iAnimaResistenciaSuperior[Index]:=1;(*Resistência Desligada*)
	END_IF
	IF (*(xReleSsrSuperior[Index] OR xSaidaReleRampaPatamarSup[Index])*)xResistenciaSuperior[Index] AND xResistenciaHabilitadaSuperior[Index]THEN
			iAnimaResistenciaSuperior[Index]:=2; (*Resistência Ligada*)
	END_IF
	IF xFalhaForcadaSuperior[Index] OR (*xAlarmeResistForceSuperior[Index]*) xAlarmesResistenciasGeralSuperior[Index] THEN
			iAnimaResistenciaSuperior[Index]:=3; (*Resistência Alarme*)
	END_IF
	IF AlmTermoparAbertoLogicoSup[Index] OR AlmTemperaturaExcedeuLogicoSup[Index] THEN
			iAnimaResistenciaSuperior[Index]:=4; (*Termopar Alarme*)
	END_IF
	IF xResistenciaForcadaSuperior[Index] AND ValorAmperagemResistenciaSuperior[Index]>5 (*xResistenciaSuperior[Index]*) (*AND xResistenciaHabilitadaSuperior[Index]*) THEN
			iAnimaResistenciaSuperior[Index]:=5; (*Resistência Forçada*)
	END_IF

END_FOR
