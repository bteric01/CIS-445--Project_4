 
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
