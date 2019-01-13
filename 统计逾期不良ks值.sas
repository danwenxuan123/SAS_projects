libname dantest "C:\Users\Dan Wenxuan\Desktop\工作资料";
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\工作资料\rulescore.xlsx' out=tmp1 dbms=xlsx replace;
sheet="rulescore";
run;
proc import datafile ='C:\Users\Dan Wenxuan\Desktop\工作资料\逾期更新.xlsx' out=tmp2 dbms=xlsx replace;
sheet="Tabelle1";
run;
/*提取逾期和非逾期数据分别放于两个表格中*/
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
/*分别对两个数据集统计频数*/

PROC FREQ DATA=TMP3;
	TABLE ZHUANJIA_SCORE SCORE;
RUN;
PROC FREQ DATA=TMP4;
	TABLE ZHUANJIA_SCORE SCORE;
RUN;
