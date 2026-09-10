__METADATA__
{
  "v3Meta": {
    "objectGuid": "cdeec8e9-2758-425c-83a7-348636387805",
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
PROGRAM H_CircuitoCC
VAR
END_VAR
__IMPLEMENTATION__
// Habilita/Desabilita Circuito CC
xHabDesabCircuitoCC:= xChHabDesabCircuitoCC;



// Posição da Chave Liga Motores CC
xCircuitoEmergenciaCC:= NOT xChCircuitoEmergenciaCC;// AND xHabDesabCircuitoCC;

IF xMaquinaEmEspera AND xChCircuitoEmergenciaCC AND xHabDesabCircuitoCC THEN
	xAlertaPosChCircCC:= TRUE;
ELSE
	xAlertaPosChCircCC:= FALSE;
END_IF
