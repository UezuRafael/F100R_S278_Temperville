__METADATA__
{
  "v3Meta": {
    "objectGuid": "d1e710f9-de9c-4ba8-af49-f3e41069f108",
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
FUNCTION_BLOCK MmConversorPulso
VAR_INPUT
	dPulso	: DINT;
	dMilimetro : DINT;
	iEntrMilimetro01: INT;
	iEntrMilimetro02: INT;
	iEntrMilimetro03: INT;
	iEntrMilimetro04: INT;
	iEntrMilimetro05: INT;
	iEntrMilimetro06: INT;
	iEntrMilimetro07: INT;
	iEntrMilimetro08: INT;
	iEntrMilimetro09: INT;
	iEntrMilimetro10: INT;
	iEntrMilimetro11: INT;
	iEntrMilimetro12: INT;
	iEntrMilimetro13: INT;
	iEntrMilimetro14: INT;
	iEntrMilimetro15: INT;
	iEntrMilimetro16: INT;
	iEntrMilimetro17: INT;
	iEntrMilimetro18: INT;
	iEntrMilimetro19: INT;
	iEntrMilimetro20: INT;
END_VAR
VAR_OUTPUT
	dSaidaPulso01:	DINT;
	dSaidaPulso02:	DINT;
	dSaidaPulso03:	DINT;
	dSaidaPulso04:	DINT;
	dSaidaPulso05:	DINT;
	dSaidaPulso06:	DINT;
	dSaidaPulso07:	DINT;
	dSaidaPulso08:	DINT;
	dSaidaPulso09:	DINT;
	dSaidaPulso10:	DINT;
	dSaidaPulso11:	DINT;
	dSaidaPulso12:	DINT;
	dSaidaPulso13:	DINT;
	dSaidaPulso14:	DINT;
	dSaidaPulso15:	DINT;
	dSaidaPulso16:	DINT;
	dSaidaPulso17:	DINT;
	dSaidaPulso18:	DINT;
	dSaidaPulso19:	DINT;
	dSaidaPulso20:	DINT;	
END_VAR
VAR
	dEntrMilimetro03	: DINT ;
	dPulsodEntrMilimetro03	: DINT ;
	
	rEntrMilimetro03	: REAL ;
	rPulso				: REAL ;
	rMilimetro			: REAL ;
	rSaidaPulso03		: REAL ;
	rPulsodEntrMilimetro03	: real ;
END_VAR
__IMPLEMENTATION__
rPulso:=DINT_TO_REAL(dPulso);
rMilimetro:=DINT_TO_REAL(dMilimetro);

dSaidaPulso01:=(dPulso*INT_TO_DINT(iEntrMilimetro01))/dMilimetro;
dSaidaPulso02:=(dPulso*INT_TO_DINT(iEntrMilimetro02))/dMilimetro;

dEntrMilimetro03:= INT_TO_DINT (iEntrMilimetro03);
rEntrMilimetro03:=DINT_TO_REAL(dEntrMilimetro03);


dPulsodEntrMilimetro03:=(dPulso*dEntrMilimetro03);
rPulsodEntrMilimetro03:=(rPulso*rEntrMilimetro03);

//dSaidaPulso03:=dPulsodEntrMilimetro03/dMilimetro;
rSaidaPulso03:=rPulsodEntrMilimetro03/rMilimetro;
dSaidaPulso03:=REAL_TO_DINT(rSaidaPulso03);

dSaidaPulso04:=(dPulso*INT_TO_DINT(iEntrMilimetro04))/dMilimetro;
dSaidaPulso05:=(dPulso*INT_TO_DINT(iEntrMilimetro05))/dMilimetro;
dSaidaPulso06:=(dPulso*INT_TO_DINT(iEntrMilimetro06))/dMilimetro;
dSaidaPulso07:=(dPulso*INT_TO_DINT(iEntrMilimetro07))/dMilimetro;
dSaidaPulso08:=(dPulso*INT_TO_DINT(iEntrMilimetro08))/dMilimetro;
dSaidaPulso09:=(dPulso*INT_TO_DINT(iEntrMilimetro09))/dMilimetro;
dSaidaPulso10:=(dPulso*INT_TO_DINT(iEntrMilimetro10))/dMilimetro;
dSaidaPulso11:=(dPulso*INT_TO_DINT(iEntrMilimetro11))/dMilimetro;
dSaidaPulso12:=(dPulso*INT_TO_DINT(iEntrMilimetro12))/dMilimetro;
dSaidaPulso13:=(dPulso*INT_TO_DINT(iEntrMilimetro13))/dMilimetro;
dSaidaPulso14:=(dPulso*INT_TO_DINT(iEntrMilimetro14))/dMilimetro;
dSaidaPulso15:=(dPulso*INT_TO_DINT(iEntrMilimetro15))/dMilimetro;
dSaidaPulso16:=(dPulso*INT_TO_DINT(iEntrMilimetro16))/dMilimetro;
dSaidaPulso17:=(dPulso*INT_TO_DINT(iEntrMilimetro17))/dMilimetro;
dSaidaPulso18:=(dPulso*INT_TO_DINT(iEntrMilimetro18))/dMilimetro;
dSaidaPulso19:=(dPulso*INT_TO_DINT(iEntrMilimetro19))/dMilimetro;
dSaidaPulso20:=(dPulso*INT_TO_DINT(iEntrMilimetro20))/dMilimetro;
