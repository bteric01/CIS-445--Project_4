***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_Age = 'Standard: Age' ;

      label S_Basement = 'Standard: Basement' ;

      label S_Baths = 'Standard: Baths' ;

      label S_FirePlace = 'Standard: FirePlace' ;

      label S_FirstFloor = 'Standard: FirstFloor' ;

      label S_GarageSize = 'Standard: GarageSize' ;

      label S_SecondFloor = 'Standard: SecondFloor' ;

      label S_TotalArea = 'Standard: TotalArea' ;

      label S_UpperArea = 'Standard: UpperArea' ;

      label CentralAir0 = 'Dummy: CentralAir=0' ;

      label BasementType0 = 'Dummy: BasementType=0' ;

      label BasementType1 = 'Dummy: BasementType=1' ;

      label ConstructionType1 = 'Dummy: ConstructionType=1' ;

      label ConstructionType2 = 'Dummy: ConstructionType=2' ;

      label GarageType0 = 'Dummy: GarageType=0' ;

      label GarageType1 = 'Dummy: GarageType=1' ;

      label GarageType2 = 'Dummy: GarageType=2' ;

      label GarageType3 = 'Dummy: GarageType=3' ;

      label GarageType4 = 'Dummy: GarageType=4' ;

      label LotSize1 = 'Dummy: LotSize=1' ;

      label Neighborhood1 = 'Dummy: Neighborhood=1' ;

      label WallType1 = 'Dummy: WallType=1' ;

      label WallType2 = 'Dummy: WallType=2' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label P_SalePrice = 'Predicted: SalePrice' ;

      label R_SalePrice = 'Residual: SalePrice' ;

      label  _WARN_ = "Warnings";

*** Generate dummy variables for CentralAir ;
drop CentralAir0 ;
if missing( CentralAir ) then do;
   CentralAir0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( CentralAir , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      CentralAir0 = -1;
   end;
   else if _dm12 = '0'  then do;
      CentralAir0 = 1;
   end;
   else do;
      CentralAir0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for BasementType ;
drop BasementType0 BasementType1 ;
if missing( BasementType ) then do;
   BasementType0 = .;
   BasementType1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( BasementType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      BasementType0 = -1;
      BasementType1 = -1;
   end;
   else if _dm12 = '1'  then do;
      BasementType0 = 0;
      BasementType1 = 1;
   end;
   else if _dm12 = '0'  then do;
      BasementType0 = 1;
      BasementType1 = 0;
   end;
   else do;
      BasementType0 = .;
      BasementType1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for ConstructionType ;
drop ConstructionType1 ConstructionType2 ;
if missing( ConstructionType ) then do;
   ConstructionType1 = .;
   ConstructionType2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( ConstructionType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      ConstructionType1 = 1;
      ConstructionType2 = 0;
   end;
   else if _dm12 = '2'  then do;
      ConstructionType1 = 0;
      ConstructionType2 = 1;
   end;
   else if _dm12 = '3'  then do;
      ConstructionType1 = -1;
      ConstructionType2 = -1;
   end;
   else do;
      ConstructionType1 = .;
      ConstructionType2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GarageType ;
drop GarageType0 GarageType1 GarageType2 GarageType3 GarageType4 ;
*** encoding is sparse, initialize to zero;
GarageType0 = 0;
GarageType1 = 0;
GarageType2 = 0;
GarageType3 = 0;
GarageType4 = 0;
if missing( GarageType ) then do;
   GarageType0 = .;
   GarageType1 = .;
   GarageType2 = .;
   GarageType3 = .;
   GarageType4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GarageType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      GarageType2 = 1;
   end;
   else if _dm12 = '0'  then do;
      GarageType0 = 1;
   end;
   else if _dm12 = '3'  then do;
      GarageType3 = 1;
   end;
   else if _dm12 = '1'  then do;
      GarageType1 = 1;
   end;
   else if _dm12 = '4'  then do;
      GarageType4 = 1;
   end;
   else if _dm12 = '5'  then do;
      GarageType0 = -1;
      GarageType1 = -1;
      GarageType2 = -1;
      GarageType3 = -1;
      GarageType4 = -1;
   end;
   else do;
      GarageType0 = .;
      GarageType1 = .;
      GarageType2 = .;
      GarageType3 = .;
      GarageType4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for LotSize ;
drop LotSize1 ;
if missing( LotSize ) then do;
   LotSize1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( LotSize , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      LotSize1 = 1;
   end;
   else if _dm12 = '3'  then do;
      LotSize1 = -1;
   end;
   else do;
      LotSize1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for Neighborhood ;
drop Neighborhood1 ;
if missing( Neighborhood ) then do;
   Neighborhood1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( Neighborhood , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      Neighborhood1 = 1;
   end;
   else if _dm12 = '2'  then do;
      Neighborhood1 = -1;
   end;
   else do;
      Neighborhood1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for WallType ;
drop WallType1 WallType2 ;
if missing( WallType ) then do;
   WallType1 = .;
   WallType2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( WallType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      WallType1 = 0;
      WallType2 = 1;
   end;
   else if _dm12 = '1'  then do;
      WallType1 = 1;
      WallType2 = 0;
   end;
   else if _dm12 = '3'  then do;
      WallType1 = -1;
      WallType2 = -1;
   end;
   else do;
      WallType1 = .;
      WallType2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   Age ,
   Basement ,
   Baths ,
   FirePlace ,
   FirstFloor ,
   GarageSize ,
   SecondFloor ,
   TotalArea ,
   UpperArea   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_Age  =     -5.5344062379496 +     0.11558244339661 * Age ;
   S_Basement  =    -0.49282257208576 +     0.00345263917246 * Basement ;
   S_Baths  =    -1.73164257267769 +     1.06846031080112 * Baths ;
   S_FirePlace  =    -2.05904915846369 +     2.38849702381788 * FirePlace ;
   S_FirstFloor  =    -5.24475132970949 +     0.00504868813728 * FirstFloor ;
   S_GarageSize  =    -1.91179006286296 +     1.80006207217616 * GarageSize ;
   S_SecondFloor  =    -0.32848444737012 +      0.0038758438334 * SecondFloor
         ;
   S_TotalArea  =    -4.17820497934562 +     0.00290463340639 * TotalArea ;
   S_UpperArea  =    -1.27983222733868 +      0.0040645612494 * UpperArea ;
END;
ELSE DO;
   IF MISSING( Age ) THEN S_Age  = . ;
   ELSE S_Age  =     -5.5344062379496 +     0.11558244339661 * Age ;
   IF MISSING( Basement ) THEN S_Basement  = . ;
   ELSE S_Basement  =    -0.49282257208576 +     0.00345263917246 * Basement ;
   IF MISSING( Baths ) THEN S_Baths  = . ;
   ELSE S_Baths  =    -1.73164257267769 +     1.06846031080112 * Baths ;
   IF MISSING( FirePlace ) THEN S_FirePlace  = . ;
   ELSE S_FirePlace  =    -2.05904915846369 +     2.38849702381788 * FirePlace
         ;
   IF MISSING( FirstFloor ) THEN S_FirstFloor  = . ;
   ELSE S_FirstFloor  =    -5.24475132970949 +     0.00504868813728 *
        FirstFloor ;
   IF MISSING( GarageSize ) THEN S_GarageSize  = . ;
   ELSE S_GarageSize  =    -1.91179006286296 +     1.80006207217616 *
        GarageSize ;
   IF MISSING( SecondFloor ) THEN S_SecondFloor  = . ;
   ELSE S_SecondFloor  =    -0.32848444737012 +      0.0038758438334 *
        SecondFloor ;
   IF MISSING( TotalArea ) THEN S_TotalArea  = . ;
   ELSE S_TotalArea  =    -4.17820497934562 +     0.00290463340639 * TotalArea
         ;
   IF MISSING( UpperArea ) THEN S_UpperArea  = . ;
   ELSE S_UpperArea  =    -1.27983222733868 +      0.0040645612494 * UpperArea
         ;
END;
*** *************************;
*** Writing the Node bin ;
*** *************************;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =      1.0811253570757 * S_Age  +     1.03792758537926 * S_Basement
          +    -2.69045458789429 * S_Baths  +    -2.58989113774345 *
        S_FirePlace  +     0.54830269811199 * S_FirstFloor
          +    -0.60146709273223 * S_GarageSize  +    -3.01068259484666 *
        S_SecondFloor  +    -1.75346426289405 * S_TotalArea
          +      0.1066594151471 * S_UpperArea ;
   H12  =     10.6056539724815 * S_Age  +    -2.31341855571048 * S_Basement
          +    -5.99788787502048 * S_Baths  +    -7.38334355297016 *
        S_FirePlace  +     1.05929143867278 * S_FirstFloor
          +    -2.72023121554838 * S_GarageSize  +    -3.75486868145665 *
        S_SecondFloor  +    -0.99588977048035 * S_TotalArea
          +     1.76027618533929 * S_UpperArea ;
   H13  =    -5.18859194462977 * S_Age  +    -0.37443474477444 * S_Basement
          +    -1.37099088047079 * S_Baths  +     -4.5197296446296 *
        S_FirePlace  +     2.34785274542451 * S_FirstFloor
          +     4.91553880125009 * S_GarageSize  +    -5.96160235964927 *
        S_SecondFloor  +    -0.36486914085505 * S_TotalArea
          +     4.36128438585689 * S_UpperArea ;
   H11  = H11  +     1.81926634733339 * CentralAir0 ;
   H12  = H12  +    -4.86126336764882 * CentralAir0 ;
   H13  = H13  +    -0.20065363380592 * CentralAir0 ;
   H11  = H11  +    -0.42553110742708 * BasementType0
          +     -2.8152494816675 * BasementType1  +    -2.28800421986934 *
        ConstructionType1  +    -3.68075682437434 * ConstructionType2
          +     0.66684549722599 * GarageType0  +     2.64229318877201 *
        GarageType1  +    -4.22584793258938 * GarageType2
          +    -5.84767011261514 * GarageType3  +     4.95381912857559 *
        GarageType4  +     2.81453134363659 * LotSize1
          +     0.84606045489123 * Neighborhood1  +     1.12668276015835 *
        WallType1  +     -1.6341125215042 * WallType2 ;
   H12  = H12  +     0.23390059615897 * BasementType0
          +     2.37386797364588 * BasementType1  +     3.08814617928987 *
        ConstructionType1  +     0.20121260732449 * ConstructionType2
          +     0.04617179753954 * GarageType0  +    -1.55515822727314 *
        GarageType1  +     1.59582509860167 * GarageType2
          +    -0.59394988854609 * GarageType3  +     0.53166320240066 *
        GarageType4  +    -0.19668617489595 * LotSize1
          +     0.74452834064345 * Neighborhood1  +    -0.33856071263169 *
        WallType1  +     0.06345085758378 * WallType2 ;
   H13  = H13  +    -8.07933326269018 * BasementType0
          +     7.36156027392192 * BasementType1  +    -9.59373504486629 *
        ConstructionType1  +    -12.3677256166013 * ConstructionType2
          +     2.78825055889834 * GarageType0  +     3.79270710138806 *
        GarageType1  +     1.22833780125341 * GarageType2
          +     0.29971745302098 * GarageType3  +    -0.68441599424622 *
        GarageType4  +     2.77468836460675 * LotSize1
          +    -1.03164722246083 * Neighborhood1  +    -5.52469784074927 *
        WallType1  +      -3.976976433923 * WallType2 ;
   H11  =     1.60222125420424 + H11 ;
   H12  =    -2.23039981030315 + H12 ;
   H13  =      8.3867095651232 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node intervalTargets ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_SalePrice  =    -6005.49431992348 * H11  +    -1039.27897944343 * H12
          +     2531.16212071821 * H13 ;
   P_SalePrice  =     77287.1480354503 + P_SalePrice ;
END;
ELSE DO;
   P_SalePrice  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_SalePrice  =              76715.8;
END;
*** *****************************;
*** Writing the Residuals  of the Node intervalTargets ;
*** ******************************;
IF MISSING( SalePrice ) THEN R_SalePrice  = . ;
ELSE R_SalePrice  = SalePrice  - P_SalePrice ;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
H11
H12
H13
;
drop S_:;
