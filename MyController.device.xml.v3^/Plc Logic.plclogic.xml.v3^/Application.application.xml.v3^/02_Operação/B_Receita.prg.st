__METADATA__
{
  "v3Meta": {
    "objectGuid": "3b4e12ef-b03e-4cae-b294-e4ede2db431f",
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
PROGRAM B_Receita
VAR
	TempoEnvioReceita: TON;
	TempoEnvioReceitaIn: BOOL;
	TempoEnvioReceitaQ: BOOL;
	Index: UINT;
	IndexSoma1: UINT;
	IndexSoma2: UINT;
	IndexSoma3: UINT;
	iSomaRecTemperaturaInferior: INT;
	iSomaRecTemperaturaSuperior: INT;
	iSomaRecPorcentagemInferior: INT;
	iSomaRecPorcentagemSuperior: INT;
	iSomaRecVelocidade01Ventilador01: INT;
	iSomaRecVelocidade02Ventilador01: INT;
	iSomaRecVelocidade01Ventilador02: INT;
	iSomaRecVelocidade02Ventilador02: INT;
	iSomaRecVelocidade01Ventilador03: INT;
	iSomaRecVelocidade02Ventilador03: INT;
	iSomaRecVelocidade01Ventilador04: INT;
	iSomaRecVelocidade02Ventilador04: INT;
	dSomaReceitaSuper: DINT;
END_VAR
__IMPLEMENTATION__
IF iHabilitaEscritaReceita=1 THEN
	xReceitaCarregadaOk:=FALSE;
	iEscreverReceita:=1;
	TempoEnvioReceitaIn:=TRUE;
	xBloqueioCargaEnvioRec:=TRUE;
	iHabilitaEscritaReceita:=0;
	
END_IF

IF iEscreverReceita=1 THEN
	IF 	sEntradaNomedaReceita=sRecNomedaReceita THEN
			xEntradaReenvioRec:=TRUE;
	ELSE
			xEntradaReenvioRec:=FALSE;
	END_IF

	iEntradaEspessuraVidro:=iRecEspessuraVidro;
	rBufferEmissividade:=rRecEmissividade;
	// Parametros de Aquecimento
	
	rBufferSetTemperaturaInferiorGeral:=rRecTemperaturaInferiorGeral;
	rBufferSetTemperaturaSuperiorGeral:=rRecTemperaturaSuperiorGeral;
	rBufferSetPorcentagemInferiorGeral:=rRecPorcentagemInferiorGeral;
	rBufferSetPorcentagemSuperiorGeral:=rRecPorcentagemSuperiorGeral;

	FOR Index:=1 TO iNumResistencias DO
		rBufferSetTemperaturaSuperior[Index]:=rRecTemperaturaSuperior[Index];
		rBufferSetTemperaturaInferior[Index]:=rRecTemperaturaInferior[Index];
		rBufferSetPorcentagemSuperior[Index]:=rRecPorcentagemSuperior[Index];
		rBufferSetPorcentagemInferior[Index]:=rRecPorcentagemInferior[Index];
	END_FOR

	iBufferTempoPausaResistInf:=iRecTempoPausaResistInf;
	iBufferTempoPausaResistSup:=iRecTempoPausaResistSup;
	iBufferTempoPausa02ResistSup:=iRecTempoPausa02ResistSup;
	iBufferTempoInicioPausa02ResistSup:=iRecTempoInicioPausa02ResistSup;
	
	iBufferTempoConveccao:=iRecTempoConveccao;

	// Parametros da Mesa do Forno
	iBufferTempoDelayCarga:=iRecTempoDelayCarga;
	iBufferTempoPausaRoletes:=iRecTempoPausaRoletes;
	iBufferTempoAquecimForno:=iRecTempoAquecimForno;
	iBufferTempoPosicaoForno:=iRecTempoPosicaoForno;//////////
	iBufferTempoVelocidadeForno:=iRecTempoVelocidadeForno;////
	iBufferVelocidade01Vaivem:=iRecVelocidade01Vaivem;////////
	iBufferVelocidade02Vaivem:=iRecVelocidade02Vaivem;////////
	iBufferVelocidade03Vaivem:=iRecVelocidade03Vaivem;////////
	iBufferVelocidadeCargaMesadoForno:=iRecVelocidadeCargaMesaForno;////////
	iBufferVelocidadeDescargaMesadoForno:=iRecVelocidadeDescargaMesaForno;/////////
	iBufferCorretorCargaMesaEntrada:=iRecCorretorCargaMesaEntrada;////////
	
	// Parametros da Mesa do Resfriador
	
	iBufferTempoResfriamento:=iRecTempoResfriamento;
	iBufferTempoTrocaEstagioResfriamento:=iRecTempoTrocaEstagioResfriamento;
	iBufferTempoTrocaEstagio02Resfriamento:=iRecTempoTrocaEstagio02Resfriamento;

	iBufferVelocidade01Ventilador01:=iRecVelocidade01Ventilador01;
	iBufferVelocidade02Ventilador01:=iRecVelocidade02Ventilador01;
	iBufferVelocidade03Ventilador01:=iRecVelocidade03Ventilador01;

	iBufferVelocidade01Ventilador02:=iRecVelocidade01Ventilador02;
	iBufferVelocidade02Ventilador02:=iRecVelocidade02Ventilador02;
	iBufferVelocidade03Ventilador02:=iRecVelocidade03Ventilador02;

	iBufferVelocidade01Ventilador03:=iRecVelocidade01Ventilador03;
	iBufferVelocidade02Ventilador03:=iRecVelocidade02Ventilador03;
	iBufferVelocidade03Ventilador03:=iRecVelocidade03Ventilador03;

	iBufferVelocidade01Ventilador04:=iRecVelocidade01Ventilador04;
	iBufferVelocidade02Ventilador04:=iRecVelocidade02Ventilador04;
	iBufferVelocidade03Ventilador04:=iRecVelocidade03Ventilador04;

	// Parametros Resfriador 01 Inferior
	iBufferValAltura01ResfriadorInf01:=iRecAltura01ResfriadorInf01;
	iBufferValAltura02ResfriadorInf01:=iRecAltura02ResfriadorInf01;
	iBufferValAltura03ResfriadorInf01:=iRecAltura03ResfriadorInf01;

	// Parametros Resfriador 01 Superior
	iBufferValAltura01ResfriadorSup01:=iRecAltura01ResfriadorSup01;
	iBufferValAltura02ResfriadorSup01:=iRecAltura02ResfriadorSup01;
	iBufferValAltura03ResfriadorSup01:=iRecAltura03ResfriadorSup01;
	iBufferVeneziana:=iRecVeneziana;
	iBufferPassagem:=iRecPassagem;

	// Parametros Resfriador 02 Inferior
	iBufferValAltura01ResfriadorInf02:=iRecAltura01ResfriadorInf02;
	iBufferValAltura02ResfriadorInf02:=iRecAltura02ResfriadorInf02;
	iBufferValAltura03ResfriadorInf02:=iRecAltura03ResfriadorInf02;

	// Parametros Resfriador 02 Superior
	iBufferValAltura01ResfriadorSup02:=iRecAltura01ResfriadorSup02;
	iBufferValAltura02ResfriadorSup02:=iRecAltura02ResfriadorSup02;
	iBufferValAltura03ResfriadorSup02:=iRecAltura03ResfriadorSup02;
	
	// Parametros Guilhotina 01
	iBufferAlturaGhilhotina01:=iRecAlturaGhilhotina01;

	iBufferAlturaGhilhotina01Sup:=iRecAlturaGhilhotina01Sup;
	iBufferAlturaGhilhotina01Inf:=iRecAlturaGhilhotina01Inf;

	// Parametros Guilhotina 02
	iBufferAlturaGhilhotina02:=iRecAlturaGhilhotina02;
	
	iBufferCorretorCargaMesaResfriador:=iRecCorretorCargaMesaResfriador;//////////////
	iBufferVelocidadeVaiVemResfriador:=iRecVelocidadeVaiVemResfriador;////////////////////
	iBufferVelocidadeDescargaMesadoResfriador:=iRecVelocidadeDescargaMesaResfriador;////////
	iBufferCorretorCargaMesaSaida:=iRecCorretorCargaMesaSaida;////////////////////

	iRecAjustaAlturaDuctosInf01:=iRecAjustaAlturaDuctosInf01;
	iRecAjustaAlturaDuctosSup01:=iRecAjustaAlturaDuctosSup01;
	iRecAjustaAlturaDuctosInf02:=iRecAjustaAlturaDuctosInf02;
	iRecAjustaAlturaDuctosSup02:=iRecAjustaAlturaDuctosSup02;
	iRecAjustaAlturaGuilho01:=iRecAjustaAlturaGuilho01;
	iRecAjustaAlturaGuilho02:=iRecAjustaAlturaGuilho02;

// Conferencia da Receita
	iSomaRecTemperaturaInferior:=0;
	FOR IndexSoma1:=1	TO iNumResistencias DO
		iSomaRecTemperaturaInferior:=iSomaRecTemperaturaInferior + REAL_TO_INT (rRecTemperaturaInferior[IndexSoma1]);
	END_FOR 
	iSomaRecPorcentagemInferior:=0;
	FOR IndexSoma2:=1	TO iNumResistencias DO
		iSomaRecPorcentagemInferior:=iSomaRecPorcentagemInferior + REAL_TO_INT (rRecPorcentagemInferior[IndexSoma2]);
	END_FOR 
	iSomaRecTemperaturaSuperior:=0;
	iSomaRecPorcentagemSuperior:=0;
	FOR IndexSoma3:=1	TO iNumResistencias DO
		iSomaRecTemperaturaSuperior:=iSomaRecTemperaturaSuperior + REAL_TO_INT (rRecTemperaturaSuperior[IndexSoma3]);
		iSomaRecPorcentagemSuperior:=iSomaRecPorcentagemSuperior + REAL_TO_INT (rRecPorcentagemSuperior[IndexSoma3]);
	END_FOR 

	
iSomaRecVelocidade01Ventilador01:=iRecVelocidade01Ventilador01/10;
iSomaRecVelocidade02Ventilador01:=iRecVelocidade02Ventilador01/10;
iSomaRecVelocidade01Ventilador02:=iRecVelocidade01Ventilador02/10;
iSomaRecVelocidade02Ventilador02:=iRecVelocidade02Ventilador02/10;
iSomaRecVelocidade01Ventilador03:=iRecVelocidade01Ventilador03/10;
iSomaRecVelocidade02Ventilador03:=iRecVelocidade02Ventilador03/10;
iSomaRecVelocidade01Ventilador04:=iRecVelocidade01Ventilador04/10;
iSomaRecVelocidade02Ventilador04:=iRecVelocidade02Ventilador04/10;

(*	
dSomaReceitaClp:=INT_TO_DINT(iRecEspessuraVidro+ REAL_TO_INT (rRecTemperaturaInferiorGeral+rRecTemperaturaSuperiorGeral+
rRecPorcentagemInferiorGeral+rRecPorcentagemSuperiorGeral)+iRecTempoPausaResistInf+iRecTempoPausaResistSup+
iRecTempoConveccao+iRecTempoPausaRoletes+iRecTempoAquecimForno+iRecTempoResfriamento+(iSomaRecVelocidade01Ventilador01)+
(iSomaRecVelocidade02Ventilador01)+(iSomaRecVelocidade01Ventilador02)+(iSomaRecVelocidade02Ventilador02)+
iRecTempoTrocaEstagioResfriamento+iRecAltura01Resfriador+iRecAltura02Resfriador+iRecAlturaGhilhotina+
iSomaRecTemperaturaInferior+iSomaRecTemperaturaSuperior+iSomaRecPorcentagemInferior+iSomaRecPorcentagemSuperior);	
*)
	dSomaReceitaSuper:=dSomaReceitaSuperClp;
	
	sEntradaNomedaReceita:=sRecNomedaReceita;
	xFornoReenvioRec:=xEntradaReenvioRec;
	iReceitaEscritaOk:=1;
	iEscreverReceita:=0;
	xEntradaReenvioRec:=0;
	xReceitaCarregadaOk:=TRUE;	
	xBloqueioCargaEnvioRec:=FALSE;
	xReceitaEnviadaEventos:=TRUE;
END_IF
(*
TempoEnvioReceita(IN:=TempoEnvioReceitaIn , PT:=T#15S , Q=>TempoEnvioReceitaQ , ET=> );

IF TempoEnvioReceitaQ THEN
	IF dSomaReceitaClp=dSomaReceitaSuper THEN
		iReceitaEscritaOk:=1;
		iEscreverReceita:=0;
		xReceitaCarregadaOk:=TRUE;
		TempoEnvioReceitaIn:=FALSE;	
	ELSE
		iReceitaEscritaFalha:=1;
		iEscreverReceita:=0;
		xReceitaCarregadaOk:=FALSE;
		TempoEnvioReceitaIn:=FALSE;	
	END_IF
END_IF
*)

IF (iResfriamentoEspessuraVidro=4 OR iResfriamentoEspessuraVidro=5) THEN
	xEspessuraVidroFino:=TRUE;
	xEspessuraVidroGrosso:=FALSE;
	xBufferValvulaDamperDifusor:=TRUE;
ELSE	
	xEspessuraVidroFino:=FALSE;
	xEspessuraVidroGrosso:=TRUE;
	xBufferValvulaDamperDifusor:=FALSE;
END_IF




