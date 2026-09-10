__METADATA__
{
  "v3Meta": {
    "objectGuid": "b74dd06c-ac4c-4921-855e-f1782730ee03",
    "objectTypeGuid": "6f9dac99-8de1-4efc-8465-68ac443b7d08",
    "embeddedObjectTypeGuids": [
      "a9ed5b7e-75c5-4651-af16-d2c27e98cb94",
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {
      "_3S.CoDeSys.CFCObject.CFCProperty": "<?xml version=\"1.0\" encoding=\"utf-8\"?><Single xml:space=\"preserve\" Type=\"{97c1f2ea-5995-48b9-abd5-a3ab983c5def}\" Method=\"IArchivable\"><Single Name=\"UseExplicitExecutionOrder\" Type=\"bool\">False</Single></Single>"
    },
    "subObjects": {}
  }
}
__DECLARATION__
PROGRAM D_CtrlResist
VAR
END_VAR
__IMPLEMENTATION__
// Tempo de Alternancia entre Zonas
TB01(ENABLE:= TRUE, TIMELOW:= T#2S, TIMEHIGH:= T#2S, OUT=> xAlternaSetor );

// Tempo de Pausa de Resistências
IF xIniciaPausaResistencias THEN
	xIniciaPausaResistInf:=TRUE;
	xIniciaPausaResistSup:=TRUE;
	xIniciaTempoPausaResistSup:=TRUE;
	xIniciaPausaResistencias:=FALSE;
END_IF
// Inferiores
TemporizaPausaResistInferior(
	IniciaTempo:= 	xIniciaPausaResistInf, 
	AbortaTempo:= 	, 
	SetPointTempo:= iTempoPausaResistInf, 
	FimTempo:= 		xFimTempoPausaResistInf, 
	TempoDecorrido=> iTempoPausaResistInfDecorrido, 
	TempoRestante=> );

IF xIniciaPausaResistInf THEN
	xResistenciaInferiorPausa:=TRUE;
	xIniciaPausaResistInf:=FALSE;
END_IF

IF xFimTempoPausaResistInf THEN
	xResistenciaInferiorPausa:=FALSE;
END_IF

// Superiores
TemporizaPausaResistSuperior(
	IniciaTempo:= 	xIniciaPausaResistSup, 
	AbortaTempo:= 	, 
	SetPointTempo:= iTempoPausaResistSup, 
	FimTempo:= 		xFimTempoPausaResistSup, 
	TempoDecorrido=> iTempoPausaResistSupDecorrido, 
	TempoRestante=> );

IF xIniciaPausaResistSup THEN
	xResistenciaSuperiorPausa01:=TRUE;
	xIniciaPausaResistSup:=FALSE;
END_IF

IF xFimTempoPausaResistSup THEN
	xResistenciaSuperiorPausa01:=FALSE;
END_IF

//Tempo P/ inicio da Pausa nas Resistências Superiores após a carga

TempoInicioPausa02ResistSuperior(IN:= xIniciaTempoPausaResistSup, PT:= T#1000S, Q=> , ET=> );

iTempoParaInicioPausaDecor:= DINT_TO_INT((TIME_TO_DINT(TempoInicioPausa02ResistSuperior.ET))/1000);

IF  iTempoParaInicioPausaDecor >= iTempoInicioPausa02ResistSup AND NOT xFornoEmEspera THEN
	xIniciaTempoPausaResistSup:=FALSE;
	xIniciaPausa02ResistSup:=TRUE;
END_IF

TemporizaPausa02ResistSuperior(
	IniciaTempo:= 	xIniciaPausa02ResistSup, 
	AbortaTempo:= 	, 
	SetPointTempo:= iTempoPausa02ResistSup, 
	FimTempo:= 		xFimTempoPausa02ResistSup, 
	TempoDecorrido=> iTempoPausa02ResistSupDecorrido, 
	TempoRestante=> );

IF xIniciaPausa02ResistSup THEN
	xResistenciaSuperiorPausa02:=TRUE;
	xIniciaPausa02ResistSup:=FALSE;
END_IF

IF xFimTempoPausa02ResistSup THEN
	xResistenciaSuperiorPausa02:=FALSE;
END_IF


//Liga Resistências Inferiores
xLigaResistenciaInferior:=(LigaInfPorAquecimentoReceita OR LigaInfPorAquecimentoRampa);
xLigaDeslResInferiores:= xLigaResistenciaInferior AND NOT xResistenciaInferiorPausa;
xResistenciaInferiorOn:=xLigaResistenciaInferior;

//Liga Resistências Superiores
xLigaResistenciaSuperior:= (LigaSupPorAquecimentoReceita OR LigaSupPorAquecimentoRampa);
xLigaDeslResSuperiores:= xLigaResistenciaSuperior AND NOT xResistenciaSuperiorPausa01 AND NOT xResistenciaSuperiorPausa02;
xResistenciaSuperiorOn:=xLigaResistenciaSuperior;


FOR Index:=1 TO iNumResistencias DO
	// Temperaturas Inferiores
	rTermoparInferiorLeitura[Index]:=INT_TO_REAL (TermoparLogicoInferior[Index])/10;
	rTemperaturaInferiorAtual[Index]:=(INT_TO_REAL (TermoparLogicoInferior[Index])/10);//rTemperaturaInferiorSetor[Index];
	rTermoparInferiorControle[Index]:=INT_TO_REAL (TermoparLogicoInferior[Index])/10;
	// Temperaturas Superiores
	rTermoparSuperiorLeitura[Index]:=INT_TO_REAL (TermoparLogicoSuperior[Index])/10;
	rTemperaturaSuperiorAtual[Index]:=(INT_TO_REAL (TermoparLogicoSuperior[Index])/10);//rTemperaturaSuperiorSetor[Index];
	rTermoparSuperiorControle[Index]:=INT_TO_REAL (TermoparLogicoSuperior[Index])/10;
END_FOR


// RESISTÊNCIAS INFERIORES
xLigaDesligaInfG01:= xLigaDeslResInferiores AND xAlternaSetor;
xLigaDesligaInfG02:= xLigaDeslResInferiores AND NOT xAlternaSetor;
// RESISTÊNCIAS SUPERIORES
xLigaDesligaSupG01:= xLigaDeslResSuperiores;// AND NOT xAlternaSetor;
xLigaDesligaSupG02:= xLigaDeslResSuperiores;// AND xAlternaSetor;

xHabilitaBlocosControleInferior:=xLigaDeslResInferiores;
xHabilitaBlocosControleSuperior:=xLigaDeslResSuperiores;
