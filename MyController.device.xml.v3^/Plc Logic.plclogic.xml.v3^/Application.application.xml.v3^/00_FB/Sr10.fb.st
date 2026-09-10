__METADATA__
{
  "v3Meta": {
    "objectGuid": "e5f6b4b5-5cab-45a5-9ac8-8f02ff6e0566",
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
FUNCTION_BLOCK Sr10
VAR_INPUT
	xPulsoRegistro: BOOL;
	xPulsoReset: BOOL;
	iDadoEntrada01: INT;
	iDadoEntrada02: INT;
	iDadoEntrada03: INT;
	iDadoEntrada04: INT;
	iDadoEntrada05: INT;
	iDadoEntrada06: INT;
	iDadoEntrada07: INT;
	iDadoEntrada08: INT;
	iDadoEntrada09: INT;
	iDadoEntrada10: INT;
END_VAR
VAR_OUTPUT
	iDadoSaida01: INT;
	iDadoSaida02: INT;
	iDadoSaida03: INT;
	iDadoSaida04: INT;
	iDadoSaida05: INT;
	iDadoSaida06: INT;
	iDadoSaida07: INT;
	iDadoSaida08: INT;
	iDadoSaida09: INT;
	iDadoSaida10: INT;
END_VAR
VAR
	Registrador01: Registrador;
	Registrador02: Registrador;
	Registrador03: Registrador;
	Registrador04: Registrador;
	Registrador05: Registrador;
	Registrador06: Registrador;
	Registrador07: Registrador;
	Registrador08: Registrador;
	Registrador09: Registrador;
	Registrador10: Registrador;
END_VAR
__IMPLEMENTATION__
Registrador01(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada01, iDadoSaida=> iDadoSaida01 );
Registrador02(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada02, iDadoSaida=> iDadoSaida02 );
Registrador03(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada03, iDadoSaida=> iDadoSaida03 );
Registrador04(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada04, iDadoSaida=> iDadoSaida04 );
Registrador05(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada05, iDadoSaida=> iDadoSaida05 );
Registrador06(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada06, iDadoSaida=> iDadoSaida06 );
Registrador07(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada07, iDadoSaida=> iDadoSaida07 );
Registrador08(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada08, iDadoSaida=> iDadoSaida08 );
Registrador09(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada09, iDadoSaida=> iDadoSaida09 );
Registrador10(xPulsoEntrada:=xPulsoRegistro , xReset:=xPulsoReset , iDadoEntrada:= iDadoEntrada10, iDadoSaida=> iDadoSaida10 );


