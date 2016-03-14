*------------------------------------------------------------*;
* Reg: Create decision matrix;
*------------------------------------------------------------*;
data WORK.SalePrice(label="SalePrice");
  length   SalePrice                            8
           ;

  label    SalePrice="SalePrice"
           ;
 SalePrice=5014;
output;
 SalePrice=121984;
output;
 SalePrice=76715.8;
output;
;
run;
proc datasets lib=work nolist;
modify SalePrice(type=PROFIT label=SalePrice);
run;
quit;
data EM_DMREG / view=EM_DMREG;
set EMWS1.Part_TRAIN(keep=
Age Basement BasementType Baths CentralAir ConstructionType FirePlace
FirstFloor GarageSize GarageType LotSize Neighborhood SalePrice SecondFloor
TotalArea UpperArea WallType);
run;
*------------------------------------------------------------* ;
* Reg: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    BasementType(ASC) CentralAir(ASC) ConstructionType(ASC) GarageType(ASC)
   LotSize(ASC) Neighborhood(ASC) WallType(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    Age Basement Baths FirePlace FirstFloor GarageSize SalePrice SecondFloor
   TotalArea UpperArea
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
SalePrice
;
run;
quit;
*------------------------------------------------------------*;
* Reg: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg_DMDB
validata = EMWS1.Part_VALIDATE
outest = EMWS1.Reg_EMESTIMATE
outterms = EMWS1.Reg_OUTTERMS
outmap= EMWS1.Reg_MAPDS namelen=200
;
class
BasementType
CentralAir
ConstructionType
GarageType
LotSize
Neighborhood
WallType
;
model SalePrice =
Age
Basement
BasementType
Baths
CentralAir
ConstructionType
FirePlace
FirstFloor
GarageSize
GarageType
LotSize
Neighborhood
SecondFloor
TotalArea
UpperArea
WallType
/error=normal
coding=DEVIATION
nodesignprint
;
;
score data=EMWS1.Part_TEST
out=_null_
outfit=EMWS1.Reg_FITTEST
role = TEST
;
code file="C:\Users\bteric01\Documents\Tutorials_Projects\Project_4\Workspaces\EMWS1\Reg\EMPUBLISHSCORE.sas"
group=Reg
;
code file="C:\Users\bteric01\Documents\Tutorials_Projects\Project_4\Workspaces\EMWS1\Reg\EMFLOWSCORE.sas"
group=Reg
residual
;
run;
quit;
