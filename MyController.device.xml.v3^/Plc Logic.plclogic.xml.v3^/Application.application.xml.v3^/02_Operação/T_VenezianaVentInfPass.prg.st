__METADATA__
{
  "v3Meta": {
    "objectGuid": "1715e716-e3a6-4e4c-9a52-6ef75cd65278",
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
PROGRAM T_VenezianaVentInfPass
VAR
	xHabilitaVenezVent01InfPass: BOOL;
	xHabilitaVenezVent02InfPass: BOOL;
	xBloqCmdManVenez: BOOL;
END_VAR
__IMPLEMENTATION__
(*// ACIONAMENTO MANUAL

// Habilita/Desabilita Funcionamento Manual
IF xAbreVenezVentPass THEN
	xPassandoTempera:=TRUE;
END_IF
IF xFechVenezVentPass THEN
	xPassandoTempera:=FALSE;
END_IF

IF iVelocidade01Ventilador01<>0 THEN
	xHabilitaVenezVent01InfPass:=TRUE;
ELSE
	xHabilitaVenezVent01InfPass:=FALSE;
END_IF

IF (xHabilitaVenezVent01InfPass OR xHabilitaVenezVent02InfPass) AND xPassandoTempera THEN
	xBloqCmdManVenez:=TRUE;
ELSE
	xBloqCmdManVenez:=FALSE;
END_IF

IF BtAbreVenezVentInfPass AND NOT xBloqCmdManVenez THEN
	xValvulaDamperDifusor:=TRUE;
END_IF
IF BtAbreVenezVentInfPass THEN
	BtAbreVenezVentInfPass:=FALSE;
END_IF

IF BtFechVenezVentInfPass AND NOT xBloqCmdManVenez THEN
	xValvulaDamperDifusor:=FALSE;
END_IF
IF BtFechVenezVentInfPass THEN
	BtFechVenezVentInfPass:=FALSE;
END_IF

// ACIONAMENTO AUTOMATICO

// Habilita Funcionamento Veneziana
IF iVelocidade01Ventilador02<>0 THEN
	xHabilitaVenezVent02InfPass:=TRUE;
ELSE
	xHabilitaVenezVent02InfPass:=FALSE;
END_IF

//Comandos de Abertura e Fechamento
//Abre
IF (xAbreVenezVentPass AND xHabilitaVenezVent02InfPass ) THEN
	xValvulaDamperDifusor:=TRUE;
END_IF
IF xAbreVenezVentPass THEN
	xAbreVenezVentPass:=FALSE;
END_IF

//Fecha
IF xFechaVenezVentPassV01 OR xFechaVenezVentPassV02 OR xFechVenezVentPass THEN
	xValvulaDamperDifusor:=FALSE;
END_IF
IF xFechaVenezVentPassV01 THEN
	xFechaVenezVentPassV01:=FALSE;
END_IF
IF xFechaVenezVentPassV02 THEN
	xFechaVenezVentPassV02:=FALSE;
END_IF
IF xFechVenezVentPass THEN
	xFechVenezVentPass:=FALSE;
END_IF

IF xOperacaoManual THEN
	xPassandoTempera:=FALSE;
	xBloqCmdManVenez:=FALSE;
END_IF

// VELOCIDADE STAND BY VENTILADORES PASSAGEM

IF xHabilitaVenezVent01InfPass THEN
	iVelocidadeStbVent01Pass:=iVelocidadeStbVentilador01;
ELSE
	iVelocidadeStbVent01Pass:=0;
END_IF

IF xHabilitaVenezVent02InfPass THEN
	iVelocidadeStbVent02Pass:=iVelocidadeStbVentilador02;
ELSE
	iVelocidadeStbVent02Pass:=0;
END_IF*)
