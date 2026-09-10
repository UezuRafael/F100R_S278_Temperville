__METADATA__
{
  "v3Meta": {
    "objectGuid": "c0e92009-0267-4914-9baf-7200b27f03f6",
    "objectTypeGuid": "6f9dac99-8de1-4efc-8465-68ac443b7d08",
    "embeddedObjectTypeGuids": [
      "a9ed5b7e-75c5-4651-af16-d2c27e98cb94",
      "3b83b776-fb25-43b8-99f2-3c507c9143fc"
    ],
    "properties": {},
    "subObjects": {}
  }
}
__DECLARATION__
PROGRAM SR_Main
VAR
END_VAR
__IMPLEMENTATION__
//programa de controle de temperatura
SR_ControleTemperatura();

rTemperaturaInferiorSetor[1]:=rTermoparInferiorLeitura[1];
rTemperaturaInferiorSetor[2]:=rTermoparInferiorLeitura[2];
rTemperaturaInferiorSetor[3]:=rTermoparInferiorLeitura[3];
rTemperaturaInferiorSetor[4]:=rTermoparInferiorLeitura[4];
rTemperaturaInferiorSetor[5]:=rTermoparInferiorLeitura[5];
rTemperaturaInferiorSetor[6]:=rTermoparInferiorLeitura[6];
rTemperaturaInferiorSetor[7]:=rTermoparInferiorLeitura[7];
rTemperaturaInferiorSetor[8]:=rTermoparInferiorLeitura[8];
rTemperaturaInferiorSetor[9]:=rTermoparInferiorLeitura[9];
rTemperaturaInferiorSetor[10]:=rTermoparInferiorLeitura[10];

rTemperaturaInferiorSetor[21]:=rTermoparInferiorLeitura[21];
rTemperaturaInferiorSetor[22]:=rTermoparInferiorLeitura[22];
rTemperaturaInferiorSetor[23]:=rTermoparInferiorLeitura[23];
rTemperaturaInferiorSetor[24]:=rTermoparInferiorLeitura[24];
rTemperaturaInferiorSetor[25]:=rTermoparInferiorLeitura[25];
rTemperaturaInferiorSetor[26]:=rTermoparInferiorLeitura[26];
rTemperaturaInferiorSetor[27]:=rTermoparInferiorLeitura[27];
rTemperaturaInferiorSetor[28]:=rTermoparInferiorLeitura[28];
rTemperaturaInferiorSetor[29]:=rTermoparInferiorLeitura[29];
rTemperaturaInferiorSetor[20]:=rTermoparInferiorLeitura[30];

rTemperaturaInferiorSetor[31]:=rTermoparInferiorLeitura[31];
rTemperaturaInferiorSetor[32]:=rTermoparInferiorLeitura[32];
rTemperaturaInferiorSetor[33]:=rTermoparInferiorLeitura[33];
rTemperaturaInferiorSetor[34]:=rTermoparInferiorLeitura[34];
rTemperaturaInferiorSetor[35]:=rTermoparInferiorLeitura[35];
rTemperaturaInferiorSetor[36]:=rTermoparInferiorLeitura[36];
rTemperaturaInferiorSetor[37]:=rTermoparInferiorLeitura[37];
rTemperaturaInferiorSetor[38]:=rTermoparInferiorLeitura[38];
rTemperaturaInferiorSetor[39]:=rTermoparInferiorLeitura[39];
rTemperaturaInferiorSetor[40]:=rTermoparInferiorLeitura[30];

rTemperaturaInferiorSetor[41]:=rTermoparInferiorLeitura[41];
rTemperaturaInferiorSetor[42]:=rTermoparInferiorLeitura[42];
rTemperaturaInferiorSetor[43]:=rTermoparInferiorLeitura[43];
rTemperaturaInferiorSetor[44]:=rTermoparInferiorLeitura[44];
rTemperaturaInferiorSetor[45]:=rTermoparInferiorLeitura[45];
rTemperaturaInferiorSetor[46]:=rTermoparInferiorLeitura[46];
rTemperaturaInferiorSetor[47]:=rTermoparInferiorLeitura[47];
rTemperaturaInferiorSetor[48]:=rTermoparInferiorLeitura[48];
rTemperaturaInferiorSetor[49]:=rTermoparInferiorLeitura[49];
rTemperaturaInferiorSetor[50]:=rTermoparInferiorLeitura[50];

rTemperaturaSuperiorSetor[1]:=rTermoparSuperiorLeitura[1];
rTemperaturaSuperiorSetor[2]:=rTermoparSuperiorLeitura[2];
rTemperaturaSuperiorSetor[3]:=rTermoparSuperiorLeitura[3];
rTemperaturaSuperiorSetor[4]:=rTermoparSuperiorLeitura[4];
rTemperaturaSuperiorSetor[5]:=rTermoparSuperiorLeitura[5];
rTemperaturaSuperiorSetor[6]:=rTermoparSuperiorLeitura[6];
rTemperaturaSuperiorSetor[7]:=rTermoparSuperiorLeitura[7];
rTemperaturaSuperiorSetor[8]:=rTermoparSuperiorLeitura[8];
rTemperaturaSuperiorSetor[9]:=rTermoparSuperiorLeitura[9];
rTemperaturaSuperiorSetor[10]:=rTermoparSuperiorLeitura[10];

rTemperaturaSuperiorSetor[11]:=rTermoparSuperiorLeitura[11];
rTemperaturaSuperiorSetor[12]:=rTermoparSuperiorLeitura[12];
rTemperaturaSuperiorSetor[13]:=rTermoparSuperiorLeitura[13];
rTemperaturaSuperiorSetor[14]:=rTermoparSuperiorLeitura[14];
rTemperaturaSuperiorSetor[15]:=rTermoparSuperiorLeitura[15];
rTemperaturaSuperiorSetor[16]:=rTermoparSuperiorLeitura[16];
rTemperaturaSuperiorSetor[17]:=rTermoparSuperiorLeitura[17];
rTemperaturaSuperiorSetor[18]:=rTermoparSuperiorLeitura[18];
rTemperaturaSuperiorSetor[19]:=rTermoparSuperiorLeitura[19];
rTemperaturaSuperiorSetor[20]:=rTermoparSuperiorLeitura[20];

rTemperaturaSuperiorSetor[21]:=rTermoparSuperiorLeitura[21];
rTemperaturaSuperiorSetor[22]:=rTermoparSuperiorLeitura[22];
rTemperaturaSuperiorSetor[23]:=rTermoparSuperiorLeitura[23];
rTemperaturaSuperiorSetor[24]:=rTermoparSuperiorLeitura[24];
rTemperaturaSuperiorSetor[25]:=rTermoparSuperiorLeitura[25];
rTemperaturaSuperiorSetor[26]:=rTermoparSuperiorLeitura[26];
rTemperaturaSuperiorSetor[27]:=rTermoparSuperiorLeitura[27];
rTemperaturaSuperiorSetor[28]:=rTermoparSuperiorLeitura[28];
rTemperaturaSuperiorSetor[29]:=rTermoparSuperiorLeitura[29];
rTemperaturaSuperiorSetor[30]:=rTermoparSuperiorLeitura[30];

rTemperaturaSuperiorSetor[31]:=rTermoparSuperiorLeitura[31];
rTemperaturaSuperiorSetor[32]:=rTermoparSuperiorLeitura[32];
rTemperaturaSuperiorSetor[33]:=rTermoparSuperiorLeitura[33];
rTemperaturaSuperiorSetor[34]:=rTermoparSuperiorLeitura[34];
rTemperaturaSuperiorSetor[35]:=rTermoparSuperiorLeitura[35];
rTemperaturaSuperiorSetor[36]:=rTermoparSuperiorLeitura[36];
rTemperaturaSuperiorSetor[37]:=rTermoparSuperiorLeitura[37];
rTemperaturaSuperiorSetor[38]:=rTermoparSuperiorLeitura[38];
rTemperaturaSuperiorSetor[39]:=rTermoparSuperiorLeitura[39];
rTemperaturaSuperiorSetor[40]:=rTermoparSuperiorLeitura[40];

rTemperaturaSuperiorSetor[41]:=rTermoparSuperiorLeitura[41];
rTemperaturaSuperiorSetor[42]:=rTermoparSuperiorLeitura[42];
rTemperaturaSuperiorSetor[43]:=rTermoparSuperiorLeitura[43];
rTemperaturaSuperiorSetor[44]:=rTermoparSuperiorLeitura[44];
rTemperaturaSuperiorSetor[45]:=rTermoparSuperiorLeitura[45];
rTemperaturaSuperiorSetor[46]:=rTermoparSuperiorLeitura[46];
rTemperaturaSuperiorSetor[47]:=rTermoparSuperiorLeitura[47];
rTemperaturaSuperiorSetor[48]:=rTermoparSuperiorLeitura[48];
rTemperaturaSuperiorSetor[49]:=rTermoparSuperiorLeitura[49];
rTemperaturaSuperiorSetor[50]:=rTermoparSuperiorLeitura[50];



xReleSsrInferior[1]:=Q_xAquecimentoPwm1;
xReleSsrInferior[2]:=Q_xAquecimentoPwm2;
xReleSsrInferior[3]:=Q_xAquecimentoPwm3;
xReleSsrInferior[4]:=Q_xAquecimentoPwm4;
xReleSsrInferior[5]:=Q_xAquecimentoPwm5;
xReleSsrInferior[6]:=Q_xAquecimentoPwm6;
xReleSsrInferior[7]:=Q_xAquecimentoPwm7;
xReleSsrInferior[8]:=Q_xAquecimentoPwm8;
xReleSsrInferior[9]:=Q_xAquecimentoPwm9;
xReleSsrInferior[10]:=Q_xAquecimentoPwm10;

xReleSsrInferior[11]:=Q_xAquecimentoPwm11;
xReleSsrInferior[12]:=Q_xAquecimentoPwm12;
xReleSsrInferior[13]:=Q_xAquecimentoPwm13;
xReleSsrInferior[14]:=Q_xAquecimentoPwm14;
xReleSsrInferior[15]:=Q_xAquecimentoPwm15;
xReleSsrInferior[16]:=Q_xAquecimentoPwm16;
xReleSsrInferior[17]:=Q_xAquecimentoPwm17;
xReleSsrInferior[18]:=Q_xAquecimentoPwm18;
xReleSsrInferior[19]:=Q_xAquecimentoPwm19;
xReleSsrInferior[20]:=Q_xAquecimentoPwm20;

xReleSsrInferior[21]:=Q_xAquecimentoPwm21;
xReleSsrInferior[22]:=Q_xAquecimentoPwm22;
xReleSsrInferior[23]:=Q_xAquecimentoPwm23;
xReleSsrInferior[24]:=Q_xAquecimentoPwm24;
xReleSsrInferior[25]:=Q_xAquecimentoPwm25;
xReleSsrInferior[26]:=Q_xAquecimentoPwm26;
xReleSsrInferior[27]:=Q_xAquecimentoPwm27;
xReleSsrInferior[28]:=Q_xAquecimentoPwm28;
xReleSsrInferior[29]:=Q_xAquecimentoPwm29;
xReleSsrInferior[30]:=Q_xAquecimentoPwm30;

xReleSsrInferior[31]:=Q_xAquecimentoPwm31;
xReleSsrInferior[32]:=Q_xAquecimentoPwm32;
xReleSsrInferior[33]:=Q_xAquecimentoPwm33;
xReleSsrInferior[34]:=Q_xAquecimentoPwm34;
xReleSsrInferior[35]:=Q_xAquecimentoPwm35;
xReleSsrInferior[36]:=Q_xAquecimentoPwm36;
xReleSsrInferior[37]:=Q_xAquecimentoPwm37;
xReleSsrInferior[38]:=Q_xAquecimentoPwm38;
xReleSsrInferior[39]:=Q_xAquecimentoPwm39;
xReleSsrInferior[40]:=Q_xAquecimentoPwm40;

xReleSsrInferior[41]:=Q_xAquecimentoPwm41;
xReleSsrInferior[42]:=Q_xAquecimentoPwm42;
xReleSsrInferior[43]:=Q_xAquecimentoPwm43;
xReleSsrInferior[44]:=Q_xAquecimentoPwm44;
xReleSsrInferior[45]:=Q_xAquecimentoPwm45;
xReleSsrInferior[46]:=Q_xAquecimentoPwm46;
xReleSsrInferior[47]:=Q_xAquecimentoPwm47;
xReleSsrInferior[48]:=Q_xAquecimentoPwm48;
xReleSsrInferior[49]:=Q_xAquecimentoPwm49;
xReleSsrInferior[50]:=Q_xAquecimentoPwm50;


xReleSsrSuperior[1]:=Q_xAquecimentoPwm51;
xReleSsrSuperior[2]:=Q_xAquecimentoPwm52;
xReleSsrSuperior[3]:=Q_xAquecimentoPwm53;
xReleSsrSuperior[4]:=Q_xAquecimentoPwm54;
xReleSsrSuperior[5]:=Q_xAquecimentoPwm55;
xReleSsrSuperior[6]:=Q_xAquecimentoPwm56;
xReleSsrSuperior[7]:=Q_xAquecimentoPwm57;
xReleSsrSuperior[8]:=Q_xAquecimentoPwm58;
xReleSsrSuperior[9]:=Q_xAquecimentoPwm59;
xReleSsrSuperior[10]:=Q_xAquecimentoPwm60;

xReleSsrSuperior[11]:=Q_xAquecimentoPwm61;
xReleSsrSuperior[12]:=Q_xAquecimentoPwm62;
xReleSsrSuperior[13]:=Q_xAquecimentoPwm63;
xReleSsrSuperior[14]:=Q_xAquecimentoPwm64;
xReleSsrSuperior[15]:=Q_xAquecimentoPwm65;
xReleSsrSuperior[16]:=Q_xAquecimentoPwm66;
xReleSsrSuperior[17]:=Q_xAquecimentoPwm67;
xReleSsrSuperior[18]:=Q_xAquecimentoPwm68;
xReleSsrSuperior[19]:=Q_xAquecimentoPwm69;
xReleSsrSuperior[20]:=Q_xAquecimentoPwm70;

xReleSsrSuperior[21]:=Q_xAquecimentoPwm71;
xReleSsrSuperior[22]:=Q_xAquecimentoPwm72;
xReleSsrSuperior[23]:=Q_xAquecimentoPwm73;

xReleSsrSuperior[24]:=Q_xAquecimentoPwm74;

xReleSsrSuperior[25]:=Q_xAquecimentoPwm75;
xReleSsrSuperior[26]:=Q_xAquecimentoPwm76;
xReleSsrSuperior[27]:=Q_xAquecimentoPwm77;
xReleSsrSuperior[28]:=Q_xAquecimentoPwm78;
xReleSsrSuperior[29]:=Q_xAquecimentoPwm79;
xReleSsrSuperior[30]:=Q_xAquecimentoPwm80;

xReleSsrSuperior[31]:=Q_xAquecimentoPwm81;
xReleSsrSuperior[32]:=Q_xAquecimentoPwm82;
xReleSsrSuperior[33]:=Q_xAquecimentoPwm83;
xReleSsrSuperior[34]:=Q_xAquecimentoPwm84;
xReleSsrSuperior[35]:=Q_xAquecimentoPwm85;
xReleSsrSuperior[36]:=Q_xAquecimentoPwm86;
xReleSsrSuperior[37]:=Q_xAquecimentoPwm87;
xReleSsrSuperior[38]:=Q_xAquecimentoPwm88;
xReleSsrSuperior[39]:=Q_xAquecimentoPwm89;
xReleSsrSuperior[40]:=Q_xAquecimentoPwm90;

xReleSsrSuperior[41]:=Q_xAquecimentoPwm91;
xReleSsrSuperior[42]:=Q_xAquecimentoPwm92;
xReleSsrSuperior[43]:=Q_xAquecimentoPwm93;
xReleSsrSuperior[44]:=Q_xAquecimentoPwm94;
xReleSsrSuperior[45]:=Q_xAquecimentoPwm95;
xReleSsrSuperior[46]:=Q_xAquecimentoPwm96;
xReleSsrSuperior[47]:=Q_xAquecimentoPwm97;
xReleSsrSuperior[48]:=Q_xAquecimentoPwm98;
xReleSsrSuperior[49]:=Q_xAquecimentoPwm99;
xReleSsrSuperior[50]:=Q_xAquecimentoPwm100;

