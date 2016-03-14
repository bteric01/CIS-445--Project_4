length _UFormat $200;
drop _UFormat;
_UFormat='';
 
*------------------------------------------------------------*;
* Variable: Age;
*------------------------------------------------------------*;
LABEL GRP_Age =
'Grouped: Age';
 
if MISSING(Age) then do;
GRP_Age = 1;
end;
else if NOT MISSING(Age) then do;
if Age < 44 then do;
GRP_Age = 2;
end;
else
if 44 <= Age AND Age < 47 then do;
GRP_Age = 3;
end;
else
if 47 <= Age AND Age < 51 then do;
GRP_Age = 4;
end;
else
if 51 <= Age then do;
GRP_Age = 5;
end;
end;
 
*------------------------------------------------------------*;
* Variable: TotalArea;
*------------------------------------------------------------*;
LABEL GRP_TotalArea =
'Grouped: TotalArea';
 
if MISSING(TotalArea) then do;
GRP_TotalArea = 1;
end;
else if NOT MISSING(TotalArea) then do;
if TotalArea < 1154 then do;
GRP_TotalArea = 2;
end;
else
if 1154 <= TotalArea AND TotalArea < 1417 then do;
GRP_TotalArea = 3;
end;
else
if 1417 <= TotalArea AND TotalArea < 1584 then do;
GRP_TotalArea = 4;
end;
else
if 1584 <= TotalArea then do;
GRP_TotalArea = 5;
end;
end;
 
*------------------------------------------------------------*;
* Mean Cutoff Binary Transformation for Target;
*------------------------------------------------------------*;
if SalePrice = . then BIN_SalePrice = .;
else do;
   if SalePrice > 76154.12 then BIN_SalePrice=1;
   else BIN_SalePrice=0;
end;
label BIN_SalePrice = 'Binary: SalePrice';
