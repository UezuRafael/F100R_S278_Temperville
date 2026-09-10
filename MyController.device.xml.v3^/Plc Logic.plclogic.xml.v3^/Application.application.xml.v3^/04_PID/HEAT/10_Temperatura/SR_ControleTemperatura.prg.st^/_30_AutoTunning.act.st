__METADATA__
{
  "v3Meta": {
    "objectGuid": "f4b158f3-f2b4-4b7f-a2a6-cee7dd1421d1",
    "objectTypeGuid": "8ac092e5-3128-4e26-9e7e-11016c6684f2",
    "embeddedObjectTypeGuids": [
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {},
    "subObjects": {}
  }
}
__IMPLEMENTATION__
// acompanha o status do auto tunning feito em tres degrais (periodos)
// ao final do ciclo do autotunning o sistema compara o comportamento do 3 periodo
// se a subtemperatura e sobretemperatura for da mesma grandeza que o resultado é 2 = sistema balanceado
// se a sobretemperatura for significativamente maior que a subtemperatura o resultado é 3 = sistema sobredimensionado (excesso de calor)
// se a subtemperatura for significativamente maior que a sobretemperatura o resulta é 4 = sistema subdimensionado (falta de calor)
// ao concluir o autotunning escreve os parametros calculados nos conjuntos de parametros de PID stMedium, stSlow e stOffensive
// e muda a variavel em iq_etSelectParameterSetPID para o conjunto de parametros medio (SE_CTBX.ET_ParameterSetPID.Medium)

// a logica abaixo monitora o resultado do autotunning e ja seleciona 
// o conjunto de parametros calculados em funcao do resultado:
// Equilibrado = usa os valores do conjunto medio de parametros
// Sobredimensionado = usa os valores do conjunto slow de parametros (pega o resultado mais suave)
// Subdimensionado = usa os valores do conjunto Offensive de parametros (pega o resultado mais reativo forte)

//======================
//AUTOTUNE TEMPERATURA 1
//======================
CASE TEMP.iAutoTuneStsTemp1 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp1 := FALSE;
		P_stPid1 := stParameterSetsPID[1].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[1].stDefault := P_stPid1; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[1] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp1 := FALSE;
		P_stPid1 := stParameterSetsPID[1].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[1].stDefault := P_stPid1; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[1] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp1 := FALSE;
		P_stPid1 := stParameterSetsPID[1].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[1].stDefault := P_stPid1; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[1] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp1 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp1 := FALSE;	
END_IF


//======================
//AUTOTUNE TEMPERATURA 2
//======================
CASE TEMP.iAutoTuneStsTemp2 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp2 := FALSE;
		P_stPid2 := stParameterSetsPID[2].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[2].stDefault := P_stPid2; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[2] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp2 := FALSE;
		P_stPid2 := stParameterSetsPID[2].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[2].stDefault := P_stPid2; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[2] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp2 := FALSE;
		P_stPid2 := stParameterSetsPID[2].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[2].stDefault := P_stPid2; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[2] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp2 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp2 := FALSE;	
END_IF


//======================
//AUTOTUNE TEMPERATURA 3
//======================
CASE TEMP.iAutoTuneStsTemp3 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp3 := FALSE;
		P_stPid3 := stParameterSetsPID[3].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[3].stDefault := P_stPid3; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[3] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp3 := FALSE;
		P_stPid3 := stParameterSetsPID[3].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[3].stDefault := P_stPid3; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[3] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp3 := FALSE;
		P_stPid3 := stParameterSetsPID[3].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[3].stDefault := P_stPid3; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[3] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp3 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp3 := FALSE;	
END_IF



//======================
//AUTOTUNE TEMPERATURA 4
//======================
CASE TEMP.iAutoTuneStsTemp4 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp4 := FALSE;
		P_stPid4 := stParameterSetsPID[4].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[4].stDefault := P_stPid4; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[4] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp4 := FALSE;
		P_stPid4 := stParameterSetsPID[4].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[4].stDefault := P_stPid4; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[4] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp4 := FALSE;
		P_stPid4 := stParameterSetsPID[4].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[4].stDefault := P_stPid4; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[4] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp4 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp4 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 5
//======================
CASE TEMP.iAutoTuneStsTemp5 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp5 := FALSE;
		P_stPid5 := stParameterSetsPID[5].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[5].stDefault := P_stPid5; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[5] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp5 := FALSE;
		P_stPid5 := stParameterSetsPID[5].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[5].stDefault := P_stPid5; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[5] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp5 := FALSE;
		P_stPid5 := stParameterSetsPID[5].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[5].stDefault := P_stPid5; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[5] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp5 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp5 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 6
//======================
CASE TEMP.iAutoTuneStsTemp6 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp6 := FALSE;
		P_stPid6 := stParameterSetsPID[6].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[6].stDefault := P_stPid6; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[6] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp6 := FALSE;
		P_stPid6 := stParameterSetsPID[6].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[6].stDefault := P_stPid6; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[6] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp6 := FALSE;
		P_stPid6 := stParameterSetsPID[6].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[6].stDefault := P_stPid6; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[6] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp6 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp6 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 7
//======================
CASE TEMP.iAutoTuneStsTemp7 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp7 := FALSE;
		P_stPid7 := stParameterSetsPID[7].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[7].stDefault := P_stPid7; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[7] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp7 := FALSE;
		P_stPid7 := stParameterSetsPID[7].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[7].stDefault := P_stPid7; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[7] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp7 := FALSE;
		P_stPid7 := stParameterSetsPID[7].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[7].stDefault := P_stPid7; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[7] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp7 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp7 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 8
//======================
CASE TEMP.iAutoTuneStsTemp8 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp8 := FALSE;
		P_stPid8 := stParameterSetsPID[8].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[8].stDefault := P_stPid8; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[8] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp8 := FALSE;
		P_stPid8 := stParameterSetsPID[8].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[8].stDefault := P_stPid8; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[8] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp8 := FALSE;
		P_stPid8 := stParameterSetsPID[8].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[8].stDefault := P_stPid8; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[8] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp8 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp8 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 9
//======================
CASE TEMP.iAutoTuneStsTemp9 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp9 := FALSE;
		P_stPid9 := stParameterSetsPID[9].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[9].stDefault := P_stPid9; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[9] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp9 := FALSE;
		P_stPid9 := stParameterSetsPID[9].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[9].stDefault := P_stPid9; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[9] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp9 := FALSE;
		P_stPid9 := stParameterSetsPID[9].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[9].stDefault := P_stPid9; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[9] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp9 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp9 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 10
//======================
CASE TEMP.iAutoTuneStsTemp10 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp10 := FALSE;
		P_stPid10 := stParameterSetsPID[10].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[10].stDefault := P_stPid10; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[10] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp10 := FALSE;
		P_stPid10 := stParameterSetsPID[10].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[10].stDefault := P_stPid10; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[10] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp10 := FALSE;
		P_stPid10 := stParameterSetsPID[10].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[10].stDefault := P_stPid10; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[10] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp10 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp10 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 11
//======================
CASE TEMP.iAutoTuneStsTemp11 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp11 := FALSE;
		P_stPid11 := stParameterSetsPID[11].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[11].stDefault := P_stPid11; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[11] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp11 := FALSE;
		P_stPid11 := stParameterSetsPID[11].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[11].stDefault := P_stPid11; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[11] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp11 := FALSE;
		P_stPid11 := stParameterSetsPID[11].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[11].stDefault := P_stPid11; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[11] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp11 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp11 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 12
//======================
CASE TEMP.iAutoTuneStsTemp12 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp12 := FALSE;
		P_stPid12 := stParameterSetsPID[12].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[12].stDefault := P_stPid12; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[12] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp12 := FALSE;
		P_stPid12 := stParameterSetsPID[12].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[12].stDefault := P_stPid12; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[12] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp12 := FALSE;
		P_stPid12 := stParameterSetsPID[12].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[12].stDefault := P_stPid12; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[12] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp12 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp12 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 13
//======================
CASE TEMP.iAutoTuneStsTemp13 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp13 := FALSE;
		P_stPid13 := stParameterSetsPID[13].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[13].stDefault := P_stPid13; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[13] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp13 := FALSE;
		P_stPid13 := stParameterSetsPID[13].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[13].stDefault := P_stPid13; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[13] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp13 := FALSE;
		P_stPid13 := stParameterSetsPID[13].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[13].stDefault := P_stPid13; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[13] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp13 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp13 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 14
//======================
CASE TEMP.iAutoTuneStsTemp14 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp14 := FALSE;
		P_stPid14 := stParameterSetsPID[14].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[14].stDefault := P_stPid14; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[14] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp14 := FALSE;
		P_stPid14 := stParameterSetsPID[14].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[14].stDefault := P_stPid14; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[14] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp14 := FALSE;
		P_stPid14 := stParameterSetsPID[14].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[14].stDefault := P_stPid14; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[14] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp14 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp14 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 15
//======================
CASE TEMP.iAutoTuneStsTemp15 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp15 := FALSE;
		P_stPid15 := stParameterSetsPID[15].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[15].stDefault := P_stPid15; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[15] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp15 := FALSE;
		P_stPid15 := stParameterSetsPID[15].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[15].stDefault := P_stPid15; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[15] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp15 := FALSE;
		P_stPid15 := stParameterSetsPID[15].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[15].stDefault := P_stPid15; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[15] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp15 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp15 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 16
//======================
CASE TEMP.iAutoTuneStsTemp16 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp16 := FALSE;
		P_stPid16 := stParameterSetsPID[16].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[16].stDefault := P_stPid16; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[16] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp16 := FALSE;
		P_stPid16 := stParameterSetsPID[16].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[16].stDefault := P_stPid16; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[16] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp16 := FALSE;
		P_stPid16 := stParameterSetsPID[16].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[16].stDefault := P_stPid16; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[16] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp16 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp16 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 17
//======================
CASE TEMP.iAutoTuneStsTemp17 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp17 := FALSE;
		P_stPid17 := stParameterSetsPID[17].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[17].stDefault := P_stPid17; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[17] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp17 := FALSE;
		P_stPid17 := stParameterSetsPID[17].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[17].stDefault := P_stPid17; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[17] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp17 := FALSE;
		P_stPid17 := stParameterSetsPID[17].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[17].stDefault := P_stPid17; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[17] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp17 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp17 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 18
//======================
CASE TEMP.iAutoTuneStsTemp18 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp18 := FALSE;
		P_stPid18 := stParameterSetsPID[18].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[18].stDefault := P_stPid18; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[18] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp18 := FALSE;
		P_stPid18 := stParameterSetsPID[18].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[18].stDefault := P_stPid18; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[18] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp18 := FALSE;
		P_stPid18 := stParameterSetsPID[18].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[18].stDefault := P_stPid18; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[18] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp18 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp18 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 19
//======================
CASE TEMP.iAutoTuneStsTemp19 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp19 := FALSE;
		P_stPid19 := stParameterSetsPID[19].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[19].stDefault := P_stPid19; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[19] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp19 := FALSE;
		P_stPid19 := stParameterSetsPID[19].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[19].stDefault := P_stPid19; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[19] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp19 := FALSE;
		P_stPid19 := stParameterSetsPID[19].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[19].stDefault := P_stPid19; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[19] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp19 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp19 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 20
//======================
CASE TEMP.iAutoTuneStsTemp20 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp20 := FALSE;
		P_stPid20 := stParameterSetsPID[20].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[20].stDefault := P_stPid20; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[20] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp20 := FALSE;
		P_stPid20 := stParameterSetsPID[20].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[20].stDefault := P_stPid20; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[20] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp20 := FALSE;
		P_stPid20 := stParameterSetsPID[20].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[20].stDefault := P_stPid20; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[20] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp20 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp20 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 21
//======================
CASE TEMP.iAutoTuneStsTemp21 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp21 := FALSE;
		P_stPid21 := stParameterSetsPID[21].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[21].stDefault := P_stPid21; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[21] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp21 := FALSE;
		P_stPid21 := stParameterSetsPID[21].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[21].stDefault := P_stPid21; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[21] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp21 := FALSE;
		P_stPid21 := stParameterSetsPID[21].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[21].stDefault := P_stPid21; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[21] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp21 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp21 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 22
//======================
CASE TEMP.iAutoTuneStsTemp22 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp22 := FALSE;
		P_stPid22 := stParameterSetsPID[22].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[22].stDefault := P_stPid22; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[22] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp22 := FALSE;
		P_stPid22 := stParameterSetsPID[22].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[22].stDefault := P_stPid22; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[22] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp22 := FALSE;
		P_stPid22 := stParameterSetsPID[22].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[22].stDefault := P_stPid22; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[22] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp22 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp22 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 23
//======================
CASE TEMP.iAutoTuneStsTemp23 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp23 := FALSE;
		P_stPid23 := stParameterSetsPID[23].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[23].stDefault := P_stPid23; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[23] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp23 := FALSE;
		P_stPid23 := stParameterSetsPID[23].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[23].stDefault := P_stPid23; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[23] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp23 := FALSE;
		P_stPid23 := stParameterSetsPID[23].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[23].stDefault := P_stPid23; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[23] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp23 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp23 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 24
//======================
CASE TEMP.iAutoTuneStsTemp24 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp24 := FALSE;
		P_stPid24 := stParameterSetsPID[24].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[24].stDefault := P_stPid24; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[24] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp24 := FALSE;
		P_stPid24 := stParameterSetsPID[24].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[24].stDefault := P_stPid24; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[24] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp24 := FALSE;
		P_stPid24 := stParameterSetsPID[24].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[24].stDefault := P_stPid24; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[24] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp24 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp24 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 25
//======================
CASE TEMP.iAutoTuneStsTemp25 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp25 := FALSE;
		P_stPid25 := stParameterSetsPID[25].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[25].stDefault := P_stPid25; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[25] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp25 := FALSE;
		P_stPid25 := stParameterSetsPID[25].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[25].stDefault := P_stPid25; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[25] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp25 := FALSE;
		P_stPid25 := stParameterSetsPID[25].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[25].stDefault := P_stPid25; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[25] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp25 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp25 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 26
//======================
CASE TEMP.iAutoTuneStsTemp26 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp26 := FALSE;
		P_stPid26 := stParameterSetsPID[26].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[26].stDefault := P_stPid26; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[26] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp26 := FALSE;
		P_stPid26 := stParameterSetsPID[26].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[26].stDefault := P_stPid26; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[26] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp26 := FALSE;
		P_stPid26 := stParameterSetsPID[26].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[26].stDefault := P_stPid26; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[26] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp26 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp26 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 27
//======================
CASE TEMP.iAutoTuneStsTemp27 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp27 := FALSE;
		P_stPid27 := stParameterSetsPID[27].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[27].stDefault := P_stPid27; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[27] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp27 := FALSE;
		P_stPid27 := stParameterSetsPID[27].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[27].stDefault := P_stPid27; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[27] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp27 := FALSE;
		P_stPid27 := stParameterSetsPID[27].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[27].stDefault := P_stPid27; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[27] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp27 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp27 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 28
//======================
CASE TEMP.iAutoTuneStsTemp28 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp28 := FALSE;
		P_stPid28 := stParameterSetsPID[28].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[28].stDefault := P_stPid28; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[28] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp28 := FALSE;
		P_stPid28 := stParameterSetsPID[28].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[28].stDefault := P_stPid28; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[28] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp28 := FALSE;
		P_stPid28 := stParameterSetsPID[28].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[28].stDefault := P_stPid28; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[28] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp28 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp28 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 29
//======================
CASE TEMP.iAutoTuneStsTemp29 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp29 := FALSE;
		P_stPid29 := stParameterSetsPID[29].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[29].stDefault := P_stPid29; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[29] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp29 := FALSE;
		P_stPid29 := stParameterSetsPID[29].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[29].stDefault := P_stPid29; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[29] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp29 := FALSE;
		P_stPid29 := stParameterSetsPID[29].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[29].stDefault := P_stPid29; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[29] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp29 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp29 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 30
//======================
CASE TEMP.iAutoTuneStsTemp30 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp30 := FALSE;
		P_stPid30 := stParameterSetsPID[30].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[30].stDefault := P_stPid30; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[30] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp30 := FALSE;
		P_stPid30 := stParameterSetsPID[30].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[30].stDefault := P_stPid30; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[30] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp30 := FALSE;
		P_stPid30 := stParameterSetsPID[30].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[30].stDefault := P_stPid30; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[30] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp30 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp30 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 31
//======================
CASE TEMP.iAutoTuneStsTemp31 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp31 := FALSE;
		P_stPid31 := stParameterSetsPID[31].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[31].stDefault := P_stPid31; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[31] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp31 := FALSE;
		P_stPid31 := stParameterSetsPID[31].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[31].stDefault := P_stPid31; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[31] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp31 := FALSE;
		P_stPid31 := stParameterSetsPID[31].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[31].stDefault := P_stPid31; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[31] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp31 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp31 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 32
//======================
CASE TEMP.iAutoTuneStsTemp32 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp32 := FALSE;
		P_stPid32 := stParameterSetsPID[32].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[32].stDefault := P_stPid32; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[32] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp32 := FALSE;
		P_stPid32 := stParameterSetsPID[32].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[32].stDefault := P_stPid32; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[32] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp32 := FALSE;
		P_stPid32 := stParameterSetsPID[32].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[32].stDefault := P_stPid32; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[32] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp32 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp32 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 33
//======================
CASE TEMP.iAutoTuneStsTemp33 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp33 := FALSE;
		P_stPid33 := stParameterSetsPID[33].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[33].stDefault := P_stPid33; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[33] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp33 := FALSE;
		P_stPid33 := stParameterSetsPID[33].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[33].stDefault := P_stPid33; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[33] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp33 := FALSE;
		P_stPid33 := stParameterSetsPID[33].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[33].stDefault := P_stPid33; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[33] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp33 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp33 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 34
//======================
CASE TEMP.iAutoTuneStsTemp34 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp34 := FALSE;
		P_stPid34 := stParameterSetsPID[34].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[34].stDefault := P_stPid34; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[34] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp34 := FALSE;
		P_stPid34 := stParameterSetsPID[34].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[34].stDefault := P_stPid34; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[34] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp34 := FALSE;
		P_stPid34 := stParameterSetsPID[34].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[34].stDefault := P_stPid34; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[34] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp34 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp34 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 35
//======================
CASE TEMP.iAutoTuneStsTemp35 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp35 := FALSE;
		P_stPid35 := stParameterSetsPID[35].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[35].stDefault := P_stPid35; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[35] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp35 := FALSE;
		P_stPid35 := stParameterSetsPID[35].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[35].stDefault := P_stPid35; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[35] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp35 := FALSE;
		P_stPid35 := stParameterSetsPID[35].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[35].stDefault := P_stPid35; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[35] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp35 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp35 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 36
//======================
CASE TEMP.iAutoTuneStsTemp36 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp36 := FALSE;
		P_stPid36 := stParameterSetsPID[36].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[36].stDefault := P_stPid36; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[36] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp36 := FALSE;
		P_stPid36 := stParameterSetsPID[36].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[36].stDefault := P_stPid36; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[36] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp36 := FALSE;
		P_stPid36 := stParameterSetsPID[36].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[36].stDefault := P_stPid36; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[36] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp36 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp36 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 37
//======================
CASE TEMP.iAutoTuneStsTemp37 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp37 := FALSE;
		P_stPid37 := stParameterSetsPID[37].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[37].stDefault := P_stPid37; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[37] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp37 := FALSE;
		P_stPid37 := stParameterSetsPID[37].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[37].stDefault := P_stPid37; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[37] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp37 := FALSE;
		P_stPid37 := stParameterSetsPID[37].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[37].stDefault := P_stPid37; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[37] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp37 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp37 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 38
//======================
CASE TEMP.iAutoTuneStsTemp38 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp38 := FALSE;
		P_stPid38 := stParameterSetsPID[38].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[38].stDefault := P_stPid38; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[38] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp38 := FALSE;
		P_stPid38 := stParameterSetsPID[38].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[38].stDefault := P_stPid38; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[38] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp38 := FALSE;
		P_stPid38 := stParameterSetsPID[38].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[38].stDefault := P_stPid38; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[38] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp38 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp38 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 39
//======================
CASE TEMP.iAutoTuneStsTemp39 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp39 := FALSE;
		P_stPid39 := stParameterSetsPID[39].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[39].stDefault := P_stPid39; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[39] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp39 := FALSE;
		P_stPid39 := stParameterSetsPID[39].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[39].stDefault := P_stPid39; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[39] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp39 := FALSE;
		P_stPid39 := stParameterSetsPID[39].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[39].stDefault := P_stPid39; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[39] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp39 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp39 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 40
//======================
CASE TEMP.iAutoTuneStsTemp40 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp40 := FALSE;
		P_stPid40 := stParameterSetsPID[40].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[40].stDefault := P_stPid40; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[40] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp40 := FALSE;
		P_stPid40 := stParameterSetsPID[40].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[40].stDefault := P_stPid40; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[40] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp40 := FALSE;
		P_stPid40 := stParameterSetsPID[40].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[40].stDefault := P_stPid40; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[40] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp40 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp40 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 41
//======================
CASE TEMP.iAutoTuneStsTemp41 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp41 := FALSE;
		P_stPid41 := stParameterSetsPID[41].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[41].stDefault := P_stPid41; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[41] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp41 := FALSE;
		P_stPid41 := stParameterSetsPID[41].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[41].stDefault := P_stPid41; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[41] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp41 := FALSE;
		P_stPid41 := stParameterSetsPID[41].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[41].stDefault := P_stPid41; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[41] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp41 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp41 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 42
//======================
CASE TEMP.iAutoTuneStsTemp42 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp42 := FALSE;
		P_stPid42 := stParameterSetsPID[42].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[42].stDefault := P_stPid42; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[42] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp42 := FALSE;
		P_stPid42 := stParameterSetsPID[42].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[42].stDefault := P_stPid42; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[42] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp42 := FALSE;
		P_stPid42 := stParameterSetsPID[42].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[42].stDefault := P_stPid42; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[42] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp42 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp42 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 43
//======================
CASE TEMP.iAutoTuneStsTemp43 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp43 := FALSE;
		P_stPid43 := stParameterSetsPID[43].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[43].stDefault := P_stPid43; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[43] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp43 := FALSE;
		P_stPid43 := stParameterSetsPID[43].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[43].stDefault := P_stPid43; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[43] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp43 := FALSE;
		P_stPid43 := stParameterSetsPID[43].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[43].stDefault := P_stPid43; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[43] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp43 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp43 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 44
//======================
CASE TEMP.iAutoTuneStsTemp44 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp44 := FALSE;
		P_stPid44 := stParameterSetsPID[44].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[44].stDefault := P_stPid44; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[44] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp44 := FALSE;
		P_stPid44 := stParameterSetsPID[44].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[44].stDefault := P_stPid44; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[44] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp44 := FALSE;
		P_stPid44 := stParameterSetsPID[44].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[44].stDefault := P_stPid44; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[44] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp44 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp44 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 45
//======================
CASE TEMP.iAutoTuneStsTemp45 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp45 := FALSE;
		P_stPid45 := stParameterSetsPID[45].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[45].stDefault := P_stPid45; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[45] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp45 := FALSE;
		P_stPid45 := stParameterSetsPID[45].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[45].stDefault := P_stPid45; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[45] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp45 := FALSE;
		P_stPid45 := stParameterSetsPID[45].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[45].stDefault := P_stPid45; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[45] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp45 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp45 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 46
//======================
CASE TEMP.iAutoTuneStsTemp46 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp46 := FALSE;
		P_stPid46 := stParameterSetsPID[46].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[46].stDefault := P_stPid46; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[46] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp46 := FALSE;
		P_stPid46 := stParameterSetsPID[46].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[46].stDefault := P_stPid46; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[46] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp46 := FALSE;
		P_stPid46 := stParameterSetsPID[46].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[46].stDefault := P_stPid46; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[46] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp46 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp46 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 47
//======================
CASE TEMP.iAutoTuneStsTemp47 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp47 := FALSE;
		P_stPid47 := stParameterSetsPID[47].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[47].stDefault := P_stPid47; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[47] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp47 := FALSE;
		P_stPid47 := stParameterSetsPID[47].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[47].stDefault := P_stPid47; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[47] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp47 := FALSE;
		P_stPid47 := stParameterSetsPID[47].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[47].stDefault := P_stPid47; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[47] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp47 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp47 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 48
//======================
CASE TEMP.iAutoTuneStsTemp48 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp48 := FALSE;
		P_stPid48 := stParameterSetsPID[48].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[48].stDefault := P_stPid48; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[48] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp48 := FALSE;
		P_stPid48 := stParameterSetsPID[48].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[48].stDefault := P_stPid48; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[48] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp48 := FALSE;
		P_stPid48 := stParameterSetsPID[48].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[48].stDefault := P_stPid48; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[48] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp48 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp48 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 49
//======================
CASE TEMP.iAutoTuneStsTemp49 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp49 := FALSE;
		P_stPid49 := stParameterSetsPID[49].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[49].stDefault := P_stPid49; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[49] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp49 := FALSE;
		P_stPid49 := stParameterSetsPID[49].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[49].stDefault := P_stPid49; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[49] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp49 := FALSE;
		P_stPid49 := stParameterSetsPID[49].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[49].stDefault := P_stPid49; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[49] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp49 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp49 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 50
//======================
CASE TEMP.iAutoTuneStsTemp50 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp50 := FALSE;
		P_stPid50 := stParameterSetsPID[50].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[50].stDefault := P_stPid50; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[50] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp50 := FALSE;
		P_stPid50 := stParameterSetsPID[50].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[50].stDefault := P_stPid50; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[50] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp50 := FALSE;
		P_stPid50 := stParameterSetsPID[50].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[50].stDefault := P_stPid50; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[50] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp50 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp50 := FALSE;	
END_IF


// superior

//======================
//AUTOTUNE TEMPERATURA 51
//======================
CASE TEMP.iAutoTuneStsTemp51 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp51 := FALSE;
		P_stPid51 := stParameterSetsPID[51].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[51].stDefault := P_stPid51; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[51] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp51 := FALSE;
		P_stPid51 := stParameterSetsPID[51].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[51].stDefault := P_stPid51; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[51] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp51 := FALSE;
		P_stPid51 := stParameterSetsPID[51].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[51].stDefault := P_stPid51; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[51] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp51 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp51 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 52
//======================
CASE TEMP.iAutoTuneStsTemp52 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp52 := FALSE;
		P_stPid52 := stParameterSetsPID[52].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[52].stDefault := P_stPid52; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[52] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp52 := FALSE;
		P_stPid52 := stParameterSetsPID[52].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[52].stDefault := P_stPid52; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[52] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp52 := FALSE;
		P_stPid52 := stParameterSetsPID[52].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[52].stDefault := P_stPid52; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[52] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp52 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp52 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 53
//======================
CASE TEMP.iAutoTuneStsTemp53 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp53 := FALSE;
		P_stPid53 := stParameterSetsPID[53].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[53].stDefault := P_stPid53; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[53] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp53 := FALSE;
		P_stPid53 := stParameterSetsPID[53].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[53].stDefault := P_stPid53; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[53] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp53 := FALSE;
		P_stPid53 := stParameterSetsPID[53].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[53].stDefault := P_stPid53; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[53] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp53 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp53 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 54
//======================
CASE TEMP.iAutoTuneStsTemp54 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp54 := FALSE;
		P_stPid54 := stParameterSetsPID[54].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[54].stDefault := P_stPid54; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[54] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp54 := FALSE;
		P_stPid54 := stParameterSetsPID[54].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[54].stDefault := P_stPid54; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[54] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp54 := FALSE;
		P_stPid54 := stParameterSetsPID[54].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[54].stDefault := P_stPid54; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[54] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp54 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp54 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 55
//======================
CASE TEMP.iAutoTuneStsTemp55 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp55 := FALSE;
		P_stPid55 := stParameterSetsPID[55].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[55].stDefault := P_stPid55; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[55] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp55 := FALSE;
		P_stPid55 := stParameterSetsPID[55].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[55].stDefault := P_stPid55; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[55] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp55 := FALSE;
		P_stPid55 := stParameterSetsPID[55].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[55].stDefault := P_stPid55; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[55] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp55 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp55 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 56
//======================
CASE TEMP.iAutoTuneStsTemp56 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp56 := FALSE;
		P_stPid56 := stParameterSetsPID[56].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[56].stDefault := P_stPid56; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[56] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp56 := FALSE;
		P_stPid56 := stParameterSetsPID[56].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[56].stDefault := P_stPid56; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[56] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp56 := FALSE;
		P_stPid56 := stParameterSetsPID[56].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[56].stDefault := P_stPid56; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[56] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp56 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp56 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 57
//======================
CASE TEMP.iAutoTuneStsTemp57 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp57 := FALSE;
		P_stPid57 := stParameterSetsPID[57].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[57].stDefault := P_stPid57; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[57] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp57 := FALSE;
		P_stPid57 := stParameterSetsPID[57].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[57].stDefault := P_stPid57; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[57] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp57 := FALSE;
		P_stPid57 := stParameterSetsPID[57].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[57].stDefault := P_stPid57; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[57] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp57 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp57 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 58
//======================
CASE TEMP.iAutoTuneStsTemp58 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp58 := FALSE;
		P_stPid58 := stParameterSetsPID[58].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[58].stDefault := P_stPid58; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[58] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp58 := FALSE;
		P_stPid58 := stParameterSetsPID[58].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[58].stDefault := P_stPid58; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[58] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp58 := FALSE;
		P_stPid58 := stParameterSetsPID[58].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[58].stDefault := P_stPid58; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[58] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp58 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp58 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 59
//======================
CASE TEMP.iAutoTuneStsTemp59 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp59 := FALSE;
		P_stPid59 := stParameterSetsPID[59].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[59].stDefault := P_stPid59; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[59] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp59 := FALSE;
		P_stPid59 := stParameterSetsPID[59].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[59].stDefault := P_stPid59; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[59] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp59 := FALSE;
		P_stPid59 := stParameterSetsPID[59].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[59].stDefault := P_stPid59; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[59] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp59 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp59 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 60
//======================
CASE TEMP.iAutoTuneStsTemp60 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp60 := FALSE;
		P_stPid60 := stParameterSetsPID[60].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[60].stDefault := P_stPid60; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[60] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp60 := FALSE;
		P_stPid60 := stParameterSetsPID[60].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[60].stDefault := P_stPid60; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[60] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp60 := FALSE;
		P_stPid60 := stParameterSetsPID[60].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[60].stDefault := P_stPid60; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[60] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp60 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp60 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 61
//======================
CASE TEMP.iAutoTuneStsTemp61 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp61 := FALSE;
		P_stPid61 := stParameterSetsPID[61].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[61].stDefault := P_stPid61; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[61] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp61 := FALSE;
		P_stPid61 := stParameterSetsPID[61].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[61].stDefault := P_stPid61; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[61] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp61 := FALSE;
		P_stPid61 := stParameterSetsPID[61].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[61].stDefault := P_stPid61; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[61] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp61 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp61 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 62
//======================
CASE TEMP.iAutoTuneStsTemp62 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp62 := FALSE;
		P_stPid62 := stParameterSetsPID[62].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[62].stDefault := P_stPid62; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[62] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp62 := FALSE;
		P_stPid62 := stParameterSetsPID[62].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[62].stDefault := P_stPid62; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[62] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp62 := FALSE;
		P_stPid62 := stParameterSetsPID[62].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[62].stDefault := P_stPid62; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[62] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp62 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp62 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 63
//======================
CASE TEMP.iAutoTuneStsTemp63 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp63 := FALSE;
		P_stPid63 := stParameterSetsPID[63].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[63].stDefault := P_stPid63; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[63] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp63 := FALSE;
		P_stPid63 := stParameterSetsPID[63].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[63].stDefault := P_stPid63; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[63] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp63 := FALSE;
		P_stPid63 := stParameterSetsPID[63].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[63].stDefault := P_stPid63; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[63] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp63 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp63 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 64
//======================
CASE TEMP.iAutoTuneStsTemp64 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp64 := FALSE;
		P_stPid64 := stParameterSetsPID[64].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[64].stDefault := P_stPid64; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[64] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp64 := FALSE;
		P_stPid64 := stParameterSetsPID[64].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[64].stDefault := P_stPid64; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[64] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp64 := FALSE;
		P_stPid64 := stParameterSetsPID[64].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[64].stDefault := P_stPid64; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[64] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp64 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp64 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 65
//======================
CASE TEMP.iAutoTuneStsTemp65 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp65 := FALSE;
		P_stPid65 := stParameterSetsPID[65].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[65].stDefault := P_stPid65; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[65] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp65 := FALSE;
		P_stPid65 := stParameterSetsPID[65].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[65].stDefault := P_stPid65; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[65] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp65 := FALSE;
		P_stPid65 := stParameterSetsPID[65].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[65].stDefault := P_stPid65; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[65] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp65 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp65 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 66
//======================
CASE TEMP.iAutoTuneStsTemp66 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp66 := FALSE;
		P_stPid66 := stParameterSetsPID[66].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[66].stDefault := P_stPid66; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[66] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp66 := FALSE;
		P_stPid66 := stParameterSetsPID[66].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[66].stDefault := P_stPid66; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[66] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp66 := FALSE;
		P_stPid66 := stParameterSetsPID[66].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[66].stDefault := P_stPid66; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[66] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp66 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp66 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 67
//======================
CASE TEMP.iAutoTuneStsTemp67 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp67 := FALSE;
		P_stPid67 := stParameterSetsPID[67].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[67].stDefault := P_stPid67; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[67] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp67 := FALSE;
		P_stPid67 := stParameterSetsPID[67].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[67].stDefault := P_stPid67; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[67] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp67 := FALSE;
		P_stPid67 := stParameterSetsPID[67].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[67].stDefault := P_stPid67; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[67] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp67 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp67 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 68
//======================
CASE TEMP.iAutoTuneStsTemp68 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp68 := FALSE;
		P_stPid68 := stParameterSetsPID[68].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[68].stDefault := P_stPid68; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[68] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp68 := FALSE;
		P_stPid68 := stParameterSetsPID[68].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[68].stDefault := P_stPid68; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[68] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp68 := FALSE;
		P_stPid68 := stParameterSetsPID[68].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[68].stDefault := P_stPid68; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[68] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp68 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp68 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 69
//======================
CASE TEMP.iAutoTuneStsTemp69 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp69 := FALSE;
		P_stPid69 := stParameterSetsPID[69].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[69].stDefault := P_stPid69; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[69] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp69 := FALSE;
		P_stPid69 := stParameterSetsPID[69].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[69].stDefault := P_stPid69; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[69] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp69 := FALSE;
		P_stPid69 := stParameterSetsPID[69].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[69].stDefault := P_stPid69; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[69] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp69 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp69 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 70
//======================
CASE TEMP.iAutoTuneStsTemp70 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp70 := FALSE;
		P_stPid70 := stParameterSetsPID[70].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[70].stDefault := P_stPid70; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[70] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp70 := FALSE;
		P_stPid70 := stParameterSetsPID[70].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[70].stDefault := P_stPid70; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[70] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp70 := FALSE;
		P_stPid70 := stParameterSetsPID[70].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[70].stDefault := P_stPid70; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[70] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp70 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp70 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 71
//======================
CASE TEMP.iAutoTuneStsTemp71 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp71 := FALSE;
		P_stPid71 := stParameterSetsPID[71].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[71].stDefault := P_stPid71; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[71] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp71 := FALSE;
		P_stPid71 := stParameterSetsPID[71].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[71].stDefault := P_stPid71; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[71] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp71 := FALSE;
		P_stPid71 := stParameterSetsPID[71].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[71].stDefault := P_stPid71; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[71] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp71 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp71 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 72
//======================
CASE TEMP.iAutoTuneStsTemp72 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp72 := FALSE;
		P_stPid72 := stParameterSetsPID[72].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[72].stDefault := P_stPid72; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[72] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp72 := FALSE;
		P_stPid72 := stParameterSetsPID[72].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[72].stDefault := P_stPid72; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[72] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp72 := FALSE;
		P_stPid72 := stParameterSetsPID[72].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[72].stDefault := P_stPid72; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[72] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp72 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp72 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 73
//======================
CASE TEMP.iAutoTuneStsTemp73 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp73 := FALSE;
		P_stPid73 := stParameterSetsPID[73].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[73].stDefault := P_stPid73; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[73] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp73 := FALSE;
		P_stPid73 := stParameterSetsPID[73].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[73].stDefault := P_stPid73; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[73] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp73 := FALSE;
		P_stPid73 := stParameterSetsPID[73].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[73].stDefault := P_stPid73; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[73] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp73 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp73 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 74
//======================
CASE TEMP.iAutoTuneStsTemp74 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp74 := FALSE;
		P_stPid74 := stParameterSetsPID[74].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[74].stDefault := P_stPid74; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[74] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp74 := FALSE;
		P_stPid74 := stParameterSetsPID[74].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[74].stDefault := P_stPid74; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[74] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp74 := FALSE;
		P_stPid74 := stParameterSetsPID[74].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[74].stDefault := P_stPid74; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[74] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp74 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp74 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 75
//======================
CASE TEMP.iAutoTuneStsTemp75 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp75 := FALSE;
		P_stPid75 := stParameterSetsPID[75].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[75].stDefault := P_stPid75; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[75] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp75 := FALSE;
		P_stPid75 := stParameterSetsPID[75].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[75].stDefault := P_stPid75; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[75] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp75 := FALSE;
		P_stPid75 := stParameterSetsPID[75].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[75].stDefault := P_stPid75; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[75] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp75 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp75 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 76
//======================
CASE TEMP.iAutoTuneStsTemp76 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp76 := FALSE;
		P_stPid76 := stParameterSetsPID[76].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[76].stDefault := P_stPid76; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[76] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp76 := FALSE;
		P_stPid76 := stParameterSetsPID[76].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[76].stDefault := P_stPid76; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[76] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp76 := FALSE;
		P_stPid76 := stParameterSetsPID[76].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[76].stDefault := P_stPid76; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[76] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp76 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp76 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 77
//======================
CASE TEMP.iAutoTuneStsTemp77 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp77 := FALSE;
		P_stPid77 := stParameterSetsPID[77].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[77].stDefault := P_stPid77; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[77] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp77 := FALSE;
		P_stPid77 := stParameterSetsPID[77].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[77].stDefault := P_stPid77; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[77] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp77 := FALSE;
		P_stPid77 := stParameterSetsPID[77].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[77].stDefault := P_stPid77; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[77] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp77 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp77 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 78
//======================
CASE TEMP.iAutoTuneStsTemp78 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp78 := FALSE;
		P_stPid78 := stParameterSetsPID[78].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[78].stDefault := P_stPid78; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[78] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp78 := FALSE;
		P_stPid78 := stParameterSetsPID[78].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[78].stDefault := P_stPid78; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[78] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp78 := FALSE;
		P_stPid78 := stParameterSetsPID[78].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[78].stDefault := P_stPid78; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[78] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp78 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp78 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 79
//======================
CASE TEMP.iAutoTuneStsTemp79 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp79 := FALSE;
		P_stPid79 := stParameterSetsPID[79].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[79].stDefault := P_stPid79; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[79] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp79 := FALSE;
		P_stPid79 := stParameterSetsPID[79].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[79].stDefault := P_stPid79; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[79] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp79 := FALSE;
		P_stPid79 := stParameterSetsPID[79].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[79].stDefault := P_stPid79; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[79] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp79 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp79 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 80
//======================
CASE TEMP.iAutoTuneStsTemp80 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp80 := FALSE;
		P_stPid80 := stParameterSetsPID[80].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[80].stDefault := P_stPid80; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[80] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp80 := FALSE;
		P_stPid80 := stParameterSetsPID[80].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[80].stDefault := P_stPid80; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[80] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp80 := FALSE;
		P_stPid80 := stParameterSetsPID[80].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[80].stDefault := P_stPid80; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[80] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp80 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp80 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 81
//======================
CASE TEMP.iAutoTuneStsTemp81 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp81 := FALSE;
		P_stPid81 := stParameterSetsPID[81].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[81].stDefault := P_stPid81; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[81] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp81 := FALSE;
		P_stPid81 := stParameterSetsPID[81].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[81].stDefault := P_stPid81; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[81] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp81 := FALSE;
		P_stPid81 := stParameterSetsPID[81].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[81].stDefault := P_stPid81; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[81] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp81 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp81 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 82
//======================
CASE TEMP.iAutoTuneStsTemp82 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp82 := FALSE;
		P_stPid82 := stParameterSetsPID[82].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[82].stDefault := P_stPid82; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[82] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp82 := FALSE;
		P_stPid82 := stParameterSetsPID[82].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[82].stDefault := P_stPid82; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[82] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp82 := FALSE;
		P_stPid82 := stParameterSetsPID[82].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[82].stDefault := P_stPid82; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[82] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp82 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp82 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 83
//======================
CASE TEMP.iAutoTuneStsTemp83 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp83 := FALSE;
		P_stPid83 := stParameterSetsPID[83].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[83].stDefault := P_stPid83; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[83] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp83 := FALSE;
		P_stPid83 := stParameterSetsPID[83].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[83].stDefault := P_stPid83; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[83] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp83 := FALSE;
		P_stPid83 := stParameterSetsPID[83].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[83].stDefault := P_stPid83; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[83] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp83 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp83 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 84
//======================
CASE TEMP.iAutoTuneStsTemp84 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp84 := FALSE;
		P_stPid84 := stParameterSetsPID[84].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[84].stDefault := P_stPid84; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[84] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp84 := FALSE;
		P_stPid84 := stParameterSetsPID[84].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[84].stDefault := P_stPid84; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[84] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp84 := FALSE;
		P_stPid84 := stParameterSetsPID[84].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[84].stDefault := P_stPid84; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[84] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp84 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp84 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 85
//======================
CASE TEMP.iAutoTuneStsTemp85 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp85 := FALSE;
		P_stPid85 := stParameterSetsPID[85].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[85].stDefault := P_stPid85; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[85] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp85 := FALSE;
		P_stPid85 := stParameterSetsPID[85].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[85].stDefault := P_stPid85; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[85] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp85 := FALSE;
		P_stPid85 := stParameterSetsPID[85].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[85].stDefault := P_stPid85; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[85] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp85 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp85 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 86
//======================
CASE TEMP.iAutoTuneStsTemp86 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp86 := FALSE;
		P_stPid86 := stParameterSetsPID[86].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[86].stDefault := P_stPid86; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[86] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp86 := FALSE;
		P_stPid86 := stParameterSetsPID[86].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[86].stDefault := P_stPid86; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[86] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp86 := FALSE;
		P_stPid86 := stParameterSetsPID[86].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[86].stDefault := P_stPid86; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[86] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp86 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp86 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 87
//======================
CASE TEMP.iAutoTuneStsTemp87 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp87 := FALSE;
		P_stPid87 := stParameterSetsPID[87].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[87].stDefault := P_stPid87; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[87] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp87 := FALSE;
		P_stPid87 := stParameterSetsPID[87].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[87].stDefault := P_stPid87; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[87] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp87 := FALSE;
		P_stPid87 := stParameterSetsPID[87].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[87].stDefault := P_stPid87; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[87] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp87 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp87 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 88
//======================
CASE TEMP.iAutoTuneStsTemp88 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp88 := FALSE;
		P_stPid88 := stParameterSetsPID[88].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[88].stDefault := P_stPid88; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[88] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp88 := FALSE;
		P_stPid88 := stParameterSetsPID[88].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[88].stDefault := P_stPid88; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[88] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp88 := FALSE;
		P_stPid88 := stParameterSetsPID[88].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[88].stDefault := P_stPid88; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[88] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp88 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp88 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 89
//======================
CASE TEMP.iAutoTuneStsTemp89 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp89 := FALSE;
		P_stPid89 := stParameterSetsPID[89].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[89].stDefault := P_stPid89; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[89] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp89 := FALSE;
		P_stPid89 := stParameterSetsPID[89].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[89].stDefault := P_stPid89; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[89] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp89 := FALSE;
		P_stPid89 := stParameterSetsPID[89].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[89].stDefault := P_stPid89; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[89] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp89 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp89 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 90
//======================
CASE TEMP.iAutoTuneStsTemp90 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp90 := FALSE;
		P_stPid90 := stParameterSetsPID[90].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[90].stDefault := P_stPid90; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[90] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp90 := FALSE;
		P_stPid90 := stParameterSetsPID[90].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[90].stDefault := P_stPid90; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[90] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp90 := FALSE;
		P_stPid90 := stParameterSetsPID[90].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[90].stDefault := P_stPid90; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[90] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp90 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp90 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 91
//======================
CASE TEMP.iAutoTuneStsTemp91 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp91 := FALSE;
		P_stPid91 := stParameterSetsPID[91].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[91].stDefault := P_stPid91; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[91] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp91 := FALSE;
		P_stPid91 := stParameterSetsPID[91].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[91].stDefault := P_stPid91; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[91] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp91 := FALSE;
		P_stPid91 := stParameterSetsPID[91].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[91].stDefault := P_stPid91; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[91] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp91 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp91 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 92
//======================
CASE TEMP.iAutoTuneStsTemp92 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp92 := FALSE;
		P_stPid92 := stParameterSetsPID[92].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[92].stDefault := P_stPid92; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[92] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp92 := FALSE;
		P_stPid92 := stParameterSetsPID[92].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[92].stDefault := P_stPid92; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[92] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp92 := FALSE;
		P_stPid92 := stParameterSetsPID[92].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[92].stDefault := P_stPid92; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[92] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp92 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp92 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 93
//======================
CASE TEMP.iAutoTuneStsTemp93 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp93 := FALSE;
		P_stPid93 := stParameterSetsPID[93].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[93].stDefault := P_stPid93; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[93] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp93 := FALSE;
		P_stPid93 := stParameterSetsPID[93].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[93].stDefault := P_stPid93; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[93] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp93 := FALSE;
		P_stPid93 := stParameterSetsPID[93].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[93].stDefault := P_stPid93; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[93] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp93 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp93 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 94
//======================
CASE TEMP.iAutoTuneStsTemp94 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp94 := FALSE;
		P_stPid94 := stParameterSetsPID[94].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[94].stDefault := P_stPid94; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[94] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp94 := FALSE;
		P_stPid94 := stParameterSetsPID[94].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[94].stDefault := P_stPid94; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[94] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp94 := FALSE;
		P_stPid94 := stParameterSetsPID[94].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[94].stDefault := P_stPid94; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[94] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp94 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp94 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 95
//======================
CASE TEMP.iAutoTuneStsTemp95 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp95 := FALSE;
		P_stPid95 := stParameterSetsPID[95].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[95].stDefault := P_stPid95; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[95] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp95 := FALSE;
		P_stPid95 := stParameterSetsPID[95].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[95].stDefault := P_stPid95; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[95] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp95 := FALSE;
		P_stPid95 := stParameterSetsPID[95].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[95].stDefault := P_stPid95; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[95] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp95 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp95 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 96
//======================
CASE TEMP.iAutoTuneStsTemp96 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp96 := FALSE;
		P_stPid96 := stParameterSetsPID[96].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[96].stDefault := P_stPid96; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[96] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp96 := FALSE;
		P_stPid96 := stParameterSetsPID[96].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[96].stDefault := P_stPid96; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[96] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp96 := FALSE;
		P_stPid96 := stParameterSetsPID[96].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[96].stDefault := P_stPid96; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[96] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp96 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp96 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 97
//======================
CASE TEMP.iAutoTuneStsTemp97 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp97 := FALSE;
		P_stPid97 := stParameterSetsPID[97].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[97].stDefault := P_stPid97; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[97] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp97 := FALSE;
		P_stPid97 := stParameterSetsPID[97].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[97].stDefault := P_stPid97; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[97] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp97 := FALSE;
		P_stPid97 := stParameterSetsPID[97].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[97].stDefault := P_stPid97; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[97] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp97 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp97 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 98
//======================
CASE TEMP.iAutoTuneStsTemp98 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp98 := FALSE;
		P_stPid98 := stParameterSetsPID[98].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[98].stDefault := P_stPid98; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[98] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp98 := FALSE;
		P_stPid98 := stParameterSetsPID[98].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[98].stDefault := P_stPid98; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[98] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp98 := FALSE;
		P_stPid98 := stParameterSetsPID[98].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[98].stDefault := P_stPid98; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[98] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp98 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp98 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 99
//======================
CASE TEMP.iAutoTuneStsTemp99 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp99 := FALSE;
		P_stPid99 := stParameterSetsPID[99].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[99].stDefault := P_stPid99; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[99] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp99 := FALSE;
		P_stPid99 := stParameterSetsPID[99].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[99].stDefault := P_stPid99; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[99] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp99 := FALSE;
		P_stPid99 := stParameterSetsPID[99].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[99].stDefault := P_stPid99; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[99] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp99 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp99 := FALSE;	
END_IF

//======================
//AUTOTUNE TEMPERATURA 100
//======================
CASE TEMP.iAutoTuneStsTemp100 OF
	
	0:	// Inativo / Parado
	
	1:	// In Progress = Executando Auto Tunning
	
	2: 	// Completed System Ok = Finished and detected a balanced system = Finalizado e OK
		
		TEMP.xAutoTuneTemp100 := FALSE;
		P_stPid100 := stParameterSetsPID[100].stMedium;	//copia os parametros do resultado medio 
		stParameterSetsPID[100].stDefault := P_stPid100; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[100] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	3:	// Completed System Oversized = Finished and detected a oversized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp100 := FALSE;
		P_stPid100 := stParameterSetsPID[100].stSlow;	//copia os parametros do resultado mais suave	
		stParameterSetsPID[100].stDefault := P_stPid100; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[100] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
	
	4:	// Completed System Undersized = Finished and detected a undersized system
		// Os valores de parametros podem ser nao aplicaveis, entrar com parametros manuais ou refazer auto tunning
		TEMP.xAutoTuneTemp100 := FALSE;
		P_stPid100 := stParameterSetsPID[100].stOffensive; //copia os parametros do resultado mais agressivo
		stParameterSetsPID[100].stDefault := P_stPid100; //escreve os parametros no conjunto de parametros padrao
		etSelectParameterSetPID[100] := SE_CTBX.ET_ParameterSetPID.Default; //volta a selecao para o conjunto de parametros padrao
		
END_CASE

//em caso de qualquer erro na saida q_etResult, desliga o comando do autotunning
//necessario enviar um comando na entrada de reset apos qualquer erro no FB_HeatingControl
IF TEMP.iCrtlTempStsTemp100 <> SE_CTBX.ET_Result.Ok THEN
	TEMP.xAutoTuneTemp100 := FALSE;	
END_IF




