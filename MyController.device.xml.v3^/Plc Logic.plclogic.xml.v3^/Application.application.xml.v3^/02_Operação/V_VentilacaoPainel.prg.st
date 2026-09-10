__METADATA__
{
  "v3Meta": {
    "objectGuid": "489aa355-0354-4e53-84a5-d03cba4f1463",
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
PROGRAM V_VentilacaoPainel
VAR
	VentiladorPainel: HabilitaDesabilita;
	IniciaTempo: BOOL;
	TOF_Vent: TOF;
	iTolSpTermoPainel: INT;
	iSpTermoparPainelHigh: INT;
	iSpTermoparPainelLow: INT;
	xTermPaiOnOff: BOOL;
END_VAR
__IMPLEMENTATION__
//TermoparPainel:=iTemperaturaPirometroPainel;

// Comando Liga Desliga Ventiladores do Painel
// Força Manual

VentiladorPainel(
	Entrada:= xBtLigaVentiPainelManual, 
	Entrada02:= , 
	Entrada03:= , 
	Alarme01:= , 
	Alarme02:= , 
	Alarme03:= , 
	StatusSaida=> xLigaVentiPainelManual);
	
IF xBtLigaVentiPainelManual THEN
	xBtLigaVentiPainelManual:=FALSE;
END_IF

iTolSpTermoPainel:=10;
iSpTermoparPainelHigh:=iSpTermoparPainel+iTolSpTermoPainel;
iSpTermoparPainelLow:=iSpTermoparPainel-iTolSpTermoPainel;

IF Termopar01Painel>=iSpTermoparPainelHigh THEN
	xTermPaiOnOff:=TRUE;
END_IF
IF Termopar01Painel<=iSpTermoparPainelLow THEN
	xTermPaiOnOff:=FALSE;
END_IF

// Automatico
IF xTermPaiOnOff OR xLigaVentiPainelManual THEN
	xVentiladoresPainel:= TRUE;
ELSE
	xVentiladoresPainel:= FALSE;
END_IF

iTemperaturaPainel:=Termopar01Painel;

// Ventiladores dos Reles de Estado Sólidos


	TOF_Vent(IN:=xResistenciasLigadas, PT:= T#600S, Q=>xVentiladoresSsr , ET=> );	



















