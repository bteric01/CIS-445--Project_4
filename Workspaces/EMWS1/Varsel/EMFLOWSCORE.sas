******************************************;
*** Begin Scoring Code from PROC DMINE ***;
******************************************;

length _WARN_ $ 4;
label _WARN_ = "Warnings";


/*----G_GarageType begin----*/
length _NORM12 $ 12;
_NORM12 = put( GarageType , BEST. );
%DMNORMIP( _NORM12 )
drop _NORM12;
select(_NORM12);
  when("0           " ) G_GarageType = 0;
  when("1           " ) G_GarageType = 0;
  when("2           " ) G_GarageType = 2;
  when("3           " ) G_GarageType = 1;
  otherwise substr(_WARN_, 2, 1) = 'U'; 
end;
label G_GarageType="Grouped Levels for GarageType";
/*----G_GarageType end----*/

/*----G_BasementType begin----*/
length _NORM12 $ 12;
_NORM12 = put( BasementType , BEST. );
%DMNORMIP( _NORM12 )
drop _NORM12;
select(_NORM12);
  when("0           " ) G_BasementType = 0;
  when("1           " ) G_BasementType = 1;
  when("2           " ) G_BasementType = 1;
  otherwise substr(_WARN_, 2, 1) = 'U'; 
end;
label G_BasementType="Grouped Levels for BasementType";
/*----G_BasementType end----*/


****************************************;
*** End Scoring Code from PROC DMINE ***;
****************************************;
