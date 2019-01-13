dm 'log; clear; output; clear;';
libname dantest "C:\Users\Dan Wenxuan\Desktop\��������";
OPTION VALIDVARNAME=ANY;
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\��������\������ֵ�������ݼ����ڸ�������.xlsx' out=tmp1 dbms=xlsx replace;
sheet="������ֵ��������2.0";
run;
data tmp1;
	set tmp1;
	where
DATA TMP2;
	SET TMP1(KEEP=SERIALNO VAR_NAME VAR_VALUE RENAME=(VAR_NAME=VAR1) );
	WHERE VAR1 = "VAR_RHZX_01 " AND VAR_VALUE>=3;
	KEEP SERIALNO VAR1;
RUN;
DATA TMP3;
	SET TMP1(KEEP=SERIALNO VAR_NAME VAR_VALUE RENAME=(VAR_NAME=VAR2));
	WHERE VAR2 = "VAR_RHZX_02" AND VAR_VALUE>=3;
	KEEP SERIALNO VAR2;
RUN;
PROC SORT DATA=TMP2; BY SERIALNO;RUN;
PROC SORT DATA=TMP3; BY SERIALNO;RUN;
DATA TMP4;
	MERGE TMP2(IN=A) TMP3(IN=B);
    BY SERIALNO;
	IF A AND B;
RUN;

