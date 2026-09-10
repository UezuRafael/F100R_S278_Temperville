__METADATA__
{
  "v3Meta": {
    "objectGuid": "1e1df465-766b-4610-9c29-fc2b020dfe39",
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
FUNCTION_BLOCK BlocoSelecaoEspessura
VAR_INPUT
	xSelecao: BOOL;
	iEntrada0101: INT;
	iEntrada0102: INT;
	iEntrada0201: INT;
	iEntrada0202: INT;
	iEntrada0301: INT;
	iEntrada0302: INT;
	iEntrada0401: INT;
	iEntrada0402: INT;
	iEntrada0501: INT;
	iEntrada0502: INT;
	iEntrada0601: INT;
	iEntrada0602: INT;
	iEntrada0701: INT;
	iEntrada0702: INT;
	iEntrada0801: INT;
	iEntrada0802: INT;
	iEntrada0901: INT;
	iEntrada0902: INT;
	iEntrada1001: INT;
	iEntrada1002: INT;
END_VAR
VAR_OUTPUT
	iSaida01: INT;
	iSaida02: INT;
	iSaida03: INT;
	iSaida04: INT;
	iSaida05: INT;
	iSaida06: INT;
	iSaida07: INT;
	iSaida08: INT;
	iSaida09: INT;
	iSaida10: INT;
END_VAR
VAR
	SelecaoEspessuraParam01: SelecaoEspessura;
	SelecaoEspessuraParam02: SelecaoEspessura;
	SelecaoEspessuraParam03: SelecaoEspessura;
	SelecaoEspessuraParam04: SelecaoEspessura;
	SelecaoEspessuraParam05: SelecaoEspessura;
	SelecaoEspessuraParam06: SelecaoEspessura;
	SelecaoEspessuraParam07: SelecaoEspessura;
	SelecaoEspessuraParam08: SelecaoEspessura;
	SelecaoEspessuraParam09: SelecaoEspessura;
	SelecaoEspessuraParam10: SelecaoEspessura;
END_VAR
__IMPLEMENTATION__
SelecaoEspessuraParam01(Selecao:=xSelecao , Entrada01:=iEntrada0101 , Entrada02:=iEntrada0102 , Saida=>iSaida01 );
SelecaoEspessuraParam02(Selecao:=xSelecao , Entrada01:=iEntrada0201 , Entrada02:=iEntrada0202 , Saida=>iSaida02 );
SelecaoEspessuraParam03(Selecao:=xSelecao , Entrada01:=iEntrada0301 , Entrada02:=iEntrada0302 , Saida=>iSaida03 );
SelecaoEspessuraParam04(Selecao:=xSelecao , Entrada01:=iEntrada0401 , Entrada02:=iEntrada0402 , Saida=>iSaida04 );
SelecaoEspessuraParam05(Selecao:=xSelecao , Entrada01:=iEntrada0501 , Entrada02:=iEntrada0502 , Saida=>iSaida05 );
SelecaoEspessuraParam06(Selecao:=xSelecao , Entrada01:=iEntrada0601 , Entrada02:=iEntrada0602 , Saida=>iSaida06 );
SelecaoEspessuraParam07(Selecao:=xSelecao , Entrada01:=iEntrada0701 , Entrada02:=iEntrada0702 , Saida=>iSaida07 );
SelecaoEspessuraParam08(Selecao:=xSelecao , Entrada01:=iEntrada0801 , Entrada02:=iEntrada0802 , Saida=>iSaida08 );
SelecaoEspessuraParam09(Selecao:=xSelecao , Entrada01:=iEntrada0901 , Entrada02:=iEntrada0902 , Saida=>iSaida09 );
SelecaoEspessuraParam10(Selecao:=xSelecao , Entrada01:=iEntrada1001 , Entrada02:=iEntrada1002 , Saida=>iSaida10 );
