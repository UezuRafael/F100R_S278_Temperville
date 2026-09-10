__METADATA__
{
  "v3Meta": {
    "objectGuid": "d1c715af-4cea-4e87-a557-beeec7914843",
    "objectTypeGuid": "6f9dac99-8de1-4efc-8465-68ac443b7d08",
    "embeddedObjectTypeGuids": [
      "a9ed5b7e-75c5-4651-af16-d2c27e98cb94",
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {},
    "subObjects": {}
  }
}
__DECLARATION__
PROGRAM H1_Dutos_Oscilantes
VAR
	AlarmeMotorOscilaSup02	: AlarmeMotor ;
	AlarmeMotorOscilaInf02	: AlarmeMotor ;
	
	TofChAbreDuctosResfrSup02 : TOF ;
	xDlyChAbreDuctosResfrSup02	: bool ;
	
END_VAR
__IMPLEMENTATION__

TofChAbreDuctosResfrSup02(IN:=xChAbreDuctosResfriadorSup02 , PT:=T#3S , Q=>xDlyChAbreDuctosResfrSup02 , ET=> );

xMotorOscilaResfr02Sup:=(xMesaResfriadorOn OR xForceDut) AND NOT xMotorDifusorSup02Ligado AND NOT xDlyChAbreDuctosResfrSup02;
xMotorOscilaResfr02Inf:=(xMesaResfriadorOn OR xForceDut) AND NOT xMotorDifusorSup02Ligado AND NOT xDlyChAbreDuctosResfrSup02;

AlarmeMotorOscilaSup02(
	KaMotor:= xKaMotorOscilaResfr02Sup, 
	KmMotor:= xMotorOscilaResfr02Sup, 
	ResetAlarm:= bResetAlmGeral, 
	AlarmeMotor=> xAlarmeMotorOscilaSup02, 
	AlarmeSonoro=> );
	
AlarmeMotorOscilaInf02(
	KaMotor:= xKaMotorOscilaResfr02Inf, 
	KmMotor:= xMotorOscilaResfr02Inf, 
	ResetAlarm:= bResetAlmGeral, 
	AlarmeMotor=> xAlarmeMotorOscilaInf02, 
	AlarmeSonoro=> );

