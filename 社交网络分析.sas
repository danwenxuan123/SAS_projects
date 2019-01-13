libname final "C:\Users\danwe\Documents\facebook"; 
/*-----------------------------------------------------------------------------
                          HOW TO USE OPTGRAPH 
------------------------------------------------------------------------------*/
/*PROC OPTGRAPH options ;
		DATA_LINKS= 
		DATA_MATRIX=
		DATA_NODES= 
		DATA_NODES_SUB= 
		OUT_LINKS=
		OUT_NODES= 
		FILTER_SUBGRAPH= 
		GRAPH_DIRECTION= 
		GRAPH_INTERNAL_FORMAT= 
		INCLUDE_SELFLINK 
		LOGLEVEL= 
		TIMETYPE=
	Data Input Statements: 
		DATA_LINKS_VAR < options > ; 
		DATA_MATRIX_VAR <column1,column2,...> ;
		DATA_NODES_VAR < options > ;
	Algorithm Statements: 
		BICONCOMP < option > ; 
		CENTRALITY < options > ; 
		CLIQUE < options > ; 
		COMMUNITY < options > ;
		CONCOMP < options > ; 
		CORE < options > ; 
		CYCLE < options > ; 
		EIGENVECTOR < options > ;
		LINEAR_ASSIGNMENT < options > ; 
		MINCOSTFLOW < options > ; 
		MINCUT < options > ; 
		MINSPANTREE < options > ; 
		EACH < options > ; 
		SHORTPATH < options > ;
		SUMMARY < options > ; 
		TRANSITIVE_CLOSURE < options > ;
		TSP < options > ;
	Performance Statement: 
		PERFORMANCE < options > ;*/
/*-----------------------------------------------------------------------------
                             END OF EXAMPLE
------------------------------------------------------------------------------*/
DATA DATA1;
	INFILE "C:\Users\danwe\Documents\facebook\1684.edges";
	INPUT from to @@;
RUN;
PROC OPTGRAPH 
	DATA_LINKS=DATA1;
/*	DATA_LINKS_VAR*/
/*		FROM=from*/
/*		TO  =to;（可以省略DATA_LINKS_VAR，因为是用from和to命名的）*/
	PERFORMANCE 
		NTHREADS = 8;
	COMMUNITY
		 ALGORITHM=LOUVAIN 
		 OUT_COMMUNITY=OUTCOM1;
RUN;

data LinkSetIn; 
	input from $ to $ weight @@; 
	datalines; 
	A B 1 
	A C 2 
	A D 4
	B C 1 B E 2 B F 5 C E 1 D E 1 E D 1 E F 2 F G 6 G H 1 G I 1 H G 2 H I 3
	;
PROC OPTGRAPH 
	GRAPH_DIRECTION = directed 
	DATA_LINKS = LinkSetIn 
	OUT_NODES = NodeSetOut 
	OUT_LINKS = LinkSetOut; 
RUN;
/*---------------------------------------------------------
                   Linear Assignment 
-----------------------------------------------------------*/
data CostMatrix; 
input back breast fly free@@; 
	datalines; 
	35.1 36.7 28.3 36.1 
	34.6 32.6 26.9 26.2
    31.3 33.9 27.1 31.2 
    28.6 34.1 29.1 30.3 
    32.9 32.2 26.6 24.0 
    27.8 32.5 27.8 27.0 
    26.3 27.6 23.5 22.4 
    29.0 24.0 27.9 25.4 
    27.2 33.8 25.2 24.1 
    27.0 29.2 23.0 21.9 
	;
proc optgraph 
	data_matrix = CostMatrix; 
	data_matrix_var
			back--free; 
	linear_assignment 
		out = LinearAssign; 
run;
/*---------------------------------------------------------
                   Clustering Coef?cient 
-----------------------------------------------------------*/
DATA LinkSetInCC1; 
	INPUT from $ to $ @@; 
	DATALINES; 
	A B A C A D B C B D C D 
	;
DATA LinkSetInCC2;
	INPUT from $ to $ @@; 
	DATALINES; 
	A B A C A D C D 
	;
PROC OPTGRAPH 
	DATA_LINKS = LinkSetInCC1 
	OUT_NODES = NodeSetOut1; 
	CENTRALITY CLUSTERING_COEF; 
RUN;
PROC OPTGRAPH 
	DATA_LINKS = LinkSetInCC2 
	OUT_NODES = NodeSetOut2; 
	CENTRALITY CLUSTERING_COEF;
RUN;
