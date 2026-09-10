__METADATA__
{
  "v3Meta": {
    "objectGuid": "268a8f83-d133-405d-ae9e-5594dcf20fad",
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
PROGRAM B_Velocidades
VAR
	EntradaForno: EquacaoDaReta;
	FornoPassagem: EquacaoDaReta;
	PassagemResfriamento : EquacaoDaReta;
	ResfriamentoSaida: EquacaoDaReta;
	rVelocidadeMesaEntrada: REAL;
	rVelocidadeCargaMesaForno: REAL;
	rVelocidDescargaMesaForno: REAL;
	rVelocidCargaMesaPassagem: REAL;
	rVelocidDescargaMesaPassagem:REAL;
	rVelocidCargaMesaResfriam: REAL;
	rVelocidDescargaMesaResfr: REAL;
	rVelocidadeMesaSaida: REAL;
	iVelocCargaMesaEntrada: INT;
	iVelocCargaMesaPassagem : INT;
	iVelocCargaResfriador: INT;
	iVelocCargaMesaSaida: INT;
END_VAR
__IMPLEMENTATION__
rVelocidadeCargaMesaForno:=INT_TO_REAL(iVelocidadeCargaMesadoForno/1);
rVelocidDescargaMesaForno:=INT_TO_REAL(iVelocidadeDescargaMesadoForno/1);
rVelocidDescargaMesaResfr:=INT_TO_REAL(iVelocidadeDescargaMesadoResfriador/1);

iVelocidadeCargaMesaForno:=REAL_TO_INT(iVelocidadeCargaMesadoForno/10);
iVelocidadeDescargaMesaForno:=REAL_TO_INT(iVelocidadeDescargaMesadoForno/10);
iVelocidadeDescargaMesaResfriador:=REAL_TO_INT(iVelocidadeDescargaMesadoResfriador/10);

EntradaForno(
	rValorY:= rVelocidadeCargaMesaForno/100, 
	rPy1:= 25, //Velocidade y1 Inversor Forno
	rPy2:= 45, //Velocidade y2 Inversor Forno
	rPx1:= rVelMesaEntrada25/10, //Velocidade x1 Inversor Entrada
	rPx2:= rVelMesaEntrada45/10, //Velocidade x2 Inversor Entrada
	rValorX=> rVelocidadeMesaEntrada);//Velocidade da Mesa de Entrada
	
iVelocCargaMesaEntrada:=REAL_TO_INT(rVelocidadeMesaEntrada*10);
iVelocidadeCargaMesaEntrada:=iVelocCargaMesaEntrada+iCorretorCargaMesaEntrada;
	
FornoPassagem(
	rValorY:= rVelocidDescargaMesaForno/100, 
	rPy1:= 25,  //Velocidade y1 Inversor Forno
	rPy2:= 45,  //Velocidade y2 Inversor Forno
	rPx1:= rVelMesaPassagem25/10, //Velocidade x1 Inversor Passagem
	rPx2:= rVelMesaPassagem45/10, //Velocidade x2 Inversor Passagem 
	rValorX=> rVelocidCargaMesaPassagem);//Velocidade da Mesa do Resfriamento
	
iVelocCargaMesaPassagem:=REAL_TO_INT(rVelocidCargaMesaPassagem*10);
iVelocidadeCargaMesaPass:=iVelocCargaMesaPassagem+iCorretorCargaMesaPassagem;


PassagemResfriamento(
	rValorY:= rVelocidDescargaMesaForno/100, 
	rPy1:= 25,  //Velocidade y1 Inversor passagem
	rPy2:= 45,  //Velocidade y2 Inversor passagem
	rPx1:= rVelMesaResfriamento25/10, //Velocidade x1 Inversor Resfriador
	rPx2:= rVelMesaResfriamento45/10, //Velocidade x2 Inversor Resfriador 
	rValorX=> rVelocidCargaMesaResfriam);//Velocidade da Mesa do Resfriamento
	
iVelocCargaResfriador:=REAL_TO_INT(rVelocidCargaMesaResfriam*10);
iVelocidadeCargaMesaResfriador:=iVelocCargaResfriador+iCorretorCargaMesaResfriador;

	
ResfriamentoSaida(
	rValorY:= rVelocidDescargaMesaResfr/10, 
	rPy1:= rVelMesaResfriamento25, // Velociade y1 Inversor Resfriador
	rPy2:= rVelMesaResfriamento45, // Velociade y2 Inversor Resfriador
	rPx1:= rVelMesaSaida25, // Velociade x1 Inversor Saída
	rPx2:= rVelMesaSaida45, // Velociade x2 Inversor Saída
	rValorX=> rVelocidadeMesaSaida); // Velocidade da Mesa de Saida
	
iVelocCargaMesaSaida:=REAL_TO_INT(rVelocidadeMesaSaida);
iVelociadeCargaMesadeSaida:=iVelocCargaMesaSaida+iCorretorCargaMesaSaida;
