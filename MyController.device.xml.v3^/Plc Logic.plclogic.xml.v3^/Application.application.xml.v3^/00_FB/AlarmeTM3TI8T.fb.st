__METADATA__
{
  "v3Meta": {
    "objectGuid": "ce8f8510-b110-489e-97c6-a109abf30951",
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
FUNCTION_BLOCK AlarmeTM3TI8T
VAR_INPUT
	inAlarmeInput01: BYTE;
	inAlarmeInput02: BYTE;
	inAlarmeInput03: BYTE;
	inAlarmeInput04: BYTE;
	inAlarmeInput05: BYTE;
	inAlarmeInput06: BYTE;
	inAlarmeInput07: BYTE;
	inAlarmeInput08: BYTE;
END_VAR
VAR_OUTPUT
	OutAlarmeInput01: BOOL;
	OutAlarmeInput02: BOOL;
	OutAlarmeInput03: BOOL;
	OutAlarmeInput04: BOOL;
	OutAlarmeInput05: BOOL;
	OutAlarmeInput06: BOOL;
	OutAlarmeInput07: BOOL;
	OutAlarmeInput08: BOOL;
END_VAR
VAR
	TonTh01: TON;
	TonTh02: TON;
	TonTh03: TON;
	TonTh04: TON;
	TonTh05: TON;
	TonTh06: TON;
	TonTh07: TON;
	TonTh08: TON;
	xTermopar01Aberto: BOOL;
	xTermopar02Aberto: BOOL;
	xTermopar03Aberto: BOOL;
	xTermopar04Aberto: BOOL;
	xTermopar05Aberto: BOOL;
	xTermopar06Aberto: BOOL;
	xTermopar07Aberto: BOOL;
	xTermopar08Aberto: BOOL;
END_VAR
__IMPLEMENTATION__
//TERMOPAR 01
IF inAlarmeInput01=5 OR inAlarmeInput01=6 OR inAlarmeInput01=4 THEN
	xTermopar01Aberto:=TRUE;
ELSE
	xTermopar01Aberto:=FALSE;
END_IF

//TERMOPAR 02
IF inAlarmeInput02=5 OR inAlarmeInput02=6 OR inAlarmeInput02=4 THEN
	xTermopar02Aberto:=TRUE;
ELSE
	xTermopar02Aberto:=FALSE;
END_IF

//TERMOPAR 03
IF inAlarmeInput03=5 OR inAlarmeInput03=6 OR inAlarmeInput03=4 THEN
	xTermopar03Aberto:=TRUE;
ELSE
	xTermopar03Aberto:=FALSE;
END_IF

//TERMOPAR 04
IF inAlarmeInput04=5 OR inAlarmeInput04=6 OR inAlarmeInput04=4 THEN
	xTermopar04Aberto:=TRUE;
ELSE
	xTermopar04Aberto:=FALSE;
END_IF

//TERMOPAR 05
IF inAlarmeInput05=5 OR inAlarmeInput05=6 OR inAlarmeInput05=4 THEN
	xTermopar05Aberto:=TRUE;
ELSE
	xTermopar05Aberto:=FALSE;
END_IF

//TERMOPAR 06
IF inAlarmeInput06=5 OR inAlarmeInput06=6 OR inAlarmeInput06=4 THEN
	xTermopar06Aberto:=TRUE;
ELSE
	xTermopar06Aberto:=FALSE;
END_IF

//TERMOPAR 07
IF inAlarmeInput07=5 OR inAlarmeInput07=6 OR inAlarmeInput07=4 THEN
	xTermopar07Aberto:=TRUE;
ELSE
	xTermopar07Aberto:=FALSE;
END_IF

//TERMOPAR 08
IF inAlarmeInput08=5 OR inAlarmeInput08=6 OR inAlarmeInput08=4 THEN
	xTermopar08Aberto:=TRUE;
ELSE
	xTermopar08Aberto:=FALSE;
END_IF

TonTh01(IN:=xTermopar01Aberto, PT:=T#0S , Q=>OutAlarmeInput01);
TonTh02(IN:=xTermopar02Aberto, PT:=T#0S , Q=>OutAlarmeInput02);
TonTh03(IN:=xTermopar03Aberto, PT:=T#0S , Q=>OutAlarmeInput03);
TonTh04(IN:=xTermopar04Aberto, PT:=T#0S , Q=>OutAlarmeInput04);
TonTh05(IN:=xTermopar05Aberto, PT:=T#0S , Q=>OutAlarmeInput05);
TonTh06(IN:=xTermopar06Aberto, PT:=T#0S , Q=>OutAlarmeInput06);
TonTh07(IN:=xTermopar07Aberto, PT:=T#0S , Q=>OutAlarmeInput07);
TonTh08(IN:=xTermopar08Aberto, PT:=T#0S , Q=>OutAlarmeInput08);

