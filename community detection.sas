libname final "C:\Users\danwe\Documents\facebook"; 
/*��������*/
DATA DATA1;
	INFILE "C:\Users\danwe\Documents\facebook\1684.edges";
	INPUT from to @@;
RUN;
%MACRO COMMUNITY_DETECTION_PERSONAL(datasetname=,target=,source=,weight=);

/*��ȡdataset��ÿ�����ڵ㣬���ų�һ��data*/
	DATA NODES1;
		SET &datasetname(KEEP=&target RENAME=(&target=ID)) &datasetname(KEEP=&source RENAME=(&source=ID));
	PROC SORT DATA=NODES1 NODUPKEY OUT=NODES;
		BY ID;
		RUN;



%MEND COMMUNITY_DETECTION_PERSONAL;


/*���ú�*/
%COMMUNITY_DETECTION_PERSONAL(datasetname=DATA1,target=to,source=from);
����modularity gain
