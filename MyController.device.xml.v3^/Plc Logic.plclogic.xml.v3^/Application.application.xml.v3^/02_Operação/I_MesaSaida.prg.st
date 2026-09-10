__METADATA__
{
  "v3Meta": {
    "objectGuid": "33285750-8f74-4b11-81e5-6b274663c142",
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
PROGRAM I_MesaSaida
VAR
	PassoMesaSaida: INT;
	PassoPauseSaida: INT;
	PassoAlmSaida: INT;
	PassoManualSaida: INT;
	///Blocos Nativos
	///Blocos Criados
	PulsoPoChAvanco: PulsoPositivo;
	PulsoNeChAvanco: PulsoNegativo;
	PulsoPoSensorDesl: PulsoPositivo;
	xAvancoMesaSaida: BOOL;
	xRecuoMesaSaida: BOOL;
	xAvancoJogMesaSaida: BOOL;
	xRecuoJogMesaSaida: BOOL;
	xChAvancaMesaSaidaPo: BOOL;
	xChAvancaMesaSaidaNe: BOOL;
	xSensorDesligaMesaSaidaPo: BOOL;
	iVelocidadeMesaSaida: INT;
END_VAR
__IMPLEMENTATION__
// JOG DA MESA DE SAIDA
(*Avanço*)
PulsoPoChAvanco(Entrada:= xChAvancaMesaSaida, SaidaPulsoPo=>xChAvancaMesaSaidaPo );
PulsoNeChAvanco(Entrada:= xChAvancaMesaSaida, SaidaPulsoNe=>xChAvancaMesaSaidaNe );
PulsoPoSensorDesl(Entrada:= xSensorDesligaMesaSaida, SaidaPulsoPo=>xSensorDesligaMesaSaidaPo );

IF xChAvancaMesaSaidaPo AND NOT xDescarregandoResfriador AND NOT xDesabJogMesaSaida (*AND NOT xPausaEmergencia*) THEN
	xAvancoJogMesaSaida:=TRUE;
END_IF
IF xChRecuaMesaSaida OR xSensorDesligaMesaSaidaPo THEN
	xAvancoJogMesaSaida:=FALSE;
END_IF

(*Recuo*)
IF xChRecuaMesaSaida AND NOT xDescarregandoResfriador AND NOT xDesabJogMesaSaida  (*AND NOT xPausaEmergencia*) THEN
	xRecuoJogMesaSaida:=TRUE;
ELSE
	xRecuoJogMesaSaida:=FALSE;
END_IF

// SEQUENCIA DE DESCARREGAMENTO

CASE PassoMesaSaida OF
	
		0:	IF xInicioDescargaMesaSaida THEN
				PassoMesaSaida:=1;
			END_IF

		1:	IF xPause THEN
				PassoPauseSaida:=0;
				PassoMesaSaida:=300;
			ELSIF xAlarmeMotorSaida THEN
				PassoAlmSaida:=0;
				PassoMesaSaida:=400;
			ELSE
				PassoMesaSaida:=2;
			END_IF
			
		2:	iVelocidadeMesaSaida:= iVelociadeCargaMesadeSaida;(*Velocidade Descarga Mesa Saida*)
			PassoMesaSaida:=5;
			
		5: xAvancoMesaSaida:=TRUE;
			PassoMesaSaida:=10;
			
		10:	xInicioDescargaMesaSaida:=FALSE;
			PassoMesaSaida:=20;
	
		20:	IF xFimDescargaMesaSaida THEN
				PassoMesaSaida:=25;
			END_IF
			IF xPause THEN
				PassoPauseSaida:=2;
				PassoMesaSaida:=300;
			END_IF
			IF xAlarmeMotorSaida OR xAlarmeMotorResfriador OR xAlarmeGeralEncoderMeResfriador THEN
				PassoAlmSaida:=2;
				PassoMesaSaida:=400;
			END_IF

		25:	xAvancoMesaSaida:=FALSE;
			PassoMesaSaida:=30;

		30:	xFimDescargaMesaSaida:=FALSE;
			PassoMesaSaida:=0;

		// Emergência Pausa/Reinicio
		300:xAvancoMesaSaida:=FALSE;
			PassoMesaSaida:=301;

		301:PassoMesaSaida:=302;
	
		302:IF xRestart THEN
				PassoMesaSaida:=303;
			END_IF
			
		303: PassoMesaSaida:=PassoPauseSaida;
			
			
		// Alarme Motor Parada/Reinicio
		400:xAvancoMesaSaida:=FALSE;
			PassoMesaSaida:=401;

		401:PassoMesaSaida:=402;
	
		402:IF xRestart AND iCanOpenInverMesaSaidaStateOk THEN
				PassoMesaSaida:=PassoAlmSaida;
			END_IF	

END_CASE

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorMesaSaidaAvanco:= xAvancoMesaSaida OR xAvancoJogMesaSaida;
xMotorMesaSaidaRecuo:= xRecuoMesaSaida OR xRecuoJogMesaSaida;

InversorMesaSaida.i_xAvanco:=xMotorMesaSaidaAvanco;
InversorMesaSaida.i_xRecuo:=xMotorMesaSaidaRecuo;

// Velocidade
IF xAvancoJogMesaSaida OR xRecuoJogMesaSaida THEN
	InversorMesaSaida.i_iFreqRef:=iVelocidadeJogMesaSaida;
ELSE
	InversorMesaSaida.i_iFreqRef:=iVelocidadeMesaSaida;	
END_IF
//--------------------------------------------------------------------------\\



IF xOperacaoManual THEN
	PassoMesaSaida:=0;
	xInicioDescargaMesaSaida:=FALSE;
	xFimDescargaMesaSaida:=FALSE;
	xAvancoMesaSaida:=FALSE;
	xRecuoMesaSaida:=FALSE;
	xAvancoJogMesaSaida:=FALSE;
	xRecuoJogMesaSaida:=FALSE;
END_IF
