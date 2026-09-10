__METADATA__
{
  "v3Meta": {
    "objectGuid": "3fa2be7d-16dc-45d2-9426-d8fae2bc00ff",
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
PROGRAM A_Inicializacao
VAR
	///passo para logica de inicialização do sistema
	PassoInit: INT := 0;
	ContDrive: INT := 0;
	TonInicilizacaoSistema: TON;
	xTonInicilizacaoSistemaIn: BOOL;
	xTonInicilizacaoSistemaQ: BOOL;
	TonLeituraErroInicial: TON;
	xTonLeituraErroInicialIn: BOOL;
	xTonLeituraErroInicialQ: BOOL;
	tDelayIniSystem: TON;
	tDelayIniSystemIn: BOOL;
	tDelayIniSystemQ: BOOL;
	///atraso entre os passos 0 e 1
	AtrasoPasso01: TON;
	/// tempo limite para verificar se os drives foram habilitados 
	AtrasoLeituraStatus: TON;
	/// tempo de reset 
	AtrasoRstErro: TON;
	delayResetaNo: TON;
	AtrasoEstabilizaRede: TON;
	/// Ativa leitura dos drives
	xAtivaLeituraErro: BOOL;
	iContadorReset: INT;
	xCanOpenOk: BOOL;
	///Flag indicativo para falha na rede CanOpen ou CanMotion
	xCanOpenFh: BOOL;
	/// Bit para habilitar drives do sistema
	xHabilitaDrives: BOOL;
	/// bit para resetar alarmes
	xRstAlarmes: BOOL;
	///------------------------------------------------------------------------//	
	///Mesa Entrada
	McResetMesaEntrada: GIPLC.MC_Reset;
	McPowerMesaEntrada: GIPLC.MC_Power;
	McReadStatusMesaEntrada: GIPLC.MC_ReadStatus;
	McReadErrorMesaEntrada: GIPLC.MC_ReadAxisError;
	///Mesa Forno
	McResetMesaForno: GIPLC.MC_Reset;
	McPowerMesaForno: GIPLC.MC_Power;
	McReadStatusMesaForno: GIPLC.MC_ReadStatus;
	McReadErrorMesaForno: GIPLC.MC_ReadAxisError;
	///Mesa Resfriamento
	McResetMesaResfriador: GIPLC.MC_Reset;
	McPowerMesaResfriador: GIPLC.MC_Power;
	McReadStatusMesaResfriado: GIPLC.MC_ReadStatus;
	McReadErrorMesaResfriador: GIPLC.MC_ReadAxisError;
	///Mesa Saída
	McResetMesaSaida: GIPLC.MC_Reset;
	McPowerMesaSaida: GIPLC.MC_Power;
	McReadStatusMesaSaida: GIPLC.MC_ReadStatus;
	McReadErrorMesaSaida: GIPLC.MC_ReadAxisError;
	///Ductos Inferior 01
	McResetDutosResfriadorInf01: GIPLC.MC_Reset;
	McPowerDutosResfriadorInf01: GIPLC.MC_Power;
	McReadDutosResfriadorInf01: GIPLC.MC_ReadStatus;
	McReadErrorDutosResfriadorInf01: GIPLC.MC_ReadAxisError;
	///Ductos Superior 01
	McResetDutosResfriadorSup01: GIPLC.MC_Reset;
	McPowerDutosResfriadorSup01: GIPLC.MC_Power;
	McReadDutosResfriadorSup01: GIPLC.MC_ReadStatus;
	McReadErrorDutosResfriadorSup01: GIPLC.MC_ReadAxisError;
	///Ductos Inferior 02
	McResetDutosResfriadorInf02: GIPLC.MC_Reset;
	McPowerDutosResfriadorInf02: GIPLC.MC_Power;
	McReadDutosResfriadorInf02: GIPLC.MC_ReadStatus;
	McReadErrorDutosResfriadorInf02: GIPLC.MC_ReadAxisError;
	///Ductos Superior 02
	McResetDutosResfriadorSup02: GIPLC.MC_Reset;
	McPowerDutosResfriadorSup02: GIPLC.MC_Power;
	McReadDutosResfriadorSup02: GIPLC.MC_ReadStatus;
	McReadErrorDutosResfriadorSup02: GIPLC.MC_ReadAxisError;
	///Guilhotina01
	McResetGuilhotina01: GIPLC.MC_Reset;
	McPowerGuilhotina01: GIPLC.MC_Power;
	McReadStatusGuilhotina01: GIPLC.MC_ReadStatus;
	McReadErrorGuilhotina01: GIPLC.MC_ReadAxisError;
	///Guilhotina02
	McResetGuilhotina02: GIPLC.MC_Reset;
	McPowerGuilhotina02: GIPLC.MC_Power;
	McReadStatusGuilhotina02: GIPLC.MC_ReadStatus;
	McReadErrorGuilhotina02: GIPLC.MC_ReadAxisError;
	/// Motor Limpeza Resfriador 02
	McResetLimpResfriadorSup02: GIPLC.MC_Reset;
	McPowerLimpResfriadorSup02: GIPLC.MC_Power;
	McReadStatusLimpResfriadorSup02: GIPLC.MC_ReadStatus;
	McReadErrorLimpResfriadorSup02: GIPLC.MC_ReadAxisError;
	/// Motor Abertura Caixa do Forno
	McResetCaixaForno: GIPLC.MC_Reset;
	McPowerCaixaForno: GIPLC.MC_Power;
	McReadStatusCaixaForno: GIPLC.MC_ReadStatus;
	McReadErrorCaixaForno: GIPLC.MC_ReadAxisError;
	///Ventilador01	
	McResetVentilador01: GIPLC.MC_Reset;
	McPowerVentilador01: GIPLC.MC_Power;
	McReadStatusVentilador01: GIPLC.MC_ReadStatus;
	McReadErrorVentilador01: GIPLC.MC_ReadAxisError;
	PulsoRstVent01Auto: TP;
	///Ventilador02	
	McResetVentilador02: GIPLC.MC_Reset;
	McPowerVentilador02: GIPLC.MC_Power;
	McReadStatusVentilador02: GIPLC.MC_ReadStatus;
	McReadErrorVentilador02: GIPLC.MC_ReadAxisError;
	PulsoRstVent02Auto: TP;
	///Ventilador03	
	McResetVentilador03: GIPLC.MC_Reset;
	McPowerVentilador03: GIPLC.MC_Power;
	McReadStatusVentilador03: GIPLC.MC_ReadStatus;
	McReadErrorVentilador03: GIPLC.MC_ReadAxisError;
	PulsoRstVent03Auto: TP;
	///Ventilador03	
	McResetVentilador04: GIPLC.MC_Reset;
	McPowerVentilador04: GIPLC.MC_Power;
	McReadStatusVentilador04: GIPLC.MC_ReadStatus;
	McReadErrorVentilador04: GIPLC.MC_ReadAxisError;
	PulsoRstVent04Auto: TP;
	///Ventilador Convecção
	McResetVentConvec: GIPLC.MC_Reset;
	McPowerVentConvec: GIPLC.MC_Power;
	McReadStatusVentConvec: GIPLC.MC_ReadStatus;
	McReadErrorVentConvec: GIPLC.MC_ReadAxisError;
	///-----------------------------------------------------------------------//	
	xResetErroVent03: BOOL;
	///----------------------------------------------------------------------//	
	xErroDeEixo: BOOL;
	ResetaRedeCanOpen: CIA405.NMT;
	iNdevice: USINT := 1;
	testemsl: BOOL;
	AuxResetRedeCanOpen: BOOL;
	xInicializacaoOk: BOOL;
	xErroEixo: ARRAY[1..14] OF BOOL;
	xEixoHabilitado: ARRAY[1..14] OF BOOL;
	xHabilitaDriveMe: BOOL;
	xHabilitaDriveMf: BOOL;
	xHabilitaDriveMr: BOOL;
	xHabilitaDriveMs: BOOL;
	xHabilitaDriveMdI01: BOOL;
	xHabilitaDriveMdS01: BOOL;
	xHabilitaDriveMdI02: BOOL;
	xHabilitaDriveMdS02: BOOL;
	xHabilitaDriveMg01: BOOL;
	xHabilitaDriveMg02: BOOL;
	xHabilitaDriveMv01: BOOL;
	xHabilitaDriveMv02: BOOL;
	xHabilitaDriveMv03: BOOL;
	xHabilitaDriveMv04: BOOL;
	xResetErroVentilador01: BOOL;
	xResetErroVentilador02: BOOL;
	xResetErroVentilador03: BOOL;
	xResetErroVentilador04: BOOL;
	xHabilitaDriveMvC: BOOL;
	xResetErroMe: BOOL;
	xResetErroMf: BOOL;
	xResetErroMr: BOOL;
	xResetErroMs: BOOL;
	xResetErroMdS02: BOOL;
	xResetErroMg02: BOOL;
	xResetErroV03: BOOL;
	xResetErroV04: BOOL;
END_VAR
__IMPLEMENTATION__

iNumResistencias:=iNumeroResistencias/2;
