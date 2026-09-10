__METADATA__
{
  "v3Meta": {
    "objectGuid": "0afbe519-50af-4f3e-b925-5ab80702e8ac",
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
PROGRAM B_Imagens
VAR
	Index: INT;
END_VAR
__IMPLEMENTATION__
//Imagens de Motores
ImgMotor[1]:=xMotorEntradaLigado;
ImgMotor[2]:=ImgMotor[2];
ImgMotor[3]:=xMotorFornoLigado;
ImgMotor[4]:=xMotorPassagemLigado;
ImgMotor[5]:=xMotorResfriadorLigado;
ImgMotor[6]:=xMotorSaidaLigado;
ImgMotor[7]:=xMotorDifusorSup01Ligado;
ImgMotor[8]:=xMotorDifusorInf01Ligado;
ImgMotor[9]:=xMotorDifusorSup02Ligado;
ImgMotor[10]:=xMotorDifusorInf02Ligado;
ImgMotor[11]:=xMotorGuilhotina01Ligado;
ImgMotor[12]:=xMotorGuilhotina02Ligado;
ImgMotor[13]:=xMotorLimpResfr02Ligado;
ImgMotor[14]:=xMotorCaixaFornoLigado;
ImgMotor[15]:=xMotorVentilador01Ligado;
ImgMotor[16]:=xMotorVentilador02Ligado;
ImgMotor[17]:=xMotorVentilador03Ligado;
ImgMotor[18]:=xMotorVentilador04Ligado;
ImgMotor[19]:=xMotorVentilador04Ligado;
ImgMotor[20]:=xMotorVentConvecEntLigado;
ImgMotor[21]:=xMotorVentConvecSaiLigado;
ImgMotor[22]:=xMotorGuilhotina01SupLigado;
ImgMotor[23]:=xMotorGuilhotina01InfLigado;
ImgMotor[24]:=xKaMotorOscilaResfr02Sup;
ImgMotor[25]:=xKaMotorOscilaResfr02Inf;

//Imagens de Válvula
ImgValvAberta[1]:=xSensorPortaEntrada;
ImgValvAberta[2]:=xSensorPortaSaida;
ImgValvAberta[3]:=xValvulaConveccaoLigada;
ImgValvAberta[4]:=xSensorGradeEntradaUp;
ImgValvAberta[5]:=xSensorGradeSaidaUp;

ImgValvFechada[1]:= NOT xSensorPortaEntrada;
ImgValvFechada[2]:= NOT xSensorPortaSaida;
ImgValvFechada[3]:= NOT xValvulaConveccaoLigada;
ImgValvFechada[4]:=	NOT xSensorGradeEntradaUp;
ImgValvFechada[5]:=	NOT xSensorGradeSaidaUp;

//Imagens Gerais
ImgGeral[1]:=xStatusNobreak;
ImgGeral[2]:=xBt01Emergencia; // Mesa Computador
ImgGeral[3]:=xBt02Emergencia; // Mesa Manual
ImgGeral[4]:=xBt03Emergencia; //
ImgGeral[5]:=xBt04Emergencia;
ImgGeral[6]:=xBt05Emergencia;
ImgGeral[7]:=xBt06Emergencia;
ImgGeral[8]:=xBt07Emergencia;
ImgGeral[9]:=xBt08Emergencia;
ImgGeral[10]:=xBt09Emergencia;
ImgGeral[11]:=xBt10Emergencia;
ImgGeral[12]:=xVentiladoresPainel;
ImgGeral[13]:=xVentiladoresSsr;
ImgGeral[14]:=xValvulaVeneziana; 


FOR Index:=1 TO iNumResistencias DO
//	ImgRetornoSsrInferior[Index]:=xRetornoSsrInferior[Index];
//	ImgRetornoSsrSuperior[Index]:=xRetornoSsrSuperior[Index];	
//	ImgResistenciaInferior[Index]:=xResistenciaInferior[Index];
//	ImgResistenciaSuperior[Index]:=xResistenciaSuperior[Index];
	ImgRetornoSsrInferior[Index]:=xResistenciaInferior[Index];
	ImgRetornoSsrSuperior[Index]:=xResistenciaSuperior[Index];	
	ImgResistenciaHabilitadaInferior[Index]:=xResistenciaHabilitadaInferior[Index];	
	ImgResistenciaHabilitadaSuperior[Index]:=xResistenciaHabilitadaSuperior[Index];
END_FOR

