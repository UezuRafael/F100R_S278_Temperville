__METADATA__
{
  "v3Meta": {
    "objectGuid": "1fe5cc58-fe5c-4a00-a8da-3c38ff76d871",
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
FUNCTION_BLOCK ComprimentoCarga
VAR_INPUT
	Sensor: BOOL;
	Habilita: BOOL;
	ValEncoder: DINT;
END_VAR
VAR_OUTPUT
	TamanhoCarga: DINT;
END_VAR
VAR_IN_OUT
	FimMedicao: BOOL;
END_VAR
VAR
	PulsoSensorNe: PulsoNegativo;
	PulsoSensorPo: PulsoPositivo;
	PulsoHabilitaNe: PulsoNegativo;
	PulsoHabilitaPo: PulsoPositivo;
	TamanhoCargaAux: DINT;
END_VAR
__IMPLEMENTATION__

PulsoSensorNe(Entrada:= Sensor, SaidaPulsoNe=> );
PulsoSensorPo(Entrada:= Sensor, SaidaPulsoPo=> );

IF PulsoSensorNe.SaidaPulsoNe OR PulsoSensorPo.SaidaPulsoPo THEN
	TamanhoCargaAux:= ValEncoder;
END_IF

PulsoHabilitaPo(Entrada:= Habilita, SaidaPulsoPo=>);

IF PulsoHabilitaPo.SaidaPulsoPo THEN
	TamanhoCargaAux:=0;
END_IF

PulsoHabilitaNe(Entrada:= Habilita, SaidaPulsoNe=> );

IF PulsoHabilitaNe.SaidaPulsoNe THEN
	TamanhoCarga:=TamanhoCargaAux;
	FimMedicao:=TRUE;
END_IF

