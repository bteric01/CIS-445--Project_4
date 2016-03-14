*------------------------------------------------------------*;
* MBR: Create decision matrix;
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
%macro EM_MBR;
%let _MBRTRAIN = EMSCORE.EM_TRAIN_MBR;
%if %symexist(em_train) %then %do;
%let _MBRTRAIN = EMWS1.Part_TRAIN;
%end;
*------------------------------------------------------------* ;
* MBR: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* MBR: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    Age Basement Baths FirePlace FirstFloor GarageSize SalePrice SecondFloor
   TotalArea UpperArea
%mend DMDBVar;
*------------------------------------------------------------*;
* MBR: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=&_MBRTRAIN
dmdbcat=WORK.MBR_DMDB
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
* MBR: Interval Variables Macro ;
*------------------------------------------------------------* ;
%macro pmbrvar;
    Age Basement Baths FirePlace FirstFloor GarageSize SecondFloor TotalArea
   UpperArea
%mend pmbrvar;
%let _vvnoption = %sysfunc(getoption(VALIDVARNAME));
%if &_vvnoption = ANY and ^%symexist(em_train) %then %do;
data em_MBR;
set &em_score_output;
run;
data &em_score_output;
set &em_score_output;
keep %pmbrvar;
run;
%end;
options validvarname=V7;
%if ^%symexist(em_train) %then %do;
proc pmbr data=&_MBRTRAIN dmdbcat=WORK.MBR_DMDB %end;
%else %do;
proc pmbr data=EMWS1.Part_TRAIN dmdbcat=WORK.MBR_DMDB %end;
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
merge em_MBR &em_score_output;
run;
proc delete data=em_MBR;
run;
%end;
%mend EM_MBR;
%EM_MBR;
