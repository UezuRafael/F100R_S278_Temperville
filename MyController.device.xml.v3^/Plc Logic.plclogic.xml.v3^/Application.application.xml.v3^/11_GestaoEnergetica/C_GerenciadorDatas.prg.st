__METADATA__
{
  "v3Meta": {
    "objectGuid": "73fb45fd-b123-4c0d-b81f-34f1029f45a4",
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
PROGRAM C_GerenciadorDatas
VAR
END_VAR
__IMPLEMENTATION__
IF uDiaRealTime <> uDiaReferencia THEN
	
	rAquecendoDiario := rBufferAquecendoDiario;
	rBufferAquecendoDiario := 0;
	
	
	rDesligadoDiario := rBufferDesligadoDiario;
	rBufferDesligadoDiario := 0;
	
	rOciosoDiario := rBufferOciosoDiario;
	rBufferOciosoDiario := 0;
	
	rTestandoDiario := rBufferTestandoDiario;
	rBufferTestandoDiario := 0;
	
	rTrabalhandoDiario := rBufferTrabalhandoDiario;
	rBufferTrabalhandoDiario := 0;
	
	rConsumoInicialDiario := rConsumoEnergiaReal_kWh;
	
	uDiaReferencia := uDiaRealTime;
	
END_IF

IF uMesRealTime <> uMesReferencia THEN
	rAquecendoMensal := rBufferAquecendoMensal;
	rBufferAquecendoMensal := 0;
    
	
	rDesligadoMensal := rBufferDesligadoMensal;
	rBufferDesligadoMensal := 0;
    
	rOciosoMensal := rBufferOciosoMensal;
	rBufferOciosoMensal := 0;
	
	rTestandoMensal := rBufferTestandoMensal;
	rBufferTestandoMensal := 0;
	
	rTrabalhandoMensal := rBufferTrabalhandoMensal;
	rBufferTrabalhandoMensal := 0;
	
	bZeraAcumulado := TRUE;
	bGravaBancoE3 := TRUE;
	
ELSE
	uMesReferencia := uMesRealTime;
END_IF

