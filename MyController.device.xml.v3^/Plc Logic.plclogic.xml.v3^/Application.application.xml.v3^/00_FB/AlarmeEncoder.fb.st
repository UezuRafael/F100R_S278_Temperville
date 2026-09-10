__METADATA__
{
  "v3Meta": {
    "objectGuid": "1d57f5fb-4961-4700-9c2c-21a098caf9b0",
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
FUNCTION_BLOCK AlarmeEncoder
VAR_INPUT
	xHabilitaAlarme: BOOL;
	xResetAlarme: BOOL;
	ixCanalA: BOOL;
	ixCanalB: BOOL;
	tTempoPulso: TIME;
END_VAR
VAR_OUTPUT
	xAlarmeCanalA: BOOL;
	xAlarmeCanalB: BOOL;
	xAlarmeGeral: BOOL;
	xAlarmeSonoro: BOOL;
END_VAR
VAR
	TonAtrasoAlarme: TON;
	TonAtrasoAlarmeIn: BOOL;
	TonAtrasoAlarmePt: TIME;
	TonAtrasoAlarmeQ: BOOL;
	TonPulsoCanalAUp: TON;
	TonPulsoCanalAUpIn: BOOL;
	TonPulsoCanalAUpPt: TIME;
	TonPulsoCanalAUpQ: BOOL;
	TonPulsoCanalADown: TON;
	TonPulsoCanalADownIn: BOOL;
	TonPulsoCanalADownPt: TIME;
	TonPulsoCanalADownQ: BOOL;
	TonPulsoCanalBUp: TON;
	TonPulsoCanalBUpIn: BOOL;
	TonPulsoCanalBUpPt: TIME;
	TonPulsoCanalBUpQ: BOOL;
	TonPulsoCanalBDown: TON;
	TonPulsoCanalBDownIn: BOOL;
	TonPulsoCanalBDownPt: TIME;
	TonPulsoCanalBDownQ: BOOL;
	TonSinAlarme: TON;
	TonSinAlarmeIn: BOOL;
	TonSinAlarmePt: TIME;
	TonSinAlarmeQ: BOOL;
	TpSireneAlarme: TP;
	TpSireneAlarmeIn: BOOL;
	TpSireneAlarmePt: TIME;
	TpSireneAlarmeQ: BOOL;
	xHabilitadorMonitoraAlarme: BOOL;
END_VAR
__IMPLEMENTATION__
(*Bloco de Monitoramento de Encoder pelas Entradas Digitais*)

(*---- Habilita Monitoramento de Alarme de Defeito ----*)
if xHabilitaAlarme then
	TonAtrasoAlarmeIn:=true;
else
	TonAtrasoAlarmeIn:=false;
end_if;

(*--- Tempo de Atraso para Inicio do Monitoramento ---*)
TonAtrasoAlarme (IN := TonAtrasoAlarmeIn,
		 PT := T#1500ms,
                 Q => TonAtrasoAlarmeQ);

xHabilitadorMonitoraAlarme:=TonAtrasoAlarmeQ;

(*--- Monitoramento do Canal A ---*)
(*--- Canal A Defeito Alto ---*)
TonPulsoCanalAUpIn:=xHabilitadorMonitoraAlarme and not ixCanalA;

TonPulsoCanalAUp (IN := TonPulsoCanalAUpIn,
                PT :=  tTempoPulso,
                Q => TonPulsoCanalAUpQ);

(*--- Canal A Defeito Baixo ---*)
TonPulsoCanalADownIn:=xHabilitadorMonitoraAlarme and ixCanalA;

TonPulsoCanalADown (IN := TonPulsoCanalADownIn,
                PT := tTempoPulso,
                Q => TonPulsoCanalADownQ);

(*--- Alarme Defeito Canal A ---*)

if TonPulsoCanalAUpQ or TonPulsoCanalADownQ then
	xAlarmeCanalA:=true;
end_if;

(*--------------------------------*)
(*--- Monitoramento do Canal B ---*)
(*--- Canal B Defeito Alto ---*)
TonPulsoCanalBUpIn:=xHabilitadorMonitoraAlarme and not ixCanalB;

TonPulsoCanalBUp (IN := TonPulsoCanalBUpIn,
                PT := tTempoPulso,
                Q => TonPulsoCanalBUpQ);

(*--- Canal A Defeito Baixo ---*)
TonPulsoCanalBDownIn:=xHabilitadorMonitoraAlarme and ixCanalB;

TonPulsoCanalBDown (IN := TonPulsoCanalBDownIn,
                PT := tTempoPulso,
                Q => TonPulsoCanalBDownQ);

(*--- Alarme Defeito Canal B ---*)

if TonPulsoCanalBUpQ or TonPulsoCanalBDownQ then
	xAlarmeCanalB:=true;
end_if;

(*--------------------------------*)
(*--- Indicação Alarme Geral ---*)
xAlarmeGeral:=xAlarmeCanalA or xAlarmeCanalB;

(*--- Alarme Sonoro ---*)
TpSireneAlarmeIn:=xAlarmeGeral;

TpSireneAlarme (IN := TpSireneAlarmeIn,
                PT := T#500ms,
                Q => TpSireneAlarmeQ);

if TpSireneAlarmeQ then
	xAlarmeSonoro:=true;
end_if;

(*--- Reseta Alarmes do Encoder ---*)
if xResetAlarme then
	xAlarmeCanalA:=false;
	xAlarmeCanalB:=false;
	xAlarmeSonoro:=false;
end_if;
