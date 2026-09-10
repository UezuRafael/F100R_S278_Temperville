__METADATA__
{
  "v3Meta": {
    "objectGuid": "141097d7-7fc0-4963-be98-0f505bfb65ca",
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
PROGRAM R_Pressostato
VAR
	TonPressBaixaRede: TON;
	TonPressAltaRede: TON;
	TpAlmRedeSom: TP;
	TpAlmRedeSomIn: BOOL;
	TonPressBaixaMaq: TON;
	TonPressAltaMaq: TON;
	TpAlmMaqSom: TP;
	AlarmePressaoArAltaRede: BOOL;
	AlarmePressaoArBaixaRede: BOOL;
	AlarmePressaoArMaqAlta: BOOL;
	AlarmePressaoArMaqBaixa: BOOL;
END_VAR
__IMPLEMENTATION__
// PRESSOSTATO DA REDE DE ALIMENTAÇÃO DE AR COMPRIMIDO
(*-----------(* OPÇÃO COM DUAS SAIDAS DIGITAIS *)-------------*)
// Status da Pressão de Ar na Rede
IF NOT xPressaoBaixaMediaRede AND NOT xPressaoMediaAltaRede THEN
	iPressaoDaRede:=0; // Baixa
END_IF

IF xPressaoBaixaMediaRede AND NOT xPressaoMediaAltaRede THEN
	iPressaoDaRede:=1; // Normal
END_IF

IF xPressaoBaixaMediaRede AND xPressaoMediaAltaRede THEN
	iPressaoDaRede:=2; // Alta
END_IF

// Alarmes
IF iPressaoDaRede<=0 AND NOT xValvulaConveccaoLigada THEN (* Pressão baixa *)
	AlarmePressaoArBaixaRede:=TRUE; (* alarme de pressão baixa *)
ELSE
	AlarmePressaoArBaixaRede:=FALSE;
END_IF

IF iPressaoDaRede>=2 THEN (* Pressão alta *)
	AlarmePressaoArAltaRede:=TRUE; (* alarme de pressão alta *)
ELSE
	AlarmePressaoArAltaRede:=FALSE;
END_IF


TonPressBaixaRede.IN:= AlarmePressaoArBaixaRede;
TonPressAltaRede.IN:= AlarmePressaoArAltaRede;

TonPressBaixaRede(PT:=T#1000MS );
TonPressAltaRede(PT:=T#1000MS );

IF TonPressBaixaRede.Q THEN
	xAlarmePressaoArBaixaRede:= TRUE;
END_IF

IF TonPressAltaRede.Q THEN
	xAlarmePressaoArAltaRede:=TRUE;
END_IF

xAlarmePressaoArRede:= xAlarmePressaoArBaixaRede OR xAlarmePressaoArAltaRede;

TpAlmRedeSomIn:= xAlarmePressaoArRede AND xMaquinaEmCiclo;

//Sinais de Alarme
TpAlmRedeSom(IN:= TpAlmRedeSomIn, PT:= T#500MS );

IF TpAlmRedeSom.Q THEN
	xAlarmePressaoArRedeSom:=TRUE;
END_IF

IF	bResetAlmGeral THEN
	xAlarmePressaoArBaixaRede:=FALSE;
	xAlarmePressaoArAltaRede:=FALSE;
	xAlarmePressaoArRedeSom:=FALSE;
END_IF


////////////////////////////////////////////////////////////////////////
// PRESSOSTATO DA REDE DE ALIMENTAÇÃO DE AR COMPRIMIDO
(*-----------(* OPÇÃO COM UMA SAIDAS DIGITAIS *)-------------*)
// Status da Pressão de Ar na Rede
(*IF NOT xPressaoBaixaMedia THEN
	iPressaoDaRede:=0; // Baixa
END_IF

IF xPressaoBaixaMedia THEN
	iPressaoDaRede:=1; // Normal
END_IF

// Alarmes
IF iPressaoDaRede<=0 AND NOT xValvulaConveccaoLigada THEN (* Pressão baixa *)
	AlarmePressaoArBaixa:=TRUE; (* alarme de pressão baixa *)
ELSE
	AlarmePressaoArBaixa:=FALSE;
END_IF

TonPressBaixaRede.IN:= AlarmePressaoArBaixa;

TonPressBaixaRede(PT:=T#1000MS );

IF TonPressBaixaRede.Q THEN
	xAlarmePressaoArBaixaRede:= TRUE;
END_IF

xAlarmePressaoArRede:= xAlarmePressaoArBaixaRede OR xAlarmePressaoArAltaRede;

//Sinais de Alarme
TpAlmRedeSom(IN:= xAlarmePressaoArRede, PT:= T#500MS );

IF TpAlmRedeSom.Q THEN
	xAlarmePressaoArRedeSom:=TRUE;
END_IF

IF	bResetAlmGeral THEN
	xAlarmePressaoArBaixaRede:=FALSE;
	xAlarmePressaoArAltaRede:=FALSE;
	xAlarmePressaoArRedeSom:=FALSE;
END_IF
*)
////////////////////////////////////////////////////////////////////
//PRESSOSTATO DA ENTRADA DA MÁQUINA
(*-----------(* OPÇÃO COM SAIDAS ANALÓGICA *)-------------*)
// Status da Pressão de Ar na Rede
(*IF rValorPressaoMaqBar < 5.0 THEN
	iPressaoDaMaquina:=0; // Baixa
END_IF

IF rValorPressaoMaqBar >= 5.0 AND rValorPressaoMaqBar <= 7.0 THEN
	iPressaoDaMaquina:=1; // Normal
END_IF

IF rValorPressaoMaqBar > 7.0 THEN
	iPressaoDaMaquina:=2; // Alta
END_IF

// Alarmes
IF iPressaoDaMaquina<=0 AND NOT xValvulaConveccaoLigada THEN (* Pressão baixa *)
	AlarmePressaoArMaqBaixa:=TRUE; (* alarme de pressão baixa *)
ELSE
	AlarmePressaoArMaqBaixa:=FALSE;
END_IF

IF iPressaoDaMaquina>=2 THEN (* Pressão alta *)
	AlarmePressaoArMaqAlta:=TRUE; (* alarme de pressão alta *)
ELSE
	AlarmePressaoArMaqAlta:=FALSE;
END_IF


TonPressBaixaMaq.IN:= AlarmePressaoArMaqBaixa;
TonPressAltaMaq.IN:= AlarmePressaoArMaqAlta;

TonPressBaixaMaq(PT:=T#1000MS );
TonPressAltaMaq(PT:=T#2000MS );

IF TonPressBaixaMaq.Q THEN
	xAlarmePressaoArBaixaMaq:= TRUE;
END_IF

IF TonPressAltaMaq.Q THEN
	xAlarmePressaoArAltaMaq:=TRUE;
END_IF

xAlarmePressaoArMaq:= xAlarmePressaoArBaixaMaq OR xAlarmePressaoArAltaMaq;

//Sinais de Alarme
TpAlmMaqSom(IN:= xAlarmePressaoArMaq, PT:= T#500MS );

IF TpAlmMaqSom.Q THEN
	xAlarmePressaoArMaqSom:=TRUE;
END_IF

IF	bResetAlmGeral THEN
	xAlarmePressaoArBaixaMaq:=FALSE;
	xAlarmePressaoArAltaMaq:=FALSE;
	xAlarmePressaoArMaqSom:=FALSE;
END_IF
*)








