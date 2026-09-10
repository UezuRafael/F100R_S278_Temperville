__METADATA__
{
  "v3Meta": {
    "objectGuid": "0c022175-fa5d-4202-bb9b-196896e03c65",
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
FUNCTION_BLOCK TimerGenerationPorc
VAR_INPUT
	ENABLE: BOOL;
	TIMELOW: TIME;
	TIMEHIGH: TIME;
	rPorceta: REAL;
END_VAR
VAR_OUTPUT
	OUT: BOOL;
END_VAR
VAR
	T1: TON;
	T1In: BOOL;
	T1Q: BOOL;
	T2: TON;
	T2In: BOOL;
	T2Q: BOOL;
END_VAR
__IMPLEMENTATION__

T1In:= ENABLE AND NOT T2Q; 

T1(IN:=T1In , PT:=TIMEHIGH , Q=>T1Q , ET=> );
T2In:=T1Q;

T2(IN:=T2In , PT:=TIMELOW , Q=>T2Q , ET=> );
OUT:=T1Q;

IF rPorceta = 0 THEN
	OUT:=0;
END_IF

IF (rPorceta >= 95) AND ENABLE THEN
	OUT:=1;
END_IF
