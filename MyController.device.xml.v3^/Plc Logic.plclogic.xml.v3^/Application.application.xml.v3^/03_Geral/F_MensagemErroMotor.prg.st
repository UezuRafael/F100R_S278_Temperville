__METADATA__
{
  "v3Meta": {
    "objectGuid": "4b501116-e031-484d-bb3f-40eb0f7fd498",
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
PROGRAM F_MensagemErroMotor
VAR
	Index: INT;
	sCodigoErroMotor: ARRAY[1..25] OF STRING;
	sDescricaoErroMotor: ARRAY[1..25] OF STRING;
END_VAR
__IMPLEMENTATION__
FOR Index:=1 TO 20 DO
	IF wErroMotorId[Index]=4096 THEN
		sCodigoErroMotor[Index]:='OLF';
		sDescricaoErroMotor[Index]:='Sobrecarga Motor ';
	END_IF
	IF wErroMotorId[Index]=8976 THEN
		sCodigoErroMotor[Index]:='OCF';
		sDescricaoErroMotor[Index]:='Sobrecorrente Motor ';
	END_IF
	IF wErroMotorId[Index]=8992 THEN
		sCodigoErroMotor[Index]:='SCF';
		sDescricaoErroMotor[Index]:='Curto Circuito Motor ';
	END_IF
	IF wErroMotorId[Index]=9008 THEN
		sCodigoErroMotor[Index]:='SCF';
		sDescricaoErroMotor[Index]:='Curto Circuito Motor (Fase-Terra) ';
	END_IF
	IF wErroMotorId[Index]=9024 THEN
		sCodigoErroMotor[Index]:='SCF';
		sDescricaoErroMotor[Index]:='Curto Circuito Motor (Fase-Fase) ';
	END_IF
	IF wErroMotorId[Index]=12560 THEN
		sCodigoErroMotor[Index]:='OSF';
		sDescricaoErroMotor[Index]:='Sobretensão na Alimentação do Motor ';
	END_IF
	IF wErroMotorId[Index]=12576 THEN
		sCodigoErroMotor[Index]:='USF';
		sDescricaoErroMotor[Index]:='Sobretensão na Alimentação do Motor ';
	END_IF
	IF wErroMotorId[Index]=12592 THEN
		sCodigoErroMotor[Index]:='PHF';
		sDescricaoErroMotor[Index]:='Erro nas Fases de Alimentação ';
	END_IF
	IF wErroMotorId[Index]=13072 THEN
		sCodigoErroMotor[Index]:='OPF';
		sDescricaoErroMotor[Index]:='Erro nas Fases do Motor ';
	END_IF
	IF wErroMotorId[Index]=16912 THEN
		sCodigoErroMotor[Index]:='OHF';
		sDescricaoErroMotor[Index]:='Sobretemperatura no Motor ';
	END_IF
	IF wErroMotorId[Index]=21792 THEN
		sCodigoErroMotor[Index]:='EEF';
		sDescricaoErroMotor[Index]:='Erro na EEPROM ';
	END_IF
	IF wErroMotorId[Index]=24832 THEN
		sCodigoErroMotor[Index]:='InF';
		sDescricaoErroMotor[Index]:='Evento Interno ';
	END_IF
	IF wErroMotorId[Index]=33024 THEN
		sCodigoErroMotor[Index]:='COF';
		sDescricaoErroMotor[Index]:='Erro de Comunicação CANopen ';
	END_IF
	IF wErroMotorId[Index]=36864 THEN
		sCodigoErroMotor[Index]:='EPF';
		sDescricaoErroMotor[Index]:='Erro Externo ';
	END_IF

END_FOR
