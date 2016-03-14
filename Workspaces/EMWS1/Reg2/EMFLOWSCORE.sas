*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

drop _Y;
_Y = SalePrice ;

drop _DM_BAD;
_DM_BAD=0;

*** Generate dummy variables for GRP_Age ;
drop _0_0 _0_1 _0_2 ;
if missing( GRP_Age ) then do;
   _0_0 = .;
   _0_1 = .;
   _0_2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_Age , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '5'  then do;
      _0_0 = -1;
      _0_1 = -1;
      _0_2 = -1;
   end;
   else if _dm12 = '4'  then do;
      _0_0 = 0;
      _0_1 = 0;
      _0_2 = 1;
   end;
   else if _dm12 = '2'  then do;
      _0_0 = 1;
      _0_1 = 0;
      _0_2 = 0;
   end;
   else if _dm12 = '3'  then do;
      _0_0 = 0;
      _0_1 = 1;
      _0_2 = 0;
   end;
   else do;
      _0_0 = .;
      _0_1 = .;
      _0_2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_TotalArea ;
drop _1_0 _1_1 _1_2 ;
if missing( GRP_TotalArea ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_TotalArea , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '5'  then do;
      _1_0 = -1;
      _1_1 = -1;
      _1_2 = -1;
   end;
   else if _dm12 = '4'  then do;
      _1_0 = 0;
      _1_1 = 0;
      _1_2 = 1;
   end;
   else if _dm12 = '3'  then do;
      _1_0 = 0;
      _1_1 = 1;
      _1_2 = 0;
   end;
   else if _dm12 = '2'  then do;
      _1_0 = 1;
      _1_1 = 0;
      _1_2 = 0;
   end;
   else do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _LP0 =     76154.1162790697;
   goto REG2DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: GRP_Age ;
_TEMP = 1;
_LP0 = _LP0 + (    3740.00871588535) * _TEMP * _0_0;
_LP0 = _LP0 + (    3993.74797883115) * _TEMP * _0_1;
_LP0 = _LP0 + (   -2388.76654325065) * _TEMP * _0_2;

***  Effect: GRP_TotalArea ;
_TEMP = 1;
_LP0 = _LP0 + (   -6300.07096725163) * _TEMP * _1_0;
_LP0 = _LP0 + (    -2786.2334563659) * _TEMP * _1_1;
_LP0 = _LP0 + (   -1051.43529071128) * _TEMP * _1_2;
*--- Intercept ---*;
_LP0 = _LP0 + (     76238.833357283);

REG2DR1:

*** Predicted Value, Error, and Residual;
label P_SalePrice = 'Predicted: SalePrice' ;
P_SalePrice = _LP0;

drop _R;
if _Y = . then do;
   R_SalePrice = .;
end;
else do;
   _R = _Y - _LP0;
    label R_SalePrice = 'Residual: SalePrice' ;
   R_SalePrice = _R;
end;

*************************************;
***** end scoring code for regression;
*************************************;
