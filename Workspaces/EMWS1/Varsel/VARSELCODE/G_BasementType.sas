*;
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
