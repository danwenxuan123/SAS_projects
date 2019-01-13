dm 'log; clear; output; clear;';
libname dantest "C:\Users\Dan Wenxuan\Desktop\��������";
option validvarname=any;
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\��������\������ֵ�������ݼ����ڸ�������.xlsx' out=tmp1 dbms=xlsx replace;
sheet="������ֵ��������2.0";
run;
DATA TMP2;
	SET TMP1(KEEP=SERIALNO VAR_NAME VAR_VALUE);
	
	/*WHERE����޷���then��������ɾ��	
	  IF������ʹ��:=��find���ﵽ��where����like"%"���Ƶ�Ч��*/
	LENGTH VAR_NAME $11;
	IF VAR_NAME=:"VAR_AGP_04" THEN VAR_NAME="VAR_AGP_004";
	IF (VAR_VALUE>=3 AND VAR_NAME="VAR_RHZX_01") OR(VAR_VALUE>=3 AND VAR_NAME="VAR_RHZX_02") OR(VAR_VALUE>=2 AND VAR_NAME="VAR_RHZX_03")
	OR(VAR_VALUE>=1 AND VAR_NAME="VAR_RHZX_05") OR(VAR_VALUE>=3 AND VAR_NAME=:"VAR_AGP_004") 
    THEN VAR_VALUE=1 ;
    ELSE IF VAR_NAME="VAR_RHZX_01" OR VAR_NAME="VAR_RHZX_02" OR VAR_NAME="VAR_RHZX_03" OR VAR_NAME="VAR_RHZX_05" OR VAR_NAME=:"VAR_AGP_004" 
    THEN VAR_VALUE=0;
	ELSE DELETE;
	DROP �����������;
RUN;
PROC TRANSPOSE DATA=TMP2 OUT=TMP3;
	BY SERIALNO;
	ID VAR_NAME;
	/*PROC ������ʹ��WHERE��䣬������ʹ��IF���*/
RUN;
DATA RULESCORE;
	SET TMP3;
	SCORE=VAR_RHZX_01*80+VAR_RHZX_02*80+VAR_RHZX_03*40+VAR_RHZX_05*80+VAR_AGP_004*40;
	ZHUANJIA_SCORE=VAR_RHZX_01*40+VAR_RHZX_02*40+VAR_RHZX_03*20+VAR_RHZX_05*10+VAR_AGP_004*20;
	DROP VAR_RHZX_01 VAR_RHZX_02 VAR_RHZX_03 VAR_RHZX_05 VAR_AGP_004;
RUN;

PROC EXPORT DATA=tmp3 OUTFILE='C:\Users\Dan Wenxuan\Desktop\��������\tmp3.xlsx' dbms=xlsx replace;
run;
PROC EXPORT DATA=rulescore OUTFILE='C:\Users\Dan Wenxuan\Desktop\��������\rulescore.xlsx' dbms=xlsx replace;
run;
