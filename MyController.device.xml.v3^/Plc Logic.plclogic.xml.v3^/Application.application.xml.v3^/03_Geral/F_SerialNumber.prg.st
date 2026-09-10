__METADATA__
{
  "v3Meta": {
    "objectGuid": "ca4bbc51-b373-46f4-ba51-c4402440648a",
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
PROGRAM F_SerialNumber
VAR
	myCtr_Serial: DWORD;
	myCtr_Bateria: WORD;
	myCtr_ID: WORD;
	myCtr_FramesRx: UDINT;
	mCtr_Model: STRING(31);
END_VAR
__IMPLEMENTATION__
//myCtr_Serial := M258.i_dwSerialNumber;
//myCtr_ID := M258.i_wVendorID;
//myCtr_FramesRx := SERIAL_R[0].i_udiFramesReceivedOK;

myCtr_Serial:=plc_r.i_dwSerialNumber;

myCtr_Bateria:=plc_r.i_wClockBatteryStatus;

mCtr_Model:=plc_r.i_sProductRef;


