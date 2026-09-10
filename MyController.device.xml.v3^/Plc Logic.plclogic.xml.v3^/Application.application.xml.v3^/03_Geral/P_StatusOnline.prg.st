__METADATA__
{
  "v3Meta": {
    "objectGuid": "8cd5d46c-4443-4148-a016-7b98abe24ca2",
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
PROGRAM P_StatusOnline
__IMPLEMENTATION__
// STATUS PROCESSO

IF xFornoEmEspera THEN
	uStatusOperacao:=0; // Forno em Espera
END_IF
IF xFornoEmCiclo THEN 
	uStatusOperacao:=1; // Forno em Ciclo
END_IF
IF xFornoFinalizando THEN
	uStatusOperacao:=2; // Forno Finalizando
END_IF


//STATUS MESA DE ENTRADA
uStatusMesaEntrada:=0; //Vazio

(*IF xCarregandoMesaEntrada THEN
	uStatusMesaEntrada:=1;
END_IF

IF xRetornaMesaEntrada THEN
	uStatusMesaEntrada:=2;
END_IF*)

//STATUS MESA DO FORNO

uStatusMesaForno:=0; //Vazio
IF xCarregandoForno THEN
	uStatusMesaForno:=1; //Carregando
END_IF
IF xFornoCarregado THEN
	uStatusMesaForno:=2; //Com Carga
END_IF
IF xDescarregandoForno THEN
	uStatusMesaForno:=3; //Descarregando
END_IF
IF xRetornandoForno THEN
	uStatusMesaForno:=4; //Retornando
END_IF

//STATUS MESA DO RESFRIAMENTO

uStatusMesaResfriador:=0; //Vazio
IF xCarregandoResfriador THEN
	uStatusMesaResfriador:=1; //Carregando
END_IF
IF xResfriadorCarregado THEN
	uStatusMesaResfriador:=2; //Com Carga
END_IF
IF xDescarregandoResfriador THEN
	uStatusMesaResfriador:=3; //Descarregando
END_IF


//STATUS MESA DE SAIDA

//STATUS DUCTOS INFERIOR 01
IF NOT xHomeDuctosResfriadorInf01Ok THEN
	uStatusDuctosResfriadorInf01:=0; // Efetuar Home
END_IF;

IF xDuctosInf01EmHome THEN
	uStatusDuctosResfriadorInf01:=1; // Em Home
END_IF

IF xDuctosInf01EmAjuste THEN
	uStatusDuctosResfriadorInf01:=2; // Ajustando Altura
END_IF

IF xAjusteAlturaDuctosInf01OK AND xHomeDuctosResfriadorInf01Ok THEN
	uStatusDuctosResfriadorInf01:=3; // Altura Ajustada
END_IF

IF xChAbreDuctosResfriadorInf01 THEN
	uStatusDuctosResfriadorInf01:=4; // Chave Acionada
END_IF;

IF xHomeDuctosResfriadorInf01Ok AND NOT xAjusteAlturaDuctosInf01OK AND NOT xDuctosInf01EmHome AND NOT xDuctosInf01EmAjuste AND NOT xChAbreDuctosResfriadorInf01 THEN
	uStatusDuctosResfriadorInf01:=5; // Ajustar Altura
END_IF;

//STATUS DUCTOS SUPERIOR 01
IF NOT xHomeDuctosResfriadorSup01Ok THEN
	uStatusDuctosResfriadorSup01:=0; // Efetuar Home
END_IF;

IF xDuctosSup01EmHome THEN
	uStatusDuctosResfriadorSup01:=1; // Em Home
END_IF

IF xDuctosSup01EmAjuste THEN
	uStatusDuctosResfriadorSup01:=2; // Ajustando Altura
END_IF

IF xAjusteAlturaDuctosSup01OK AND xHomeDuctosResfriadorSup01Ok THEN
	uStatusDuctosResfriadorSup01:=3; // Altura Ajustada
END_IF

IF xChAbreDuctosResfriadorSup01 THEN
	uStatusDuctosResfriadorSup01:=4; // Chave Acionada
END_IF;

IF xHomeDuctosResfriadorSup01Ok AND NOT xAjusteAlturaDuctosSup01OK AND NOT xDuctosSup01EmHome AND NOT xDuctosSup01EmAjuste AND NOT xChAbreDuctosResfriadorSup01 THEN
	uStatusDuctosResfriadorSup01:=5; // Ajustar Altura
END_IF;


//STATUS DUCTOS INFERIOR 02

IF NOT xHomeDuctosResfriadorInf02Ok THEN
	uStatusDuctosResfriadorInf02:=0; // Efetuar Home
END_IF;

IF xDuctosInf02EmHome THEN
	uStatusDuctosResfriadorInf02:=1; // Em Home
END_IF

IF xDuctosInf02EmAjuste THEN
	uStatusDuctosResfriadorInf02:=2; // Ajustando Altura
END_IF

IF xAjusteAlturaDuctosInf02OK AND xHomeDuctosResfriadorInf02Ok THEN
	uStatusDuctosResfriadorInf02:=3; // Altura Ajustada
END_IF

IF xChAbreDuctosResfriadorInf02 THEN
	uStatusDuctosResfriadorInf02:=4; // Chave Acionada
END_IF;

IF xHomeDuctosResfriadorInf02Ok AND NOT xAjusteAlturaDuctosInf02OK AND NOT xDuctosInf02EmHome AND NOT xDuctosInf02EmAjuste AND NOT xChAbreDuctosResfriadorInf02 THEN
	uStatusDuctosResfriadorInf02:=5; // Ajustar Altura
END_IF;


//STATUS DUCTOS SUPERIOR 02
IF NOT xHomeDuctosResfriadorSup02Ok THEN
	uStatusDuctosResfriadorSup02:=0; // Efetuar Home
END_IF;

IF xDuctosSup02EmHome THEN
	uStatusDuctosResfriadorSup02:=1; // Em Home
END_IF

IF xDuctosSup02EmAjuste THEN
	uStatusDuctosResfriadorSup02:=2; // Ajustando Altura
END_IF

IF xAjusteAlturaDuctosSup02OK AND xHomeDuctosResfriadorSup02Ok THEN
	uStatusDuctosResfriadorSup02:=3; // Altura Ajustada
END_IF

IF xChAbreDuctosResfriadorSup02 THEN
	uStatusDuctosResfriadorSup02:=4; // Chave Acionada
END_IF;

IF xHomeDuctosResfriadorSup02Ok AND NOT xAjusteAlturaDuctosSup02OK AND NOT xDuctosSup02EmHome AND NOT xDuctosSup02EmAjuste AND NOT xChAbreDuctosResfriadorSup02 THEN
	uStatusDuctosResfriadorSup02:=5; // Ajustar Altura
END_IF;

//STATUS GUILHOTINA 01

IF NOT xHomeGuilhotina01Ok THEN
	uStatusGuilhotina01:=0; // Efetuar Home
END_IF;

IF xGuilhotina01EmHome THEN
	uStatusGuilhotina01:=1; // Em Home
END_IF

IF xGuilhotina01EmAjuste THEN
	uStatusGuilhotina01:=2; // Ajustando Altura
END_IF

IF xAjusteAlturaGuilhotina01OK AND xHomeGuilhotina01Ok THEN
	uStatusGuilhotina01:=3; // Altura Ajustada
END_IF

IF xHomeGuilhotina01Ok AND NOT xAjusteAlturaGuilhotina01OK AND NOT xGuilhotina01EmHome AND NOT xGuilhotina01EmAjuste THEN
	uStatusGuilhotina01:=5; // Ajustar Altura
END_IF;

//STATUS GUILHOTINA 01 SUPERIOR

IF NOT xHomeGuilhotina01SupOk THEN
	uStatusGuilhotina01Sup:=0; // Efetuar Home
END_IF;

IF xGuilhotina01SupEmHome THEN
	uStatusGuilhotina01Sup:=1; // Em Home
END_IF

IF xGuilhotina01SupEmAjuste THEN
	uStatusGuilhotina01Sup:=2; // Ajustando Altura
END_IF

IF xAjusteAlturaGuilhotina01SupOK AND xHomeGuilhotina01SupOk THEN
	uStatusGuilhotina01Sup:=3; // Altura Ajustada
END_IF

IF xHomeGuilhotina01SupOk AND NOT xAjusteAlturaGuilhotina01SupOK AND NOT xGuilhotina01SupEmHome AND NOT xGuilhotina01SupEmAjuste THEN
	uStatusGuilhotina01Sup:=5; // Ajustar Altura
END_IF;

//STATUS GUILHOTINA 01 INFERIOR

IF NOT xHomeGuilhotina01InfOk THEN
	uStatusGuilhotina01Inf:=0; // Efetuar Home
END_IF;

IF xGuilhotina01InfEmHome THEN
	uStatusGuilhotina01Inf:=1; // Em Home
END_IF

IF xGuilhotina01InfEmAjuste THEN
	uStatusGuilhotina01Inf:=2; // Ajustando Altura
END_IF

IF xAjusteAlturaGuilhotina01InfOK AND xHomeGuilhotina01InfOk THEN
	uStatusGuilhotina01Inf:=3; // Altura Ajustada
END_IF

IF xHomeGuilhotina01InfOk AND NOT xAjusteAlturaGuilhotina01InfOK AND NOT xGuilhotina01InfEmHome AND NOT xGuilhotina01InfEmAjuste THEN
	uStatusGuilhotina01Inf:=5; // Ajustar Altura
END_IF;


//STATUS GUILHOTINA 02

IF NOT xHomeGuilhotina02Ok THEN
	uStatusGuilhotina02:=0; // Efetuar Home
END_IF;

IF xGuilhotina02EmHome THEN
	uStatusGuilhotina02:=1; // Em Home
END_IF

IF xGuilhotina02EmAjuste THEN
	uStatusGuilhotina02:=2; // Ajustando Altura
END_IF

IF xAjusteAlturaGuilhotina02OK AND xHomeGuilhotina02Ok THEN
	uStatusGuilhotina02:=3; // Altura Ajustada
END_IF

IF xHomeGuilhotina02Ok AND NOT xAjusteAlturaGuilhotina02OK AND NOT xGuilhotina02EmHome AND NOT xGuilhotina02EmAjuste THEN
	uStatusGuilhotina02:=5; // Ajustar Altura
END_IF;
