__METADATA__
{
  "v3Meta": {
    "objectGuid": "efcdfdd3-a98e-4946-856f-dc3334f2996f",
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
PROGRAM C_HabDesabResistencias
VAR
	Index: INT;
	HabResInferior: ARRAY[1..60] OF HabilitaDesabilita;
	HabResSuperior: ARRAY[1..60] OF HabilitaDesabilita;
	xDesabilitaSobreTemperInferior: BOOL;
	xDesabilitaSobreTemperSuperior: BOOL;
	TpHabilitaResistenciasOn: tp;
	TpHabilitaResistenciasOnIn: BOOL;
	TpHabilitaResistenciasOnQ: BOOL;
END_VAR
__IMPLEMENTATION__
// Desabilita Geral pela Temperatura Média Elevada
IF rMediaLogiaTempInferior>=730 THEN
	xDesabilitaSobreTemperInferior:=TRUE;
ELSE
	xDesabilitaSobreTemperInferior:=FALSE;
END_IF

IF rMediaLogiaTempSuperior>=730 THEN
	xDesabilitaSobreTemperSuperior:=TRUE;
ELSE
	xDesabilitaSobreTemperSuperior:=FALSE;
END_IF

// Habilita geral ao comando ligar resistencias 
TpHabilitaResistenciasOnIn:=xResistenciasLigadas;
TpHabilitaResistenciasOn(IN:=TpHabilitaResistenciasOnIn , PT:=T#150MS , Q=>TpHabilitaResistenciasOnQ , ET=> );


FOR Index:= 1 TO iNumResistencias DO

//HabResInferior[Index](	Alarme01:= 	(*xAlarmeResistRompidaInferior[Index]*), 
						//Alarme02:= 	AlmTermoparAbertoLogicoInf[Index], 
						//Alarme03:=	AlmTemperaturaExcedeuLogicoInf[Index],
						//Entrada:= 	BtHabilitaResistenciaInferior[Index], 
						//Entrada02:=	BtHabilitaResistenciasGeralInferior OR TpHabilitaResistenciasOnQ,
						//Entrada03:= BtDesabilitaResistenciasGeralInferior OR xDesabilitaSobreTemperInferior OR xDesabilitaSobreTemperSuperior,
						//StatusSaida=> xResistenciaHabilitadaInferior[Index]);
						
IF 	( BtHabilitaResistenciaInferior[Index] AND xResistenciaHabilitadaInferior[Index]) OR AlmTermoparAbertoLogicoInf[Index] OR AlmTemperaturaExcedeuLogicoInf[Index] OR BtDesabilitaResistenciasGeralInferior THEN
	xResistenciaHabilitadaInferior[Index]:=FALSE;
ELSIF TpHabilitaResistenciasOnQ OR BtHabilitaResistenciaInferior[Index] OR BtHabilitaResistenciasGeralInferior THEN
	xResistenciaHabilitadaInferior[Index]:=TRUE;
END_IF
						
xResistenciaHabilitada[Index]:=xResistenciaHabilitadaInferior[Index];		

IF 	(BtHabilitaResistenciaInferior[Index]) THEN
	BtHabilitaResistenciaInferior[Index]:=0;
END_IF	
						
//HabResSuperior[Index](	Alarme01:= 	(*xAlarmeResistRompidaSuperior[Index]*), 
						//Alarme02:= 	AlmTermoparAbertoLogicoSup[Index], 
						//Alarme03:=	AlmTemperaturaExcedeuLogicoSup[Index],
						//Entrada:= 	BtHabilitaResistenciaSuperior[Index], 
						//Entrada02:=	BtHabilitaResistenciasGeralSuperior OR TpHabilitaResistenciasOnQ,
						//Entrada03:= BtDesabilitaResistenciasGeralSuperior OR xDesabilitaSobreTemperSuperior OR xDesabilitaSobreTemperInferior,
						//StatusSaida=> xResistenciaHabilitadaSuperior[Index]);	

IF 	( BtHabilitaResistenciaSuperior[Index] AND xResistenciaHabilitadaSuperior[Index]) OR AlmTermoparAbertoLogicoSup[Index] OR AlmTemperaturaExcedeuLogicoSup[Index] OR BtDesabilitaResistenciasGeralSuperior THEN
	xResistenciaHabilitadaSuperior[Index]:=FALSE;
ELSIF TpHabilitaResistenciasOnQ OR BtHabilitaResistenciaSuperior[Index] OR BtHabilitaResistenciasGeralSuperior THEN
	xResistenciaHabilitadaSuperior[Index]:=TRUE;
END_IF
					
xResistenciaHabilitada[Index+iNumResistencias]:=xResistenciaHabilitadaSuperior[Index];	

IF 	(BtHabilitaResistenciaSuperior[Index]) THEN
	BtHabilitaResistenciaSuperior[Index]:=0;
END_IF	

END_FOR

