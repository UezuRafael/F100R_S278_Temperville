__METADATA__
{
  "v3Meta": {
    "objectGuid": "cedd9443-8eaa-44f2-9e87-0369d2ff74e0",
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
FUNCTION_BLOCK MonitoraEncoder
VAR_INPUT
	xEncoHabilitado: BOOL;
	bResetAlmGeral: BOOL;
	dValorEncoder: DINT;
	tTempoCheck: TIME;
END_VAR
VAR_OUTPUT
	xAlarmeEncoder: BOOL;
	xAlarmeSonoro: BOOL;
	xEncoderOk: BOOL;
END_VAR
VAR
	TonCheck: TON;
	PassoEncoder: INT;
	dEncoder: DINT;
	dEncoderMenos: DINT;
	dEncoderMais: DINT;
	xCheckEnco: BOOL;
	xEncoderParado: BOOL;
	TonAlarme: TON;
	xTonAlarmeIn: BOOL;
	xTonAlarmeQ: BOOL;
	TonSinAlarme: TON;
	TonSinAlarmeIn: BOOL;
	TonSinAlarmePt: TIME;
	TonSinAlarmeQ: BOOL;
	TpSireneAlarme: TP;
	TpSireneAlarmeIn: BOOL;
	TpSireneAlarmePt: TIME;
	TpSireneAlarmeQ: BOOL;
END_VAR
__IMPLEMENTATION__

TonCheck(IN:= NOT xCheckEnco , PT:=tTempoCheck , Q=>xCheckEnco , ET=> );

CASE PassoEncoder OF
	
	0: 	IF xCheckEnco AND xEncoHabilitado THEN
			PassoEncoder:=5;
		END_IF
	
	5:	//xTonAlarmeIn:=TRUE;
		//IF xTonAlarmeQ THEN
			PassoEncoder:=6;
		//END_IF
			
	6:	//xTonAlarmeIn:=FALSE;
		dEncoderMenos:=dEncoder-10;
		dEncoderMais:=dEncoder+10;
		PassoEncoder:=7;
		
	7:	IF dValorEncoder>=dEncoderMenos AND dValorEncoder<=dEncoderMais THEN
			xEncoderParado:=TRUE;
			xTonAlarmeIn:=TRUE;
			IF xTonAlarmeQ THEN
				xAlarmeEncoder:=TRUE;
				xEncoderOk:=FALSE;
				PassoEncoder:=20;
			END_IF
		ELSE
			xEncoderParado:=FALSE;
			xTonAlarmeIn:=FALSE;
			xEncoderOk:=true;
			PassoEncoder:=15;	
		END_IF
		
	8: xEncoderParado:=TRUE;
	

	15:	dEncoder:=dValorEncoder;
		PassoEncoder:=0;
		
	20: IF bResetAlmGeral THEN
			xAlarmeEncoder:=FALSE;
			xAlarmeSonoro:=FALSE;
			PassoEncoder:=0;
		END_IF
		
END_CASE

TonAlarme (IN := xTonAlarmeIn,
           PT := T#500MS,
           Q => xTonAlarmeQ);


(*--- Alarme Sonoro ---*)
TpSireneAlarmeIn:=xAlarmeEncoder;

TpSireneAlarme (IN := TpSireneAlarmeIn,
                PT := T#500ms,
                Q => TpSireneAlarmeQ);

if TpSireneAlarmeQ then
	xAlarmeSonoro:=true;
end_if;

IF bResetAlmGeral THEN
	xAlarmeSonoro:=FALSE;
END_IF

