__METADATA__
{
  "v3Meta": {
    "objectGuid": "995a6aaf-5ba3-434f-ae66-f795a980d1f6",
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
PROGRAM A_EncoderCpu
__IMPLEMENTATION__
// Encoder Mesa do Forno
IF NOT xRunEncoMForno OR xHomeEncoderForno THEN 
	xPresetEncoMForno:=TRUE;
ELSE
	xPresetEncoMforno:=FALSE;
END_IF
dValorEncoderForno:=(-1)*dValorEncoderFornoEntrada;

// Encoder Mesa do Resfriamento
IF NOT xRunEncoMResfr OR xHomeEncoderResfriador THEN 
	xPresetEncoMResfr:=TRUE;
ELSE
	xPresetEncoMResfr:=FALSE;
END_IF
dValorEncoderResfriador:=(1)*dValorEncoderResfrEntrada;

// Encoder Dutos Resfriador Superior
IF NOT xRunEncoResfrSup02 OR xHomeEncoderDuctosResfriadorSup02 THEN
	xPresetEncoResfrSup02:=TRUE;
ELSE
	xPresetEncoResfrSup02:=FALSE;
END_IF
dValorEncoderDuctosResfriadorSup02:=(1)*dValorEncoderDuctosResfrSup02Entrada;

// Encoder Dutos Resfriador Inferior
(*IF NOT xRunEncoResfrInf02 OR xHomeEncoderDuctosResfriadorInf02 THEN
	xPresetEncoResfrInf02:=TRUE;
ELSE
	xPresetEncoResfrInf02:=FALSE;
END_IF
dValorEncoderDuctosResfriadorInf02:=(-1)*dValorEncoderDuctosResfrInf02Entrada;
*)
// Encoder Dutos Passagem Superior
(*IF NOT xRunEncoResfrSup01 OR xHomeEncoderDuctosResfriadorSup01 THEN
	xPresetEncoResfrSup01:=TRUE;
ELSE
	xPresetEncoResfrSup01:=FALSE;
END_IF
dValorEncoderDuctosResfriadorSup01:=(1)*dValorEncoderDuctosResfrSup01Entrada;*)

// Encoder Dutos Passagem Inferior
(*IF NOT xRunEncoResfrInf01 OR xHomeEncoderDuctosResfriadorInf01 THEN
	xPresetEncoResfrInf01:=TRUE;
ELSE
	xPresetEncoResfrInf01:=FALSE;
END_IF
dValorEncoderDuctosResfriadorInf01:=(1)*dValorEncoderDuctosResfrInf01Entrada;*)

// Encoder Guilhotina 01
(*IF NOT xRunEncoGuilhotina01 OR xHomeEncoderGuilhotinaResfriador01 THEN
	xPresetEncoGuilhotina01:=TRUE;
ELSE
	xPresetEncoGuilhotina01:=FALSE;
END_IF
dValorEncoderGuilhotinaResfriador01:= (-1)*dValorEncoderGuilhoResfr01Entrada;
*)
// Encoder Guilhotina 01 Superior - Passagem
(*IF NOT xRunEncoGuilhotina01Sup OR xHomeEncoderGuilhotinaResfriador01Sup THEN
	xPresetEncoGuilhotina01Sup:=TRUE;
ELSE
	xPresetEncoGuilhotina01Sup:=FALSE;
END_IF
dValorEncoderGuilhotinaResfriador01Sup:= (1)*dValorEncoderGuilhoResfr01SupEntrada;*)

// Encoder Guilhotina 01 Inferior - Passagem
(*IF NOT xRunEncoGuilhotina01Inf OR xHomeEncoderGuilhotinaResfriador01Inf THEN
	xPresetEncoGuilhotina01Inf:=TRUE;
ELSE
	xPresetEncoGuilhotina01Inf:=FALSE;
END_IF
dValorEncoderGuilhotinaResfriador01Inf:= (1)*dValorEncoderGuilhoResfr01InfEntrada;*)

// Encoder Guilhotina 02
IF NOT xRunEncoGuilhotina02 OR xHomeEncoderGuilhotinaResfriador02 THEN
	xPresetEncoGuilhotina02:=TRUE;
ELSE
	xPresetEncoGuilhotina02:=FALSE;
END_IF
dValorEncoderGuilhotinaResfriador02:= (-1)*dValorEncoderGuilhoResfr02Entrada;

