libname dantest "C:\Users\Dan Wenxuan\Desktop\��������";
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\��������\rulescore.xlsx' out=tmp1 dbms=xlsx replace;
sheet="rulescore";
run;
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\��������\���ڸ���.xlsx' out=tmp2 dbms=xlsx replace;
sheet="Tabelle1";
run;
/*��ȡ���ںͷ��������ݷֱ�������������*/
PROC SQL;
	CREATE TABLE TMP3 AS
	SELECT SERIALNO,SCORE,ZHUANJIA_SCORE FROM tmp1
	WHERE SERIALNO IN (SELECT SERIALNO FROM TMP2);
QUIT; 
PROC SQL;
	CREATE TABLE TMP4 AS
	SELECT SERIALNO,SCORE,ZHUANJIA_SCORE FROM tmp1
	WHERE SERIALNO NOT IN (SELECT SERIALNO FROM TMP2);
QUIT; 
/*�ֱ���������ݼ�ͳ��Ƶ��*/

PROC FREQ DATA=TMP3;
	TABLE ZHUANJIA_SCORE SCORE;
RUN;
PROC FREQ DATA=TMP4;
	TABLE ZHUANJIA_SCORE SCORE;
RUN;
