__METADATA__
{
  "v3Meta": {
    "objectGuid": "ece1a323-1dc3-42cd-b364-e632cc052085",
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
PROGRAM Q_MonitoraEncoder
VAR
	MonitoraEncoderMForno: MonitoraEncoder;
	MonitoraEncoderMResfr: MonitoraEncoder;
	MonitoraEncoderResfrSup01: MonitoraEncoder;
	MonitoraEncoderGuilho01Sup: MonitoraEncoder;
	MonitoraEncoderGuilho01Inf: MonitoraEncoder;
	MonitoraEncoderResfrSup02: MonitoraEncoder;
	MonitoraEncoderGuilhotina02: MonitoraEncoder;
	xEncoderMesaFornoOk: BOOL;
	xEncoderMesaResfriamentoOk: BOOL;
	xEncoderResfriamentoSup01Ok: BOOL;
	xEncoderGuilhotina01SupOk: BOOL;
	xEncoderGuilhotina01InfOk: BOOL;
	xEncoderResfriamentoSup02Ok: BOOL;
	xEncoderGuilhotina02Ok: BOOL;
END_VAR
__IMPLEMENTATION__

(* --------------- MONITORAMENTO DE ENCODERS ---------------- *)

MonitoraEncoderMForno(
	xEncoHabilitado:= xMotorFornoLigado AND NOT xAlarmeMotorForno AND NOT xAlarmeMeFornoParado AND NOT xTempoPausaRoletesOn,
	bResetAlmGeral:= bResetAlmGeral, 
	tTempoCheck:=T#1000MS,
	dValorEncoder:= dValorEncoderFornoEntrada, 
	xAlarmeEncoder=> xAlarmeGeralEncoderMeForno, 
	xAlarmeSonoro=> xAlarmeSonoroEncoderMeForno, 
	xEncoderOk=> 	xEncoderMesaFornoOk);
	
MonitoraEncoderMResfr(
	xEncoHabilitado:= xMotorResfriadorLigado, 
	bResetAlmGeral:= bResetAlmGeral, 
	tTempoCheck:=T#2000MS,
	dValorEncoder:= dValorEncoderResfrEntrada, 
	xAlarmeEncoder=> xAlarmeGeralEncoderMeResfriador, 
	xAlarmeSonoro=> xAlarmeSonoroEncoderMeResfriador, 
	xEncoderOk=> xEncoderMesaResfriamentoOk);


MonitoraEncoderResfrSup02(
	xEncoHabilitado:= xMotorDifusorSup02Ligado, 
	bResetAlmGeral:= bResetAlmGeral, 
	tTempoCheck:=T#3000MS,
	dValorEncoder:= dValorEncoderDuctosResfriadorSup02, 
	xAlarmeEncoder=> xAlarmeGeralEncoderDuResfriadorSup02, 
	xAlarmeSonoro=> xAlarmeSonoroEncoderDuResfriadorSup02, 
	xEncoderOk=> xEncoderResfriamentoSup02Ok);
				  
MonitoraEncoderGuilhotina02(
	xEncoHabilitado:= xMotorGuilhotina02Ligado, 
	bResetAlmGeral:= bResetAlmGeral, 
	tTempoCheck:=T#1500MS,
	dValorEncoder:= dValorEncoderGuilhotinaResfriador02, 
	xAlarmeEncoder=> xAlarmeGeralEncoderGuiResfriador02,
	xAlarmeSonoro=>xAlarmeSonoroEncoderGuiResfriador02,
	xEncoderOk=>xEncoderGuilhotina02Ok);
					  
					  
