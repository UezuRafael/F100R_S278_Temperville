__METADATA__
{
  "v3Meta": {
    "objectGuid": "8b13bda0-1c39-49c0-bc7f-e8e821779d78",
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
FUNCTION_BLOCK HabilitaDesabilita
VAR_IN_OUT
	Entrada: BOOL;
END_VAR
VAR_INPUT
	Entrada02: BOOL;
	Entrada03: BOOL;
	Alarme01: BOOL;
	Alarme02: BOOL;
	Alarme03: BOOL;
END_VAR
VAR_OUTPUT
	StatusSaida: BOOL;
END_VAR
VAR
	PulsoHabilita: PulsoPositivo;
	PulsoHabilitaSaida: BOOL;
	Auxiliar01Habilita: BOOL;
	Auxiliar02Habilita: BOOL;
END_VAR
__IMPLEMENTATION__

PulsoHabilita(Entrada:=Entrada , SaidaPulsoPo=> PulsoHabilitaSaida);
Auxiliar02Habilita:=PulsoHabilitaSaida AND Auxiliar01Habilita;
Auxiliar01Habilita:=(((PulsoHabilitaSaida OR Entrada02) AND NOT  Auxiliar01Habilita) OR Auxiliar01Habilita) AND NOT Auxiliar02Habilita AND NOT Entrada03 AND NOT Alarme01 AND NOT Alarme02 AND NOT Alarme03;
StatusSaida:=Auxiliar01Habilita;
//Entrada := FALSE;


