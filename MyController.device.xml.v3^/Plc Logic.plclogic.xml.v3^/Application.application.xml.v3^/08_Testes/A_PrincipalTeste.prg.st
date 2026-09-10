__METADATA__
{
  "v3Meta": {
    "objectGuid": "c326d57c-8c3d-4595-bfd3-a2b0b6914697",
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
PROGRAM A_PrincipalTeste
VAR
	TesteResistenciasGeral: HabilitaDesabilitaSB;
	TesteResistenciasAuto: HabilitaDesabilita;
	TesteResistenciasMan: HabilitaDesabilita;
	TesteEntradaSaidas: HabilitaDesabilita;
END_VAR
__IMPLEMENTATION__
(* BLOCO PRINCIPAL DE TESTES *)
// Testes de Resistências
//TesteResistenciasGeral( Entrada:=BtTesteResistencias ,Entrada02:= ,Entrada03:= ,Alarme01:= ,StatusSaida=> xTesteResistencias);
xTesteResistencias:=xTesteResistencias;
//TesteResistenciasAuto( Entrada:=BtTesteResistenciaAutomatico ,Entrada02:= ,Entrada03:= ,Alarme01:= ,StatusSaida=> xTesteResistenciaAutomatico);
xTesteResistenciaAutomatico:=xTesteResistenciaAutomatico;
//TesteResistenciasMan( Entrada:=BtTesteResistenciaManual ,Entrada02:= ,Entrada03:= ,Alarme01:= ,StatusSaida=> xTesteResistenciaManual);
xTesteResistenciaManual:=NOT xTesteResistenciaAutomatico;

IF xTesteResistencias THEN
	B_TesteResistencias();
END_IF

//Testes de Entradas e Saídas
//TesteEntradaSaidas( Entrada:=BtTesteEntradaSaidas ,Entrada02:= ,Entrada03:= ,Alarme01:= ,StatusSaida=> xTesteEntradaSaidas);
xTesteEntradaSaidas:=xTesteEntradaSaidas;
IF xTesteEntradaSaidas THEN
	C_Teste_Entradas_Saidas();
END_IF

D_Teste_Nobreak();
TesteSTOP();
