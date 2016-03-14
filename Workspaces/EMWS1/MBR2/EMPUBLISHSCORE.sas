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
%macro EM_MBR2;
%let _MBRTRAIN = EMSCORE.EM_TRAIN_MBR2;
%if %symexist(em_train) %then %do;
%let _MBRTRAIN = EMWS1.BINNING_TRAIN;
%end;
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
proc dmdb batch data=&_MBRTRAIN
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
%let _vvnoption = %sysfunc(getoption(VALIDVARNAME));
%if &_vvnoption = ANY and ^%symexist(em_train) %then %do;
data em_MBR2;
set &em_score_output;
run;
data &em_score_output;
set &em_score_output;
keep %pmbrvar;
run;
%end;
options validvarname=V7;
%if ^%symexist(em_train) %then %do;
proc pmbr data=&_MBRTRAIN dmdbcat=WORK.MBR2_DMDB %end;
%else %do;
proc pmbr data=EMWS1.BINNING_TRAIN dmdbcat=WORK.MBR2_DMDB %end;
k = 10
epsilon = 0
buckets = 8
method = RDTREE
weighted
neighbors
;
var %pmbrvar;
target SalePrice;
score data=&em_score_output out=&em_score_output role=score;
;
id _dataobs_;
run;
quit;
options validvarname=&_vvnoption;
%if &_vvnoption = ANY and ^%symexist(em_train) %then %do;
data &em_score_output;
merge em_MBR2 &em_score_output;
run;
proc delete data=em_MBR2;
run;
%end;
%mend EM_MBR2;
%EM_MBR2;
