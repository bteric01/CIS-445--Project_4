drop _temp_;
if (P_SalePrice ge 81747.321107805) then do;
b_SalePrice = 1;
end;
else
if (P_SalePrice ge 78903.5655083872) then do;
b_SalePrice = 2;
end;
else
if (P_SalePrice ge 77925.8027619315) then do;
_temp_ = dmran(1234);
b_SalePrice = floor(5 + 2*_temp_);
end;
else
if (P_SalePrice ge 77925.2012658001) then do;
_temp_ = dmran(1234);
b_SalePrice = floor(7 + 2*_temp_);
end;
else
if (P_SalePrice ge 74162.7066174771) then do;
_temp_ = dmran(1234);
b_SalePrice = floor(10 + 2*_temp_);
end;
else
if (P_SalePrice ge 72238.2917703056) then do;
_temp_ = dmran(1234);
b_SalePrice = floor(12 + 2*_temp_);
end;
else
if (P_SalePrice ge 68475.211660387) then do;
_temp_ = dmran(1234);
b_SalePrice = floor(17 + 2*_temp_);
end;
else
do;
b_SalePrice = 20;
end;
