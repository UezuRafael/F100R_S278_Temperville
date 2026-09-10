__METADATA__
{
  "v3Meta": {
    "objectGuid": "934e27a7-c3db-4b7c-9b6a-1e393f52ecc9",
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
FUNCTION_BLOCK AlarmeTM5SAI6TH
VAR_INPUT
	bEntradaByte00: BYTE;
	bEntradaByte01: BYTE;
	ResetAlarm: BOOL;
END_VAR
VAR_OUTPUT
	Termopar01AbaixoMinimo: BOOL;
	Termopar01AcimaMaximo: BOOL;
	Termopar01Ok: BOOL;
	Termopar01Aberto: BOOL;
	Termopar02AbaixoMinimo: BOOL;
	Termopar02AcimaMaximo: BOOL;
	Termopar02Ok: BOOL;
	Termopar02Aberto: BOOL;
	Termopar03AbaixoMinimo: BOOL;
	Termopar03AcimaMaximo: BOOL;
	Termopar03Ok: BOOL;
	Termopar03Aberto: BOOL;
	Termopar04AbaixoMinimo: BOOL;
	Termopar04AcimaMaximo: BOOL;
	Termopar04Ok: BOOL;
	Termopar04Aberto: BOOL;
	Termopar05AbaixoMinimo: BOOL;
	Termopar05AcimaMaximo: BOOL;
	Termopar05Ok: BOOL;
	Termopar05Aberto: BOOL;
	Termopar06AbaixoMinimo: BOOL;
	Termopar06AcimaMaximo: BOOL;
	Termopar06Ok: BOOL;
	Termopar06Aberto: BOOL;
END_VAR
VAR
	StatusByte00: BYTE_AS_BIT;
	StatusByte01: BYTE_AS_BIT;
	xEntradaTermopar0101: BOOL;
	xEntradaTermopar0201: BOOL;
	xEntradaTermopar0102: BOOL;
	xEntradaTermopar0202: BOOL;
	xEntradaTermopar0103: BOOL;
	xEntradaTermopar0203: BOOL;
	xEntradaTermopar0104: BOOL;
	xEntradaTermopar0204: BOOL;
	xEntradaTermopar0105: BOOL;
	xEntradaTermopar0205: BOOL;
	xEntradaTermopar0106: BOOL;
	xEntradaTermopar0206: BOOL;
	TonTh01: TON;
	TonTh02: TON;
	TonTh03: TON;
	TonTh04: TON;
	TonTh05: TON;
	TonTh06: TON;
END_VAR
__IMPLEMENTATION__


StatusByte00(
		B:= bEntradaByte00, 
		B0=> xEntradaTermopar0101, 
		B1=> xEntradaTermopar0201, 
		B2=> xEntradaTermopar0102, 
		B3=> xEntradaTermopar0202, 
		B4=> xEntradaTermopar0103, 
		B5=> xEntradaTermopar0203, 
		B6=> xEntradaTermopar0104, 
		B7=> xEntradaTermopar0204);
		
StatusByte01(
		B:= bEntradaByte01, 
		B0=> xEntradaTermopar0105, 
		B1=> xEntradaTermopar0205, 
		B2=> xEntradaTermopar0106, 
		B3=> xEntradaTermopar0206);
		
Termopar01Ok:= NOT xEntradaTermopar0101 AND NOT xEntradaTermopar0201;
Termopar01AbaixoMinimo:= NOT xEntradaTermopar0101 AND xEntradaTermopar0201;
Termopar01AcimaMaximo:= xEntradaTermopar0101 AND NOT xEntradaTermopar0201;	
TonTh01.IN:= xEntradaTermopar0101 AND xEntradaTermopar0201;

Termopar02Ok:= NOT xEntradaTermopar0102 AND NOT xEntradaTermopar0202;
Termopar02AbaixoMinimo:= NOT xEntradaTermopar0102 AND xEntradaTermopar0202;
Termopar02AcimaMaximo:= xEntradaTermopar0102 AND NOT xEntradaTermopar0202;	
TonTh02.IN:= xEntradaTermopar0102 AND xEntradaTermopar0202;

Termopar03Ok:= NOT xEntradaTermopar0103 AND NOT xEntradaTermopar0203;
Termopar03AbaixoMinimo:= NOT xEntradaTermopar0103 AND xEntradaTermopar0203;
Termopar03AcimaMaximo:= xEntradaTermopar0103 AND NOT xEntradaTermopar0203;	
TonTh03.IN:= xEntradaTermopar0103 AND xEntradaTermopar0203;

Termopar04Ok:= NOT xEntradaTermopar0104 AND NOT xEntradaTermopar0204;
Termopar04AbaixoMinimo:= NOT xEntradaTermopar0104 AND xEntradaTermopar0204;
Termopar04AcimaMaximo:= xEntradaTermopar0104 AND NOT xEntradaTermopar0204;	
TonTh04.IN:= xEntradaTermopar0104 AND xEntradaTermopar0204;

Termopar05Ok:= NOT xEntradaTermopar0105 AND NOT xEntradaTermopar0205;
Termopar05AbaixoMinimo:= NOT xEntradaTermopar0105 AND xEntradaTermopar0205;
Termopar05AcimaMaximo:= xEntradaTermopar0105 AND NOT xEntradaTermopar0205;	
TonTh05.IN:= xEntradaTermopar0105 AND xEntradaTermopar0205;

Termopar06Ok:= NOT xEntradaTermopar0106 AND NOT xEntradaTermopar0206;
Termopar06AbaixoMinimo:= NOT xEntradaTermopar0106 AND xEntradaTermopar0206;
Termopar06AcimaMaximo:= xEntradaTermopar0106 AND NOT xEntradaTermopar0206;	
TonTh06.IN:= xEntradaTermopar0106 AND xEntradaTermopar0206;

TonTh01(PT:=T#0S , Q=>Termopar01Aberto);
TonTh02(PT:=T#0S , Q=>Termopar02Aberto);
TonTh03(PT:=T#0S , Q=>Termopar03Aberto);
TonTh04(PT:=T#0S , Q=>Termopar04Aberto);
TonTh05(PT:=T#0S , Q=>Termopar05Aberto);
TonTh06(PT:=T#0S , Q=>Termopar06Aberto);




