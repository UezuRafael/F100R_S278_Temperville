__METADATA__
{
  "v3Meta": {
    "objectGuid": "7aaf6e78-7ed8-4675-8b24-79fd09c664bd",
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
PROGRAM A_PrincipalOperacao
VAR
	HabDesabMotorDuctosInf01: HabilitaDesabilita;
	HabDesabMotorDuctosSup01: HabilitaDesabilita;
	HabDesabMotorDuctosInf02: HabilitaDesabilita;
	HabDesabMotorDuctosSup02: HabilitaDesabilita;
	HabDesabMotorGuilho01: HabilitaDesabilita;
	HabDesabMotorGuilho02: HabilitaDesabilita;

	HabDesabMotorGuilho01Sup: HabilitaDesabilita;
	HabDesabMotorGuilho01Inf: HabilitaDesabilita;
END_VAR
__IMPLEMENTATION__
//EncoderMForno();
//EncoderMResfr();
//EncoderResfriInf01();
//EncoderResfriSup01();
//EncoderResfriInf02();
//EncoderResfriSup02();
EncoderModulo01();
EncoderModulo02();
//EncoderModulo03();
//EncoderModulo04();
A_EncoderCpu();
B_Receita();
B_Velocidades();
C_ComandosOperacao();
D_SensoresEntrada();
E_MesaEntrada();
F_BufferForno();
F_MesaForno();
G_BufferResfriamento();
G_BufferTemperaPass();
H_MesaPassagem();
H_MesaResfriador();
H1_Dutos_Oscilantes();
I_MesaSaida();
//J_DuctosResfriadorInf01();
//J_DuctosResfriadorSup01();
//J_DuctosResfriadorInf02();
//J_DuctosResfriadorSup02();
//K_Guilhotina01();
//K_Guilhotina01Sup();
//K_Guilhotina01Inf();
//K_Guilhotina02();
L_EstagiosResfriador();
M_Ventilador01();
//M_Ventilador02();
M_Ventilador03();
//M_Ventilador04();
N_Grades();
//N_MesaBasculante();
O_Portas();
P_ComandosEventos();
//Q_Conveccao();
R_Pressostato();
R_PressostatoAnal();
R_ManometroDifusor();
R_SensorVibracao();
S_ElevacaoForno();
//T_Damper();
T_VenezianaDutPass();
T_VenezianaVentInfPass();
V_VentilacaoPainel();
//X_LimpaResfriador02();

//Habilita/Desabilita Resfriador Inferior 01
(*HabDesabMotorDuctosInf01(Entrada:= xBtDuctosInf01Enable,StatusSaida=> xDuctosInf01Enable);
IF xBtDuctosInf01Enable THEN
	xBtDuctosInf01Enable:=FALSE;
END_IF

IF NOT xDuctosInf01Enable THEN
	J_DuctosResfriadorInf01();
END_IF

xDuctosInf01CheckOk:= xDuctosInf01Enable OR xHomeDuctosResfriadorInf01Ok;
*)

// Habilita/Desabilita Resfriador Superior 01
(*HabDesabMotorDuctosSup01(Entrada:= xBtDuctosSup01Enable,StatusSaida=> xDuctosSup01Enable);
IF xBtDuctosSup01Enable THEN
	xBtDuctosSup01Enable:=FALSE;
END_IF

IF NOT xDuctosSup01Enable THEN
	J_DuctosResfriadorSup01();
END_IF

xDuctosSup01CheckOk:= xDuctosSup01Enable OR xHomeDuctosResfriadorSup01Ok;
*)
// Habilita/Desabilita Resfirador Inferior 02
(*HabDesabMotorDuctosInf02(Entrada:= xBtDuctosInf02Enable,StatusSaida=> xDuctosInf02Enable);
IF xBtDuctosInf02Enable THEN
	xBtDuctosInf02Enable:=FALSE;
END_IF

IF NOT xDuctosInf02Enable THEN
	J_DuctosResfriadorInf02();
END_IF

xDuctosInf02CheckOk:= xDuctosInf02Enable OR xHomeDuctosResfriadorInf02Ok;
*)

// Habilita/Desabilita Resfriador Superior 02
HabDesabMotorDuctosSup02(Entrada:= xBtDuctosSup02Enable,StatusSaida=> xDuctosSup02Enable);
IF xBtDuctosSup02Enable THEN
	xBtDuctosSup02Enable:=FALSE;
END_IF

IF NOT xDuctosSup02Enable THEN
	J_DuctosResfriadorSup02();
END_IF

xDuctosSup02CheckOk:= xDuctosSup02Enable OR xHomeDuctosResfriadorSup02Ok;


// Habilita/Desabilita Guilhotina Resfriador 01
(*HabDesabMotorGuilho01(Entrada:= xBtGuilhotina01Enable,StatusSaida=> xGuilhotina01Enable);
IF xBtGuilhotina01Enable THEN
	xBtGuilhotina01Enable:=FALSE;
END_IF

IF NOT xGuilhotina01Enable THEN
	K_Guilhotina01();	
END_IF

xGuilhotina01CheckOk:= xGuilhotina01Enable OR xHomeGuilhotina01Ok;
*)
// Habilita/Desabilita Guilhotina Resfirador 02
HabDesabMotorGuilho02(Entrada:= xBtGuilhotina02Enable,StatusSaida=> xGuilhotina02Enable);
IF xBtGuilhotina02Enable THEN
	xBtGuilhotina02Enable:=FALSE;
END_IF

IF NOT xGuilhotina02Enable THEN
	K_Guilhotina02();	
END_IF

xGuilhotina02CheckOk:= xGuilhotina02Enable OR xHomeGuilhotina02Ok;

// Habilita/Desabilita Guilhotina Superior Resfirador 01
(*HabDesabMotorGuilho01Sup(Entrada:= xBtGuilhotina01SupEnable,StatusSaida=> xGuilhotina01SupEnable);
IF xBtGuilhotina01SupEnable THEN
	xBtGuilhotina01SupEnable:=FALSE;
END_IF

IF NOT xGuilhotina01SupEnable THEN
	K_Guilhotina01Sup();	
END_IF

xGuilhotina01SupCheckOk:= xGuilhotina01SupEnable OR xHomeGuilhotina01SupOk;*)

// Habilita/Desabilita Guilhotina Inferior Resfirador 01
(*HabDesabMotorGuilho01Inf(Entrada:= xBtGuilhotina01InfEnable,StatusSaida=> xGuilhotina01InfEnable);
IF xBtGuilhotina01InfEnable THEN
	xBtGuilhotina01InfEnable:=FALSE;
END_IF

IF NOT xGuilhotina01InfEnable THEN
	K_Guilhotina01Inf();	
END_IF

xGuilhotina01InfCheckOk:= xGuilhotina01InfEnable OR xHomeGuilhotina01InfOk;*)


