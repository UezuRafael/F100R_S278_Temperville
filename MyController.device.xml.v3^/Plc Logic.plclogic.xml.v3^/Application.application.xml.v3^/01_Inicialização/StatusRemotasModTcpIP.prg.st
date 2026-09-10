__METADATA__
{
  "v3Meta": {
    "objectGuid": "bed0f8ef-89b9-4378-a5fb-397df5457c2c",
    "objectTypeGuid": "6f9dac99-8de1-4efc-8465-68ac443b7d08",
    "embeddedObjectTypeGuids": [
      "a9ed5b7e-75c5-4651-af16-d2c27e98cb94",
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {
      "_3S.CoDeSys.CFCObject.CFCProperty": "<?xml version=\"1.0\" encoding=\"utf-8\"?><Single xml:space=\"preserve\" Type=\"{97c1f2ea-5995-48b9-abd5-a3ab983c5def}\" Method=\"IArchivable\"><Single Name=\"UseExplicitExecutionOrder\" Type=\"bool\">False</Single></Single>"
    },
    "subObjects": {}
  }
}
__DECLARATION__
PROGRAM StatusRemotasModTcpIP
VAR
// Variaveis Lógica StatusRemotasModTcpIP
//IOScanner Statuus
ModbusTcpIoScanner_Not_OK 	: BOOL;
ModbusTcpIoScanner_Not_Ope 	: INT;
ModbusTcpReset				: BOOL;  // Reset 
//Aux HealthBits Remotas
TM3BC_ModbusTCP_1_Hb  : BOOL;
TM3BC_ModbusTCP_2_Hb  : BOOL;
TM3BC_ModbusTCP_3_Hb  : BOOL;
TM3BC_ModbusTCP_4_Hb  : BOOL;
//HealthBit Remotas not Ok
TM3BC_ModbusTCP_1_Hb_Nok  : INT;
TM3BC_ModbusTCP_2_Hb_Nok  : INT;
TM3BC_ModbusTCP_3_Hb_Nok  : INT;
TM3BC_ModbusTCP_4_Hb_Nok  : INT;
//Horários do ultimo erro
ModBusTcpAno:  ARRAY [1..10] OF UINT;
ModBusTcpMes:  ARRAY [1..10] OF UINT;
ModBusTcpDia:  ARRAY [1..10] OF UINT;
ModBusTcpHora: ARRAY [1..10] OF UINT;
ModBusTcpMin:  ARRAY [1..10] OF UINT;
ModBusTcpSeg:  ARRAY [1..10] OF UINT;

END_VAR
__IMPLEMENTATION__
//Verifica IOScanner se está operacional
IF ModbusTCP_IOScanner_Gstatus = 2 THEN
	ModbusTcpIoScanner_Not_OK :=FALSE;
ELSE
	ModbusTcpIoScanner_Not_OK :=TRUE;
	ModbusTcpIoScanner_Not_Ope := ModbusTcpIoScanner_Not_Ope + 1;
	ModBusTcpAno[1]:=uAnoRealTime;	  
	ModBusTcpMes[1]:=uMesRealTime;  
	ModBusTcpDia[1]:=uDiaRealTime; 
	ModBusTcpHora[1]:=uHoraRealTime; 
	ModBusTcpMin[1]:=uMinutoRealTime;
	ModBusTcpSeg[1]:=uSegundoRealTime;
END_IF

// Health bit remotas 
//Verifica  remota 1 Ch0
IF ModbusTCP_IOScanner_Gstatus = 2 AND NOT TM3BC_ModbusTCP_1_Hb_Ch0 THEN
	TM3BC_ModbusTCP_1_Hb_Nok := TM3BC_ModbusTCP_1_Hb_Nok + 1;	
	ModBusTcpAno[2]:=uAnoRealTime;	  
	ModBusTcpMes[2]:=uMesRealTime;  
	ModBusTcpDia[2]:=uDiaRealTime; 
	ModBusTcpHora[2]:=uHoraRealTime; 
	ModBusTcpMin[2]:=uMinutoRealTime;
	ModBusTcpSeg[2]:=uSegundoRealTime;
END_IF

//Verifica remota 1 Ch1	
IF ModbusTCP_IOScanner_Gstatus = 2 AND NOT TM3BC_ModbusTCP_1_Hb_Ch1 THEN	
	TM3BC_ModbusTCP_1_Hb_Nok := TM3BC_ModbusTCP_1_Hb_Nok + 1;
	ModBusTcpAno[3]:=uAnoRealTime;	  
	ModBusTcpMes[3]:=uMesRealTime;  
	ModBusTcpDia[3]:=uDiaRealTime; 
	ModBusTcpHora[3]:=uHoraRealTime; 
	ModBusTcpMin[3]:=uMinutoRealTime;
	ModBusTcpSeg[3]:=uSegundoRealTime;
END_IF

//Verifica remota 2 Ch2
IF ModbusTCP_IOScanner_Gstatus = 2 AND NOT TM3BC_ModbusTCP_2_Hb_Ch2 THEN
	TM3BC_ModbusTCP_2_Hb_Nok := TM3BC_ModbusTCP_2_Hb_Nok + 1;
	ModBusTcpAno[4]:=uAnoRealTime;	  
	ModBusTcpMes[4]:=uMesRealTime;  
	ModBusTcpDia[4]:=uDiaRealTime; 
	ModBusTcpHora[4]:=uHoraRealTime; 
	ModBusTcpMin[4]:=uMinutoRealTime;
	ModBusTcpSeg[4]:=uSegundoRealTime;	
END_IF

//Verifica remota 2 Ch3
IF ModbusTCP_IOScanner_Gstatus = 2 AND NOT TM3BC_ModbusTCP_2_Hb_Ch3 THEN	
	TM3BC_ModbusTCP_2_Hb_Nok := TM3BC_ModbusTCP_2_Hb_Nok + 1;
	ModBusTcpAno[5]:=uAnoRealTime;	  	
	ModBusTcpMes[5]:=uMesRealTime;  	
	ModBusTcpDia[5]:=uDiaRealTime; 	
	ModBusTcpHora[5]:=uHoraRealTime; 	
	ModBusTcpMin[5]:=uMinutoRealTime;
	ModBusTcpSeg[5]:=uSegundoRealTime;	
END_IF

//Verifica remota 3 Ch4
IF ModbusTCP_IOScanner_Gstatus = 2 AND NOT TM3BC_ModbusTCP_3_Hb_Ch4 THEN
	TM3BC_ModbusTCP_3_Hb_Nok := TM3BC_ModbusTCP_3_Hb_Nok + 1;
	ModBusTcpAno[6]:=uAnoRealTime;	  
	ModBusTcpMes[6]:=uMesRealTime;  
	ModBusTcpDia[6]:=uDiaRealTime; 
	ModBusTcpHora[6]:=uHoraRealTime; 
	ModBusTcpMin[6]:=uMinutoRealTime;
	ModBusTcpSeg[6]:=uSegundoRealTime;	
END_IF

//Verifica remota 3 Ch5	
IF ModbusTCP_IOScanner_Gstatus = 2 AND NOT TM3BC_ModbusTCP_3_Hb_Ch5 THEN	
	TM3BC_ModbusTCP_3_Hb_Nok := TM3BC_ModbusTCP_3_Hb_Nok + 1;
	ModBusTcpAno[7]:=uAnoRealTime;	  	
	ModBusTcpMes[7]:=uMesRealTime;  	
	ModBusTcpDia[7]:=uDiaRealTime; 	
	ModBusTcpHora[7]:=uHoraRealTime; 	
	ModBusTcpMin[7]:=uMinutoRealTime;
	ModBusTcpSeg[7]:=uSegundoRealTime;	
	
END_IF

//Verifica remota 4 Ch6
IF ModbusTCP_IOScanner_Gstatus = 2 AND NOT TM3BC_ModbusTCP_4_Hb_Ch6 THEN
	TM3BC_ModbusTCP_4_Hb_Nok := TM3BC_ModbusTCP_4_Hb_Nok + 1;
	ModBusTcpAno[8]:=uAnoRealTime;	  
	ModBusTcpMes[8]:=uMesRealTime;  
	ModBusTcpDia[8]:=uDiaRealTime; 
	ModBusTcpHora[8]:=uHoraRealTime; 
	ModBusTcpMin[8]:=uMinutoRealTime;
	ModBusTcpSeg[8]:=uSegundoRealTime;
	
END_IF

//Verifica remota 4 Ch7	
IF ModbusTCP_IOScanner_Gstatus = 2 AND NOT TM3BC_ModbusTCP_4_Hb_Ch7 THEN	
	TM3BC_ModbusTCP_4_Hb_Nok := TM3BC_ModbusTCP_4_Hb_Nok + 1;
	ModBusTcpAno[9]:=uAnoRealTime;	  	
	ModBusTcpMes[9]:=uMesRealTime;  	
	ModBusTcpDia[9]:=uDiaRealTime; 	
	ModBusTcpHora[9]:=uHoraRealTime; 	
	ModBusTcpMin[9]:=uMinutoRealTime;
	ModBusTcpSeg[9]:=uSegundoRealTime;	
	
END_IF

//Reset de contagem 
IF ModbusTcpReset THEN
	ModbusTcpIoScanner_Not_OK := FALSE;
	ModbusTcpIoScanner_Not_Ope 	:= 0;
	//Aux HealthBits
	TM3BC_ModbusTCP_1_Hb  := FALSE;
	TM3BC_ModbusTCP_2_Hb  := FALSE;
	TM3BC_ModbusTCP_3_Hb  := FALSE;
	TM3BC_ModbusTCP_4_Hb  := FALSE;
	//HealthBit not Ok
	TM3BC_ModbusTCP_1_Hb_Nok  := 0;
	TM3BC_ModbusTCP_2_Hb_Nok  := 0;
	TM3BC_ModbusTCP_3_Hb_Nok  := 0;
	TM3BC_ModbusTCP_4_Hb_Nok  := 0;
	ModbusTcpReset := FALSE;	
END_IF
