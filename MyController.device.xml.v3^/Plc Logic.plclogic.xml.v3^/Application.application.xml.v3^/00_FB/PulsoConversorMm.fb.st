__METADATA__
{
  "v3Meta": {
    "objectGuid": "12184673-118f-4cba-98e8-cff9ebfe57e2",
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
FUNCTION_BLOCK PulsoConversorMm
VAR_INPUT
	dPulso: DINT;
	dMilimetro: DINT;
	dEntradaPulso01: DINT;
	dEntradaPulso02: DINT;
	dEntradaPulso03: DINT;
	dEntradaPulso04: DINT;
	dEntradaPulso05: DINT;
	dEntradaPulso06: DINT;
	dEntradaPulso07: DINT;
	dEntradaPulso08: DINT;
	dEntradaPulso09: DINT;
	dEntradaPulso10: DINT;
	dEntradaPulso11: DINT;
	dEntradaPulso12: DINT;
	dEntradaPulso13: DINT;
	dEntradaPulso14: DINT;
	dEntradaPulso15: DINT;
	dEntradaPulso16: DINT;
	dEntradaPulso17: DINT;
	dEntradaPulso18: DINT;
	dEntradaPulso19: DINT;
	dEntradaPulso20: DINT;
END_VAR
VAR_OUTPUT
	iSaidaMilimetro01: INT;
	iSaidaMilimetro02: INT;
	iSaidaMilimetro03: INT;
	iSaidaMilimetro04: INT;
	iSaidaMilimetro05: INT;
	iSaidaMilimetro06: INT;
	iSaidaMilimetro07: INT;
	iSaidaMilimetro08: INT;
	iSaidaMilimetro09: INT;
	iSaidaMilimetro10: INT;
	iSaidaMilimetro11: INT;
	iSaidaMilimetro12: INT;
	iSaidaMilimetro13: INT;
	iSaidaMilimetro14: INT;
	iSaidaMilimetro15: INT;
	iSaidaMilimetro16: INT;
	iSaidaMilimetro17: INT;
	iSaidaMilimetro18: INT;
	iSaidaMilimetro19: INT;
	iSaidaMilimetro20: INT;
END_VAR
__IMPLEMENTATION__
iSaidaMilimetro01:=DINT_TO_INT((dEntradaPulso01*dMilimetro)/dPulso);
iSaidaMilimetro02:=DINT_TO_INT((dEntradaPulso02*dMilimetro)/dPulso);
iSaidaMilimetro03:=DINT_TO_INT((dEntradaPulso03*dMilimetro)/dPulso);
iSaidaMilimetro04:=DINT_TO_INT((dEntradaPulso04*dMilimetro)/dPulso);
iSaidaMilimetro05:=DINT_TO_INT((dEntradaPulso05*dMilimetro)/dPulso);
iSaidaMilimetro06:=DINT_TO_INT((dEntradaPulso06*dMilimetro)/dPulso);
iSaidaMilimetro07:=DINT_TO_INT((dEntradaPulso07*dMilimetro)/dPulso);
iSaidaMilimetro08:=DINT_TO_INT((dEntradaPulso08*dMilimetro)/dPulso);
iSaidaMilimetro09:=DINT_TO_INT((dEntradaPulso09*dMilimetro)/dPulso);
iSaidaMilimetro10:=DINT_TO_INT((dEntradaPulso10*dMilimetro)/dPulso);
iSaidaMilimetro11:=DINT_TO_INT((dEntradaPulso11*dMilimetro)/dPulso);
iSaidaMilimetro12:=DINT_TO_INT((dEntradaPulso12*dMilimetro)/dPulso);
iSaidaMilimetro13:=DINT_TO_INT((dEntradaPulso13*dMilimetro)/dPulso);
iSaidaMilimetro14:=DINT_TO_INT((dEntradaPulso14*dMilimetro)/dPulso);
iSaidaMilimetro15:=DINT_TO_INT((dEntradaPulso15*dMilimetro)/dPulso);
iSaidaMilimetro16:=DINT_TO_INT((dEntradaPulso16*dMilimetro)/dPulso);
iSaidaMilimetro17:=DINT_TO_INT((dEntradaPulso17*dMilimetro)/dPulso);
iSaidaMilimetro18:=DINT_TO_INT((dEntradaPulso18*dMilimetro)/dPulso);
iSaidaMilimetro19:=DINT_TO_INT((dEntradaPulso19*dMilimetro)/dPulso);
iSaidaMilimetro20:=DINT_TO_INT((dEntradaPulso20*dMilimetro)/dPulso);
