__METADATA__
{
  "v3Meta": {
    "objectGuid": "fa6a9a43-dc62-4388-bbc4-86223a18e297",
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
PROGRAM R_SensorVibracao
VAR
	MediaValoresSensorV01: RegistradorMedia;
	MediaValoresSensorV02: RegistradorMedia;
	rValorLeituraSensorVibraV01: REAL;
	rValorLeituraSensorVibraV02: REAL;
	rValorLeituraSensorVibraV01Aux: REAL;
	rValorLeituraSensorVibraV02Aux: REAL;
END_VAR
__IMPLEMENTATION__
// Sensor de Vibração Ventilador 01

MediaValoresSensorV01.rDadoEntrada:=INT_TO_REAL(iValorLeituraSensorVibraV01);

MediaValoresSensorV01(rDadoEntrada:= , rDadoSaida=>rValorLeituraSensorVibraV01Aux );

IF	rValorLeituraSensorVibraV01Aux<= 1300 THEN
	rValorLeituraSensorVibraV01:=0;
ELSE
	rValorLeituraSensorVibraV01:=rValorLeituraSensorVibraV01Aux;
END_IF

rValorVibracaoVent01:=((rValorLeituraSensorVibraV01*25)/32767);

// Sensor de Vibração Ventilador 02

MediaValoresSensorV02.rDadoEntrada:=INT_TO_REAL(iValorLeituraSensorVibraV02);

MediaValoresSensorV02(rDadoEntrada:= , rDadoSaida=>rValorLeituraSensorVibraV02Aux );

IF	rValorLeituraSensorVibraV02Aux<= 1300 THEN
	rValorLeituraSensorVibraV02:=0;
ELSE
	rValorLeituraSensorVibraV02:=rValorLeituraSensorVibraV02Aux;
END_IF

rValorVibracaoVent02:=((rValorLeituraSensorVibraV02*25)/32767);
