__METADATA__
{
  "v3Meta": {
    "objectGuid": "2c320166-1118-45f4-bf02-c100e7c052fc",
    "objectTypeGuid": "8ac092e5-3128-4e26-9e7e-11016c6684f2",
    "embeddedObjectTypeGuids": [
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {},
    "subObjects": {}
  }
}
__IMPLEMENTATION__
// alarmes de temperatura

//limites de temperatura superior
//Set Point + valor de temperatura fora da faixa

//rLimiteTempSuperior[1] := P_rSpTemp1 + P_rTempForaFaixa;
//rLimiteTempSuperior[2] := P_rSpTemp2 + P_rTempForaFaixa;
//rLimiteTempSuperior[3] := P_rSpTemp3 + P_rTempForaFaixa;
//rLimiteTempSuperior[4] := P_rSpTemp4 + P_rTempForaFaixa;

//limites de temperatura Inferior
//Set Point - valor de temperatura fora da faixa

//rLimiteTempTemp3[1] := P_rSpTemp1 - P_rTempForaFaixa;
//rLimiteTempTemp3[2] := P_rSpTemp2 - P_rTempForaFaixa;
//rLimiteTempTemp3[3] := P_rSpTemp3 - P_rTempForaFaixa;
//rLimiteTempTemp3[4] := P_rSpTemp4 - P_rTempForaFaixa;

//habilitacao alarme = habilitacao do controle de temperatura

//xHabilitaTemp[1] := P_xHabTemp1;
//xHabilitaTemp[2] := P_xHabTemp2;
//xHabilitaTemp[3] := P_xHabTemp3;
//xHabilitaTemp[4] := P_xHabTemp4;

//alarmes dos pontos de temperatura
//para alarme de erro do bloco de controle ver variavel TEMP.xCrtlTemperatura[] em SR_ControleTemperatura

//FOR iTemp:=1 TO 100 BY 1 DO
//	IF xHabilitaTemp[iTemp] THEN
//		TEMP.xAlmTermopar[iTemp] 		:= I_byStatusTemp[iTemp] <> 0;  //status termopar
//		TEMP.xTemperaturaAlta[iTemp] 	:= (I_iTemperatura[iTemp] / 10.0) > rLimiteTempSuperior[iTemp]; //temperatura excessiva
//		TEMP.xTemperaturaBaixa[iTemp] 	:= (I_iTemperatura[iTemp] / 10.0) < rLimiteTempTemp3[iTemp]; //temperatura baixa
//	END_IF
//END_FOR


//IF InterfaceHeat.xReset THEN 
	//------------- reset alarmes de temperatura ----------------------
//	FOR iTemp:=1 TO 100 BY 1 DO
//		TEMP.xAlmTermopar[iTemp]		:= FALSE; // Alarme - termopar aberto ou em curto, sem leitura - ver codigo status diagnostico na tela de manutencao
//		TEMP.xCrtlTemperatura[iTemp]	:= FALSE; // Alarme - Erro no bloco de controle de temperatura
//		TEMP.xTemperaturaAlta[iTemp]	:= FALSE; // Alarme - temperatura excessiva
//		TEMP.xTemperaturaBaixa[iTemp] 	:= FALSE; // Alarme - temperatura muito abaixo do valor programado
//	END_FOR
//END_IF
