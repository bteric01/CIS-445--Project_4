

length _FILTERFMT1  $200;
drop _FILTERFMT1 ;
_FILTERFMT1= put(GarageType,BEST.);
length _FILTERNORM1  $32;
drop _FILTERNORM1 ;
%dmnormcp(_FILTERFMT1,_FILTERNORM1);


length _FILTERFMT2  $200;
drop _FILTERFMT2 ;
_FILTERFMT2= put(LotSize,BEST.);
length _FILTERNORM2  $32;
drop _FILTERNORM2 ;
%dmnormcp(_FILTERFMT2,_FILTERNORM2);
if
_FILTERNORM1 not in ( '4' , '5')
 and
_FILTERNORM2 not in ( '3')
and
( Age eq . or (21.927259569<=Age) and (Age<=73.838257673))
and ( Basement eq . or (-726.162597<=Basement) and (Basement<=1011.6384591))
and ( Baths eq . or (-1.187088949<=Baths) and (Baths<=4.4284682593))
and ( FirePlace eq . or (-0.393951021<=FirePlace) and (FirePlace<=2.1180889522))
and ( FirstFloor eq . or (444.62071506<=FirstFloor) and (FirstFloor<=1633.0482505))
and ( GarageSize eq . or (-0.604540229<=GarageSize) and (GarageSize<=2.7286781599))
and ( SecondFloor eq . or (-689.2732699<=SecondFloor) and (SecondFloor<=858.77671817))
and ( TotalArea eq . or (405.62949416<=TotalArea) and (TotalArea<=2471.2946438))
and ( UpperArea eq . or (-423.2111825<=UpperArea) and (UpperArea<=1052.9629066))
;
