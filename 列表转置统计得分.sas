dm 'log; clear; output; clear;';
libname dantest "C:\Users\Dan Wenxuan\Desktop\工作资料";
option validvarname=any;
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\工作资料\互金阈值测试数据及逾期更新数据.xlsx' out=tmp1 dbms=xlsx replace;
sheet="互金阈值测试数据2.0";
run;
DATA TMP2;
	SET TMP1(KEEP=SERIALNO VAR_NAME VAR_VALUE);
	
	/*WHERE语句无法接then进行数据删改	
	  IF语句必须使用:=或find来达到和where里面like"%"类似的效果*/
	LENGTH VAR_NAME $11;
	IF VAR_NAME=:"VAR_AGP_04" THEN VAR_NAME="VAR_AGP_004";
	IF (VAR_VALUE>=3 AND VAR_NAME="VAR_RHZX_01") OR(VAR_VALUE>=3 AND VAR_NAME="VAR_RHZX_02") OR(VAR_VALUE>=2 AND VAR_NAME="VAR_RHZX_03")
	OR(VAR_VALUE>=1 AND VAR_NAME="VAR_RHZX_05") OR(VAR_VALUE>=3 AND VAR_NAME=:"VAR_AGP_004") 
    THEN VAR_VALUE=1 ;
    ELSE IF VAR_NAME="VAR_RHZX_01" OR VAR_NAME="VAR_RHZX_02" OR VAR_NAME="VAR_RHZX_03" OR VAR_NAME="VAR_RHZX_05" OR VAR_NAME=:"VAR_AGP_004" 
    THEN VAR_VALUE=0;
	ELSE DELETE;
	DROP 最大逾期天数;
RUN;
PROC TRANSPOSE DATA=TMP2 OUT=TMP3;
	BY SERIALNO;
	ID VAR_NAME;
	/*PROC 步可以使用WHERE语句，但不能使用IF语句*/
RUN;
DATA RULESCORE;
	SET TMP3;
	SCORE=VAR_RHZX_01*80+VAR_RHZX_02*80+VAR_RHZX_03*40+VAR_RHZX_05*80+VAR_AGP_004*40;
	ZHUANJIA_SCORE=VAR_RHZX_01*40+VAR_RHZX_02*40+VAR_RHZX_03*20+VAR_RHZX_05*10+VAR_AGP_004*20;
	DROP VAR_RHZX_01 VAR_RHZX_02 VAR_RHZX_03 VAR_RHZX_05 VAR_AGP_004;
RUN;

PROC EXPORT DATA=tmp3 OUTFILE='C:\Users\Dan Wenxuan\Desktop\工作资料\tmp3.xlsx' dbms=xlsx replace;
run;
PROC EXPORT DATA=rulescore OUTFILE='C:\Users\Dan Wenxuan\Desktop\工作资料\rulescore.xlsx' dbms=xlsx replace;
run;
