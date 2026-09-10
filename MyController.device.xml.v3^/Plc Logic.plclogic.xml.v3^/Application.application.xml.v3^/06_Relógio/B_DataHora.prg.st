__METADATA__
{
  "v3Meta": {
    "objectGuid": "de44753e-f082-4ca3-bee8-abd2becba9b0",
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
PROGRAM B_DataHora
VAR
	LerDataHora: GetDateAndTime;
	SetDataHora: SetDateAndTime;
	TonAcertoHora: TON;
	TonAcertoHoraIn: BOOL;
	TonAcertoHoraQ: BOOL;
	uAnoRealTimeq_UIntMonth: UINT;
END_VAR
__IMPLEMENTATION__
// Auto Acerto Data/Hora

TonAcertoHoraIn:= NOT TonAcertoHoraQ;

TonAcertoHora(IN:= TonAcertoHoraIn, PT:=T#30S , Q=>TonAcertoHoraQ, ET=> );

IF TonAcertoHoraQ THEN
	xAcertaRelogio:=TRUE;
END_IF


SetDataHora(
	i_xSetDateTime:= 	BtAcertaRelogioPlc, 
	i_UIntYear:= 		uAcertoAno, 
	i_UIntMonth:= 		uAcertoMes, 
	i_UIntDay:= 		uAcertoDia, 
	i_UIntHour:= 		uAcertoHora, 
	i_UIntMinute:= 		uAcertoMinuto, 
	i_UIntSecond:= 		uAcertoSegundo, 
	q_UIntDatetoUTC_diag=> , 
	q_UIntRtcSet_diag=> );

IF BtAcertaRelogioPlc THEN
	BtAcertaRelogioPlc:=false;
END_IF
	
	
LerDataHora(
	q_UIntYear=> 		uAnoRealTime, 
	q_UIntMonth=> 		uMesRealTime, 
	q_UIntDay=> 		uDiaRealTime, 
	q_UIntHour=> 		uHoraRealTime, 
	q_UIntMinute=> 		uMinutoRealTime, 
	q_UIntSecond=> 		uSegundoRealTime, 
	q_UIntMSecond=> 	uMSegundoRealTime, 
	q_UIntDayOfWeek=> 	uDiaSemanaRealTime, 
	q_UIntYday=> 		uDiaAnoRealTime);
	
IF xRelogioAcertado THEN
	xAcertaRelogio:=FALSE;
	xRelogioAcertado:=FALSE;
END_IF
	
	
