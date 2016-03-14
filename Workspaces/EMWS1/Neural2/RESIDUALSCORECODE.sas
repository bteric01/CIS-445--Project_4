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
      label GRP_Age2 = 'Dummy: GRP_Age=2' ;

      label GRP_Age3 = 'Dummy: GRP_Age=3' ;

      label GRP_Age4 = 'Dummy: GRP_Age=4' ;

      label GRP_TotalArea2 = 'Dummy: GRP_TotalArea=2' ;

      label GRP_TotalArea3 = 'Dummy: GRP_TotalArea=3' ;

      label GRP_TotalArea4 = 'Dummy: GRP_TotalArea=4' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label P_SalePrice = 'Predicted: SalePrice' ;

      label R_SalePrice = 'Residual: SalePrice' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for GRP_Age ;
drop GRP_Age2 GRP_Age3 GRP_Age4 ;
if missing( GRP_Age ) then do;
   GRP_Age2 = .;
   GRP_Age3 = .;
   GRP_Age4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_Age , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '5'  then do;
      GRP_Age2 = 0.63245553203367;
      GRP_Age3 = 0.63245553203367;
      GRP_Age4 = 0.63245553203367;
   end;
   else if _dm12 = '4'  then do;
      GRP_Age2 = 0.63245553203367;
      GRP_Age3 = 0.63245553203367;
      GRP_Age4 = -0.63245553203367;
   end;
   else if _dm12 = '2'  then do;
      GRP_Age2 = -0.63245553203367;
      GRP_Age3 = -0.63245553203367;
      GRP_Age4 = -0.63245553203367;
   end;
   else if _dm12 = '3'  then do;
      GRP_Age2 = 0.63245553203367;
      GRP_Age3 = -0.63245553203367;
      GRP_Age4 = -0.63245553203367;
   end;
   else do;
      GRP_Age2 = .;
      GRP_Age3 = .;
      GRP_Age4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_TotalArea ;
drop GRP_TotalArea2 GRP_TotalArea3 GRP_TotalArea4 ;
if missing( GRP_TotalArea ) then do;
   GRP_TotalArea2 = .;
   GRP_TotalArea3 = .;
   GRP_TotalArea4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_TotalArea , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '5'  then do;
      GRP_TotalArea2 = 0.63245553203367;
      GRP_TotalArea3 = 0.63245553203367;
      GRP_TotalArea4 = 0.63245553203367;
   end;
   else if _dm12 = '4'  then do;
      GRP_TotalArea2 = 0.63245553203367;
      GRP_TotalArea3 = 0.63245553203367;
      GRP_TotalArea4 = -0.63245553203367;
   end;
   else if _dm12 = '3'  then do;
      GRP_TotalArea2 = 0.63245553203367;
      GRP_TotalArea3 = -0.63245553203367;
      GRP_TotalArea4 = -0.63245553203367;
   end;
   else if _dm12 = '2'  then do;
      GRP_TotalArea2 = -0.63245553203367;
      GRP_TotalArea3 = -0.63245553203367;
      GRP_TotalArea4 = -0.63245553203367;
   end;
   else do;
      GRP_TotalArea2 = .;
      GRP_TotalArea3 = .;
      GRP_TotalArea4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
*** *************************;
*** Writing the Node ord ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =  1.0000000827403E-10 * GRP_Age2  +  1.0000000827403E-10 * GRP_Age3
          +     18.9559961302211 * GRP_Age4  +  1.0000000827403E-10 * 
        GRP_TotalArea2  +     14.7725771784866 * GRP_TotalArea3
          +      82.296259261635 * GRP_TotalArea4 ;
   H12  =     3.15340711708705 * GRP_Age2  +      7.7019890208257 * GRP_Age3
          +  1.0000000827403E-10 * GRP_Age4  +     19.1423937009409 * 
        GRP_TotalArea2  +  1.0000000827403E-10 * GRP_TotalArea3
          +     16.0556035718679 * GRP_TotalArea4 ;
   H13  =      159.41309684645 * GRP_Age2  +     235.223316073762 * GRP_Age3
          +     155.697624338212 * GRP_Age4  +     94.2208519596052 * 
        GRP_TotalArea2  +  1.0000000133514E-10 * GRP_TotalArea3
          +  9.9998231917197E-11 * GRP_TotalArea4 ;
   H11  =    -4.97510380635433 + H11 ;
   H12  =     9.28190669399731 + H12 ;
   H13  =     79.4398612902139 + H13 ;
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
   P_SalePrice  =     3332.63686904079 * H11  +      1881.5492640311 * H12
          +    -2843.75668761685 * H13 ;
   P_SalePrice  =     76533.1360629322 + P_SalePrice ;
END;
ELSE DO;
   P_SalePrice  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_SalePrice  =     76154.1162790697;
END;
*** *****************************;
*** Writing the Residuals  of the Node intervalTargets ;
*** ******************************;
IF MISSING( SalePrice ) THEN R_SalePrice  = . ;
ELSE R_SalePrice  = SalePrice  - P_SalePrice ;
********************************;
*** End Scoring Code for Neural;
********************************;
