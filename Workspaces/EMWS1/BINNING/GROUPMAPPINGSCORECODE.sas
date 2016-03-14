 length _LABEL_ $200;
 label _LABEL_="%sysfunc(sasmsg(sashelp.dmine, rpt_groupvalues_vlabel , NOQUOTE))";
 
if DISPLAY_VAR='Age' and _GROUP_ = 2 then do;
_LABEL_='Age< 44';
UB=44;
end;
else
if DISPLAY_VAR='Age' and _GROUP_ = 3 then do;
_LABEL_='44<= Age< 47';
UB=47;
end;
else
if DISPLAY_VAR='Age' and _GROUP_ = 4 then do;
_LABEL_='47<= Age< 51';
UB=51;
end;
else
if DISPLAY_VAR='Age' and _GROUP_ = 5 then do;
_LABEL_='51<= Age';
UB=.;
end;
 
if DISPLAY_VAR='Baths' and _GROUP_ = 2 then do;
_LABEL_='Baths< 1';
UB=1;
end;
else
if DISPLAY_VAR='Baths' and _GROUP_ = 3 then do;
_LABEL_='1<= Baths< 2';
UB=2;
end;
else
if DISPLAY_VAR='Baths' and _GROUP_ = 4 then do;
_LABEL_='2<= Baths';
UB=.;
end;
 
if DISPLAY_VAR='FirePlace' and _GROUP_ = 2 then do;
_LABEL_='FirePlace< 1';
UB=1;
end;
else
if DISPLAY_VAR='FirePlace' and _GROUP_ = 3 then do;
_LABEL_='1<= FirePlace';
UB=.;
end;
 
if DISPLAY_VAR='GarageSize' and _GROUP_ = 2 then do;
_LABEL_='GarageSize< 1';
UB=1;
end;
else
if DISPLAY_VAR='GarageSize' and _GROUP_ = 3 then do;
_LABEL_='1<= GarageSize';
UB=.;
end;
 
if DISPLAY_VAR='SecondFloor' and _GROUP_ = 2 then do;
_LABEL_='SecondFloor< 0';
UB=0;
end;
else
if DISPLAY_VAR='SecondFloor' and _GROUP_ = 3 then do;
_LABEL_='0<= SecondFloor';
UB=.;
end;
 
if DISPLAY_VAR='TotalArea' and _GROUP_ = 2 then do;
_LABEL_='TotalArea< 1154';
UB=1154;
end;
else
if DISPLAY_VAR='TotalArea' and _GROUP_ = 3 then do;
_LABEL_='1154<= TotalArea< 1417';
UB=1417;
end;
else
if DISPLAY_VAR='TotalArea' and _GROUP_ = 4 then do;
_LABEL_='1417<= TotalArea< 1584';
UB=1584;
end;
else
if DISPLAY_VAR='TotalArea' and _GROUP_ = 5 then do;
_LABEL_='1584<= TotalArea';
UB=.;
end;
 
if DISPLAY_VAR='CentralAir' and _GROUP_ = 2 then
_LABEL_='1';
else
if DISPLAY_VAR='CentralAir' and _GROUP_ = 3 then
_LABEL_='0';
 
if DISPLAY_VAR='ConstructionType' and _GROUP_ = 2 then
_LABEL_='1';
else
if DISPLAY_VAR='ConstructionType' and _GROUP_ = 3 then
_LABEL_='2';
else
if DISPLAY_VAR='ConstructionType' and _GROUP_ = 4 then
_LABEL_='3';
 
if DISPLAY_VAR='G_BasementType' and _GROUP_ = 2 then
_LABEL_='1';
else
if DISPLAY_VAR='G_BasementType' and _GROUP_ = 3 then
_LABEL_='0';
 
if DISPLAY_VAR='G_GarageType' and _GROUP_ = 2 then
_LABEL_='2';
else
if DISPLAY_VAR='G_GarageType' and _GROUP_ = 3 then
_LABEL_='0';
else
if DISPLAY_VAR='G_GarageType' and _GROUP_ = 4 then
_LABEL_='1';
 
if DISPLAY_VAR='WallType' and _GROUP_ = 2 then
_LABEL_='2';
else
if DISPLAY_VAR='WallType' and _GROUP_ = 3 then
_LABEL_='1';
else
if DISPLAY_VAR='WallType' and _GROUP_ = 4 then
_LABEL_='3';
