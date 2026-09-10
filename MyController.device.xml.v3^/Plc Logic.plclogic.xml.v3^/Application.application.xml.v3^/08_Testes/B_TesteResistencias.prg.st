__METADATA__
{
  "v3Meta": {
    "objectGuid": "d8ab2d1a-d462-45fb-99b0-658f5ed2bb63",
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
PROGRAM B_TesteResistencias
VAR
	/// ------------Variáveis Teste Automático------------- 
	PassoTesteInf: INT;
	PassoTesteSup: INT;
	Index: INT;
	Index01: INT;
	Index02: INT;
	Index03: INT;
	Contador: INT;
	rCorrenteInstantInicialFaseA_Amp: REAL;
	rCorrenteInstantInicialFaseB_Amp: REAL;
	rCorrenteInstantInicialFaseC_Amp: REAL;
	rCorrenteResistenciaFaseA_Amp: REAL;
	rCorrenteResistenciaFaseB_Amp: REAL;
	rCorrenteResistenciaFaseC_Amp: REAL;
	TemporizadorTeste: TON;
	TemporizadorIntervalo: TON;
	TemporizadorTesteIn: BOOL;
	TemporizadorTesteQ: BOOL;
	TemporizadorIntervaloIn: BOOL;
	TemporizadorIntervaloQ: BOOL;
	TempoFalhaForceSup: ARRAY[1..60] OF TON;
	TempoFalhaForceSupIn: ARRAY[1..60] OF BOOL;
	TempoFalhaForceSupQ: ARRAY[1..60] OF BOOL;
	TempoFalhaForceInf: ARRAY[1..60] OF TON;
	TempoFalhaForceInfIn: ARRAY[1..60] OF BOOL;
	TempoFalhaForceInfQ: ARRAY[1..60] OF BOOL;
	ValorAmperResistInferiorOk: ARRAY[1..60] OF BOOL;
	ValorAmperResistSuperiorOk: ARRAY[1..60] OF BOOL;
	ValorAmperResistInferiorAlm: ARRAY[1..60] OF BOOL;
	ValorAmperResistSuperiorAlm: ARRAY[1..60] OF BOOL;
	xIniciaTesteResistencias: BOOL;
	xFimCaseInferior: BOOL;
	xFimCaseSuperior: BOOL;
	/// --------------------------------------------------- 
	/// --------------Variáveis Teste Manual--------------- 
	IndexForce: INT;
	TempoAlmForceSup: ARRAY[1..60] OF TON;
	TempoAlmForceSupIn: ARRAY[1..60] OF BOOL;
	TempoAlmForceSupQ: ARRAY[1..60] OF BOOL;
	TempoAlmForceInf: ARRAY[1..60] OF TON;
	TempoAlmForceInfIn: ARRAY[1..60] OF BOOL;
	TempoAlmForceInfQ: ARRAY[1..60] OF BOOL;
	ForceResInferior: ARRAY[1..60] OF HabilitaDesabilita;
	ForceResSuperior: ARRAY[1..60] OF HabilitaDesabilita;
	BitsSomaInferior: INT;
	BitsSomaInferiorOk: BOOL;
	BitsSomaSuperior: INT;
	BitsSomaSuperiorOk: BOOL;
END_VAR
__IMPLEMENTATION__
(* BLOCO DE TESTE DAS RESISTÊNCIAS *)

// Teste em Automático
IF xTesteResistenciaAutomatico THEN (* Inicio Teste Automático *)	
	CASE PassoTesteInf OF
			0: IF bIniciaTesteResistencias THEN
				xExecutandoTesteResistencias:=TRUE;				
				xTesteResistenciasIniciado:=TRUE;
				Contador:=Contador+1;
				xTestandoResistenciaInferior[Contador]:=TRUE;
				PassoTesteInf:=5;
			   END_IF
			   
			5:	xReleSsrInferior[Contador]:=TRUE;
				rCorrenteInstantInicialFaseA_Amp:=rCorrenteInstantFaseA_Amp;
				rCorrenteInstantInicialFaseB_Amp:=rCorrenteInstantFaseB_Amp;
				rCorrenteInstantInicialFaseC_Amp:=rCorrenteInstantFaseC_Amp;
				PassoTesteInf:=10;
				
			10:	TemporizadorTesteIn:=TRUE;
				IF TemporizadorTesteQ THEN
					PassoTesteInf:=15;
				END_IF
				
			15: TemporizadorTesteIn:=FALSE;
				//xTestandoResistenciaInferior[Contador]:=FALSE;
				IF ValorAmperagemResistenciaInferior[Contador]>5 THEN
					PassoTesteInf:=20;
				ELSE
					PassoTesteInf:=25;
				END_IF

			20:	ValorAmperResistInferiorOk[Contador]:= TRUE;
				PassoTesteInf:=21;
				
			21: xReleSsrInferior[Contador]:=FALSE;
				PassoTesteInf:=22;
			
			//22: IF rCorrenteInstantFaseA_Amp<12 AND rCorrenteInstantFaseB_Amp<11 AND rCorrenteInstantFaseC_Amp<11 THEN
			//		PassoTesteInf:=23;
			//	END_IF
				
			22: IF rCorrenteResistenciaFaseA_Amp<5 AND rCorrenteResistenciaFaseB_Amp<5 AND rCorrenteResistenciaFaseC_Amp<5 THEN
					PassoTesteInf:=23;
				END_IF

			23: TemporizadorIntervaloIn:=TRUE;
				IF TemporizadorIntervaloQ THEN
					PassoTesteInf:=24;
				END_IF
			
			24: TemporizadorIntervaloIn:=FALSE;
				PassoTesteInf:=30;
			
			25:	ValorAmperResistInferiorAlm[Contador]:= TRUE;
			    ValorAmperagemResistenciaInferior[Contador]:=0;
				//xFaseReleInferior[Index]:='';
				PassoTesteInf:=30;
				
			30:	xTestandoResistenciaInferior[Contador]:=FALSE;
				xReleSsrInferior[Contador]:=FALSE;	
				IF Contador= iNumResistencias THEN
					xFimCaseInferior:=TRUE;	
					PassoTesteInf:=0;
				ELSE
					PassoTesteInf:=0;
				END_IF
				
		xTesteResistenciaInferiorOk[Contador]:=ValorAmperResistInferiorOk[Contador];
		xTesteResistenciaInferiorFlh[Contador]:=ValorAmperResistInferiorAlm[Contador];

	END_CASE	
	IF xFimCaseInferior THEN
		Contador:=0;
		bIniciaTesteResistencias:=FALSE;
		xFimCaseInferior:=FALSE;
		xIniciaTesteResistencias:=TRUE;
	END_IF

	CASE PassoTesteSup OF
			0: IF xIniciaTesteResistencias THEN
				Contador:=Contador+1;
				xTestandoResistenciaSuperior[Contador]:=TRUE;
				PassoTesteSup:=5;
			   END_IF
			   
			5:	xReleSsrSuperior[Contador]:=TRUE;
				rCorrenteInstantInicialFaseA_Amp:=rCorrenteInstantFaseA_Amp;
				rCorrenteInstantInicialFaseB_Amp:=rCorrenteInstantFaseB_Amp;
				rCorrenteInstantInicialFaseC_Amp:=rCorrenteInstantFaseC_Amp;
				PassoTesteSup:=10;
				
			10:	TemporizadorTesteIn:=TRUE;
				IF TemporizadorTesteQ THEN
					PassoTesteSup:=15;
				END_IF
				
			15: TemporizadorTesteIn:=FALSE;
				IF ValorAmperagemResistenciaSuperior[Contador]>5 THEN
					PassoTesteSup:=20;
				ELSE
					PassoTesteSup:=25;
				END_IF

			20:	ValorAmperResistSuperiorOk[Contador]:= TRUE;
				PassoTesteSup:=21;
				
			21: xReleSsrSuperior[Contador]:=FALSE;
				PassoTesteSup:=22;
								
			//22: IF rCorrenteInstantFaseA_Amp<12 AND rCorrenteInstantFaseB_Amp<11 AND rCorrenteInstantFaseC_Amp<11 THEN
			//		PassoTesteSup:=23;
			//	END_IF
				
			22: IF rCorrenteResistenciaFaseA_Amp<5 AND rCorrenteResistenciaFaseB_Amp<5 AND rCorrenteResistenciaFaseC_Amp<5 THEN
					PassoTesteSup:=23;
				END_IF

			23: TemporizadorIntervaloIn:=TRUE;
					IF TemporizadorIntervaloQ THEN
					PassoTesteSup:=24;
				END_IF
			
			24: TemporizadorIntervaloIn:=FALSE;
				PassoTesteSup:=30;

			25:	ValorAmperResistSuperiorAlm[Contador]:= TRUE;
				ValorAmperagemResistenciaSuperior[Contador]:=0;
				xFaseReleSuperior[Index]:='';
				PassoTesteSup:=30;
				
			30:	xTestandoResistenciaSuperior[Contador]:=FALSE;
				xReleSsrSuperior[Contador]:=FALSE;	
				IF Contador= iNumResistencias THEN
					xFimCaseSuperior:=TRUE;	
				END_IF
				PassoTesteSup:=0;
				
		xTesteResistenciaSuperiorOk[Contador]:=ValorAmperResistSuperiorOk[Contador];
		xTesteResistenciaSuperiorFlh[Contador]:=ValorAmperResistSuperiorAlm[Contador];

	END_CASE	
	IF xFimCaseSuperior THEN
		Contador:=0;
		xFimCaseSuperior:=FALSE;
		xIniciaTesteResistencias:=FALSE;
		xExecutandoTesteResistencias:=FALSE;
		xFimTesteResistencias:=TRUE;
	END_IF

	IF	bResetTesteResistencias  THEN
		FOR Index:=1 TO iNumResistencias DO
			ValorAmperagemResistenciaInferior[Index]:= 0;	
			ValorAmperagemResistenciaSuperior[Index]:= 0;	
			xFaseReleInferior[Index]:='';	
			xFaseReleSuperior[Index]:='';
			ValorAmperResistInferiorOk[Index]:= FALSE;
			ValorAmperResistSuperiorOk[Index]:= FALSE;
			ValorAmperResistInferiorAlm[Index]:= FALSE;
			ValorAmperResistSuperiorAlm[Index]:= FALSE;
			xTesteResistenciaInferiorOk[Index]:=FALSE;
			xTesteResistenciaInferiorFlh[Index]:=FALSE;
			xTesteResistenciaSuperiorOk[Index]:=FALSE;
			xTesteResistenciaSuperiorFlh[Index]:=FALSE;
			xTesteResistenciasIniciado:=FALSE;
			xFimTesteResistencias:=FALSE;
			xExecutandoTesteResistencias:=FALSE;
			bResetTesteResistencias:=FALSE;
		END_FOR
	END_IF

	IF bAbortaTesteResistencias THEN
		PassoTesteInf:=0;
		PassoTesteSup:=0;
		Contador:=0;
		bIniciaTesteResistencias:=FALSE;
		xFimCaseInferior:=FALSE;
		xFimCaseSuperior:=FALSE;
		xIniciaTesteResistencias:=FALSE;
		xExecutandoTesteResistencias:=FALSE;
		xFimTesteResistencias:=TRUE;
		TemporizadorTesteIn:=FALSE;
		FOR Index01:=1 TO iNumResistencias DO
			xReleSsrInferior[Index01]:=0;
			xReleSsrSuperior[Index01]:=0;
			xTestandoResistenciaInferior[Index01]:=FALSE;
			xTestandoResistenciaSuperior[Index01]:=FALSE;
			ValorAmperagemResistenciaInferior[Index01]:=0;
			ValorAmperagemResistenciaSuperior[Index01]:=0;
		END_FOR
		bAbortaTesteResistencias:=FALSE;	
	END_IF

	TemporizadorTeste(IN:=TemporizadorTesteIn , PT:=T#3000MS, Q=>TemporizadorTesteQ , ET=> );
	TemporizadorIntervalo(IN:=TemporizadorIntervaloIn , PT:=T#500MS, Q=>TemporizadorIntervaloQ , ET=> );

	IF NOT xTesteResistenciasIniciado AND NOT xFimTesteResistencias THEN
		iAnimaStatusTesteResistencias:=0;
	ELSIF xTesteResistenciasIniciado AND NOT xFimTesteResistencias THEN
		iAnimaStatusTesteResistencias:=1;
	ELSIF xTesteResistenciasIniciado AND xFimTesteResistencias THEN
		iAnimaStatusTesteResistencias:=2;
	END_IF

	// Faz a Leitura Das Correntes e Das Fases 
		rCorrenteResistenciaFaseA_Amp:=rCorrenteInstantFaseA_Amp-rCorrenteInstantInicialFaseA_Amp;
		rCorrenteResistenciaFaseB_Amp:=rCorrenteInstantFaseB_Amp-rCorrenteInstantInicialFaseB_Amp;
		rCorrenteResistenciaFaseC_Amp:=rCorrenteInstantFaseC_Amp-rCorrenteInstantInicialFaseC_Amp;

	// Inferiores
	IF xReleSsrInferior[Contador] AND rCorrenteResistenciaFaseA_Amp>5 THEN
		xFaseReleInferior[Contador]:='Fase R';
		ValorAmperagemResistenciaInferior[Contador]:=rCorrenteResistenciaFaseA_Amp;
	ELSIF xReleSsrInferior[Contador] AND rCorrenteResistenciaFaseB_Amp>5 THEN
		xFaseReleInferior[Contador]:='Fase S';
		ValorAmperagemResistenciaInferior[Contador]:=rCorrenteResistenciaFaseB_Amp;
	ELSIF xReleSsrInferior[Contador] AND rCorrenteInstantFaseC_Amp>5 THEN
		xFaseReleInferior[Contador]:='Fase T';
		ValorAmperagemResistenciaInferior[Contador]:=rCorrenteResistenciaFaseC_Amp;
	// Superiores
	ELSIF xReleSsrSuperior[Contador] AND rCorrenteResistenciaFaseA_Amp>5 THEN
		xFaseReleSuperior[Contador]:='Fase R';
		ValorAmperagemResistenciaSuperior[Contador]:=rCorrenteResistenciaFaseA_Amp;
	ELSIF xReleSsrSuperior[Contador] AND rCorrenteResistenciaFaseB_Amp>5 THEN
		xFaseReleSuperior[Contador]:='Fase S';
		ValorAmperagemResistenciaSuperior[Contador]:=rCorrenteResistenciaFaseB_Amp;
	ELSIF xReleSsrSuperior[Contador] AND rCorrenteResistenciaFaseC_Amp>5 THEN
		xFaseReleSuperior[Contador]:='Fase T';
		ValorAmperagemResistenciaSuperior[Contador]:=rCorrenteResistenciaFaseC_Amp;
	END_IF
END_IF (* Final Teste Automático *)



// Teste em Manual -> Force Resistências 
IF xTesteResistenciaManual THEN (* Inicio Teste Manual *)	
	BitsSomaInferior:=0;
	BitsSomaSuperior:=0;
	FOR IndexForce:= 1 TO iNumResistencias DO

		//ForceResInferior[IndexForce]
			//			(Alarme01:= 	xFalhaForcadaInferior[IndexForce] OR xAlarmeResistForceInferior[IndexForce],(*xAlarmeResistRompidaInferior[IndexForce] OR xAlarmeSsrInferiorAberto[IndexForce] OR xAlarmeSsrInferiorFechado[IndexForce]*) 
			//			Alarme02:= 		AlmTermoparAbertoLogicoInf[IndexForce] OR AlmTemperaturaExcedeuLogicoInf[IndexForce], 
			//			Entrada:= 		BtForceResistenciaInferior[IndexForce], 
			//			StatusSaida=> 	xResistenciaForcadaInferior[IndexForce]);
						
IF 	(BtForceResistenciaInferior[IndexForce] AND xResistenciaForcadaInferior[IndexForce]) OR xFalhaForcadaInferior[IndexForce] OR xAlarmeResistForceInferior[IndexForce] OR 	AlmTermoparAbertoLogicoInf[IndexForce] OR AlmTemperaturaExcedeuLogicoInf[IndexForce] THEN
	xResistenciaForcadaInferior[IndexForce]:=FALSE;
ELSIF	BtForceResistenciaInferior[IndexForce] THEN
	xResistenciaForcadaInferior[IndexForce]:=TRUE;
END_IF
						
		BitsSomaInferior:= BitsSomaInferior + BOOL_TO_INT (xResistenciaForcadaInferior[IndexForce]);

		//ForceResSuperior[IndexForce]
						//(Alarme01:= 	xFalhaForcadaSuperior[IndexForce] OR xAlarmeResistForceSuperior[IndexForce],(*xAlarmeResistRompidaSuperior[IndexForce] OR xAlarmeSsrSuperiorAberto[IndexForce] OR xAlarmeSsrSuperiorFechado[IndexForce]*) 
						//Alarme02:= 		AlmTermoparAbertoLogicoSup[IndexForce] OR AlmTemperaturaExcedeuLogicoSup[IndexForce], 
						//Entrada:= 		BtForceResistenciaSuperior[IndexForce], 
						//StatusSaida=> 	xResistenciaForcadaSuperior[IndexForce]);
						
IF  (BtForceResistenciaSuperior[IndexForce] AND xResistenciaForcadaSuperior[IndexForce]) OR xFalhaForcadaSuperior[IndexForce] OR xAlarmeResistForceSuperior[IndexForce] OR AlmTermoparAbertoLogicoSup[IndexForce] OR AlmTemperaturaExcedeuLogicoSup[IndexForce] THEN
	xResistenciaForcadaSuperior[IndexForce]:=FALSE;
ELSIF	BtForceResistenciaSuperior[IndexForce] THEN
	xResistenciaForcadaSuperior[IndexForce]:=TRUE;
END_IF;
					
		BitsSomaSuperior:= BitsSomaSuperior + BOOL_TO_INT (xResistenciaForcadaSuperior[IndexForce]);
		(*---------------------------------------------*)

		//IF	BtForceResistenciaInferior[IndexForce] OR BtForceResistenciaSuperior[IndexForce] THEN	
		IF (xResistenciaForcadaInferior[IndexForce] OR xResistenciaForcadaInferior[IndexForce]) AND NOT xGeralResistenciaForcada THEN
				rCorrenteInstantInicialFaseA_Amp:=rCorrenteInstantFaseA_Amp;
				rCorrenteInstantInicialFaseB_Amp:=rCorrenteInstantFaseB_Amp;
				rCorrenteInstantInicialFaseC_Amp:=rCorrenteInstantFaseC_Amp;
		END_IF
		
		IF BtForceResistenciaInferior[IndexForce] THEN
			BtForceResistenciaInferior[IndexForce]:=FALSE;
		END_IF
		
		IF BtForceResistenciaSuperior[IndexForce] THEN
			BtForceResistenciaSuperior[IndexForce]:=FALSE;
		END_IF;
		
		//Saidas
		xReleSsrInferior[IndexForce]:=xResistenciaForcadaInferior[IndexForce];
		xReleSsrSuperior[IndexForce]:=xResistenciaForcadaSuperior[IndexForce];		
	
		// Alarme Falha no Force Manual das Resistencias Inferiores
		IF xResistenciaForcadaInferior[IndexForce] AND ValorAmperagemResistenciaInferior[IndexForce]<5 (*AND xResistenciaHabilitadaInferior[IndexForce]*) THEN
			TempoAlmForceInfIn[IndexForce]:=TRUE;
		ELSE
			TempoAlmForceInfIn[IndexForce]:=FALSE;
		END_IF
		TempoAlmForceInf[IndexForce](IN:=TempoAlmForceInfIn[IndexForce], PT:=T#3S , Q=>TempoAlmForceInfQ[IndexForce] , ET=> );
		IF TempoAlmForceInfQ[IndexForce] THEN	
			xAlarmeResistForceInferior[IndexForce]:= TRUE;
		END_IF
		IF bResetAlmGeral THEN
			xAlarmeResistForceInferior[IndexForce]:= FALSE;
		END_IF
	
		// Alarme Falha no Force Manual das Resistencias Superiores
		IF xResistenciaForcadaSuperior[IndexForce] AND ValorAmperagemResistenciaSuperior[IndexForce]<5 (*AND xResistenciaHabilitadaSuperior[IndexForce]*) THEN
			TempoAlmForceSupIn[IndexForce]:=TRUE;
		ELSE
			TempoAlmForceSupIn[IndexForce]:=FALSE;
		END_IF
		TempoAlmForceSup[IndexForce](IN:=TempoAlmForceSupIn[IndexForce], PT:=T#3S , Q=>TempoAlmForceSupQ[IndexForce] , ET=> );
		IF TempoAlmForceSupQ[IndexForce] THEN	
			xAlarmeResistForceSuperior[IndexForce]:= TRUE;
		END_IF
		IF bResetAlmGeral THEN
			xAlarmeResistForceSuperior[IndexForce]:= FALSE;
		END_IF
	END_FOR;
	BitsSomaInferiorOk:= BitsSomaInferior=1;
	BitsSomaSuperiorOk:= BitsSomaSuperior=1;
	xGeralResistenciaForcada:=	BitsSomaInferiorOk OR BitsSomaSuperiorOk;					
	// Faz a Leitura Das Correntes e Das Fases 
		rCorrenteResistenciaFaseA_Amp:=rCorrenteInstantFaseA_Amp-rCorrenteInstantInicialFaseA_Amp;
		rCorrenteResistenciaFaseB_Amp:=rCorrenteInstantFaseB_Amp-rCorrenteInstantInicialFaseB_Amp;
		rCorrenteResistenciaFaseC_Amp:=rCorrenteInstantFaseC_Amp-rCorrenteInstantInicialFaseC_Amp;

	FOR Index02:=1 TO iNumResistencias DO
		// Inferiores
		IF xReleSsrInferior[Index02] AND rCorrenteResistenciaFaseA_Amp>5 THEN
			xFaseReleInferior[Index02]:='Fase R';
			ValorAmperagemResistenciaInferior[Index02]:=rCorrenteResistenciaFaseA_Amp;
			TempoFalhaForceInfIn[Index02]:=FALSE;
		ELSIF xReleSsrInferior[Index02] AND rCorrenteResistenciaFaseB_Amp>5 THEN
			xFaseReleInferior[Index02]:='Fase S';
			ValorAmperagemResistenciaInferior[Index02]:=rCorrenteResistenciaFaseB_Amp;
			TempoFalhaForceInfIn[Index02]:=FALSE;
		ELSIF xReleSsrInferior[Index02] AND rCorrenteResistenciaFaseC_Amp>5 THEN
			xFaseReleInferior[Index02]:='Fase T';
			ValorAmperagemResistenciaInferior[Index02]:=rCorrenteResistenciaFaseC_Amp;
			TempoFalhaForceInfIn[Index02]:=FALSE;
		ELSIF xReleSsrInferior[Index02] AND (rCorrenteResistenciaFaseA_Amp<5) AND (rCorrenteResistenciaFaseB_Amp<5) AND (rCorrenteResistenciaFaseC_Amp<5) THEN
				TempoFalhaForceInfIn[Index02]:=TRUE;
		// Superiores
		ELSIF xReleSsrSuperior[Index02] AND rCorrenteResistenciaFaseA_Amp>5 THEN
			xFaseReleSuperior[Index02]:='Fase R';
			ValorAmperagemResistenciaSuperior[Index02]:=rCorrenteResistenciaFaseA_Amp;
			TempoFalhaForceSupIn[Index02]:=FALSE;
		ELSIF xReleSsrSuperior[Index02] AND rCorrenteResistenciaFaseB_Amp>5 THEN
			xFaseReleSuperior[Index02]:='Fase S';
			ValorAmperagemResistenciaSuperior[Index02]:=rCorrenteResistenciaFaseB_Amp;
			TempoFalhaForceSupIn[Index02]:=FALSE;
		ELSIF xReleSsrSuperior[Index02] AND rCorrenteResistenciaFaseC_Amp>5 THEN
			xFaseReleSuperior[Index02]:='Fase T';
			ValorAmperagemResistenciaSuperior[Index02]:=rCorrenteResistenciaFaseC_Amp;
			TempoFalhaForceSupIn[Index02]:=FALSE;
		ELSIF xReleSsrSuperior[Index02] AND (rCorrenteResistenciaFaseA_Amp<5) AND (rCorrenteResistenciaFaseB_Amp<5) AND (rCorrenteResistenciaFaseC_Amp<5) THEN
			TempoFalhaForceSupIn[Index02]:=TRUE;
		END_IF

		IF NOT xGeralResistenciaForcada THEN
			ValorAmperagemResistenciaInferior[Index02]:=0;
			ValorAmperagemResistenciaSuperior[Index02]:=0;
		END_IF
	END_FOR
	//Tempórizadores de Alarme Force
	FOR Index03:=1 TO iNumResistencias DO
		//Inferior
		TempoFalhaForceInf[Index03](IN:=TempoFalhaForceInfIn[Index03], PT:=T#3S , Q=>TempoFalhaForceInfQ[Index03] , ET=> );
		IF TempoFalhaForceInfQ[Index03] THEN
			xFalhaForcadaInferior[Index03]:=TRUE;	
		END_IF
		//Superior
		TempoFalhaForceSup[Index03](IN:=TempoFalhaForceSupIn[Index03], PT:=T#3S , Q=>TempoFalhaForceSupQ[Index03] , ET=> );
		IF TempoFalhaForceSupQ[Index03] THEN
			xFalhaForcadaSuperior[Index03]:=TRUE;	
		END_IF
	
		IF bResetAlmGeral THEN
			xFalhaForcadaInferior[Index03]:= FALSE;
			xFalhaForcadaSuperior[Index03]:= FALSE;
			TempoFalhaForceInfIn[Index03]:=FALSE;	
			TempoFalhaForceSupIn[Index03]:=FALSE;	
		END_IF
	END_FOR
END_IF



