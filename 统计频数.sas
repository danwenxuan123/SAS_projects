dm 'log; clear; output; clear;';
libname dantest "C:\Users\Dan Wenxuan\Desktop\工作资料";
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\工作资料\互金阈值测试数据及逾期更新数据.xlsx' out=tmp1 dbms=xlsx replace;
sheet="互金阈值测试数据2.0";
run;
DATA TMP2;
	SET TMP1;
	WHERE VAR_NAME like "VAR_AGP_03%" AND FLAG=1;
RUN;
PROC freq DATA=TMP2;
	TABLES VAR_VALUE;
RUN;

