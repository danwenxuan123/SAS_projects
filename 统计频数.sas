dm 'log; clear; output; clear;';
libname dantest "C:\Users\Dan Wenxuan\Desktop\��������";
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\��������\������ֵ�������ݼ����ڸ�������.xlsx' out=tmp1 dbms=xlsx replace;
sheet="������ֵ��������2.0";
run;
DATA TMP2;
	SET TMP1;
	WHERE VAR_NAME like "VAR_AGP_03%" AND FLAG=1;
RUN;
PROC freq DATA=TMP2;
	TABLES VAR_VALUE;
RUN;

