__METADATA__
{
  "v3Meta": {
    "objectGuid": "82360729-5686-4495-bf62-6c0771299066",
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
PROGRAM L_EstagiosResfriador
VAR
	PassoEstagioResfriador: INT;
	///Bloco Conta Tempo de Pausa dos Roletes
	TimerTrocaEstagios1p2: Temporizador;
	///Bloco Conta Tempo de Pausa dos Roletes
	TimerTrocaEstagios2p3: Temporizador;
	///xIniciaTempoPrimeiroEstagio: BOOL;	
	xFimTempoPrimeiroEstagio: BOOL;
	xFimTempoSegundoEstagio: BOOL;
END_VAR
__IMPLEMENTATION__
// SEQUENCIA DE ESTAGIOS

CASE PassoEstagioResfriador OF
		
		0:	IF xInicioPrimeiroEstagio THEN //<- TASK/MesaResfriador
				PassoEstagioResfriador:=10;
			END_IF
			
		10:	xFimTrocaEstagiosResfriador:=FALSE;
			xInicioPrimeiroEstagio:=FALSE;
			xPrimeiroEstagioResfriador:=TRUE;
			//xIniciaTempoPrimeiroEstagio:=TRUE;
			PassoEstagioResfriador:=20;
			
		20:	IF xFimTempoPrimeiroEstagio OR xFimTrocaEstagiosResfriador THEN
				xInicioSegundoEstagio:=TRUE;
				PassoEstagioResfriador:=21;
			END_IF
			
		21: xInicioSegundoEstagio:=FALSE;
			PassoEstagioResfriador:=30;
			
		30:	xPrimeiroEstagioResfriador:=FALSE;
			xSegundoEstagioResfriador:=TRUE;
			//xLigaSegEstagDuctosSup01:= TRUE;
			//xLigaSegEstagDuctosInf01:= TRUE;
			xLigaSegEstagDuctosSup02:= TRUE;
			xLigaSegEstagDuctosInf02:= TRUE;
			//xSegundoEstagioVentilador01:=TRUE;
			//xSegundoEstagioVentilador02:=TRUE;
			xSegundoEstagioVentilador03:=TRUE;
			xSegundoEstagioVentilador04:=TRUE;
			PassoEstagioResfriador:=31;
			
		31:	IF xFimTempoSegundoEstagio OR xFimTrocaEstagiosResfriador THEN
				PassoEstagioResfriador:=32;
			END_IF

		32:	xSegundoEstagioResfriador:=FALSE;
			xTerceiroEstagioResfriador:=TRUE;
			//xLigaTerEstagDuctosSup01:= TRUE;
			//xLigaTerEstagDuctosInf01:= TRUE;
			xLigaTerEstagDuctosSup02:= TRUE;
			xLigaTerEstagDuctosInf02:= TRUE;
			//xTerceiroEstagioVentilador01:=TRUE;
			//xTerceiroEstagioVentilador02:=TRUE;
			xTerceiroEstagioVentilador03:=TRUE;
			xTerceiroEstagioVentilador04:=TRUE;
			PassoEstagioResfriador:=40;

		40:	IF xFimTrocaEstagiosResfriador THEN //<- TASK/MesaResfriador
				PassoEstagioResfriador:=50;
			END_IF
			
		50:	//xIniciaTempoPrimeiroEstagio:=FALSE;
			xTerceiroEstagioResfriador:=FALSE;
			xFimTempoPrimeiroEstagio:=FALSE;
			xFimTempoSegundoEstagio:=FALSE;
			xFimTrocaEstagiosResfriador:=FALSE;
			PassoEstagioResfriador:=0;
			
END_CASE

//TEMPORIZADOR TROCA DE ESTAGIOS DO RESFRIADOR
TimerTrocaEstagios1p2(
	IniciaTempo:= 	xInicioPrimeiroEstagio, 
	AbortaTempo:= 	xOperacaoManual OR xFimTrocaEstagiosResfriador, 
	SetPointTempo:= iTempoTrocaEstagioResfriamento, 
	FimTempo:= 		xFimTempoPrimeiroEstagio, 
	TempoDecorrido=>iTempoTrocaEstagioDecorrido , 
	TempoRestante=> );

TimerTrocaEstagios2p3(
	IniciaTempo:= 	xInicioSegundoEstagio, 
	AbortaTempo:= 	xOperacaoManual OR xFimTrocaEstagiosResfriador, 
	SetPointTempo:= iTempoTrocaEstagio02Resfriamento, 
	FimTempo:= 		xFimTempoSegundoEstagio, 
	TempoDecorrido=>iTempoTrocaEstagio02Decorrido , 
	TempoRestante=> );

	
IF xOperacaoManual THEN
	PassoEstagioResfriador:=0;
	xInicioPrimeiroEstagio:=FALSE;
	//xIniciaTempoPrimeiroEstagio:=FALSE;
	xPrimeiroEstagioResfriador:=FALSE;
	xSegundoEstagioResfriador:=FALSE;
	xTerceiroEstagioResfriador:=FALSE;
	xFimTempoPrimeiroEstagio:=FALSE;	
	xFimTempoSegundoEstagio:=FALSE;	
END_IF
