proc sort data=sashelp.cars out=cars;

  by origin;

  run;

/*--Separate the class data into multiple columns--*/

data cars1 cars2 cars3;

  set cars (keep=mpg_city origin);

  if origin='USA' then do; mpg_usa=mpg_city; output cars1; end;

  if origin='Asia' then do; mpg_asia=mpg_city; output cars2; end;

  if origin='Europe' then do; mpg_eur=mpg_city; output cars3; end;

  run;

/*--Merge data into one data set--*/

data MpgByOrigin;

  merge cars1(keep=mpg_usa) cars2(keep=mpg_asia) cars3(keep=mpg_eur);

  run;

/*--Create graph using SGPLOT--*/

title 'Milage Distribution by Origin';

proc sgplot data=mpgbyorigin;

  density mpg_usa / legendlabel='USA' lineattrs=(pattern=solid);

  density mpg_asia  / legendlabel='Asia' lineattrs=(pattern=solid);

  density mpg_eur  / legendlabel='Europe' lineattrs=(pattern=solid);

  keylegend / location=inside position=topright across=1;

  xaxis display=(nolabel);

  run;
