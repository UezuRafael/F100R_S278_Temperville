__METADATA__
{
  "v3Meta": {
    "objectGuid": "9e2676ed-45b8-422d-a367-b8f03c39b5ae",
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
FUNCTION_BLOCK CalculosResfriador
VAR_INPUT
	DistanciaVelMinResfriador: INT;
	DistanciaCargaResfriador: INT;
	DistanciaOscilacaoResfriador: INT;
	DistanciaDescargaResfriador: INT;
	TamanhoAreaUtil: INT;
	///////
	TamanhoCarga: INT;
END_VAR
VAR_OUTPUT
	SetPointVelMinCarga: INT;
	SetPointCargaResfriador: INT;
	SetPointDescargaResfriador: INT;
	SetPointAvancaVaiVemResfriador: INT;
	SetPointRecuaVaiVemResfriador: INT;
END_VAR
__IMPLEMENTATION__
(*SetPointVelMinCarga:= DistanciaCargaResfriador-DistanciaVelMinResfriador;
SetPointCargaResfriador:= DistanciaCargaResfriador;
SetPointDescargaResfriador:= DistanciaDescargaResfriador;
SetPointAvancaVaiVemResfriador:= DistanciaCargaResfriador;
SetPointRecuaVaiVemResfriador:= DistanciaCargaResfriador-DistanciaOscilacaoResfriador;*)

SetPointVelMinCarga:= DistanciaCargaResfriador-DistanciaVelMinResfriador;
SetPointCargaResfriador:= DistanciaCargaResfriador;
SetPointDescargaResfriador:= DistanciaDescargaResfriador;
SetPointAvancaVaiVemResfriador:= DistanciaCargaResfriador;
SetPointRecuaVaiVemResfriador:= DistanciaCargaResfriador-(TamanhoAreaUtil-TamanhoCarga);
 
