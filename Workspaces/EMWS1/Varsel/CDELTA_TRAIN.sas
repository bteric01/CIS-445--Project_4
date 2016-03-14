if upcase(name) = 'BASEMENT' then role = 'REJECTED';
else
if upcase(name) = 'BASEMENTTYPE' then role = 'REJECTED';
else
if upcase(name) = 'FIRSTFLOOR' then role = 'REJECTED';
else
if upcase(name) = 'GARAGETYPE' then role = 'REJECTED';
else
if upcase(name) = 'LOTSIZE' then role = 'REJECTED';
else
if upcase(name) = 'NEIGHBORHOOD' then role = 'REJECTED';
else
if upcase(name) = 'UPPERAREA' then role = 'REJECTED';
if upcase(strip(name)) = "G_GARAGETYPE" then level = "NOMINAL";
if upcase(strip(name)) = "G_BASEMENTTYPE" then level = "NOMINAL";
