dm 'log; clear; output; clear;';
libname dantest "C:\Users\Dan Wenxuan\Desktop\工作资料";
OPTION VALIDVARNAME=ANY;
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\工作资料\互金阈值测试数据及逾期更新数据.xlsx' out=tmp1 dbms=xlsx replace;
sheet="互金阈值测试数据2.0";
run;
DATA TMP2;
	SET TMP1(KEEP=SERIALNO VAR_NAME VAR_VALUE FLAG );
	IF FLAG=1;
    WHERE 最大逾期天数>=90;
	/*WHERE语句无法接then进行数据删改	
	  IF语句必须使用:=或find来达到和where里面like"%"类似的效果*/
	IF (VAR_VALUE>=3 AND VAR_NAME="VAR_RHZX_01") OR(VAR_VALUE>=3 AND VAR_NAME="VAR_RHZX_02") OR(VAR_VALUE>=2 AND VAR_NAME="VAR_RHZX_03")
	OR(VAR_VALUE>=1 AND VAR_NAME="VAR_RHZX_05") OR(VAR_VALUE>=3 AND VAR_NAME=:"VAR_AGP_04")
    THEN VAR_VALUE=1 ;
	ELSE DELETE;
RUN;
PROC TRANSPOSE DATA=TMP2 OUT=TMP3;
	BY SERIALNO;
	ID VAR_NAME;
	/*PROC 步可以使用WHERE语句，但不能使用IF语句*/
RUN;
PROC SORT DATA=TMP3 NODUPKEY;
	BY SERIALNO;
RUN;
