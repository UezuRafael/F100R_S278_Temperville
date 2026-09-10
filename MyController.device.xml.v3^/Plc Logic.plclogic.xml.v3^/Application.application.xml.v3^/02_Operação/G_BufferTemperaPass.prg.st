__METADATA__
{
  "v3Meta": {
    "objectGuid": "80d594ad-cdcb-45f5-a3d4-fd8eedd53c50",
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
PROGRAM G_BufferTemperaPass
VAR
	iEscreverReceitaPassagem: INT;
END_VAR
__IMPLEMENTATION__

IF ((sFornoNomedaReceita<>sResfriamentoNomedaReceita) OR xPassagemReenvioRec) AND NOT xPassandoTempera THEN
	iEscreverReceitaPassagem:=1;
END_IF

IF iEscreverReceitaPassagem=1 THEN
	xPassagemReenvioRec:=0;
	
	//iVelocidade01Ventilador01:=iBuffer02Velocidade01Ventilador01;
	//iVelocidade02Ventilador01:=iBuffer02Velocidade02Ventilador01;
	//iVelocidade03Ventilador01:=iBuffer02Velocidade03Ventilador01;
	
	iVelocidade01Ventilador02:=iBuffer02Velocidade01Ventilador02;
	iVelocidade02Ventilador02:=iBuffer02Velocidade02Ventilador02;
	iVelocidade03Ventilador02:=iBuffer02Velocidade03Ventilador02;
	
	iEscreverReceitaPassagem:=0;
END_IF
