 
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
