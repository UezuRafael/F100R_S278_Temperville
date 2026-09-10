__METADATA__
{
  "v3Meta": {
    "objectGuid": "b823c62a-55d5-4f78-b2c6-a14b97f8e780",
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
FUNCTION_BLOCK EquacaoDaReta
VAR_INPUT
	rValorY: REAL;
	rPy1: REAL;
	rPy2: REAL;
	rPx1: REAL;
	rPx2: REAL;
END_VAR
VAR_OUTPUT
	rValorX: REAL;
END_VAR
VAR
	Aux01: REAL;
	Aux02: REAL;
	Aux03: REAL;
	Aux04: REAL;
	Aux05: REAL;
END_VAR
__IMPLEMENTATION__
// EQUAÇÃO FUNDAMENTAL DA RETA

//X= (-Y*x2+Y*x1)-(x1*y2)+(y1*x2)/(y1-y2);

rValorX:= (-(rValorY*rPx2)+(rValorY*rPx1)-(rPx1*rPy2)+(rPy1*rPx2))/(rPy1-rPy2);

Aux01:=(rValorY*rPx2);
Aux02:=(rValorY*rPx1);
Aux03:=(rPx1*rPy2);
Aux04:=(rPy1*rPx2);
Aux05:=(rPy1-rPy2);

