__METADATA__
{
  "v3Meta": {
    "objectGuid": "76e38bbe-d63c-4599-b4c1-2a21e5dc1409",
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
FUNCTION_BLOCK RegistradorMedia
VAR_INPUT
	rDadoEntrada: REAL;
END_VAR
VAR_OUTPUT
	rDadoSaida: REAL;
END_VAR
VAR
	Tg01: TimerGeneration;
	PulsoEntrada: PulsoPositivo;
	xPulsoEntrada: BOOL;
	xPulsoSaida: BOOL;
	rDadoAuxiliar01: REAL;
	rDadoAuxiliar02: REAL;
	rDadoAuxiliar03: REAL;
	rDadoAuxiliar04: REAL;
	rDadoAuxiliar05: REAL;
	rDadoAuxiliar06: REAL;
	rDadoAuxiliar07: REAL;
	rDadoAuxiliar08: REAL;
	rDadoAuxiliar09: REAL;
	rDadoAuxiliar10: REAL;
END_VAR
__IMPLEMENTATION__

Tg01(ENABLE:= TRUE, TIMELOW:=T#1000MS , TIMEHIGH:=T#50MS , OUT=>xPulsoEntrada );
PulsoEntrada(Entrada:=xPulsoEntrada , SaidaPulsoPo=> xPulsoSaida);

IF xPulsoSaida THEN
	rDadoAuxiliar10:=rDadoAuxiliar09;
	rDadoAuxiliar09:=rDadoAuxiliar08;
	rDadoAuxiliar08:=rDadoAuxiliar07;
	rDadoAuxiliar07:=rDadoAuxiliar06;
	rDadoAuxiliar06:=rDadoAuxiliar05;
	rDadoAuxiliar05:=rDadoAuxiliar04;
	rDadoAuxiliar04:=rDadoAuxiliar03;
	rDadoAuxiliar03:=rDadoAuxiliar02;
	rDadoAuxiliar02:=rDadoAuxiliar01;
	rDadoAuxiliar01:=rDadoEntrada;
END_IF

rDadoSaida:=( rDadoAuxiliar10 + rDadoAuxiliar09 + rDadoAuxiliar08 + rDadoAuxiliar07 + rDadoAuxiliar06 + rDadoAuxiliar05 + rDadoAuxiliar04 + rDadoAuxiliar03 + rDadoAuxiliar02 + rDadoAuxiliar01)/10;
 
