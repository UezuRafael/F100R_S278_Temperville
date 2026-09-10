__METADATA__
{
  "v3Meta": {
    "objectGuid": "a281ef10-92a9-49ed-8cf0-439494e2e0f0",
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
PROGRAM G_BufferResfriamento
VAR
	Index: INT;
	iEscreverReceitaResfriamento: INT;
END_VAR
__IMPLEMENTATION__
//BUFFER PARAMETROS DO RESFRIAMENTO

(*---------------- SISTEMA NOVO --------------------*)


IF ((sFornoNomedaReceita<>sResfriamentoNomedaReceita) OR xResfriamentoReenvioRec) AND NOT xResfriadorEmCiclo THEN
	iEscreverReceitaResfriamento:=1;
END_IF

IF iEscreverReceitaResfriamento=1 THEN
	xResfriamentoReenvioRec:=0;
	iResfriamentoEspessuraVidro:=iFornoEspessuraVidro;

	
	// Parametros da Mesa do Resfriador
	rEmissividade:=rBuffer02Emissividade;
	
	iTempoResfriamento:=iBuffer02TempoResfriamento;
	iTempoTrocaEstagioResfriamento:=iBuffer02TempoTrocaEstagioResfriamento;
	iTempoTrocaEstagio02Resfriamento:=iBuffer02TempoTrocaEstagio02Resfriamento;
	
	//iVelocidade01Ventilador01:=iBuffer02Velocidade01Ventilador01;
	//iVelocidade02Ventilador01:=iBuffer02Velocidade02Ventilador01;
	//iVelocidade03Ventilador01:=iBuffer02Velocidade03Ventilador01;
	
	//iVelocidade01Ventilador02:=iBuffer02Velocidade01Ventilador02;
	//iVelocidade02Ventilador02:=iBuffer02Velocidade02Ventilador02;
	//iVelocidade03Ventilador02:=iBuffer02Velocidade03Ventilador02;

	iVelocidade01Ventilador03:=iBuffer02Velocidade01Ventilador03;
	iVelocidade02Ventilador03:=iBuffer02Velocidade02Ventilador03;
	iVelocidade03Ventilador03:=iBuffer02Velocidade03Ventilador03;
	
	//iVelocidade01Ventilador04:=iBuffer02Velocidade01Ventilador04;
	//iVelocidade02Ventilador04:=iBuffer02Velocidade02Ventilador04;
	//iVelocidade03Ventilador04:=iBuffer02Velocidade03Ventilador04;


	// Parametros Resfriador 01 Inferior
	iValAltura01ResfriadorInf01:=iBuffer02ValAltura01ResfriadorInf01;
	iValAltura02ResfriadorInf01:=iBuffer02ValAltura02ResfriadorInf01;
	iValAltura03ResfriadorInf01:=iBuffer02ValAltura03ResfriadorInf01;
	
	// Parametros Resfriador 01 Superior
	iValAltura01ResfriadorSup01:=iBuffer02ValAltura01ResfriadorSup01;
	iValAltura02ResfriadorSup01:=iBuffer02ValAltura02ResfriadorSup01;
	iValAltura03ResfriadorSup01:=iBuffer02ValAltura03ResfriadorSup01;
	iVeneziana:=iBuffer02Veneziana;
	iPassagem:=iBuffer02Passagem;
	
	// Parametros Resfriador 02 Inferior
	iValAltura01ResfriadorInf02:=iBuffer02ValAltura01ResfriadorInf02;
	iValAltura02ResfriadorInf02:=iBuffer02ValAltura02ResfriadorInf02;
	iValAltura03ResfriadorInf02:=iBuffer02ValAltura03ResfriadorInf02;
	
	// Parametros Resfriador 02 Superior
	iValAltura01ResfriadorSup02:=iBuffer02ValAltura01ResfriadorSup02;
	iValAltura02ResfriadorSup02:=iBuffer02ValAltura02ResfriadorSup02;
	iValAltura03ResfriadorSup02:=iBuffer02ValAltura03ResfriadorSup02;
	
	// Parametros Guilhotina 01
	iAlturaGhilhotina01:=iBuffer02AlturaGhilhotina01;

	iAlturaGhilhotina01Sup:=iBuffer02AlturaGhilhotina01Sup;
	iAlturaGhilhotina01Inf:=iBuffer02AlturaGhilhotina01Inf;
	
	// Parametros Guilhotina 02
	iAlturaGhilhotina02:=iBuffer02AlturaGhilhotina02;
	
	iCorretorCargaMesaResfriador:=iBuffer02CorretorCargaMesaResfriador;
	iVelocidadeVaiVemResfriador:=iBuffer02VelocidadeVaiVemResfriador;
	iVelocidadeDescargaMesadoResfriador:=iBuffer02VelocidadeDescargaMesadoResfriador;
	iCorretorCargaMesaSaida:=iBuffer02CorretorCargaMesaSaida;

	sResfriamentoNomedaReceita:=sFornoNomedaReceita;
	xBtRecAjustaAlturaDuctosSup01:=TRUE;
	xBtRecAjustaAlturaDuctosInf01:=TRUE;
	xBtRecAjustaAlturaDuctosSup02:=TRUE;
	xBtRecAjustaAlturaDuctosInf02:=TRUE;
	xBtRecAjustaGuilhotina01:=TRUE;
	xBtRecAjustaGuilhotina01Sup:=TRUE;
	xBtRecAjustaGuilhotina01Inf:=TRUE;
	xBtRecAjustaGuilhotina02:=TRUE;
	iEscreverReceitaResfriamento:=0;
	
	IF iVeneziana=1 THEN
		xValvulaVeneziana:=TRUE;
	ELSE
		xValvulaVeneziana:=FALSE;
	END_IF



END_IF

IF iResfriamentoEspessuraVidro = 4 THEN
	xEspessuraVidroFinoResfriador:=TRUE;
ELSE	
	xEspessuraVidroFinoResfriador:=FALSE;
END_IF
