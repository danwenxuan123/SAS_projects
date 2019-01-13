libname final "C:\Users\danwe\Documents\facebook"; 
/*导入数据*/
DATA DATA1;
	INFILE "C:\Users\danwe\Documents\facebook\1684.edges";
	INPUT from to @@;
RUN;
%MACRO COMMUNITY_DETECTION_PERSONAL(datasetname=,target=,source=,weight=);

/*获取dataset的每个个节点，并排成一个data*/
	DATA NODES1;
		SET &datasetname(KEEP=&target RENAME=(&target=ID)) &datasetname(KEEP=&source RENAME=(&source=ID));
	PROC SORT DATA=NODES1 NODUPKEY OUT=NODES;
		BY ID;
		RUN;



%MEND COMMUNITY_DETECTION_PERSONAL;


/*调用宏*/
%COMMUNITY_DETECTION_PERSONAL(datasetname=DATA1,target=to,source=from);
计算modularity gain
