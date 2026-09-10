__METADATA__
{
  "v3Meta": {
    "objectGuid": "8c791b63-8aa6-468e-a004-d0767ed8239c",
    "objectTypeGuid": "6f9dac99-8de1-4efc-8465-68ac443b7d08",
    "embeddedObjectTypeGuids": [
      "a9ed5b7e-75c5-4651-af16-d2c27e98cb94",
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {},
    "subObjects": {}
  }
}
__DECLARATION__
PROGRAM H_MesaPassagem
VAR
///Passo da Execução da Movimentação do Mesa Passagem
	PassoMesaPassagem: INT;
	PassoPausePassagem: INT;
	PassoAlmMesaPassagem: INT;
	
	iVelocidadeMesaPassagem: INT;
END_VAR
__IMPLEMENTATION__
// MOVIMENTAÇÃO DA MESA DE PASSAGEM

CASE PassoMesaPassagem OF
	
		0:	IF xLigaCargaPassagem THEN
				PassoMesaPassagem:=1;
			END_IF
			
		1:	xMesaPassagemOn:=TRUE;
			IF xPause THEN
				PassoPausePassagem:=1;
				PassoMesaPassagem:=300;
				xLigaCargaPassagem:=TRUE;
			ELSIF xAlarmeMotorResfriador THEN
				PassoAlmMesaPassagem:=1;
				PassoMesaPassagem:=400;
			ELSE
				PassoMesaPassagem:=3;
			END_IF

		3:	iVelocidadeMesaPassagem:= iVelocidadeCargaMesaPass;(*Velocidade Carga Resfriador*)
			PassoMesaPassagem:=5;
		
		5:	xAvancoMesaPassagem:=TRUE;
			PassoMesaPassagem:=8;
			
		8:	xLigaCargaPassagem:=FALSE;
			IF xIniciaCargaPassagem THEN				
				PassoMesaPassagem:=10;
			END_IF
			IF xPause THEN
				PassoPausePassagem:=1;
				PassoMesaPassagem:=300;
				xLigaCargaPassagem:=TRUE;
			END_IF
			IF xAlarmeMotorResfriador THEN
				PassoAlmMesaPassagem:=1;
				PassoMesaPassagem:=400;
			END_IF
			
		10:  xIniciaCargaPassagem:=FALSE;				
			PassoMesaPassagem:=12;
			
		12:	IF xFimDescargaMesaPass THEN
				PassoMesaPassagem:=14;
		    END_IF
		
		14: xFimDescargaMesaPass:=FALSE;
			xAvancoMesaPassagem:=FALSE;
			xMesaPassagemOn:=FALSE;
			PassoMesaPassagem:=0;
			
END_CASE

// MOVIMENTAÇÃO PELO COMANDO ENTRADAS DIGITAIS DO INVERSOR
// Comando e Direção
xMotorMesaPassAvanco:= xAvancoMesaPassagem ;
xMotorMesaPassRecuo:= xRecuoMesaPassagem ;

InversorMesaPass.i_xAvanco:=xMotorMesaPassAvanco;
InversorMesaPass.i_xRecuo:=xMotorMesaPassRecuo;

// Velocidade
InversorMesaPass.i_iFreqRef:=iVelocidadeMesaPassagem;	

IF xOperacaoManual THEN
	PassoMesaPassagem:=0;
	PassoPausePassagem:=0;
	PassoAlmMesaPassagem:=0;
	xLigaCargaPassagem:=FALSE;
	xMesaPassagemOn:=FALSE;
	xAvancoMesaPassagem:=FALSE;
	xRecuoMesaPassagem:=FALSE;	
END_IF
