__METADATA__
{
  "v3Meta": {
    "objectGuid": "c4a5e97e-6a03-4b74-ab5c-2001c38802da",
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
PROGRAM R_PressostatoAnal
VAR
	MediaValoresPressRede: RegistradorMedia;
	rValorLeituraPressaoRede: REAL;
	MediaValoresPressMaq: RegistradorMedia;
	rValorLeituraPressaoMaq: REAL;
END_VAR
__IMPLEMENTATION__
// PRESSOSTATO PRESSÃO DA REDE DE ALIMENTAÇÃO DA MAQUINA
MediaValoresPressRede.rDadoEntrada:=INT_TO_REAL(iValorLeituraPressaoRede);

MediaValoresPressRede(rDadoEntrada:= , rDadoSaida=>rValorLeituraPressaoRede );


rValorPressaoRedeMpa:= rValorLeituraPressaoRede/32767;
rValorPressaoRedeBar:=rValorPressaoRedeMpa*10;
rValorPressaoRedePsi:=rValorPressaoRedeBar/0.068948;

rValorPressaoRedeInHg:=rValorPressaoRedeBar*29.5299889;
rValorPressaoRedeCmHg:=rValorPressaoRedeBar*75.006375;
rValorPressaoRedeMmHg:=rValorPressaoRedeBar*750.06375;
rValorPressaoRedeMmCa:=rValorPressaoRedeBar*10197.1621; 
		
// PRESSOSTATO PRESSÃO DA MAQUINA
MediaValoresPressMaq.rDadoEntrada:=INT_TO_REAL(iValorLeituraPressaoMaq);

MediaValoresPressMaq(rDadoEntrada:= , rDadoSaida=>rValorLeituraPressaoMaq );


rValorPressaoMaqMpa:= rValorLeituraPressaoMaq/32767;
rValorPressaoMaqBar:=rValorPressaoMaqMpa*10;
rValorPressaoMaqPsi:=rValorPressaoMaqBar/0.068948;

rValorPressaoMaqInHg:=rValorPressaoMaqBar*29.5299889;
rValorPressaoMaqCmHg:=rValorPressaoMaqBar*75.006375;
rValorPressaoMaqMmHg:=rValorPressaoMaqBar*750.06375;
rValorPressaoMaqMmCa:=rValorPressaoMaqBar*10197.1621; 
