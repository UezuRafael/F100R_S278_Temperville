__METADATA__
{
  "v3Meta": {
    "objectGuid": "db6e3932-5e77-4709-bc18-07a60b4eaeff",
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
FUNCTION Valor_Float : REAL
VAR_INPUT
	Input_01: WORD;
	Input_02: WORD;
END_VAR
VAR
	Convert_01: WORD_AS_DWORD;
	DW_AxOutpt: DWORD;
	Bit_DWord_Mantissa: BIT_AS_DWORD;
	Aux_Mantissa: DWORD;
	Mantissa1: REAL;
	Bit_DW_Expoente: BIT_AS_DWORD;
	Aux_Exp: DWORD;
	Aux_Exp2: REAL;
	Expoente: REAL;
	Sinal: REAL;
	Sinal2: REAL;
	base1: REAL;
END_VAR
__IMPLEMENTATION__

Convert_01(i_wLow:= Input_01, i_wHigh:= Input_02, q_dwOput=>DW_AxOutpt );

(*=========== F=-1^s * 2^(e-127) * (1 + M/2^23)============= *) 

//Composição da Mantissa
Bit_DWord_Mantissa(
	B00:= DW_AxOutpt.0, 
	B01:= DW_AxOutpt.1, 
	B02:= DW_AxOutpt.2, 
	B03:= DW_AxOutpt.3, 
	B04:= DW_AxOutpt.4, 
	B05:= DW_AxOutpt.5, 
	B06:= DW_AxOutpt.6, 
	B07:= DW_AxOutpt.7, 
	B08:= DW_AxOutpt.8, 
	B09:= DW_AxOutpt.9, 
	B10:= DW_AxOutpt.10, 
	B11:= DW_AxOutpt.11, 
	B12:= DW_AxOutpt.12, 
	B13:= DW_AxOutpt.13, 
	B14:= DW_AxOutpt.14, 
	B15:= DW_AxOutpt.15, 
	B16:= DW_AxOutpt.16, 
	B17:= DW_AxOutpt.17, 
	B18:= DW_AxOutpt.18, 
	B19:= DW_AxOutpt.19, 
	B20:= DW_AxOutpt.20, 
	B21:= DW_AxOutpt.21, 
	B22:= DW_AxOutpt.22, 
	X=> Aux_Mantissa);
	
	Mantissa1:= DWORD_TO_REAL (Aux_Mantissa);
	
	//Composição Expoente
	
	Bit_DW_Expoente(
	B00:= DW_AxOutpt.23, 
	B01:= DW_AxOutpt.24, 
	B02:= DW_AxOutpt.25, 
	B03:= DW_AxOutpt.26, 
	B04:= DW_AxOutpt.27, 
	B05:= DW_AxOutpt.28, 
	B06:= DW_AxOutpt.29, 
	B07:= DW_AxOutpt.30, 
	X=> Aux_Exp);
	
	Aux_Exp2:= DWORD_TO_REAL (Aux_Exp - 127);
	
	Expoente:= EXPT (2,Aux_Exp2);
	
	//Sinal
	base1:=BOOL_TO_REAL (DW_AxOutpt.31);
	Sinal2:= EXPT (-1,base1);
	
	// Equação para o resultado em FLOAT
	
	Valor_Float:= Sinal2 * Expoente * (1 + Mantissa1/ 8388608);
	
	
	
	
	
	
	
	
	
	
