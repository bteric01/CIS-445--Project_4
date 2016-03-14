*------------------------------------------------------------*;
* MBR2: Create decision matrix;
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
*------------------------------------------------------------* ;
* MBR2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* MBR2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    GarageSize SalePrice
%mend DMDBVar;
*------------------------------------------------------------*;
* MBR2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.BINNING_TRAIN
dmdbcat=WORK.MBR2_DMDB
maxlevel = 513
;
id
_dataobs_
;
var %DMDBVar;
target
SalePrice
;
run;
quit;
*------------------------------------------------------------* ;
* MBR2: Interval Variables Macro ;
*------------------------------------------------------------* ;
%macro pmbrvar;
    GarageSize
%mend pmbrvar;
proc pmbr data=EMWS1.BINNING_TRAIN dmdbcat=WORK.MBR2_DMDB
validata = EMWS1.BINNING_VALIDATE
testdata = EMWS1.BINNING_TEST
outest = EMWS1.MBR2_ESTIMATE
k = 10
epsilon = 0
buckets = 8
method = RDTREE
weighted
neighbors
;
var %pmbrvar;
target SalePrice;
score data=EMWS1.BINNING_TRAIN
out=EMWS1.MBR2_TRAIN
role = TRAIN
;
id _dataobs_;
run;
quit;
*------------------------------------------------------------* ;
* MBR2: Interval Variables Macro ;
*------------------------------------------------------------* ;
%macro pmbrvar;
    GarageSize
%mend pmbrvar;
proc pmbr data=EMWS1.BINNING_TRAIN dmdbcat=WORK.MBR2_DMDB
outest = WORK.MBR2_OUTEST
k = 10
epsilon = 0
buckets = 8
method = RDTREE
weighted
neighbors
;
var %pmbrvar;
target SalePrice;
score data=EMWS1.BINNING_VALIDATE
out=EMWS1.MBR2_VALIDATE
role = VALID
;
id _dataobs_;
run;
quit;
*------------------------------------------------------------* ;
* MBR2: Interval Variables Macro ;
*------------------------------------------------------------* ;
%macro pmbrvar;
    GarageSize
%mend pmbrvar;
proc pmbr data=EMWS1.BINNING_TRAIN dmdbcat=WORK.MBR2_DMDB
outest = WORK.MBR2_OUTEST
k = 10
epsilon = 0
buckets = 8
method = RDTREE
weighted
neighbors
;
var %pmbrvar;
target SalePrice;
score data=EMWS1.BINNING_TEST
out=EMWS1.MBR2_TEST
role = TEST
;
id _dataobs_;
run;
quit;
