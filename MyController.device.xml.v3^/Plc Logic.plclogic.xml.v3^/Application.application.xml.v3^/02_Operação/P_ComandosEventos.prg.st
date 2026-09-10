__METADATA__
{
  "v3Meta": {
    "objectGuid": "98a08585-4182-4e64-9f8f-08accd744e3a",
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
PROGRAM P_ComandosEventos
VAR
	TonInicioCicloEventos: ton;
	TonInicioCicloEventosIn: BOOL;
	TonInicioCicloEventosQ: BOOL;
	///------------ Disjuntores ----------------
	TpDisjGeralOn: PulsoPositivo;
	TpDisjGeralOff: PulsoPositivo;
	TpDisjResistOn: PulsoPositivo;
	TpDisjResistOff: PulsoPositivo;
	///------- Comandos Mesa de Operação -------
	TpOperacaoStandby: PulsoPositivo;
	TpOperacaoHabilitada: PulsoPositivo;
	TpBtEmergencia09On: PulsoPositivo;
	TpBtEmergencia09Off: PulsoNegativo;
	TpBt01ResetEmergencia: PulsoPositivo;
	///--- Comandos Mesa de Operação Manual ---
	TpOperacaoManual: PulsoPositivo;
	TpOperacaoAutoma: PulsoPositivo;
	TpBtEmergencia10On: PulsoPositivo;
	TpBtEmergencia10Off: PulsoNegativo;
	TpBt02ResetEmergencia: PulsoPositivo;
	///------ Comandos Mesa de Entrada ------
	TpBtEmergencia01On: PulsoPositivo;
	TpBtEmergencia01Off: PulsoNegativo;
	TpBtEmergencia02On: PulsoPositivo;
	TpBtEmergencia02Off: PulsoNegativo;
	TpBtConfirmaCarga: PulsoPositivo;
	TpChAvancoMeEntOn: PulsoPositivo;
	TpChAvancoMeEntOff: PulsoNegativo;
	TpChRecuoMeEntOn: PulsoPositivo;
	TpChRecuoMeEntOff: PulsoNegativo;
	TpGradeEntradaUp: PulsoPositivo;
	TpGradeEntradaDown: PulsoNegativo;
	TpBtEmergencia03On: PulsoPositivo;
	TpBtEmergencia03Off: PulsoNegativo;
	TpBtEmergencia04On: PulsoPositivo;
	TpBtEmergencia04Off: PulsoNegativo;
	///------ Comandos do Resfriamento ------
	TpBtEmergencia05On: PulsoPositivo;
	TpBtEmergencia05Off: PulsoNegativo;
	TpChAbreResfSup01: PulsoPositivo;
	TpChFechaResfSup01: PulsoNegativo;
	TpChAbreResfInf01: PulsoPositivo;
	TpChFechaResfInf01: PulsoNegativo;
	TpChAbreResfSup02: PulsoPositivo;
	TpChFechaResfSup02: PulsoNegativo;
	TpChAbreResfInf02: PulsoPositivo;
	TpChFechaResfInf02: PulsoNegativo;
	TpBtEmergencia06On: PulsoPositivo;
	TpBtEmergencia06Off: PulsoNegativo;
	TpChAvancoLimpVidroOn: PulsoPositivo;
	TpChAvancoLimpVidroOff: PulsoNegativo;
	TpChRecuoLimpVidroOn: PulsoPositivo;
	TpChRecuoLimpVidroOff: PulsoNegativo;
	///------- Comandos Mesa de Saida -------
	TpBtEmergencia07On: PulsoPositivo;
	TpBtEmergencia07Off: PulsoNegativo;
	TpChAvancoMeSaiOn: PulsoPositivo;
	TpChAvancoMeSaiOff: PulsoNegativo;
	TpChRecuoMeSaiOn: PulsoPositivo;
	TpChRecuoMeSaiOff: PulsoNegativo;
	TpGradeSaidaUp: PulsoPositivo;
	TpGradeSaidaDown: PulsoNegativo;
	TpBtEmergencia08On: PulsoPositivo;
	TpBtEmergencia08Off: PulsoNegativo;
	///------ Comandos do Supervisório ------
	TpBtEnvioDeReceita: PulsoPositivo;
	TpBtHmiIniciaCiclo: PulsoPositivo;
	TpBtHmiFinalizaCiclo: PulsoPositivo;
	TpBtSairForno: PulsoPositivo;
	TpBtSairResfriamento: PulsoPositivo;
	TpBtAbrePortaEntrForno: PulsoPositivo;
	TpBtFechaPortaEntForno: PulsoNegativo;
	TpBtAbrePortaSaidaForno: PulsoPositivo;
	TpBtFechaPortaSaidForno: PulsoNegativo;
	TpBtForceConveccaoOn: PulsoPositivo;
	TpBtForceConveccaoOff: PulsoNegativo;
	TpBtSobeForno: PulsoPositivo;
	TpBtDesceForno: PulsoPositivo;
	TpTesteAutoResistencia: PulsoPositivo;
	TpTesteAutoResistFim: PulsoPositivo;
	TpTesteAutoResistAbort: PulsoPositivo;
	TpProgrHorariaAtivada: PulsoPositivo;
	TpProgrHorariaDesativada: PulsoNegativo;
	TpProgrHorariaIniciadda: PulsoPositivo;
	TpBtLigaAquecimentoRampa: PulsoPositivo;
	TpBtLigaAquecimento: PulsoPositivo;
	TpBtDesligaAquecimento: PulsoPositivo;
	TpResistenciaLigada: PulsoPositivo;
	TpResistenciaDesligada: PulsoNegativo;
	TpHomeDutosIniciado: PulsoPositivo;
	TpHomeDutosOK: PulsoPositivo;
	TpHomeGuilhotinaIniciado: PulsoPositivo;
	TpHomeGuilhotinaOK: PulsoPositivo;
END_VAR
__IMPLEMENTATION__
//Registro de Eventos

//Sinais Retorno Disjuntores
(*----------- Disjuntor Geral -------------*)
TpDisjGeralOn	(Entrada:= xDisjGeralOn, 	SaidaPulsoPo=> );
TpDisjGeralOff	(Entrada:= xDisjGeralOff, 	SaidaPulsoPo=> );
	
(*-------- Disjuntor Resistências ---------*)
TpDisjResistOn	(Entrada:= xDisjResistOn, 	SaidaPulsoPo=> );
TpDisjResistOff	(Entrada:= xDisjResistOff, 	SaidaPulsoPo=> );


//Sinais de Acionamento de Botoes Fisicos
(*------- Comandos Mesa de Operação -------*) 
TpOperacaoHabilitada	(Entrada:= xOperacaoHabilitada, 	SaidaPulsoPo=> );
TpOperacaoStandby		(Entrada:= xOperacaoStandBy, 		SaidaPulsoPo=> );
TpBtEmergencia09On		(Entrada:= xBt09Emergencia, 		SaidaPulsoPo=> );
TpBtEmergencia09Off		(Entrada:= xBt09Emergencia, 		SaidaPulsoNe=> );
TpBt01ResetEmergencia	(Entrada:= xBt01CalaAlarme, 		SaidaPulsoPo=> );

(*--- Comandos Mesa de Operação Manual ---*) 
TpOperacaoManual		(Entrada:= xOperacaoManual, 		SaidaPulsoPo=> );
TpOperacaoAutoma		(Entrada:= xOperacaoAutoma, 		SaidaPulsoPo=> );
TpBtEmergencia10On		(Entrada:= xBt10Emergencia,			SaidaPulsoPo=> );
TpBtEmergencia10Off		(Entrada:= xBt10Emergencia,			SaidaPulsoNe=> );
TpBt02ResetEmergencia	(Entrada:= xBt02CalaAlarme, 		SaidaPulsoPo=> );

(*------ Comandos Mesa de Entrada ------*) 
TpBtEmergencia01On		(Entrada:= xBt01Emergencia,			SaidaPulsoPo=> );
TpBtEmergencia01Off		(Entrada:= xBt01Emergencia,			SaidaPulsoNe=> );
TpBtEmergencia02On		(Entrada:= xBt02Emergencia,			SaidaPulsoPo=> );
TpBtEmergencia02Off		(Entrada:= xBt02Emergencia,			SaidaPulsoNe=> );
TpBtConfirmaCarga		(Entrada:= xBtHabilitaCarregamento,	SaidaPulsoPo=> );
TpChAvancoMeEntOn		(Entrada:= xChAvancaMesaEntrada,	SaidaPulsoPo=> );
TpChAvancoMeEntOff		(Entrada:= xChAvancaMesaEntrada,	SaidaPulsoNe=> );
TpChRecuoMeEntOn		(Entrada:= xChRecuaMesaEntrada,		SaidaPulsoPo=> );
TpChRecuoMeEntOff		(Entrada:= xChRecuaMesaEntrada,		SaidaPulsoNe=> );
TpGradeEntradaUp		(Entrada:= xValvulaGradeEntrada,	SaidaPulsoPo=> );
TpGradeEntradaDown		(Entrada:= xValvulaGradeEntrada,	SaidaPulsoNe=> );
TpBtEmergencia03On		(Entrada:= xBt03Emergencia,			SaidaPulsoPo=> );
TpBtEmergencia03Off		(Entrada:= xBt03Emergencia,			SaidaPulsoNe=> );
TpBtEmergencia04On		(Entrada:= xBt04Emergencia,			SaidaPulsoPo=> );
TpBtEmergencia04Off		(Entrada:= xBt04Emergencia,			SaidaPulsoNe=> );

(*------ Comandos do Resfriamento ------*)
TpBtEmergencia05On		(Entrada:= xBt05Emergencia,			SaidaPulsoPo=> );
TpBtEmergencia05Off		(Entrada:= xBt05Emergencia,			SaidaPulsoNe=> );
TpChAbreResfSup01		(Entrada:= xChAbreDuctosResfriadorSup01,SaidaPulsoPo=> );
TpChFechaResfSup01		(Entrada:= xChAbreDuctosResfriadorSup01,SaidaPulsoNe=> );
TpChAbreResfInf01		(Entrada:= xChAbreDuctosResfriadorInf01,SaidaPulsoPo=> );
TpChFechaResfInf01		(Entrada:= xChAbreDuctosResfriadorInf01,SaidaPulsoNe=> );
TpChAbreResfSup02		(Entrada:= xChAbreDuctosResfriadorSup02,SaidaPulsoPo=> );
TpChFechaResfSup02		(Entrada:= xChAbreDuctosResfriadorSup02,SaidaPulsoNe=> );
TpChAbreResfInf02		(Entrada:= xChAbreDuctosResfriadorInf02,SaidaPulsoPo=> );
TpChFechaResfInf02		(Entrada:= xChAbreDuctosResfriadorInf02,SaidaPulsoNe=> );
TpBtEmergencia06On		(Entrada:= xBt06Emergencia,				SaidaPulsoPo=> );
TpBtEmergencia06Off		(Entrada:= xBt06Emergencia,				SaidaPulsoNe=> );
TpChAvancoLimpVidroOn	(Entrada:= xChAvancoLimpaResfriador02,	SaidaPulsoPo=> );
TpChAvancoLimpVidroOff	(Entrada:= xChAvancoLimpaResfriador02,	SaidaPulsoNe=> );
TpChRecuoLimpVidroOn	(Entrada:= xChRecuoLimpaResfriador02,	SaidaPulsoPo=> );
TpChRecuoLimpVidroOff	(Entrada:= xChRecuoLimpaResfriador02,	SaidaPulsoNe=> );

(*------- Comandos Mesa de Saida -------*)
TpBtEmergencia07On		(Entrada:= xBt07Emergencia,		SaidaPulsoPo=> );
TpBtEmergencia07Off		(Entrada:= xBt07Emergencia,		SaidaPulsoNe=> );
TpChAvancoMeSaiOn		(Entrada:= xChAvancaMesaSaida,	SaidaPulsoPo=> );
TpChAvancoMeSaiOff		(Entrada:= xChAvancaMesaSaida,	SaidaPulsoNe=> );
TpChRecuoMeSaiOn		(Entrada:= xChRecuaMesaSaida,	SaidaPulsoPo=> );
TpChRecuoMeSaiOff		(Entrada:= xChRecuaMesaSaida,	SaidaPulsoNe=> );
TpGradeSaidaUp			(Entrada:= xValvulaGradeSaida,	SaidaPulsoPo=> );
TpGradeSaidaDown		(Entrada:= xValvulaGradeSaida,	SaidaPulsoNe=> );
TpBtEmergencia08On		(Entrada:= xBt08Emergencia,		SaidaPulsoPo=> );
TpBtEmergencia08Off		(Entrada:= xBt08Emergencia,		SaidaPulsoNe=> );

//Sinais de Acionamento de Botoes Logicos 

TpBtEnvioDeReceita		(Entrada:= xReceitaEnviadaEventos,	SaidaPulsoPo=> );
xReceitaEnviadaEventos:=FALSE;
TpBtHmiIniciaCiclo		(Entrada:= xBtHmiIniciaCiclo, 		SaidaPulsoPo=> );
TpBtHmiFinalizaCiclo	(Entrada:= xBtHmiFinalizaCiclo, 	SaidaPulsoPo=> );
TpBtSairForno			(Entrada:= xSairForno, 			SaidaPulsoPo=> );
TpBtSairResfriamento	(Entrada:= xSairResfriamentoEventos,SaidaPulsoPo=> );
xSairResfriamentoEventos:=FALSE;
TpBtAbrePortaEntrForno	(Entrada:= xPortaEntradaFornoForce, SaidaPulsoPo=> );
TpBtFechaPortaEntForno	(Entrada:= xPortaEntradaFornoForce, SaidaPulsoNe=> );
TpBtAbrePortaSaidaForno	(Entrada:= xPortaSaidaFornoForce, 	SaidaPulsoPo=> );
TpBtFechaPortaSaidForno	(Entrada:= xPortaSaidaFornoForce, 	SaidaPulsoNe=> );
TpBtForceConveccaoOn	(Entrada:= xForceConveccao, 		SaidaPulsoPo=> );
TpBtForceConveccaoOff	(Entrada:= xForceConveccao, 		SaidaPulsoNe=> );
TpBtSobeForno			(Entrada:= xBtSobeForno	, 			SaidaPulsoPo=> );
TpBtDesceForno			(Entrada:= xBtDesceForno,		 	SaidaPulsoPo=> );
TpTesteAutoResistencia	(Entrada:= bIniciaTesteResistencias,SaidaPulsoPo=> );
TpTesteAutoResistAbort	(Entrada:= bAbortaTesteResistencias,SaidaPulsoPo=> );
TpTesteAutoResistFim	(Entrada:= bResetTesteResistencias,	SaidaPulsoPo=> );
TpProgrHorariaAtivada	(Entrada:= xStatusAtvProgHoraria, 	SaidaPulsoPo=> );
TpProgrHorariaDesativada(Entrada:= xStatusAtvProgHoraria, 	SaidaPulsoNe=> );
TpProgrHorariaIniciadda	(Entrada:= xDataHoraProgOk, 		SaidaPulsoPo=> );

TpBtLigaAquecimentoRampa(Entrada:= xBtLigaResRampa, 	SaidaPulsoPo=> );
xBtLigaResRampa:=FALSE;
TpBtLigaAquecimento		(Entrada:= xBtLigaResCiclo, 	SaidaPulsoPo=> );
xBtLigaResCiclo:=FALSE;
TpBtDesligaAquecimento	(Entrada:= xBtDeslResCiclo, 	SaidaPulsoPo=> );
xBtDeslResCiclo:=FALSE;

TpResistenciaLigada		(Entrada:= xResistenciasLigadas, 	SaidaPulsoPo=> );
TpResistenciaDesligada	(Entrada:= xResistenciasLigadas, 	SaidaPulsoNe=> );


TpHomeDutosIniciado		(Entrada:= , 	SaidaPulsoPo=> );
TpHomeDutosOK			(Entrada:=xHomeDuctosResfriadorSup01Ok , 	SaidaPulsoPo=> );
TpHomeGuilhotinaIniciado(Entrada:= , 	SaidaPulsoPo=> );
TpHomeGuilhotinaOK		(Entrada:=xHomeGuilhotina01Ok , 	SaidaPulsoPo=> );


// Tempo para Inicio de Ciclo

TonInicioCicloEventosIn:=TRUE;
TonInicioCicloEventos(IN:=TonInicioCicloEventosIn , PT:=T#200MS , Q=>TonInicioCicloEventosQ, ET=> );

IF TonInicioCicloEventosQ THEN
	
	(*------------- Disjuntores ---------------*)
	IF TpDisjGeralOn.SaidaPulsoPo			THEN bDisjGeralOn	:=TRUE;		END_IF;
	IF TpDisjGeralOff.SaidaPulsoPo			THEN bDisjGeralOff	:=TRUE;		END_IF;
	IF TpDisjResistOn.SaidaPulsoPo			THEN bDisjResistOn	:=TRUE;		END_IF;
	IF TpDisjResistOff.SaidaPulsoPo			THEN bDisjResistOff	:=TRUE;		END_IF;
	

	(*------- Comandos Mesa de Operação -------*) 
	IF TpOperacaoStandby.SaidaPulsoPo 		THEN bMaquinaOperacaoStandby:=TRUE;		END_IF;
	IF TpOperacaoHabilitada.SaidaPulsoPo 	THEN bMaquinaOperacaoHabilitada:=TRUE;	END_IF;
	IF TpBtEmergencia01On.SaidaPulsoPo 		THEN bEmergencia01On:=TRUE;		END_IF;
	IF TpBtEmergencia01Off.SaidaPulsoNe 	THEN bEmergencia01Off:=TRUE;	END_IF;
	IF TpBt01ResetEmergencia.SaidaPulsoPo	THEN b01ResetEmergencia:=TRUE;  END_IF;

	(*--- Comandos Mesa de Operação Manual ---*) 
	IF TpOperacaoManual.SaidaPulsoPo 		THEN bMaquinaEmManual:=TRUE;		END_IF;
	IF TpOperacaoAutoma.SaidaPulsoPo 		THEN bMaquinaEmAutoma:=TRUE;		END_IF;
	IF TpBtEmergencia10On.SaidaPulsoPo 		THEN bEmergencia10On:=TRUE;		END_IF;
	IF TpBtEmergencia10Off.SaidaPulsoNe 	THEN bEmergencia10Off:=TRUE;	END_IF;
	IF TpBt02ResetEmergencia.SaidaPulsoPo	THEN b02ResetEmergencia:=TRUE;  END_IF;

	(*------ Comandos Mesa de Entrada ------*) 
	IF TpBtEmergencia02On.SaidaPulsoPo 		THEN bEmergencia02On:=TRUE;		END_IF;
	IF TpBtEmergencia02Off.SaidaPulsoNe 	THEN bEmergencia02Off:=TRUE;	END_IF;
	IF TpBtConfirmaCarga.SaidaPulsoPo 		THEN bConfirmaCarga:=TRUE;		END_IF;
	IF TpChAvancoMeEntOn.SaidaPulsoPo 		THEN bAvancoMeEntOn:=TRUE;		END_IF;
	IF TpChAvancoMeEntOff.SaidaPulsoNe 		THEN bAvancoMeEntOff:=TRUE;		END_IF;
	IF TpChRecuoMeEntOn.SaidaPulsoPo 		THEN bRecuoMeEntOn:=TRUE;		END_IF;
	IF TpChRecuoMeEntOff.SaidaPulsoNe 		THEN bRecuoMeEntOff:=TRUE;		END_IF;
	IF TpGradeEntradaUp.SaidaPulsoPo 		THEN bGradeEntradaUp:=TRUE;		END_IF;
	IF TpGradeEntradaDown.SaidaPulsoNe 		THEN bGradeEntradaDown:=TRUE;	END_IF;
	

	(*------ Comandos do Resfriamento ------*)
	IF TpBtEmergencia03On.SaidaPulsoPo 		THEN bEmergencia03On:=TRUE;		END_IF;
	IF TpBtEmergencia03Off.SaidaPulsoNe 	THEN bEmergencia03Off:=TRUE;	END_IF;
	IF TpBtEmergencia05On.SaidaPulsoPo 		THEN bEmergencia05On:=TRUE;		END_IF;
	IF TpBtEmergencia05Off.SaidaPulsoNe 	THEN bEmergencia05Off:=TRUE;	END_IF;
	IF TpChAbreResfSup01.SaidaPulsoPo 		THEN bAbreResfSup01:=TRUE;		END_IF;
	IF TpChFechaResfSup01.SaidaPulsoNe 		THEN bFechaResfSup01:=TRUE;		END_IF;
	IF TpChAbreResfInf01.SaidaPulsoPo 		THEN bAbreResfInf01:=TRUE;		END_IF;
	IF TpChFechaResfInf01.SaidaPulsoNe 		THEN bFechaResfInf01:=TRUE;		END_IF;
	IF TpChAbreResfSup02.SaidaPulsoPo 		THEN bAbreResfSup02:=TRUE;		END_IF;
	IF TpChFechaResfSup02.SaidaPulsoNe 		THEN bFechaResfSup02:=TRUE;		END_IF;
	IF TpChAbreResfInf02.SaidaPulsoPo 		THEN bAbreResfInf02:=TRUE;		END_IF;
	IF TpChFechaResfInf02.SaidaPulsoNe 		THEN bFechaResfInf02:=TRUE;		END_IF;
	IF TpBtEmergencia06On.SaidaPulsoPo 		THEN bEmergencia06On:=TRUE;		END_IF;
	IF TpBtEmergencia06Off.SaidaPulsoNe 	THEN bEmergencia06Off:=TRUE;	END_IF;
	IF TpChAvancoLimpVidroOn.SaidaPulsoPo 	THEN bAvancoLimpVidroOn:=TRUE;	END_IF;
	IF TpChAvancoLimpVidroOff.SaidaPulsoNe 	THEN bAvancoLimpVidroOff:=TRUE;	END_IF;
	IF TpChRecuoLimpVidroOn.SaidaPulsoPo 	THEN bRecuoLimpVidroOn:=TRUE;	END_IF;
	IF TpChRecuoLimpVidroOff.SaidaPulsoNe 	THEN bRecuoLimpVidroOff:=TRUE;	END_IF;

	(*------- Comandos Mesa de Saida -------*)
	IF TpBtEmergencia04On.SaidaPulsoPo 		THEN bEmergencia04On:=TRUE;		END_IF;
	IF TpBtEmergencia04Off.SaidaPulsoNe 	THEN bEmergencia04Off:=TRUE;	END_IF; 
	IF TpBtEmergencia07On.SaidaPulsoPo 		THEN bEmergencia07On:=TRUE;		END_IF;
	IF TpBtEmergencia07Off.SaidaPulsoNe 	THEN bEmergencia07Off:=TRUE;	END_IF;
	IF TpChAvancoMeSaiOn.SaidaPulsoPo 		THEN bAvancoMeSaiOn:=TRUE;		END_IF;
	IF TpChAvancoMeSaiOff.SaidaPulsoNe 		THEN bAvancoMeSaiOff:=TRUE;		END_IF;
	IF TpChRecuoMeSaiOn.SaidaPulsoPo 		THEN bRecuoMeSaiOn:=TRUE;		END_IF;
	IF TpChRecuoMeSaiOff.SaidaPulsoNe 		THEN bRecuoMeSaiOff:=TRUE;		END_IF;
	IF TpGradeSaidaUp.SaidaPulsoPo 			THEN bGradeSaidaUp:=TRUE;		END_IF;
	IF TpGradeSaidaDown.SaidaPulsoNe 		THEN bGradeSaidaDown:=TRUE;		END_IF;
	IF TpBtEmergencia08On.SaidaPulsoPo 		THEN bEmergencia08On:=TRUE;		END_IF;
	IF TpBtEmergencia08Off.SaidaPulsoNe 	THEN bEmergencia08Off:=TRUE;	END_IF;

	(*------ Comandos do Supervisório ------*)	
	IF TpBtEnvioDeReceita.SaidaPulsoPo 		THEN bEnvioDeReceita:=TRUE; 		END_IF;
	IF TpBtHmiIniciaCiclo.SaidaPulsoPo 		THEN bHimIniciaCiclo:=TRUE; 		END_IF;
	IF TpBtHmiFinalizaCiclo.SaidaPulsoPo 	THEN bHimFinalCiclo:=TRUE; 			END_IF;
	IF TpBtSairForno.SaidaPulsoPo 			THEN bBtSairForno:=TRUE; 			END_IF;
	IF TpBtSairResfriamento.SaidaPulsoPo 	THEN bBtSairResfriamento:=TRUE; 	END_IF;
	IF TpBtAbrePortaEntrForno.SaidaPulsoPo 	THEN bBtAbrePortaEntrForno:=TRUE; 	END_IF;
	IF TpBtFechaPortaEntForno.SaidaPulsoNe 	THEN bBtFechaPortaEntForno:=TRUE; 	END_IF;
	IF TpBtAbrePortaSaidaForno.SaidaPulsoPo	THEN bBtAbrePortaSaidaForno:=TRUE;	END_IF;
	IF TpBtFechaPortaSaidForno.SaidaPulsoNe	THEN bBtFechaPortaSaidForno:=TRUE;	END_IF;
	IF TpBtForceConveccaoOn.SaidaPulsoPo		THEN	bBtForceConveccaoOn:=TRUE;		END_IF;	  
	IF TpBtForceConveccaoOff.SaidaPulsoNe		THEN	bBtForceConveccaoOff:=TRUE;		END_IF;
	IF TpBtSobeForno.SaidaPulsoPo				THEN	bBtSobeForno:=TRUE;				END_IF;
	IF TpBtDesceForno.SaidaPulsoPo				THEN	bBtDesceForno:=TRUE;			END_IF;
	IF TpTesteAutoResistencia.SaidaPulsoPo		THEN	bTesteAutoResistencia:=TRUE;	END_IF;
	IF TpTesteAutoResistAbort.SaidaPulsoPo		THEN	bTesteAutoResistAbort:=TRUE;	END_IF;
	IF TpTesteAutoResistFim.SaidaPulsoPo		THEN	bTesteAutoResistFim:=TRUE;		END_IF;
	IF TpProgrHorariaAtivada.SaidaPulsoPo		THEN	bProgrHorariaAtivada:=TRUE;		END_IF;
	IF TpProgrHorariaDesativada.SaidaPulsoNe	THEN	bProgrHorariaDesativada:=TRUE;	END_IF;
	IF TpProgrHorariaIniciadda.SaidaPulsoPo		THEN	bProgrHorariaIniciadda:=TRUE;	END_IF;
	IF TpBtLigaAquecimentoRampa.SaidaPulsoPo	THEN	bBtLigaAquecimentoRampa:=TRUE;	END_IF;
	IF TpBtLigaAquecimento.SaidaPulsoPo			THEN	bBtLigaAquecimento:=TRUE;		END_IF;
	IF TpBtDesligaAquecimento.SaidaPulsoPo		THEN	bBtDesligaAquecimento:=TRUE;	END_IF;
	IF TpResistenciaLigada.SaidaPulsoPo			THEN	bResistenciaLigada:=TRUE;		END_IF;
	IF TpResistenciaDesligada.SaidaPulsoNe		THEN	bResistenciaDesligada:=TRUE;	END_IF;

	IF TpHomeDutosIniciado.SaidaPulsoPo			THEN	bHomeDutosIniciado:=TRUE;		END_IF;
	IF TpHomeDutosOK.SaidaPulsoPo				THEN	bHomeDutosOK:=TRUE;				END_IF;
	IF TpHomeGuilhotinaIniciado.SaidaPulsoPo	THEN	bHomeGuilhotinaIniciado:=TRUE;	END_IF;
	IF TpHomeGuilhotinaOK.SaidaPulsoPo			THEN	bHomeGuilhotinaOK:=TRUE;		END_IF;
	
END_IF



