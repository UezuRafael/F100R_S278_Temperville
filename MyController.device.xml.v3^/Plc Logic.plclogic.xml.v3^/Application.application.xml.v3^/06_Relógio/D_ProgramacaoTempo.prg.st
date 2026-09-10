__METADATA__
{
  "v3Meta": {
    "objectGuid": "f515b438-bc10-4260-af56-7e3a435063fd",
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
PROGRAM D_ProgramacaoTempo
VAR
	xTrvAno: BOOL;
	xTrvMes: BOOL;
	xTrvDia: BOOL;
	xTrvData: BOOL;
	xTrvHora: BOOL;
	xTrvMinuto: BOOL;
	xTrvSegundo: BOOL;
	xTrvTempo: BOOL;
	xTrava: BOOL;
END_VAR
__IMPLEMENTATION__
IF BtHabDesabBloqueio THEN
	IF xBloqueioHabilitado THEN
		xBloqueioHabilitado:=FALSE;
	ELSE
		xBloqueioHabilitado:=TRUE;
	END_IF
	BtHabDesabBloqueio:=FALSE;
END_IF



xTrvAno:=	uAnoRealTime = uAnoProgTrv;// = 2015;
xTrvMes:=	uMesRealTime = uMesProgTrv;// = 5;
xTrvDia:=	uDiaRealTime = uDiaProgTrv;// = 10;
xTrvData := xTrvAno AND xTrvMes AND xTrvDia;

xTrvHora:=		uHoraRealTime = uHorProgTrv;// = 23;
xTrvMinuto:=	uMinutoRealTime = uMinProgTrv;// = 0;
xTrvSegundo:=	uSegundoRealTime = uSegProgTrv;// = 0;
xTrvTempo := xTrvHora AND xTrvMinuto AND xTrvSegundo ;	

xTrava:= xTrvData AND xTrvTempo AND xBloqueioHabilitado;

IF xTrava THEN
	xSeguranca:=TRUE;
END_IF
IF BtDesbloqueio THEN
	xSeguranca:=FALSE;
	BtDesbloqueio:=FALSE;
END_IF
