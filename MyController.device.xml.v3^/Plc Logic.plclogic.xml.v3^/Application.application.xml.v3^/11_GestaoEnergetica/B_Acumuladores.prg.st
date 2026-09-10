__METADATA__
{
  "v3Meta": {
    "objectGuid": "04df7826-dd08-4252-8f56-5bc865fc5598",
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
PROGRAM B_Acumuladores
VAR
	rInstAquecimento : REAL;
	rInstDesligado : REAL;
	rInstOcioso : REAL;
	rInstTrabalhando : REAL;
	rInstTestando : REAL;
END_VAR
__IMPLEMENTATION__



//--------------------- INICIO LÓGICA AQUECENDO ---------------------------\\

IF uStatusAquecimento = 1 THEN
	rInstAquecimento := (rBufferAquecendoDiario + rBufferDesligadoDiario + rBufferOciosoDiario + rBufferTestandoDiario + rBufferTrabalhandoDiario + rConsumoEnergiaReal_kWh) - rConsumoInicialDiario; 
	rBufferAquecendoDiario := rBufferAquecendoDiario + rInstAquecimento;
ELSE
	rInstAquecimento := 0;
END_IF


//------------------------ FIM LÓGICA AQUECENDO ---------------------------\\



//--------------------- INICIO LÓGICA DESLIGADO ---------------------------\\

IF xResistenciasLigadas = FALSE AND NOT xTesteResistencias AND NOT xTesteEntradaSaidas THEN
	rInstDesligado := (rBufferAquecendoDiario + rBufferDesligadoDiario + rBufferOciosoDiario + rBufferTestandoDiario + rBufferTrabalhandoDiario + rConsumoEnergiaReal_kWh) - rConsumoInicialDiario; 
	rBufferDesligadoDiario := rBufferDesligadoDiario + rInstDesligado;
END_IF

//------------------------ FIM LÓGICA DESLIGADO ---------------------------\\


//--------------------- INICIO LÓGICA OCIOSO ---------------------------\\

IF xResistenciasLigadas = TRUE AND uStatusMesaForno = 0 AND uStatusMesaResfriador = 0 THEN
	rInstOcioso := (rBufferAquecendoDiario + rBufferDesligadoDiario + rBufferOciosoDiario + rBufferTestandoDiario + rBufferTrabalhandoDiario + rConsumoEnergiaReal_kWh) - rConsumoInicialDiario; 
	rBufferOciosoDiario := rBufferOciosoDiario + rInstOcioso;
ELSE
	rInstOcioso := 0;
END_IF

//------------------------ FIM LÓGICA OCIOSO ---------------------------\\


//--------------------- INICIO LÓGICA TRABALHANDO ----------------------\\

IF xResistenciasLigadas = TRUE AND uStatusMesaForno = 1 OR xResistenciasLigadas = TRUE AND uStatusMesaResfriador = 1 THEN
	rInstTrabalhando := (rBufferAquecendoDiario + rBufferDesligadoDiario + rBufferOciosoDiario + rBufferTestandoDiario + rBufferTrabalhandoDiario + rConsumoEnergiaReal_kWh) - rConsumoInicialDiario; 
	rBufferTrabalhandoDiario := rBufferTrabalhandoDiario + rInstTrabalhando;
ELSE
	rInstTrabalhando := 0;
END_IF

//------------------------ FIM LÓGICA TRABALHANDO ----------------------\\

//--------------------- INICIO LÓGICA TESTANDO ----------------------\\

IF xResistenciasLigadas = FALSE AND xTesteResistencias OR xResistenciasLigadas = FALSE AND xTesteEntradaSaidas OR xOperacaoManual THEN
	rInstTestando := (rBufferAquecendoDiario + rBufferDesligadoDiario + rBufferOciosoDiario + rBufferTestandoDiario + rBufferTrabalhandoDiario + rConsumoEnergiaReal_kWh) - rConsumoInicialDiario; 
	rBufferTestandoDiario := rBufferTestandoDiario + rInstTestando;
ELSE
	rInstTestando := 0;
END_IF

//------------------------ FIM LÓGICA TESTANDO -----------------------\\
