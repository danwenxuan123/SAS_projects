dm 'log; clear; output; clear;';
libname dantest "C:\Users\Dan Wenxuan\Desktop\��������";
OPTION VALIDVARNAME=ANY;
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\��������\������ֵ�������ݼ����ڸ�������.xlsx' out=tmp1 dbms=xlsx replace;
sheet="������ֵ��������2.0";
run;
DATA TMP2;
	SET TMP1(KEEP=SERIALNO VAR_NAME VAR_VALUE FLAG );
	IF FLAG=1;
    WHERE �����������>=90;
	/*WHERE����޷���then��������ɾ��	
	  IF������ʹ��:=��find���ﵽ��where����like"%"���Ƶ�Ч��*/
	IF (VAR_VALUE>=3 AND VAR_NAME="VAR_RHZX_01") OR(VAR_VALUE>=3 AND VAR_NAME="VAR_RHZX_02") OR(VAR_VALUE>=2 AND VAR_NAME="VAR_RHZX_03")
	OR(VAR_VALUE>=1 AND VAR_NAME="VAR_RHZX_05") OR(VAR_VALUE>=3 AND VAR_NAME=:"VAR_AGP_04")
    THEN VAR_VALUE=1 ;
	ELSE DELETE;
RUN;
PROC TRANSPOSE DATA=TMP2 OUT=TMP3;
	BY SERIALNO;
	ID VAR_NAME;
	/*PROC ������ʹ��WHERE��䣬������ʹ��IF���*/
RUN;
PROC SORT DATA=TMP3 NODUPKEY;
	BY SERIALNO;
RUN;
