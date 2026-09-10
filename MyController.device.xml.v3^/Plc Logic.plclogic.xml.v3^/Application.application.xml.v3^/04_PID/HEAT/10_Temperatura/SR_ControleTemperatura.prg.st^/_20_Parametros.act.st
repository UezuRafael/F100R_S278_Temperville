__METADATA__
{
  "v3Meta": {
    "objectGuid": "f91c44e9-debc-4e59-8105-c86b109b27d2",
    "objectTypeGuid": "8ac092e5-3128-4e26-9e7e-11016c6684f2",
    "embeddedObjectTypeGuids": [
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {},
    "subObjects": {}
  }
}
__IMPLEMENTATION__
//escreve parametros da estrutura ST_PID para dentro do conjunto "Padrão" de parametros PID
//elementos da estrutura ST_PID das variaveis P_stPidxxxxx abaixo:
//Kp ganho proporcional
//Tn tempo integral
//Tv tempo derivada
//Td damping time derivada 	

//copia os parametros somente dos controles habilitados para operar
IF InterfaceHeat.P_xHabTemp1 OR xLigaDeslResInferiores THEN stParameterSetsPID[1].stDefault := P_stPid1; END_IF
IF InterfaceHeat.P_xHabTemp2 OR xLigaDeslResInferiores THEN stParameterSetsPID[2].stDefault := P_stPid2;  END_IF
IF InterfaceHeat.P_xHabTemp3 OR xLigaDeslResInferiores THEN stParameterSetsPID[3].stDefault := P_stPid3; END_IF
IF InterfaceHeat.P_xHabTemp4 OR xLigaDeslResInferiores THEN stParameterSetsPID[4].stDefault := P_stPid4; END_IF
IF InterfaceHeat.P_xHabTemp5 OR xLigaDeslResInferiores THEN stParameterSetsPID[5].stDefault := P_stPid5; END_IF
IF InterfaceHeat.P_xHabTemp6 OR xLigaDeslResInferiores THEN stParameterSetsPID[6].stDefault := P_stPid6; END_IF
IF InterfaceHeat.P_xHabTemp7 OR xLigaDeslResInferiores THEN stParameterSetsPID[7].stDefault := P_stPid7; END_IF
IF InterfaceHeat.P_xHabTemp8 OR xLigaDeslResInferiores THEN stParameterSetsPID[8].stDefault := P_stPid8; END_IF
IF InterfaceHeat.P_xHabTemp9 OR xLigaDeslResInferiores THEN stParameterSetsPID[9].stDefault := P_stPid9; END_IF
IF InterfaceHeat.P_xHabTemp10 OR xLigaDeslResInferiores THEN stParameterSetsPID[10].stDefault := P_stPid10; END_IF
IF InterfaceHeat.P_xHabTemp11 OR xLigaDeslResInferiores THEN stParameterSetsPID[11].stDefault := P_stPid11; END_IF
IF InterfaceHeat.P_xHabTemp12 OR xLigaDeslResInferiores THEN stParameterSetsPID[12].stDefault := P_stPid12; END_IF
IF InterfaceHeat.P_xHabTemp13 OR xLigaDeslResInferiores THEN stParameterSetsPID[13].stDefault := P_stPid13; END_IF
IF InterfaceHeat.P_xHabTemp14 OR xLigaDeslResInferiores THEN stParameterSetsPID[14].stDefault := P_stPid14; END_IF
IF InterfaceHeat.P_xHabTemp15 OR xLigaDeslResInferiores THEN stParameterSetsPID[15].stDefault := P_stPid15; END_IF
IF InterfaceHeat.P_xHabTemp16 OR xLigaDeslResInferiores THEN stParameterSetsPID[16].stDefault := P_stPid16; END_IF
IF InterfaceHeat.P_xHabTemp17 OR xLigaDeslResInferiores THEN stParameterSetsPID[17].stDefault := P_stPid17; END_IF
IF InterfaceHeat.P_xHabTemp18 OR xLigaDeslResInferiores THEN stParameterSetsPID[18].stDefault := P_stPid18; END_IF
IF InterfaceHeat.P_xHabTemp19 OR xLigaDeslResInferiores THEN stParameterSetsPID[19].stDefault := P_stPid19; END_IF
IF InterfaceHeat.P_xHabTemp20 OR xLigaDeslResInferiores THEN stParameterSetsPID[20].stDefault := P_stPid20; END_IF
IF InterfaceHeat.P_xHabTemp21 OR xLigaDeslResInferiores THEN stParameterSetsPID[21].stDefault := P_stPid21; END_IF
IF InterfaceHeat.P_xHabTemp22 OR xLigaDeslResInferiores THEN stParameterSetsPID[22].stDefault := P_stPid22; END_IF
IF InterfaceHeat.P_xHabTemp23 OR xLigaDeslResInferiores THEN stParameterSetsPID[23].stDefault := P_stPid23; END_IF
IF InterfaceHeat.P_xHabTemp24 OR xLigaDeslResInferiores THEN stParameterSetsPID[24].stDefault := P_stPid24; END_IF
IF InterfaceHeat.P_xHabTemp25 OR xLigaDeslResInferiores THEN stParameterSetsPID[25].stDefault := P_stPid25; END_IF
IF InterfaceHeat.P_xHabTemp26 OR xLigaDeslResInferiores THEN stParameterSetsPID[26].stDefault := P_stPid26; END_IF
IF InterfaceHeat.P_xHabTemp27 OR xLigaDeslResInferiores THEN stParameterSetsPID[27].stDefault := P_stPid27; END_IF
IF InterfaceHeat.P_xHabTemp28 OR xLigaDeslResInferiores THEN stParameterSetsPID[28].stDefault := P_stPid28; END_IF
IF InterfaceHeat.P_xHabTemp29 OR xLigaDeslResInferiores THEN stParameterSetsPID[29].stDefault := P_stPid29; END_IF
IF InterfaceHeat.P_xHabTemp30 OR xLigaDeslResInferiores THEN stParameterSetsPID[20].stDefault := P_stPid30; END_IF
IF InterfaceHeat.P_xHabTemp31 OR xLigaDeslResInferiores THEN stParameterSetsPID[31].stDefault := P_stPid31; END_IF
IF InterfaceHeat.P_xHabTemp32 OR xLigaDeslResInferiores THEN stParameterSetsPID[32].stDefault := P_stPid32; END_IF
IF InterfaceHeat.P_xHabTemp33 OR xLigaDeslResInferiores THEN stParameterSetsPID[33].stDefault := P_stPid33; END_IF
IF InterfaceHeat.P_xHabTemp34 OR xLigaDeslResInferiores THEN stParameterSetsPID[34].stDefault := P_stPid34; END_IF
IF InterfaceHeat.P_xHabTemp35 OR xLigaDeslResInferiores THEN stParameterSetsPID[35].stDefault := P_stPid35; END_IF
IF InterfaceHeat.P_xHabTemp36 OR xLigaDeslResInferiores THEN stParameterSetsPID[36].stDefault := P_stPid36; END_IF
IF InterfaceHeat.P_xHabTemp37 OR xLigaDeslResInferiores THEN stParameterSetsPID[37].stDefault := P_stPid37; END_IF
IF InterfaceHeat.P_xHabTemp38 OR xLigaDeslResInferiores THEN stParameterSetsPID[38].stDefault := P_stPid38; END_IF
IF InterfaceHeat.P_xHabTemp39 OR xLigaDeslResInferiores THEN stParameterSetsPID[39].stDefault := P_stPid39; END_IF
IF InterfaceHeat.P_xHabTemp40 OR xLigaDeslResInferiores THEN stParameterSetsPID[40].stDefault := P_stPid40; END_IF
IF InterfaceHeat.P_xHabTemp41 OR xLigaDeslResInferiores THEN stParameterSetsPID[41].stDefault := P_stPid41; END_IF
IF InterfaceHeat.P_xHabTemp42 OR xLigaDeslResInferiores THEN stParameterSetsPID[42].stDefault := P_stPid42; END_IF
IF InterfaceHeat.P_xHabTemp43 OR xLigaDeslResInferiores THEN stParameterSetsPID[43].stDefault := P_stPid43; END_IF
IF InterfaceHeat.P_xHabTemp44 OR xLigaDeslResInferiores THEN stParameterSetsPID[44].stDefault := P_stPid44; END_IF
IF InterfaceHeat.P_xHabTemp45 OR xLigaDeslResInferiores THEN stParameterSetsPID[45].stDefault := P_stPid45; END_IF
IF InterfaceHeat.P_xHabTemp46 OR xLigaDeslResInferiores THEN stParameterSetsPID[46].stDefault := P_stPid46; END_IF
IF InterfaceHeat.P_xHabTemp47 OR xLigaDeslResInferiores THEN stParameterSetsPID[47].stDefault := P_stPid47; END_IF
IF InterfaceHeat.P_xHabTemp48 OR xLigaDeslResInferiores THEN stParameterSetsPID[48].stDefault := P_stPid48; END_IF
IF InterfaceHeat.P_xHabTemp49 OR xLigaDeslResInferiores THEN stParameterSetsPID[49].stDefault := P_stPid49; END_IF
IF InterfaceHeat.P_xHabTemp50 OR xLigaDeslResInferiores THEN stParameterSetsPID[50].stDefault := P_stPid50; END_IF
IF InterfaceHeat.P_xHabTemp51 OR xLigaDeslResInferiores THEN stParameterSetsPID[51].stDefault := P_stPid51; END_IF
IF InterfaceHeat.P_xHabTemp52 OR xLigaDeslResInferiores THEN stParameterSetsPID[52].stDefault := P_stPid52; END_IF
IF InterfaceHeat.P_xHabTemp53 OR xLigaDeslResInferiores THEN stParameterSetsPID[53].stDefault := P_stPid53; END_IF
IF InterfaceHeat.P_xHabTemp54 OR xLigaDeslResInferiores THEN stParameterSetsPID[54].stDefault := P_stPid54; END_IF
IF InterfaceHeat.P_xHabTemp55 OR xLigaDeslResInferiores THEN stParameterSetsPID[55].stDefault := P_stPid55; END_IF
IF InterfaceHeat.P_xHabTemp56 OR xLigaDeslResInferiores THEN stParameterSetsPID[56].stDefault := P_stPid56; END_IF
IF InterfaceHeat.P_xHabTemp57 OR xLigaDeslResInferiores THEN stParameterSetsPID[57].stDefault := P_stPid57; END_IF
IF InterfaceHeat.P_xHabTemp58 OR xLigaDeslResInferiores THEN stParameterSetsPID[58].stDefault := P_stPid58; END_IF
IF InterfaceHeat.P_xHabTemp59 OR xLigaDeslResInferiores THEN stParameterSetsPID[59].stDefault := P_stPid59; END_IF
IF InterfaceHeat.P_xHabTemp60 OR xLigaDeslResInferiores THEN stParameterSetsPID[60].stDefault := P_stPid60; END_IF
IF InterfaceHeat.P_xHabTemp61 OR xLigaDeslResInferiores THEN stParameterSetsPID[61].stDefault := P_stPid61; END_IF
IF InterfaceHeat.P_xHabTemp62 OR xLigaDeslResInferiores THEN stParameterSetsPID[62].stDefault := P_stPid62; END_IF
IF InterfaceHeat.P_xHabTemp63 OR xLigaDeslResInferiores THEN stParameterSetsPID[63].stDefault := P_stPid63; END_IF
IF InterfaceHeat.P_xHabTemp64 OR xLigaDeslResInferiores THEN stParameterSetsPID[64].stDefault := P_stPid64; END_IF
IF InterfaceHeat.P_xHabTemp65 OR xLigaDeslResInferiores THEN stParameterSetsPID[65].stDefault := P_stPid65; END_IF
IF InterfaceHeat.P_xHabTemp66 OR xLigaDeslResInferiores THEN stParameterSetsPID[66].stDefault := P_stPid66; END_IF
IF InterfaceHeat.P_xHabTemp67 OR xLigaDeslResInferiores THEN stParameterSetsPID[67].stDefault := P_stPid67; END_IF
IF InterfaceHeat.P_xHabTemp68 OR xLigaDeslResInferiores THEN stParameterSetsPID[68].stDefault := P_stPid68; END_IF
IF InterfaceHeat.P_xHabTemp69 OR xLigaDeslResInferiores THEN stParameterSetsPID[69].stDefault := P_stPid69; END_IF
IF InterfaceHeat.P_xHabTemp70 OR xLigaDeslResInferiores THEN stParameterSetsPID[70].stDefault := P_stPid70; END_IF
IF InterfaceHeat.P_xHabTemp71 OR xLigaDeslResInferiores THEN stParameterSetsPID[71].stDefault := P_stPid71; END_IF
IF InterfaceHeat.P_xHabTemp72 OR xLigaDeslResInferiores THEN stParameterSetsPID[72].stDefault := P_stPid72; END_IF
IF InterfaceHeat.P_xHabTemp73 OR xLigaDeslResInferiores THEN stParameterSetsPID[73].stDefault := P_stPid73; END_IF
IF InterfaceHeat.P_xHabTemp74 OR xLigaDeslResInferiores THEN stParameterSetsPID[74].stDefault := P_stPid74; END_IF
IF InterfaceHeat.P_xHabTemp75 OR xLigaDeslResInferiores THEN stParameterSetsPID[75].stDefault := P_stPid75; END_IF
IF InterfaceHeat.P_xHabTemp76 OR xLigaDeslResInferiores THEN stParameterSetsPID[76].stDefault := P_stPid76; END_IF
IF InterfaceHeat.P_xHabTemp77 OR xLigaDeslResInferiores THEN stParameterSetsPID[77].stDefault := P_stPid77; END_IF
IF InterfaceHeat.P_xHabTemp78 OR xLigaDeslResInferiores THEN stParameterSetsPID[78].stDefault := P_stPid78; END_IF
IF InterfaceHeat.P_xHabTemp79 OR xLigaDeslResInferiores THEN stParameterSetsPID[79].stDefault := P_stPid79; END_IF
IF InterfaceHeat.P_xHabTemp80 OR xLigaDeslResInferiores THEN stParameterSetsPID[80].stDefault := P_stPid80; END_IF
IF InterfaceHeat.P_xHabTemp81 OR xLigaDeslResInferiores THEN stParameterSetsPID[81].stDefault := P_stPid81; END_IF
IF InterfaceHeat.P_xHabTemp82 OR xLigaDeslResInferiores THEN stParameterSetsPID[82].stDefault := P_stPid82; END_IF
IF InterfaceHeat.P_xHabTemp83 OR xLigaDeslResInferiores THEN stParameterSetsPID[83].stDefault := P_stPid83; END_IF
IF InterfaceHeat.P_xHabTemp84 OR xLigaDeslResInferiores THEN stParameterSetsPID[84].stDefault := P_stPid84; END_IF
IF InterfaceHeat.P_xHabTemp85 OR xLigaDeslResInferiores THEN stParameterSetsPID[85].stDefault := P_stPid85; END_IF
IF InterfaceHeat.P_xHabTemp86 OR xLigaDeslResInferiores THEN stParameterSetsPID[86].stDefault := P_stPid86; END_IF
IF InterfaceHeat.P_xHabTemp87 OR xLigaDeslResInferiores THEN stParameterSetsPID[87].stDefault := P_stPid87; END_IF
IF InterfaceHeat.P_xHabTemp88 OR xLigaDeslResInferiores THEN stParameterSetsPID[88].stDefault := P_stPid88; END_IF
IF InterfaceHeat.P_xHabTemp89 OR xLigaDeslResInferiores THEN stParameterSetsPID[89].stDefault := P_stPid89; END_IF
IF InterfaceHeat.P_xHabTemp90 OR xLigaDeslResInferiores THEN stParameterSetsPID[80].stDefault := P_stPid90; END_IF
IF InterfaceHeat.P_xHabTemp91 OR xLigaDeslResInferiores THEN stParameterSetsPID[91].stDefault := P_stPid91; END_IF
IF InterfaceHeat.P_xHabTemp92 OR xLigaDeslResInferiores THEN stParameterSetsPID[92].stDefault := P_stPid92; END_IF
IF InterfaceHeat.P_xHabTemp93 OR xLigaDeslResInferiores THEN stParameterSetsPID[93].stDefault := P_stPid93; END_IF
IF InterfaceHeat.P_xHabTemp94 OR xLigaDeslResInferiores THEN stParameterSetsPID[94].stDefault := P_stPid94; END_IF
IF InterfaceHeat.P_xHabTemp95 OR xLigaDeslResInferiores THEN stParameterSetsPID[95].stDefault := P_stPid95; END_IF
IF InterfaceHeat.P_xHabTemp96 OR xLigaDeslResInferiores THEN stParameterSetsPID[96].stDefault := P_stPid96; END_IF
IF InterfaceHeat.P_xHabTemp97 OR xLigaDeslResInferiores THEN stParameterSetsPID[97].stDefault := P_stPid97; END_IF
IF InterfaceHeat.P_xHabTemp98 OR xLigaDeslResInferiores THEN stParameterSetsPID[98].stDefault := P_stPid98; END_IF
IF InterfaceHeat.P_xHabTemp99 OR xLigaDeslResInferiores THEN stParameterSetsPID[99].stDefault := P_stPid99; END_IF
IF InterfaceHeat.P_xHabTemp100 OR xLigaDeslResInferiores THEN stParameterSetsPID[100].stDefault := P_stPid100; END_IF
