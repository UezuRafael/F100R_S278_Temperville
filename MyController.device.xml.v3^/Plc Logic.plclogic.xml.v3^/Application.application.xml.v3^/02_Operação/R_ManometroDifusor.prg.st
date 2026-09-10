__METADATA__
{
  "v3Meta": {
    "objectGuid": "32da383d-4fc3-4412-9173-30520e56849b",
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
PROGRAM R_ManometroDifusor
VAR
	MediaValoresDifusor01: RegistradorMedia;
	MediaValoresDifusor02: RegistradorMedia;
	rValorLeituraPressaoDifusor01: REAL;
	rValorLeituraPressaoAuxiliarDif01: REAL;
	rValorLeituraPressaoDifusor02: REAL;
	rValorLeituraPressaoAuxiliarDif02: REAL;
END_VAR
__IMPLEMENTATION__
// ----------------------Manometro Difusor 01------------------------------

MediaValoresDifusor01.rDadoEntrada:=INT_TO_REAL(iValorLeituraPressaoDifusor01);

MediaValoresDifusor01(rDadoEntrada:= , rDadoSaida=>rValorLeituraPressaoAuxiliarDif01 );

IF	rValorLeituraPressaoAuxiliarDif01<= 200 THEN
	rValorLeituraPressaoDifusor01:=0;
ELSE
	rValorLeituraPressaoDifusor01:=rValorLeituraPressaoAuxiliarDif01;
END_IF


rValorLeituraPressaoDifusor01Mbar:= 1000*rValorLeituraPressaoDifusor01/32767;
rValorLeituraPressaoDifusor01Bar:=rValorLeituraPressaoDifusor01Mbar/1000;
rValorLeituraPressaoDifusor01Psi:=rValorLeituraPressaoDifusor01Bar/0.068948;

rValorLeituraPressaoDifusor01InHg:=rValorLeituraPressaoDifusor01Bar*29.5299889;
rValorLeituraPressaoDifusor01CmHg:=rValorLeituraPressaoDifusor01Bar*75.006375;
rValorLeituraPressaoDifusor01MmHg:=rValorLeituraPressaoDifusor01Bar*750.06375;
rValorLeituraPressaoDifusor01MmCa:=rValorLeituraPressaoDifusor01Bar*10197.1621; 

// ----------------------Manometro Difusor 02------------------------------

MediaValoresDifusor02.rDadoEntrada:=INT_TO_REAL(iValorLeituraPressaoDifusor02);

MediaValoresDifusor02(rDadoEntrada:= , rDadoSaida=>rValorLeituraPressaoAuxiliarDif02 );

IF	rValorLeituraPressaoAuxiliarDif02<= 200 THEN
	rValorLeituraPressaoDifusor02:=0;
ELSE
	rValorLeituraPressaoDifusor02:=rValorLeituraPressaoAuxiliarDif02;
END_IF


rValorLeituraPressaoDifusor02Mbar:= 1000*rValorLeituraPressaoDifusor02/32767;
rValorLeituraPressaoDifusor02Bar:=rValorLeituraPressaoDifusor02Mbar/1000;
rValorLeituraPressaoDifusor02Psi:=rValorLeituraPressaoDifusor02Bar/0.068948;

rValorLeituraPressaoDifusor02InHg:=rValorLeituraPressaoDifusor02Bar*29.5299889;
rValorLeituraPressaoDifusor02CmHg:=rValorLeituraPressaoDifusor02Bar*75.006375;
rValorLeituraPressaoDifusor02MmHg:=rValorLeituraPressaoDifusor02Bar*750.06375;
rValorLeituraPressaoDifusor02MmCa:=rValorLeituraPressaoDifusor02Bar*10197.1621; 
