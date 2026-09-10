__METADATA__
{
  "v3Meta": {
    "objectGuid": "bc18a1fd-8f29-4e0b-a16b-ee38d9ea1e98",
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
PROGRAM C_ComandosOperacao
VAR
	PassoCmdForno: INT;
	PulsoLedFinalizando: TimerGeneration;
	PulsoLedRestart: TimerGeneration;
	PulsoLedEmEspera: TimerGeneration;
	TonxPausaEmergenciaDelay: TOF;
	TpRestart: TP;
	PulsoPoBtReinicia: PulsoPositivo;
	xLedFornoFinalizando: BOOL;
	xBtRestart: BOOL;
	xPoBtReinicia: BOOL;
	PulsoOperManual: TP;
	PulsoOperAutoma: TP;
	TonOperManual: TON;
	TonOperAutoma: TON;
	TofOperManual: TON;
	TofOperAutoma: TON;
	
	PulsoPoStartCiclo: PulsoPositivo;
	xFornoEmCicloPulso:	BOOL ;

END_VAR
__IMPLEMENTATION__
// SEQUENCIA DE CONTROLE DE OPERAÇÃO

// Seleção Operação ou Stand By

//IF xChStandByOperacao THEN
	xOperacaoHabilitada:=TRUE;
//	xOperacaoStandBy:=FALSE;
(*ELSE
	xOperacaoHabilitada:=FALSE;
	xOperacaoStandBy:=TRUE;
END_IF*)

//Seleção do Modo de Operação Manual ou Automatico
IF xChAutomaticoManual THEN
	xOperacaoManual:=TRUE;
	xOperacaoAutoma:=FALSE;
ELSE
	xOperacaoManual:=FALSE;
	xOperacaoAutoma:=TRUE;
END_IF

PulsoOperManual(IN:= xOperacaoManual, PT:=T#1S , Q=> xPulsoOperacaoManual, ET=> );
PulsoOperAutoma(IN:= xOperacaoAutoma, PT:=T#1S , Q=> xPulsoOperacaoAutoma, ET=> );
TonOperManual(IN:= xOperacaoManual, PT:=T#1S , Q=> xTonOperacaoManual, ET=> );
TonOperAutoma(IN:= xOperacaoAutoma, PT:=T#1S , Q=> xTonOperacaoAutoma, ET=> );
TofOperManual(IN:= xOperacaoManual, PT:=T#1S , Q=> xTofOperacaoManual, ET=> );
TofOperAutoma(IN:= xOperacaoAutoma, PT:=T#1S , Q=> xTofOperacaoAutoma, ET=> );

//Botão de Emergência
xEmergencia:=xBtEmergencia;
// Emergencia para o Supervisório
xBtEmergenciaAcionado:= xBtEmergencia;

IF xEmergencia OR xAlarmeMotorForno THEN
	xPause:=TRUE;
	xRestart:=FALSE;
	xPausaEmergencia:=TRUE;
END_IF
IF NOT xEmergencia THEN
	xPause:=FALSE;
END_IF
(* Reinicio sem Botao Reinicia somente no Reset Alarme *) 
IF NOT xEmergencia AND bResetAlmGeral THEN
	xRestart:=TRUE;
	xPausaEmergencia:=FALSE;
ELSE
	xRestart:=FALSE;
END_IF

(* Reinicio com Botão Reinicia Apos Reconhecimento do alarme *)
(*PulsoPoBtReinicia(Entrada:=xBtReinicia, SaidaPulsoPo=>xPoBtReinicia );

IF BtRestart OR xPoBtReinicia THEN
	xBtRestart:=TRUE;
	BtRestart:=FALSE;
ELSE
	xBtRestart:=FALSE;	
END_IF

TpRestart(IN:=xBtRestart , PT:=T#500MS , Q=>xBtRestart , ET=> );

IF NOT xEmergencia AND xReleSeguranca AND xBtRestart THEN
	xRestart:=TRUE;
	xPausaEmergencia:=FALSE;
ELSE
	xRestart:=FALSE;
END_IF*)

(*--------- LED RESTART ----------*)

(*PulsoLedRestart.ENABLE:=(xLedStart OR xPausaEmergencia) AND NOT xOperacaoManual;

PulsoLedRestart(ENABLE:= , TIMELOW:=T#500MS , TIMEHIGH:=T#500MS , OUT=>xLedRestart );
 
(* ----- Informação para Botão Restart do Supervisório -----*)

IF NOT xEmergencia AND xReleSeguranca AND xPausaEmergencia THEN
	xbRestart:=TRUE;
ELSE
	xbRestart:=FALSE;
END_IF*)

TonxPausaEmergenciaDelay(IN:=NOT xReleSeguranca(*xPausaEmergencia*), PT:=T#5000MS , Q=>xPausaEmergenciaTof , ET=> );


(*--------------------------------*)

//Sequencia Ciclo Forno
CASE PassoCmdForno OF
		
		0:	IF xCmdIniciaCiclo THEN 
				PassoCmdForno:=10;
			END_IF
			
		5:	//xCmdIniciaCiclo:=FALSE;
			PassoCmdForno:=7;
			
		7: IF xEnergiaOk THEN
				PassoCmdForno:=10;
			ELSE
				PassoCmdForno:=0;
			END_IF
			
		10: IF xTesteNobreakOk OR xNobreakDesabilitado THEN
				PassoCmdForno:=12;
			END_IF

		12:	uStatusInicioCiclo:=1; // Aguardando Ajustar Dutos
			IF xHomeDuctosResfriadorSup02Ok OR xDuctosSup02Enable THEN
				PassoCmdForno:=15;
			//ELSE
				//PassoCmdForno:=0;
			END_IF
			
		13:	IF xHomeDuctosResfriadorSup01Ok OR xDuctosSup01Enable THEN
				PassoCmdForno:=15;
			//ELSE
				//PassoCmdForno:=0;
			END_IF

		15:	uStatusInicioCiclo:=2; // Aguardando Ajustar Guilhotina
			IF xHomeGuilhotina02Ok OR xGuilhotina02Enable THEN
				PassoCmdForno:=20;
			//ELSE
				//PassoCmdForno:=0;
			END_IF

		16:	IF xHomeGuilhotina01SupOk OR xGuilhotina01SupEnable THEN
				PassoCmdForno:=17;
			//ELSE
				//PassoCmdForno:=0;
			END_IF

		17:	IF xHomeGuilhotina01InfOk OR xGuilhotina01InfEnable THEN
				PassoCmdForno:=20;
			//ELSE
				//PassoCmdForno:=0;
			END_IF


		20:	uStatusInicioCiclo:=3; // Aguardando Carregar Receita
			IF xReceitaCarregadaOk THEN
				PassoCmdForno:=21;
			//ELSE
				//PassoCmdForno:=0;
			END_IF
			
		21:	uStatusInicioCiclo:=4; // Aguardando Ligar Resistencias 
			IF xLigaResistenciaInferior AND xLigaResistenciaSuperior THEN
				PassoCmdForno:=23;
			//ELSE
				//PassoCmdForno:=0;
			END_IF
			
		(*22:	uStatusInicioCiclo:=5; // Aguardando Ligar Resistencias Superiores
			IF xLigaResistenciaSuperior THEN
				PassoCmdForno:=23;
			//ELSE
				//PassoCmdForno:=0;
			END_IF*)

		23: uStatusInicioCiclo:=6; // Aguardando Finalizar Aquecimento
			IF uStatusAquecimento=2 THEN // Aquecimento finalizado
				PassoCmdForno:=24;
			//ELSE
				//PassoCmdForno:=0;
			END_IF
			IF xCmFinalizaCiclo OR xSemEnergia THEN(*OR xBtHmiFinalizaCiclo OR xBloqueioAtivo*) 
				PassoCmdForno:=40;
			END_IF
			
		24: xCmdIniciaCiclo:=FALSE;
			xSetTempStandyByInicio:=TRUE;
			PassoCmdForno:=30;
			
		30:	xFornoEmCiclo:=TRUE;
			IF xCmFinalizaCiclo OR xSemEnergia THEN(*OR xBtHmiFinalizaCiclo OR xBloqueioAtivo*) 
				PassoCmdForno:=40;
			END_IF
			IF xAbortaCicloForno THEN
				PassoCmdForno:=200;
			END_IF
			
		40:	xFornoFinalizando:=TRUE;
			xCmFinalizaCiclo:=FALSE;
			//xBtHmiFinalizaCiclo:=FALSE;
			IF xFornoVazio THEN
				PassoCmdForno:=50;
			END_IF
			IF xAbortaCicloForno THEN
				PassoCmdForno:=200;
			END_IF
			
		50:	xFornoEmCiclo:=FALSE;
			xFornoFinalizando:=FALSE;
			//xReceitaCarregadaOk:=FALSE;
			xDesligaFimVentilador01:=TRUE;
			xDesligaFimVentilador02:=TRUE;
			xDesligaFimVentilador03:=TRUE;
			xDesligaFimVentilador04:=TRUE;
			PassoCmdForno:=0;
			
		200:xAbortaCicloForno:=FALSE;
			xFornoFinalizando:=FALSE;
			xBtHmiFinalizaCiclo:=FALSE;
			xFornoEmCiclo:=FALSE;
			xFornoFinalizando:=FALSE;
			
END_CASE

IF (*NOT xBtFinalizaCiclo OR xBtHmiFinalizaCiclo*)xCmFinalizaCiclo  AND xFornoEmEspera THEN
	//xReceitaCarregadaOk:=FALSE;
	dSomaReceitaClp:=0;
	xReceitaAqiecimCarregadaOk:=FALSE;
	xDesligaFimVentilador01:=TRUE;
	xDesligaFimVentilador02:=TRUE;
	xDesligaFimVentilador03:=TRUE;
	xDesligaFimVentilador04:=TRUE;

	//xBtHmiFinalizaCiclo:=FALSE;
END_IF


xFornoEmEspera:= NOT xFornoEmCiclo AND NOT xFornoFinalizando;
	
PulsoLedEmEspera(ENABLE:= xFornoEmEspera, TIMELOW:=T#1000MS , TIMEHIGH:=T#1000MS , OUT=>xLedMaqEmEspera );
 

//xLedMaqEmCiclo:=(xFornoEmCiclo AND NOT xFornoFinalizando) OR xLedFornoFinalizando;

//Sequencia Ciclo Máquina

xMaquinaEmCiclo:= xFornoEmCiclo OR xResfriadorEmCiclo;

xMaquinaEmEspera:= NOT xMaquinaEmCiclo;

// Led Indicação Maquina em Ciclo/Stand-By

PulsoLedFinalizando(ENABLE:= xFornoFinalizando, TIMELOW:=T#500MS , TIMEHIGH:=T#500MS , OUT=>xLedFornoFinalizando );
 
xLedMaqEmCiclo:=(xFornoEmCiclo AND NOT xFornoFinalizando) OR xLedFornoFinalizando OR xLedMaqEmEspera;

// Libera Ajuste da Altura dos Ductos e da Guilhotina

IF iRecAjustaAlturaDuctosInf01=1 AND xFornoEmCiclo AND xReceitaCarregadaOk THEN
	xBtRecAjustaAlturaDuctosInf01:=TRUE;
	iRecAjustaAlturaDuctosInf01:=0;
END_IF

IF iRecAjustaAlturaDuctosSup01=1 AND xFornoEmCiclo AND xReceitaCarregadaOk THEN
	xBtRecAjustaAlturaDuctosSup01:=TRUE;
	iRecAjustaAlturaDuctosSup01:=0;
END_IF

IF iRecAjustaAlturaDuctosInf02=1 AND xFornoEmCiclo AND xReceitaCarregadaOk THEN
	xBtRecAjustaAlturaDuctosInf02:=TRUE;
	iRecAjustaAlturaDuctosInf02:=0;
END_IF

IF iRecAjustaAlturaDuctosSup02=1 AND xFornoEmCiclo AND xReceitaCarregadaOk THEN
	xBtRecAjustaAlturaDuctosSup02:=TRUE;
	iRecAjustaAlturaDuctosSup02:=0;
END_IF

IF iRecAjustaAlturaGuilho01=1 AND xFornoEmCiclo AND xReceitaCarregadaOk THEN
	xBtRecAjustaGuilhotina01:=TRUE;
	iRecAjustaAlturaGuilho01:=0;
END_IF

IF iRecAjustaAlturaGuilho02=1 AND xFornoEmCiclo AND xReceitaCarregadaOk THEN
	xBtRecAjustaGuilhotina02:=TRUE;
	iRecAjustaAlturaGuilho02:=0;
END_IF

// Auto Home Motores Dutos e Guilhotina
PulsoPoStartCiclo(Entrada:= xFornoEmCiclo, SaidaPulsoPo=> xFornoEmCicloPulso);

IF xFornoEmCicloPulso AND NOT xFornoEmCiclocomCarga AND NOT xResfriadorEmCiclo THEN
	xAutoHomeResfInf02	:= TRUE ;
	xAutoHomeResfSup02	:= TRUE ;
	xAutoHomeGuilho01	:= TRUE ;
	xAutoHomeGuilho02	:= TRUE ;
END_IF


IF xOperacaoManual THEN
	PassoCmdForno:=0;
	xAbortaCicloForno:=FALSE;
	xFornoFinalizando:=FALSE;
	xBtHmiFinalizaCiclo:=FALSE;
	xFornoEmCiclo:=FALSE;
	xFornoFinalizando:=FALSE;
	//xReceitaCarregadaOk:=FALSE;
	dSomaReceitaClp:=0;
	iRecAjustaAlturaDuctosInf01:=0;
	iRecAjustaAlturaDuctosSup01:=0;
	iRecAjustaAlturaDuctosInf02:=0;
	iRecAjustaAlturaDuctosSup02:=0;
	iRecAjustaAlturaGuilho01:=0;
	iRecAjustaAlturaGuilho02:=0;
	xBtRecAjustaAlturaDuctosSup01:=FALSE;
	xBtRecAjustaAlturaDuctosInf01:=FALSE;
	xBtRecAjustaAlturaDuctosSup02:=FALSE;
	xBtRecAjustaAlturaDuctosInf02:=FALSE;
	xBtRecAjustaGuilhotina01:=FALSE;
	xBtRecAjustaGuilhotina02:=FALSE;
	
	xPausaEmergencia:=FALSE;
	xAutoHomeResfInf02	:= FALSE ;
	xAutoHomeResfSup02	:= FALSE ;
	xAutoHomeGuilho01	:= FALSE ;
	xAutoHomeGuilho02	:= FALSE ;
END_IF
