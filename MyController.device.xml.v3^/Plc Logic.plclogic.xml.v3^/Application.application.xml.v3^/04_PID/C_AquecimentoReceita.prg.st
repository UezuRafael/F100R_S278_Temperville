__METADATA__
{
  "v3Meta": {
    "objectGuid": "865e59db-5792-4943-a117-ed76c956f7eb",
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
PROGRAM C_AquecimentoReceita
VAR
	Index: INT;
	PulsoLigaResistSupLento: PulsoPositivo;
	PulsoLigaResistSupRapid: PulsoPositivo;
	xTempoDesligaResist: TON;
	TemperaturaSetPointInferior: ARRAY[1..60] OF AlarmeTemperatura;
	TemperaturaSetPointSuperior: ARRAY[1..60] OF AlarmeTemperatura;
	xTemperaturaSetorInferiorOk: ARRAY[1..60] OF BOOL;
	xTemperaturaSetorSuperiorOk: ARRAY[1..60] OF BOOL;
	iSomaSetorInferiorOk: INT;
	iSomaSetorSuperiorOk: INT;
	xSetorInferiorQuente: BOOL;
	xSetorSuperiorQuente: BOOL;
	xFimAquecimentoReceita: BOOL;
	xPulsoLigaResistSupLento: BOOL;
	xPulsoLigaResistSupRapid: BOOL;
	xTempoDesligaResistIn: BOOL;
END_VAR
__IMPLEMENTATION__
// Aquecimento por Rampa e Patamar
	
IF (xBtLigaAquecimento)(* OR xDataHoraProgOk) AND xAqueceReceita*) THEN
	xBtLigaResCiclo:=TRUE;
	xIniciaAquecimentoRec:=TRUE;
	//xCmdIniciaCiclo:=TRUE;
END_IF

IF	xBtLigaAquecimento (*AND xAqueceReceita*) THEN
	xBtLigaAquecimento:=FALSE;
END_IF

IF xIniciaAquecimentoRec THEN
	xAuxiliarLigaResistenciasInferiores:=TRUE;
	xResistenciasLigadas:=TRUE;
	xCmdIniciaCiclo:=TRUE;
	xIniciaRelatorioAquecRec:=TRUE;
	uStatusAquecimento:=1;
	xIniciaAquecimentoRec:=FALSE;
END_IF

iSomaSetorInferiorOk:=0;
iSomaSetorSuperiorOk:=0;
FOR Index:= 1 TO iNumResistencias DO
// Temperatura Inferior
	TemperaturaSetPointInferior[Index](
		TermoparAtual:= 			TermoparLogicoInferior[Index]/10, 
		TemperaturaMax:= 			rSetTemperaturaInferior[Index], 
		ResetAlarm:= 				xBtDesligaAquecimento OR NOT xResistenciasLigadas, 
		TermoparAlmTemperatura=> 	xTemperaturaSetorInferiorOk[Index]);
		
	iSomaSetorInferiorOk:=iSomaSetorInferiorOk + BOOL_TO_INT(xTemperaturaSetorInferiorOk[Index]);

// Temperatura Superior
	TemperaturaSetPointSuperior[Index](
		TermoparAtual:= 			TermoparLogicoSuperior[Index]/10, 
		TemperaturaMax:= 			rSetTemperaturaSuperior[Index], 
		ResetAlarm:= 				xBtDesligaAquecimento OR NOT xResistenciasLigadas, 
		TermoparAlmTemperatura=> 	xTemperaturaSetorSuperiorOk[Index]);
		
	iSomaSetorSuperiorOk:=iSomaSetorSuperiorOk + BOOL_TO_INT(xTemperaturaSetorSuperiorOk[Index]);	
	
	xSetorInferiorQuente:=iSomaSetorInferiorOk=iNumResistencias;
	xSetorSuperiorQuente:=iSomaSetorSuperiorOk=iNumResistencias;

END_FOR	


xFimAquecimentoReceita:=xSetorInferiorQuente AND xSetorSuperiorQuente;

IF xFimAquecimentoReceita (*and xAqueceReceita*) THEN
	uStatusAquecimento:=2;
	xFimAquecimento:=TRUE;
	xFinalizaRelatorioAquecRec:=TRUE;
END_IF




//Pulso Liga Resistências Superiores

PulsoLigaResistSupLento(Entrada:= xSetorInferiorQuente, 				SaidaPulsoPo=> xPulsoLigaResistSupLento);
PulsoLigaResistSupRapid(Entrada:= xAuxiliarLigaResistenciasInferiores , SaidaPulsoPo=> xPulsoLigaResistSupRapid);

// Seleção do Aquecimento por Receita Rapido ou Lento


xAqueceLento:= FALSE;//NOT xBtSelAqueceRapidoLento AND xAqueceReceita;
xAqueceRapido:= TRUE;//xBtSelAqueceRapidoLento AND xAqueceReceita;

// Aquecimento Rápido
IF xAqueceRapido AND xPulsoLigaResistSupRapid THEN
	xAuxiliarLigaResistenciasSuperiores:=TRUE;
END_IF
// Aquecimento Lento
IF xAqueceLento AND xPulsoLigaResistSupLento THEN
	xAuxiliarLigaResistenciasSuperiores:=TRUE;
END_IF

// Desliga Resistência se Motor do forno não Rodando

IF NOT xMotorFornoLigado AND NOT xFornoEmCicloComCarga AND xResistenciasLigadas THEN
	xTempoDesligaResistIn:=TRUE;
ELSE
	xTempoDesligaResistIn:=FALSE;
END_IF

xTempoDesligaResist(IN:=xTempoDesligaResistIn , PT:=T#10S , Q=>xTempoDesligaResistQ , ET=> );

// Desligamento das Resistências
IF xBtDesligaAquecimento OR xSemEnergia OR xOperacaoManual OR xTempoDesligaResistQ OR xBtEmergencia THEN
	xAuxiliarLigaResistenciasInferiores:=FALSE;
	xAuxiliarLigaResistenciasSuperiores:=FALSE;
	xResistenciasLigadas:=FALSE;
	xIniciaAquecimentoRec:=FALSE;
	uStatusAquecimento:=0;
	xFimAquecimento:=FALSE;
	xCmFinalizaCiclo:=TRUE;
	//xDesligaAquecimento:=FALSE;
END_IF
IF xBtDesligaAquecimento (*AND xAqueceReceita*) THEN
	xBtDeslResCiclo:=true;
	xBtDesligaAquecimento:=FALSE;
END_IF

LigaInfPorAquecimentoReceita:= xAuxiliarLigaResistenciasInferiores;
LigaSupPorAquecimentoReceita:= xAuxiliarLigaResistenciasSuperiores;
