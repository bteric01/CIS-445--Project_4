*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;


drop _DM_BAD;
_DM_BAD=0;

*** Check Age for missing values ;
if missing( Age ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check Basement for missing values ;
if missing( Basement ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check Baths for missing values ;
if missing( Baths ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check FirePlace for missing values ;
if missing( FirePlace ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check FirstFloor for missing values ;
if missing( FirstFloor ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check GarageSize for missing values ;
if missing( GarageSize ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check SecondFloor for missing values ;
if missing( SecondFloor ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check TotalArea for missing values ;
if missing( TotalArea ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for BasementType ;
drop _0_0 _0_1 ;
if missing( BasementType ) then do;
   _0_0 = .;
   _0_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( BasementType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      _0_0 = -1;
      _0_1 = -1;
   end;
   else if _dm12 = '1'  then do;
      _0_0 = 0;
      _0_1 = 1;
   end;
   else if _dm12 = '0'  then do;
      _0_0 = 1;
      _0_1 = 0;
   end;
   else do;
      _0_0 = .;
      _0_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for CentralAir ;
drop _1_0 ;
if missing( CentralAir ) then do;
   _1_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( CentralAir , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      _1_0 = -1;
   end;
   else if _dm12 = '0'  then do;
      _1_0 = 1;
   end;
   else do;
      _1_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for ConstructionType ;
drop _2_0 _2_1 ;
if missing( ConstructionType ) then do;
   _2_0 = .;
   _2_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( ConstructionType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      _2_0 = 1;
      _2_1 = 0;
   end;
   else if _dm12 = '2'  then do;
      _2_0 = 0;
      _2_1 = 1;
   end;
   else if _dm12 = '3'  then do;
      _2_0 = -1;
      _2_1 = -1;
   end;
   else do;
      _2_0 = .;
      _2_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GarageType ;
drop _3_0 _3_1 _3_2 _3_3 _3_4 ;
*** encoding is sparse, initialize to zero;
_3_0 = 0;
_3_1 = 0;
_3_2 = 0;
_3_3 = 0;
_3_4 = 0;
if missing( GarageType ) then do;
   _3_0 = .;
   _3_1 = .;
   _3_2 = .;
   _3_3 = .;
   _3_4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GarageType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      _3_2 = 1;
   end;
   else if _dm12 = '0'  then do;
      _3_0 = 1;
   end;
   else if _dm12 = '3'  then do;
      _3_3 = 1;
   end;
   else if _dm12 = '1'  then do;
      _3_1 = 1;
   end;
   else if _dm12 = '4'  then do;
      _3_4 = 1;
   end;
   else if _dm12 = '5'  then do;
      _3_0 = -1;
      _3_1 = -1;
      _3_2 = -1;
      _3_3 = -1;
      _3_4 = -1;
   end;
   else do;
      _3_0 = .;
      _3_1 = .;
      _3_2 = .;
      _3_3 = .;
      _3_4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for LotSize ;
drop _4_0 ;
if missing( LotSize ) then do;
   _4_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( LotSize , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      _4_0 = 1;
   end;
   else if _dm12 = '3'  then do;
      _4_0 = -1;
   end;
   else do;
      _4_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for Neighborhood ;
drop _5_0 ;
if missing( Neighborhood ) then do;
   _5_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( Neighborhood , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      _5_0 = 1;
   end;
   else if _dm12 = '2'  then do;
      _5_0 = -1;
   end;
   else do;
      _5_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for WallType ;
drop _6_0 _6_1 ;
if missing( WallType ) then do;
   _6_0 = .;
   _6_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( WallType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      _6_0 = 0;
      _6_1 = 1;
   end;
   else if _dm12 = '1'  then do;
      _6_0 = 1;
      _6_1 = 0;
   end;
   else if _dm12 = '3'  then do;
      _6_0 = -1;
      _6_1 = -1;
   end;
   else do;
      _6_0 = .;
      _6_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _LP0 =              76715.8;
   goto REGDR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: Age ;
_TEMP = Age ;
_LP0 = _LP0 + (   -350.220891555292 * _TEMP);

***  Effect: Basement ;
_TEMP = Basement ;
_LP0 = _LP0 + (    0.55138033621828 * _TEMP);

***  Effect: BasementType ;
_TEMP = 1;
_LP0 = _LP0 + (   -8653.60581449876) * _TEMP * _0_0;
_LP0 = _LP0 + (    6658.09218979669) * _TEMP * _0_1;

***  Effect: Baths ;
_TEMP = Baths ;
_LP0 = _LP0 + (    1635.12149040632 * _TEMP);

***  Effect: CentralAir ;
_TEMP = 1;
_LP0 = _LP0 + (   -1397.54166271615) * _TEMP * _1_0;

***  Effect: ConstructionType ;
_TEMP = 1;
_LP0 = _LP0 + (   -14733.2621407772) * _TEMP * _2_0;
_LP0 = _LP0 + (    -10701.293990626) * _TEMP * _2_1;

***  Effect: FirePlace ;
_TEMP = FirePlace ;
_LP0 = _LP0 + (   -1111.75247869807 * _TEMP);

***  Effect: FirstFloor ;
_TEMP = FirstFloor ;
_LP0 = _LP0 + (    7.84443011026151 * _TEMP);

***  Effect: GarageSize ;
_TEMP = GarageSize ;
_LP0 = _LP0 + (     7103.3602556968 * _TEMP);

***  Effect: GarageType ;
_TEMP = 1;
_LP0 = _LP0 + (    6223.58510212181) * _TEMP * _3_0;
_LP0 = _LP0 + (   -3559.40689604525) * _TEMP * _3_1;
_LP0 = _LP0 + (     3502.5546108992) * _TEMP * _3_2;
_LP0 = _LP0 + (      10980.67500456) * _TEMP * _3_3;
_LP0 = _LP0 + (   -17981.2509877292) * _TEMP * _3_4;

***  Effect: LotSize ;
_TEMP = 1;
_LP0 = _LP0 + (   -2031.91352054267) * _TEMP * _4_0;

***  Effect: Neighborhood ;
_TEMP = 1;
_LP0 = _LP0 + (   -2099.21169910219) * _TEMP * _5_0;

***  Effect: SecondFloor ;
_TEMP = SecondFloor ;
_LP0 = _LP0 + (   -40.2996301538319 * _TEMP);

***  Effect: TotalArea ;
_TEMP = TotalArea ;
_LP0 = _LP0 + (    9.21079560283023 * _TEMP);

***  Effect: WallType ;
_TEMP = 1;
_LP0 = _LP0 + (   -2607.35681641369) * _TEMP * _6_0;
_LP0 = _LP0 + (   -1368.98360880173) * _TEMP * _6_1;
*--- Intercept ---*;
_LP0 = _LP0 + (    73302.4358950686);

REGDR1:

*** Predicted Value;
label P_SalePrice = 'Predicted: SalePrice' ;
P_SalePrice = _LP0;


*************************************;
***** end scoring code for regression;
*************************************;
