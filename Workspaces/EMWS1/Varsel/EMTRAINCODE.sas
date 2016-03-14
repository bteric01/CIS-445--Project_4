*------------------------------------------------------------* ;
* EM: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    BasementType(ASC) CentralAir(ASC) ConstructionType(ASC) GarageType(ASC)
   LotSize(ASC) Neighborhood(ASC) WallType(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* EM: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    Age Basement Baths FirePlace FirstFloor GarageSize SalePrice SecondFloor
   TotalArea UpperArea
%mend DMDBVar;
*------------------------------------------------------------*;
* EM: Create DMDB;
*------------------------------------------------------------*;
libname _spdslib SPDE "C:\Users\bteric01\AppData\Local\Temp\SAS Temporary Files\_TD4112_COB-IT-M13_\Prc2";
proc dmdb batch data=EMWS1.Filter_TRAIN
dmdbcat=WORK.EM_DMDB
maxlevel = 101
out=_spdslib.EM_DMDB
;
class %DMDBClass;
var %DMDBVar;
target
SalePrice
;
run;
quit;
*------------------------------------------------------------* ;
* Varsel: Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INPUTS;
               AGE BASEMENT BASEMENTTYPE BATHS CENTRALAIR CONSTRUCTIONTYPE FIREPLACE
              FirstFloor GARAGESIZE GARAGETYPE LOTSIZE NEIGHBORHOOD SECONDFLOOR TOTALAREA
   UpperArea WALLTYPE
%mend INPUTS;
proc dmine data=_spdslib.EM_DMDB dmdbcat=WORK.EM_DMDB
minr2=0.005 maxrows=3000 stopr2=0.0005 NOAOV16 NOINTER USEGROUPS OUTGROUP=EMWS1.Varsel_OUTGROUP outest=EMWS1.Varsel_OUTESTDMINE outeffect=EMWS1.Varsel_OUTEFFECT outrsquare =EMWS1.Varsel_OUTRSQUARE
NOMONITOR
PSHORT
;
var %INPUTS;
target SalePrice;
code file="C:\Users\bteric01\Documents\Tutorials_Projects\Project_4\Workspaces\EMWS1\Varsel\EMFLOWSCORE.sas";
code file="C:\Users\bteric01\Documents\Tutorials_Projects\Project_4\Workspaces\EMWS1\Varsel\EMPUBLISHSCORE.sas";
run;
quit;
/*      proc print data =EMWS1.Varsel_OUTEFFECT;      proc print data =EMWS1.Varsel_OUTRSQUARE;      */
run;
