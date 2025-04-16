libname hw3 'E:\Users\nxk220078\Desktop\Assignment3';
/*A*/
data hw3.laptop_m;
	set hw3.laptop;
	if brand not in ('ACER','APPLE','ASUS','DELL','DYNABOOK','HP','LENOVO')  then brand = 'OTHER';
	if operating_system not in ('WINDOWS') then operating_system = 'OTHER';
proc print data=hw3.laptop_m;
run;
/*B*/
proc contents data= hw3.laptop_m;
run;
/*C*/
proc freq data=hw3.laptop_m;
	tables brand operating_system refurbished;
run;	
/*D*/
data hw3.laptop_c;
	set hw3.laptop_m;
	if brand = 'ACER' then brand_c = 1;
	else if brand = 'APPLE' then brand_c = 2;
	else if brand = 'ASUS' then brand_c = 3;
	else if brand = 'DELL' then brand_c = 4;
	else if brand = 'DYNABOOK' then brand_c = 5;
	else if brand = 'HP' then brand_c = 6;
	else if brand = 'LENOVO' then brand_c = 7;
	else brand_c = 8;
	
	if operating_system = 'WINDOWS' then os = 1;
	else os = 0;
	
	if refurbished = 'YES' then refurb = 1;
	else refurb = 0;
	
	ram = ram_nth**2;
	storage = storage_nth**2;
	
proc print data = hw3.laptop_c;
run;
/*E*/
title "1e";
Proc reg data = hw3.laptop_c;
	model price = brand_c os refurb ram storage cpu_benchmark gpu_class screen_size PPI warranty;
Run;
title;
/*F*/
data hw3.laptop_f;
	set hw3.laptop_c;
	log_price = log(price);
	log_screen_size = log(screen_size);
	log_warranty = log(warranty);
run;

proc print data = hw3.laptop_f; 
run;
/*G*/
title "1g";
Proc reg data = hw3.laptop_f;
	model log_price = brand_c os refurb ram storage cpu_benchmark gpu_class log_screen_size PPI log_warranty;
Run;
title; 

/*H*/
/*The adjusted R-Squared value for 1G is 0.8050, The R-Squared value for 1E is 0.7575*/
/*1G offters higher Adjusted R-Squared.A higher value indicates a better fit to the data.*/  

