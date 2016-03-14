*------------------------------------------------------------*;
* Reg2: Create decision matrix;
*------------------------------------------------------------*;
data WORK.SalePrice(label="SalePrice");
  length   SalePrice                            8
           ;

  label    SalePrice="SalePrice"
           ;
 SalePrice=49539;
output;
 SalePrice=121984;
output;
 SalePrice=76154.1162790697;
output;
;
run;
proc datasets lib=work nolist;
modify SalePrice(type=PROFIT label=SalePrice);
run;
quit;
data EM_DMREG / view=EM_DMREG;
set EMWS1.BINNING_TRAIN(keep=
GRP_Age GRP_TotalArea SalePrice);
run;
*------------------------------------------------------------* ;
* Reg2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    GRP_Age(ASC) GRP_TotalArea(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    SalePrice
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg2_DMDB
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
* Reg2: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg2_DMDB
validata = EMWS1.BINNING_VALIDATE
outest = EMWS1.Reg2_EMESTIMATE
outterms = EMWS1.Reg2_OUTTERMS
outmap= EMWS1.Reg2_MAPDS namelen=200
;
class
GRP_Age
GRP_TotalArea
;
model SalePrice =
GRP_Age
GRP_TotalArea
/error=normal
coding=DEVIATION
nodesignprint
;
;
score data=EMWS1.BINNING_TEST
out=_null_
outfit=EMWS1.Reg2_FITTEST
role = TEST
;
code file="C:\Users\bteric01\Documents\Tutorials_Projects\Project_4\Workspaces\EMWS1\Reg2\EMPUBLISHSCORE.sas"
group=Reg2
;
code file="C:\Users\bteric01\Documents\Tutorials_Projects\Project_4\Workspaces\EMWS1\Reg2\EMFLOWSCORE.sas"
group=Reg2
residual
;
run;
quit;
