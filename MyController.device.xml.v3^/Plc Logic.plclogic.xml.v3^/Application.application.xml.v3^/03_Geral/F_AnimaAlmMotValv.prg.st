__METADATA__
{
  "v3Meta": {
    "objectGuid": "bcdd664b-3dd0-4f56-9807-f59325cd177f",
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
PROGRAM F_AnimaAlmMotValv
VAR
	Index: INT;
END_VAR
__IMPLEMENTATION__
FOR Index:=1 TO 25 DO
//Motores
	IF NOT AlmMotor[Index] AND NOT ImgMotor[Index] THEN
		iAnimaAlarmesMotores[Index]:=0; //Desligado
	END_IF
	IF NOT AlmMotor[Index] AND ImgMotor[Index] THEN
		iAnimaAlarmesMotores[Index]:=1; //Ligado
	END_IF
	IF AlmMotor[Index] THEN
		iAnimaAlarmesMotores[Index]:=2; //Alarme
	END_IF
//Válvulas	
	
	IF (NOT AlmValvAberta[Index] OR NOT AlmValvFechada[Index] ) AND ImgValvFechada[Index] THEN
		iAnimaAlarmesValvulas[Index]:=0; // Fechada
	END_IF
	IF (NOT AlmValvAberta[Index] OR NOT AlmValvFechada[Index] ) AND ImgValvAberta[Index] THEN
		iAnimaAlarmesValvulas[Index]:=1; // Aberta
	END_IF	
	IF AlmValvAberta[Index] OR AlmValvFechada[Index]  THEN
		iAnimaAlarmesValvulas[Index]:=2; // Alarme
	END_IF	
END_FOR

