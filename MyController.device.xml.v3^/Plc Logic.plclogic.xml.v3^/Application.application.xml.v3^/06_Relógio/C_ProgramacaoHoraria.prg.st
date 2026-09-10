__METADATA__
{
  "v3Meta": {
    "objectGuid": "8e0f489a-50a8-47f0-b253-f5c186ae7d5e",
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
PROGRAM C_ProgramacaoHoraria
VAR
	AtivaDesativaSemanal: HabilitaDesabilita;
	AtivaDesativaDiaria: HabilitaDesabilita;
	xLigaSegunda: BOOL;
	xLigaTerca: BOOL;
	xLigaQuarta: BOOL;
	xLigaQuinta: BOOL;
	xLigaSexta: BOOL;
	xLigaSabado: BOOL;
	xLigaDomingo: BOOL;
	xLigaSemanda: BOOL;

	xLigaHoraSeg: BOOL;
	xLigaMinutoSeg: BOOL;
	xLigaHoraTer: BOOL;
	xLigaMinutoTer: BOOL;
	xLigaHoraQua: BOOL;
	xLigaMinutoQua: BOOL;
	xLigaHoraQui: BOOL;
	xLigaMinutoQui: BOOL;
	xLigaHoraSex: BOOL;
	xLigaMinutoSex: BOOL;
	xLigaHoraSab: BOOL;
	xLigaMinutoSab: BOOL;
	xLigaHoraDom: BOOL;
	xLigaMinutoDom: BOOL;
	xLigaSegundo: BOOL;
	xLigaTempoSeg: BOOL;
	xLigaTempoTer: BOOL;
	xLigaTempoQua: BOOL;
	xLigaTempoQui: BOOL;
	xLigaTempoSex: BOOL;
	xLigaTempoSab: BOOL;
	xLigaTempoDom: BOOL;
	xLigaSemanaDias: BOOL;
	uDiaSemanaRealTimeAuxiliar: UINT;
	xAuxLiga: BOOL;
	xAuxEnable: BOOL;
	teste: BOOL;
	
	xDataHoraDomProgOk	: BOOL ;
	xDataHoraSegProgOk	: BOOL ;
	xDataHoraTerProgOk	: BOOL ;
	xDataHoraQuaProgOk	: BOOL ;
	xDataHoraQuiProgOk	: BOOL ;
	xDataHoraSexProgOk	: BOOL ;
	xDataHoraSabProgOk	: BOOL ;
	
END_VAR
__IMPLEMENTATION__


// Programação Horario		

IF uDiaSemanaRealTime=0 THEN
	uDiaSemanaRealTimeAuxiliar:=7;
ELSE
	uDiaSemanaRealTimeAuxiliar:=uDiaSemanaRealTime;
END_IF


//Horario Domingo
xLigaHoraDom:=		uHoraRealTime = rHorProgramadoDom;
xLigaMinutoDom:=	uMinutoRealTime = rMinProgramadoDom;
xLigaSegundo:=		uSegundoRealTime = uSegProgramado;
xLigaTempodom := xLigaHoraDom AND xLigaMinutoDom AND xLigaSegundo;

IF bDomingo AND uDiaSemanaRealTimeAuxiliar=7 THEN
	xLigaDomingo:=TRUE;	
ELSE
	xLigaDomingo:=FALSE;
END_IF

xDataHoraDomProgOk:= xLigaDomingo AND xLigaTempodom;
IF xDataHoraDomProgOk THEN
	rTempoRampa03 := rRampaDomingo;	
END_IF

//Horario Segunda
xLigaHoraSeg:=		uHoraRealTime = rHorProgramadoSeg;
xLigaMinutoSeg:=	uMinutoRealTime = rMinProgramadoSeg;
xLigaSegundo:=		uSegundoRealTime = uSegProgramado;
xLigaTempoSeg := xLigaHoraSeg AND xLigaMinutoSeg AND xLigaSegundo;

IF bSegunda AND uDiaSemanaRealTimeAuxiliar=1 THEN
	xLigaSegunda:=TRUE;
ELSE
	xLigaSegunda:=FALSE;
END_IF

xDataHoraSegProgOk:= xLigaSegunda AND xLigaTempoSeg;
IF xDataHoraSegProgOk THEN
	rTempoRampa03 := rRampaSegunda;	
END_IF

//Horario Terça
xLigaHoraTer:=		uHoraRealTime = rHorProgramadoTer;
xLigaMinutoTer:=	uMinutoRealTime = rMinProgramadoTer;
xLigaSegundo:=		uSegundoRealTime = uSegProgramado;
xLigaTempoTer := xLigaHoraTer AND xLigaMinutoTer AND xLigaSegundo;

IF bTerca AND uDiaSemanaRealTimeAuxiliar=2 THEN
	xLigaTerca:=TRUE;
ELSE
	xLigaTerca:=FALSE;
END_IF

xDataHoraTerProgOk:= xLigaTerca AND xLigaTempoTer;
IF xDataHoraTerProgOk THEN
	rTempoRampa03 := rRampaTerca;	
END_IF
//Horario Quarta
xLigaHoraQua:=		uHoraRealTime = rHorProgramadoQua;
xLigaMinutoQua:=	uMinutoRealTime = rMinProgramadoQua;
xLigaSegundo:=		uSegundoRealTime = uSegProgramado;
xLigaTempoQua := xLigaHoraQua AND xLigaMinutoQua AND xLigaSegundo;

IF bQuarta AND uDiaSemanaRealTimeAuxiliar=3 THEN
	xLigaQuarta:=TRUE;
ELSE
	xLigaQuarta:=FALSE;
END_IF

xDataHoraQuaProgOk:= xLigaQuarta AND xLigaTempoQua;
IF xDataHoraQuaProgOk THEN
	rTempoRampa03 := rRampaQuarta;	
END_IF

//Horario Quinta
xLigaHoraQui:=		uHoraRealTime = rHorProgramadoQui;
xLigaMinutoQui:=	uMinutoRealTime = rMinProgramadoQui;
xLigaSegundo:=		uSegundoRealTime = uSegProgramado;
xLigaTempoQui := xLigaHoraQui AND xLigaMinutoQui AND xLigaSegundo;

IF bQuinta AND uDiaSemanaRealTimeAuxiliar=4 THEN
	xLigaQuinta:=TRUE;
ELSE
	xLigaQuinta:=FALSE;
END_IF

xDataHoraQuiProgOk:= xLigaQuinta AND xLigaTempoQui;
IF xDataHoraQuiProgOk THEN
	rTempoRampa03 := rRampaQuinta;	
END_IF

//Horario Sexta
xLigaHoraSex:=		uHoraRealTime = rHorProgramadoSex;
xLigaMinutoSex:=	uMinutoRealTime = rMinProgramadoSex;
xLigaSegundo:=		uSegundoRealTime = uSegProgramado;
xLigaTempoSex := xLigaHoraSex AND xLigaMinutoSex AND xLigaSegundo;

IF bSexta AND uDiaSemanaRealTimeAuxiliar=5 THEN
	xLigaSexta:=TRUE;
ELSE
	xLigaSexta:=FALSE;
END_IF

xDataHoraSexProgOk:= xLigaSexta AND xLigaTempoSex;
IF xDataHoraSexProgOk THEN
	rTempoRampa03 := rRampaSexta;	
END_IF

//Horario Sabado
xLigaHoraSab:=		uHoraRealTime = rHorProgramadoSab;
xLigaMinutoSab:=	uMinutoRealTime = rMinProgramadoSab;
xLigaSegundo:=		uSegundoRealTime = uSegProgramado;
xLigaTempoSab := 	xLigaHoraSab AND xLigaMinutoSab AND xLigaSegundo;

IF bSabado AND uDiaSemanaRealTimeAuxiliar=6 THEN
	xLigaSabado:=TRUE;
ELSE
	xLigaSabado:=FALSE;
END_IF

xDataHoraSabProgOk:= xLigaSabado AND xLigaTempoSab;
IF xDataHoraSabProgOk THEN
	rTempoRampa03 := rRampaSabado;	
END_IF

// Programação Horaria Ativada

IF bDomingo OR bSegunda OR bTerca OR bQuarta OR bQuinta OR bSexta OR bSabado THEN
	bStatusAtvProgSemana:=TRUE;
ELSE
	bStatusAtvProgSemana:=FALSE;
END_IF

xStatusAtvProgHoraria:= bStatusAtvProgSemana;

// Liga Resisências

xDataHoraProgOk:= xDataHoraDomProgOk or xDataHoraSegProgOk OR xDataHoraTerProgOk OR xDataHoraQuaProgOk OR xDataHoraQuiProgOk OR xDataHoraSexProgOk OR xDataHoraSabProgOk;



