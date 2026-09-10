__METADATA__
{
  "v3Meta": {
    "objectGuid": "3a36ca7f-2b30-4b71-9e5d-6797ee2fe45d",
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
PROGRAM ComunicacaoOpc
VAR
	xEnviaSuperClp: INT;
	xRecebeClpSuper: INT;
	ton01: ton;
	ton01In: BOOL;
END_VAR
VAR_OUTPUT
	ton01Q: BOOL;
END_VAR
__IMPLEMENTATION__
IF xEnviaSuperClp=1 THEN
	xEnviaSuperClp:=0;
	ton01In:=TRUE;
END_IF

ton01(IN:=ton01In , PT:=T#1000ms , Q=>ton01Q , ET=> );

IF ton01Q THEN
	xRecebeClpSuper:=1;
	ton01In:=FALSE;	
END_IF
