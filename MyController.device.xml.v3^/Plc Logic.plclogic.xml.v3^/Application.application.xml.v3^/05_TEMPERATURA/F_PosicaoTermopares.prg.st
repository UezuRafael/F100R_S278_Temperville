__METADATA__
{
  "v3Meta": {
    "objectGuid": "f547b5fb-5439-4c21-be59-1ee93e1858fb",
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
PROGRAM F_PosicaoTermopares
VAR
	Index: INT;
	Posicao: INT;
END_VAR
__IMPLEMENTATION__

FOR Index:= 1 TO iNumResistencias DO
	FOR Posicao:= 1 TO iNumResistencias DO
		IF PosicaoTermoparSetorInferior[Index]=Posicao THEN
			TermoparLogicoInferior[Index]:=TermoparInferior[Posicao];
			TermoparAbertoLogicoInf[Index]:=TermoparAbertoInferior[Posicao];
		END_IF
	END_FOR
	FOR Posicao:= 1 TO iNumResistencias DO
		IF PosicaoTermoparSetorSuperior[Index]=Posicao THEN
			TermoparLogicoSuperior[Index]:=TermoparSuperior[Posicao];
			TermoparAbertoLogicoSup[Index]:=TermoparAbertoSuperior[Posicao];
		END_IF
	END_FOR
END_FOR
