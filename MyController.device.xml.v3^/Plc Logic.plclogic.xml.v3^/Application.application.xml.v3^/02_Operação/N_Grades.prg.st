__METADATA__
{
  "v3Meta": {
    "objectGuid": "894f82e8-4a30-461f-8582-1873bdebce71",
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
PROGRAM N_Grades
VAR
	GradeEntrada: Grade;
	GradeSaida: Grade;
	TpBtGradEnt: TP;
	xTpBtGradEntIn: BOOL;
	xTpBtGradEntQ: BOOL;
	xDesabGradeEntrada: BOOL;
	xHabilGradeEntrada: BOOL;
END_VAR
__IMPLEMENTATION__
// Grade Mesa de Entrada

xDesabGradeEntrada:= xCarregandoForno OR xRetornandoForno;
xHabilGradeEntrada:= NOT xDesabGradeEntrada;

GradeEntrada(
	LigaDesl:= xBtGradeEntrada,
	Libera:= TRUE,//xS01PistPneumRecuado AND xS03PistHidraulRecuado, 
	Liga:= , 
	Desl:= xDesabGradeEntrada,//xMotorEntradaLigado, 
	Alarme01:=,// xEmergencia, 
	StatusSaida=> xValvulaGradeEntrada);


	
//Grade Mesa de Saída	
GradeSaida(
	LigaDesl:= xBtGradeSaida,
	Libera:=TRUE,
	Liga:= , 
	Desl:= xDesceGradeMesaSaida OR xMotorSaidaLigado, 
	Alarme01:= xEmergencia, 
	StatusSaida=> xValvulaGradeSaida);

IF xDesceGradeMesaSaida THEN	
	xDesceGradeMesaSaida:=FALSE;
END_IF	

//IF xOperacaoManual THEN	
//	xDesceGradeMesaSaida:=TRUE;
//END_IF;
