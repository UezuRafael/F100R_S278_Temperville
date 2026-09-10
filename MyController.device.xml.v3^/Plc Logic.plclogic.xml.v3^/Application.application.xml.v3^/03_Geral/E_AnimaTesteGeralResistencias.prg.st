__METADATA__
{
  "v3Meta": {
    "objectGuid": "ce350f74-b3f2-440f-894f-94f5ea05d035",
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
PROGRAM E_AnimaTesteGeralResistencias
VAR
	Index: INT;
END_VAR
__IMPLEMENTATION__
FOR Index:=1 TO iNumResistencias DO
//Inferior
	IF NOT xAlarmesResistenciasGeralInferior[Index] AND NOT xTesteResistenciaInferiorFlh[Index] AND NOT  xResistenciaInferior[Index] AND NOT xTestandoResistenciaInferior[Index]THEN
		iAnimaTesteResistenciaInferior[Index]:=0;(*Resistência Desligada*)
	END_IF

	IF xResistenciaForcadaInferior[Index] AND ValorAmperagemResistenciaInferior[Index]>40(*xResistenciaInferior[Index]*) THEN
		iAnimaTesteResistenciaInferior[Index]:=1; (*Resistência Forçada*)
	END_IF

	IF xResistenciaInferior[Index] AND xTestandoResistenciaInferior[Index]THEN
		iAnimaTesteResistenciaInferior[Index]:=2; (*Resistência Testando*)
	END_IF

	IF xTesteResistenciaInferiorOk[Index]THEN
		iAnimaTesteResistenciaInferior[Index]:=3; (* Teste Resistência Ok*)
	END_IF
	
	IF xFalhaForcadaInferior[Index] OR (*xAlarmeResistForceInferior[Index]*) xAlarmesResistenciasGeralInferior[Index] OR xTesteResistenciaInferiorFlh[Index] THEN
		iAnimaTesteResistenciaInferior[Index]:=4; (* Teste Resistência Resistência Alarme*)
	END_IF
	
//Superior
	IF NOT xAlarmesResistenciasGeralSuperior[Index] AND NOT xTesteResistenciaSuperiorFlh[Index] AND NOT xResistenciaSuperior[Index] AND NOT xTestandoResistenciaSuperior[Index]THEN
		iAnimaTesteResistenciaSuperior[Index]:=0;(*Resistência Desligada*)
	END_IF

	IF xResistenciaForcadaSuperior[Index] AND ValorAmperagemResistenciaSuperior[Index]>40(*xResistenciaSuperior[Index]*) THEN
		iAnimaTesteResistenciaSuperior[Index]:=1; (*Resistência Forçada*)
	END_IF

	IF xResistenciaSuperior[Index] AND xTestandoResistenciaSuperior[Index]THEN
		iAnimaTesteResistenciaSuperior[Index]:=2; (*Resistência Testando*)
	END_IF

	IF xTesteResistenciaSuperiorOk[Index]THEN
		iAnimaTesteResistenciaSuperior[Index]:=3; (* Teste Resistência Ok*)
	END_IF
	
	IF xFalhaForcadaSuperior[Index] OR (*xAlarmeResistForceSuperior[Index]*) xAlarmesResistenciasGeralSuperior[Index] OR xTesteResistenciaSuperiorFlh[Index] THEN
		iAnimaTesteResistenciaSuperior[Index]:=4; (* Teste Resistência Resistência Alarme*)
	END_IF

END_FOR
