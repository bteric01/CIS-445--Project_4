if name='SalePrice' then role='TARGET';
if name='BIN_SalePrice' then do;
   role='REJECTED';
   level='BINARY';
end;
if name = 'TotalArea' then role='REJECTED';
if name = 'GRP_TotalArea' then role='INPUT';
if name = 'GRP_TotalArea' then level='ORDINAL';
if name = 'Age' then role='REJECTED';
if name = 'GRP_Age' then role='INPUT';
if name = 'GRP_Age' then level='ORDINAL';
if name = 'Baths' then role='REJECTED';
if name = 'GRP_Baths' then role='REJECTED';
if name = 'GRP_Baths' then level='ORDINAL';
if name = 'ConstructionType' then role='REJECTED';
if name = 'GRP_ConstructionType' then role='REJECTED';
if name = 'GRP_ConstructionType' then level='ORDINAL';
if name = 'FirePlace' then role='REJECTED';
if name = 'GRP_FirePlace' then role='REJECTED';
if name = 'GRP_FirePlace' then level='ORDINAL';
if name = 'CentralAir' then role='REJECTED';
if name = 'GRP_CentralAir' then role='REJECTED';
if name = 'GRP_CentralAir' then level='ORDINAL';
if name = 'WallType' then role='REJECTED';
if name = 'GRP_WallType' then role='REJECTED';
if name = 'GRP_WallType' then level='ORDINAL';
if name = 'G_GarageType' then role='REJECTED';
if name = 'GRP_G_GarageType' then role='REJECTED';
if name = 'GRP_G_GarageType' then level='ORDINAL';
if name = 'GarageSize' then role='REJECTED';
if name = 'GRP_GarageSize' then role='REJECTED';
if name = 'GRP_GarageSize' then level='ORDINAL';
if name = 'G_BasementType' then role='REJECTED';
if name = 'GRP_G_BasementType' then role='REJECTED';
if name = 'GRP_G_BasementType' then level='ORDINAL';
if name = 'SecondFloor' then role='REJECTED';
if name = 'GRP_SecondFloor' then role='REJECTED';
if name = 'GRP_SecondFloor' then level='ORDINAL';
