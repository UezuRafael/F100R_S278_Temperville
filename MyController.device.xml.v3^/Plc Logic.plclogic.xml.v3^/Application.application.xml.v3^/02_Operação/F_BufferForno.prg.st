__METADATA__
{
  "v3Meta": {
    "objectGuid": "966cb40d-c819-444b-b9c9-0a1a81230a8b",
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
PROGRAM F_BufferForno
VAR
	Index: INT;
	iEscreverReceitaForno: INT;
END_VAR
__IMPLEMENTATION__
IF ((sEntradaNomedaReceita<>sFornoNomedaReceita) OR xFornoReenvioRec) AND xFornoVazio THEN
	iEscreverReceitaForno:=1;
END_IF

IF iEscreverReceitaForno=1 THEN
	iFornoEspessuraVidro:=iEntradaEspessuraVidro;
	// Parametros de Aquecimento
	
	rSetTemperaturaInferiorGeral:=rBufferSetTemperaturaInferiorGeral;
	rSetTemperaturaSuperiorGeral:=rBufferSetTemperaturaSuperiorGeral;
	rSetPorcentagemInferiorGeral:=rBufferSetPorcentagemInferiorGeral;
	rSetPorcentagemSuperiorGeral:=rBufferSetPorcentagemSuperiorGeral;
	
	rSetTemperaturaInferiorGeralAux:=rBufferSetTemperaturaInferiorGeral;
	rSetTemperaturaSuperiorGeralAux:=rBufferSetTemperaturaSuperiorGeral;
	rSetPorcentagemInferiorGeralAux:=rBufferSetPorcentagemInferiorGeral;
	rSetPorcentagemSuperiorGeralAux:=rBufferSetPorcentagemSuperiorGeral;
	

	FOR Index:=1	TO iNumResistencias DO
		rSetTemperaturaSuperior[Index]:=rBufferSetTemperaturaSuperior[Index];
		rSetTemperaturaInferior[Index]:=rBufferSetTemperaturaInferior[Index];
		rSetPorcentagemSuperior[Index]:=rBufferSetPorcentagemSuperior[Index];
		rSetPorcentagemInferior[Index]:=rBufferSetPorcentagemInferior[Index];
	END_FOR

	iTempoPausaResistInf:=iBufferTempoPausaResistInf;
	iTempoPausaResistSup:=iBufferTempoPausaResistSup;
	iTempoPausa02ResistSup:=iBufferTempoPausa02ResistSup;
	iTempoInicioPausa02ResistSup:=iBufferTempoInicioPausa02ResistSup;
	
	iTempoConveccao:=iBufferTempoConveccao;

	// Parametros da Mesa do Forno
	iTempoDelayCarga:=iBufferTempoDelayCarga;
	iTempoPausaRoletes:=iBufferTempoPausaRoletes;
	iTempoAquecimForno:=iBufferTempoAquecimForno;
	iTempoPosicaoForno:=iBufferTempoPosicaoForno;//////////
	iTempoVelocidadeForno:=iBufferTempoVelocidadeForno;////
	iVelocidade01Vaivem:=iBufferVelocidade01Vaivem;////////
	iVelocidade02Vaivem:=iBufferVelocidade02Vaivem;////////
	iVelocidade03Vaivem:=iBufferVelocidade03Vaivem;////////
	iVelocidadeCargaMesadoForno:=iBufferVelocidadeCargaMesadoForno;////////
	iVelocidadeDescargaMesadoForno:=iBufferVelocidadeDescargaMesadoForno;/////////
	iCorretorCargaMesaEntrada:=iBufferCorretorCargaMesaEntrada;////////
	
	// Parametros da Mesa do Resfriador
	rBuffer02Emissividade:=rBufferEmissividade;
	
	iBuffer02TempoResfriamento:=iBufferTempoResfriamento;
	iBuffer02TempoTrocaEstagioResfriamento:=iBufferTempoTrocaEstagioResfriamento;
	iBuffer02TempoTrocaEstagio02Resfriamento:=iBufferTempoTrocaEstagio02Resfriamento;

	//iBuffer02Velocidade01Ventilador01:=iBufferVelocidade01Ventilador01;
	iVelocidade01Ventilador01:=iBufferVelocidade01Ventilador01;
	iBuffer02Velocidade02Ventilador01:=iBufferVelocidade02Ventilador01;
	iBuffer02Velocidade03Ventilador01:=iBufferVelocidade03Ventilador01;

	iBuffer02Velocidade01Ventilador02:=iBufferVelocidade01Ventilador02;
	iBuffer02Velocidade02Ventilador02:=iBufferVelocidade02Ventilador02;
	iBuffer02Velocidade03Ventilador02:=iBufferVelocidade03Ventilador02;

	iBuffer02Velocidade01Ventilador03:=iBufferVelocidade01Ventilador03;
	iBuffer02Velocidade02Ventilador03:=iBufferVelocidade02Ventilador03;
	iBuffer02Velocidade03Ventilador03:=iBufferVelocidade03Ventilador03;

	iBuffer02Velocidade01Ventilador04:=iBufferVelocidade01Ventilador04;
	iBuffer02Velocidade02Ventilador04:=iBufferVelocidade02Ventilador04;
	iBuffer02Velocidade03Ventilador04:=iBufferVelocidade03Ventilador04;

	// Parametros Resfriador 01 Inferior
	iBuffer02ValAltura01ResfriadorInf01:=iBufferValAltura01ResfriadorInf01;
	iBuffer02ValAltura02ResfriadorInf01:=iBufferValAltura02ResfriadorInf01;
	iBuffer02ValAltura03ResfriadorInf01:=iBufferValAltura03ResfriadorInf01;

	// Parametros Resfriador 01 Superior
	iBuffer02ValAltura01ResfriadorSup01:=iBufferValAltura01ResfriadorSup01;
	iBuffer02ValAltura02ResfriadorSup01:=iBufferValAltura02ResfriadorSup01;
	iBuffer02ValAltura03ResfriadorSup01:=iBufferValAltura03ResfriadorSup01;
	iBuffer02Veneziana:=iBufferVeneziana;
	iBuffer02Passagem:=iBufferPassagem;			

	
	// Parametros Resfriador 02 Inferior
	iBuffer02ValAltura01ResfriadorInf02:=iBufferValAltura01ResfriadorInf02;
	iBuffer02ValAltura02ResfriadorInf02:=iBufferValAltura02ResfriadorInf02;
	iBuffer02ValAltura03ResfriadorInf02:=iBufferValAltura03ResfriadorInf02;

	// Parametros Resfriador 02 Superior
	iBuffer02ValAltura01ResfriadorSup02:=iBufferValAltura01ResfriadorSup02;
	iBuffer02ValAltura02ResfriadorSup02:=iBufferValAltura02ResfriadorSup02;
	iBuffer02ValAltura03ResfriadorSup02:=iBufferValAltura03ResfriadorSup02;
		
	// Parametros Guilhotina 01	
	iBuffer02AlturaGhilhotina01:=iBufferAlturaGhilhotina01;

	iBuffer02AlturaGhilhotina01Sup:=iBufferAlturaGhilhotina01Sup;
	iBuffer02AlturaGhilhotina01Inf:=iBufferAlturaGhilhotina01Inf;

	// Parametros Guilhotina 02	
	iBuffer02AlturaGhilhotina02:=iBufferAlturaGhilhotina02;
	
	
	iBuffer02CorretorCargaMesaResfriador:=iBufferCorretorCargaMesaResfriador;
	iBuffer02VelocidadeVaiVemResfriador:=iBufferVelocidadeVaiVemResfriador;
	iBuffer02VelocidadeDescargaMesadoResfriador:=iBufferVelocidadeDescargaMesadoResfriador;
	iBuffer02CorretorCargaMesaSaida:=iBufferCorretorCargaMesaSaida;
	
	sFornoNomedaReceita:=sEntradaNomedaReceita;
	xResfriamentoReenvioRec:=xFornoReenvioRec;
	iEscreverReceitaForno:=0;
	xFornoReenvioRec:=0;
END_IF

IF iFornoEspessuraVidro = 4 THEN
	xEspessuraVidroFino:=TRUE;
	xEspessuraVidroGrosso:=FALSE;
ELSE	
	xEspessuraVidroFino:=FALSE;
	xEspessuraVidroGrosso:=TRUE;
END_IF
