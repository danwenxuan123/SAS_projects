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
/*�ֱ���������ݼ�ͳ�Ʒ���*/	
data tmp5;
	set tmp3(in=a) tmp4(in=b);
	if a then source="����";
	if b then source="������";
run; 
PROC MEANS DATA=TMP5 MEAN STD MIN MAX;
	VAR SCORE ZHUANJIA_SCORE;
	CLASS SOURCE;
RUN;
