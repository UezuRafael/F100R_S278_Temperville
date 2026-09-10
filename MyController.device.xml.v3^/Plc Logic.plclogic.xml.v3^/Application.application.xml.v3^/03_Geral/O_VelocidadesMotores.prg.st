__METADATA__
{
  "v3Meta": {
    "objectGuid": "eae0224f-21e8-4eb3-8785-9fb9da22cc6d",
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
PROGRAM O_VelocidadesMotores
VAR
	EntradaFornoGrosso: EquacaoDaReta;
	FornoResfriamentoGrosso: EquacaoDaReta;
	ResfriamentoSaidaGrosso: EquacaoDaReta;
	EntradaFornoFino: EquacaoDaReta;
	FornoResfriamentoFino: EquacaoDaReta;
	ResfriamentoSaidaFino: EquacaoDaReta;
	///Bloco Seleciona Pulsos para Vidro Fino ou Grosso
	SelecaoPulsos01: BlocoSelecaoEspessura;
	///Bloco Seleciona Pulsos para Vidro Fino ou Grosso
	SelecaoPulsos02: BlocoSelecaoEspessura;
	rVelocidadeMesaEntrada: REAL;
	rVelocidadeCargaMesaForno: REAL;
	rVelocidDescargaMesaForno: REAL;
	rVelocidCargaMesaResfriam: REAL;
	rVelocidDescargaMesaResfr: REAL;
	rVelocidadeMesaSaida: REAL;
	rVelocidadeMesaEntradaVidroFin: REAL;
	rVelocidadeCargaMesaFornoVidroFin: REAL;
	rVelocidDescargaMesaFornoVidroFin: REAL;
	rVelocidCargaMesaResfriamVidroFin: REAL;
	rVelocidDescargaMesaResfrVidroFin: REAL;
	rVelocidadeMesaSaidaVidroFin: REAL;
END_VAR
__IMPLEMENTATION__
(* CÁLCULOS DOS VALORES DE VELOCIDADES DAS MESAS EM FUNÇÃO DA VELOCIDADE DO FORNO*)

//Vidros com Espessura 4mm
rVelocidadeCargaMesaFornoVidroFin:=INT_TO_REAL(iVelocidadeCargaFornoVidroFin);
rVelocidDescargaMesaFornoVidroFin:=INT_TO_REAL(iVelDescargaFornoVidroFin);
rVelocidDescargaMesaResfrVidroFin:=INT_TO_REAL(iVelDescargaResfriadorVidroFin);

EntradaFornoFino(
	rValorY:= (rVelocidadeCargaMesaFornoVidroFin/10), 
	rPy1:= 25, //Velocidade y1 Inversor Forno
	rPy2:= 45, //Velocidade y2 Inversor Forno
	rPx1:= 39, //Velocidade x1 Inversor Entrada
	rPx2:= 70, //Velocidade x2 Inversor Entrada
	rValorX=> rVelocidadeMesaEntradaVidroFin);//Velocidade da Mesa de Entrada
	
iVelCargaMesaEntradaVidroFin:=REAL_TO_INT(rVelocidadeMesaEntradaVidroFin*10);
iVelCargaMeEntradaVidroFin:=iVelCargaMesaEntradaVidroFin+iCorretorCargaEntradaVidroFin;
	
FornoResfriamentoFino(
	rValorY:= (rVelocidDescargaMesaFornoVidroFin/10), 
	rPy1:= 25,  //Velocidade y1 Inversor Forno
	rPy2:= 45,  //Velocidade y2 Inversor Forno
	rPx1:= 42.6, //Velocidade x1 Inversor Resfriador
	rPx2:= 77, //Velocidade x2 Inversor Resfriador 
	rValorX=> rVelocidCargaMesaResfriamVidroFin);//Velocidade da Mesa do Resfriamento
	
iVelCargaResfriadorVidroFin:=REAL_TO_INT(rVelocidCargaMesaResfriamVidroFin*10);
iVelCargaMeResfriadorVidroFin:=iVelCargaResfriadorVidroFin+iCorretorCargaResfriadorVidroFin;
	
ResfriamentoSaidaFino(
	rValorY:= (rVelocidDescargaMesaResfrVidroFin/10), 
	rPy1:= 42.6, // Velociade y1 Inversor Resfriador
	rPy2:= 77, // Velociade y2 Inversor Resfriador
	rPx1:= 37, // Velociade x1 Inversor Saída
	rPx2:= 65, // Velociade x2 Inversor Saída
	rValorX=> rVelocidadeMesaSaidaVidroFin); // Velocidade da Mesa de Saida
	
iVelCargaMesaSaidaVidroFin:=REAL_TO_INT(rVelocidadeMesaSaidaVidroFin*10);
iVelCargaMeSaidaVidroFin:=iVelCargaMesaSaidaVidroFin+iCorretorCargaSaidaVidroFin;

//-------------------------------------------------------------------------------//
//Vidros com Espessura Superior a 4mm
rVelocidadeCargaMesaForno:=INT_TO_REAL(iVelocidadeCargaForno);
rVelocidDescargaMesaForno:=INT_TO_REAL(iVelDescargaForno);
rVelocidDescargaMesaResfr:=INT_TO_REAL(iVelDescargaResfriador);

EntradaFornoGrosso(
	rValorY:= (rVelocidadeCargaMesaForno/10), 
	rPy1:= 25, //Velocidade y1 Inversor Forno
	rPy2:= 40, //Velocidade y2 Inversor Forno
	rPx1:= 41.0, //Velocidade x1 Inversor Entrada
	rPx2:= 65.2, //Velocidade x2 Inversor Entrada
	rValorX=> rVelocidadeMesaEntrada);//Velocidade da Mesa de Entrada
	
iVelCargaMesaEntrada:=REAL_TO_INT(rVelocidadeMesaEntrada*10);
iVelCargaMeEntrada:=iVelCargaMesaEntrada+iCorretorCargaEntrada;
	
FornoResfriamentoGrosso(
	rValorY:= (rVelocidDescargaMesaForno/10), 
	rPy1:= 25,  //Velocidade y1 Inversor Forno
	rPy2:= 40,  //Velocidade y2 Inversor Forno
	rPx1:= 46.2, //Velocidade x1 Inversor Resfriador
	rPx2:= 73.6, //Velocidade x2 Inversor Resfriador 
	rValorX=> rVelocidCargaMesaResfriam);//Velocidade da Mesa do Resfriamento
	
iVelCargaResfriador:=REAL_TO_INT(rVelocidCargaMesaResfriam*10);
iVelCargaMeResfriador:=iVelCargaResfriador+iCorretorCargaResfriador;
	
ResfriamentoSaidaGrosso(
	rValorY:= (rVelocidDescargaMesaResfr/10), 
	rPy1:= 46, // Velociade y1 Inversor Resfriador
	rPy2:= 73.6, // Velociade y2 Inversor Resfriador
	rPx1:= 45.5, // Velociade x1 Inversor Saída
	rPx2:= 72.2, // Velociade x2 Inversor Saída
	rValorX=> rVelocidadeMesaSaida); // Velocidade da Mesa de Saida
	
iVelCargaMesaSaida:=REAL_TO_INT(rVelocidadeMesaSaida*10);
iVelCargaMeSaida:=iVelCargaMesaSaida+iCorretorCargaSaida;


//Seleção das Variáveis de Velocidade

SelecaoPulsos01(
	xSelecao:= xEspessuraVidroFino, 
	iEntrada0101:= iVelCargaMeEntradaVidroFin, 
	iEntrada0102:= iVelCargaMeEntrada, 
	iEntrada0201:= iVelocidadeCargaFornoVidroFin, 
	iEntrada0202:= iVelocidadeCargaForno, 
	iEntrada0301:= iVelVaiVemFornoVidroFin, 
	iEntrada0302:= iVelVaiVemForno, 
	iEntrada0401:= iVelDescargaFornoVidroFin, 
	iEntrada0402:= iVelDescargaForno, 
	iEntrada0501:= iVelCargaMeResfriadorVidroFin, 
	iEntrada0502:= iVelCargaMeResfriador, 
	iEntrada0601:= iVelVaiVemResfriadorVidroFin, 
	iEntrada0602:= iVelVaiVemResfriador, 
	iSaida01=> ,//iVelocidadeCargaMesaEntrada, 
	iSaida02=> ,//iVelocidadeCargaMesaForno, 
	iSaida03=> ,//iVelocidadeVaiVemMesaForno, Retirado para vir diretamente da Receita 
	iSaida04=> ,//iVelocidadeDescargaMesaForno, 
	iSaida05=> ,//iVelocidadeCargaMesaResfriador, 
	iSaida06=> );//iVelocidadeVaiVemMesaResfriador);
	
SelecaoPulsos02(
	xSelecao:= xEspessuraVidroFino, 
	iEntrada0101:= iVelDescargaResfriadorVidroFin, 
	iEntrada0102:= iVelDescargaResfriador, 
	iEntrada0201:= iVelCargaMeSaidaVidroFin, 
	iEntrada0202:= iVelCargaMeSaida, 
	iSaida01=> ,//iVelocidadeDescargaMesaResfriador, 
	iSaida02=> );//iVelociadeCargaMesadeSaida);
	
