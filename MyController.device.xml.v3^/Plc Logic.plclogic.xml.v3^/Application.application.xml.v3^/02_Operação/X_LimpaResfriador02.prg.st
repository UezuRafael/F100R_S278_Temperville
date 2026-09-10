__METADATA__
{
  "v3Meta": {
    "objectGuid": "bd83ed33-e412-445f-aefb-723b62665415",
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
PROGRAM X_LimpaResfriador02
VAR
	xResfriador02Aberto: BOOL;
	TonLimpVidroForaPosicao: TON;
	xTonLimpVidroForaPosicaoIn: BOOL;
	xTonLimpVidroForaPosicaoQ: BOOL;
	TonLimpVidroForaPosicaoSom: TP;
	xTonLimpVidroForaPosicaoSomIn: BOOL;
	xTonLimpVidroForaPosicaoSomQ: BOOL;
END_VAR
__IMPLEMENTATION__
(*---------------Pré Condição para Funcionamento Limpa Resfriador -------------------*)
(* Resfriador 02 Inferior Totalmente Aberto *)
xResfriador02Aberto:=xSensorAbertoResfriadorInf02 OR xFcMaximoSegResfriadorInf02;

(* Comando do Limpa Vidros Manual *)
xAvancoLimpaResfriador02:=xCHAvancoLimpaResfriador02 AND NOT xFcLimMaxLimpaResfriador02 AND xResfriador02Aberto;
xRecuoLimpaResfriador02:=xCHRecuoLimpaResfriador02 AND NOT xFcLimMinLimpaResfriador02 AND xResfriador02Aberto;

(* Alarme Limpa Vidro Fora de Posição *)

xTonLimpVidroForaPosicaoIn:= NOT xMotorLimpResfr02Ligado AND NOT xFcLimMinLimpaResfriador02;
TonLimpVidroForaPosicao(IN:=xTonLimpVidroForaPosicaoIn , PT:=T#3S , Q=>xTonLimpVidroForaPosicaoQ , ET=> );

IF xTonLimpVidroForaPosicaoQ THEN
	xLimpVidroForaPosicao:=TRUE;
END_IF

(*------------Alerta Sonoro Limpa Vidro fora de Posição --------*)
xTonLimpVidroForaPosicaoSomIn:=xLimpVidroForaPosicao;
TonLimpVidroForaPosicaoSom(IN:= xTonLimpVidroForaPosicaoSomIn, PT:= T#500MS , Q=>xTonLimpVidroForaPosicaoSomQ );

IF xTonLimpVidroForaPosicaoSomQ THEN
	xLimpVidroForaPosicaoSon:=TRUE;
END_IF

IF	bResetAlmGeral THEN
	xLimpVidroForaPosicao:=FALSE;
	xLimpVidroForaPosicaoSon:=FALSE;
END_IF

