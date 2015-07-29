delete Output/ManTotalAge1.xls
clear all
load 'Output\Total.mat';
A.x25=cellfun(@(x) x(6:7),A.x5,'uniformoutput', false);
C=grpstats(A,{'x25','x2', 'x16'},{'sum','mean'},'DataVars',{'x7', 'x8'});
% C(:,'GroupCount') = [];
C.Properties.ObsNames=[];
C.Properties.VarNames{1} = 'Date';
C.Properties.VarNames{2} = 'District';
C.Properties.VarNames{3} = 'Age';
C.Properties.VarNames{4} = 'NumTrans';
C.Properties.VarNames{5} = 'TotalValue';
C.Properties.VarNames{6} = 'MeanValue';
C.Properties.VarNames{7} = 'SumPrice';
C.Properties.VarNames{8} = 'Mean';
D=grpstats(A,{'x25', 'x16'},{'sum','mean'},'DataVars',{'x7', 'x8'});
% D(:,{'mean_NumTrans','sum_Mean', 'mean_TotalValue'}) = [];
% D(:,'GroupCount') = [];
D.Properties.ObsNames=[];
D.Properties.VarNames{1} = 'Date';
D.Properties.VarNames{2} = 'Age';
D.Properties.VarNames{3} = 'NumTrans';
D.Properties.VarNames{4} = 'TotalValue';
D.Properties.VarNames{5} = 'MeanValue';
D.Properties.VarNames{6} = 'SumPrice';
D.Properties.VarNames{7} = 'Mean';
D.District=zeros(size(D,1),1);
D = sortrows(D,'Date','ascend');
C=[C;D];
C = sortrows(C,'Date','ascend');
% clear A B D
C = sortrows(C,'Date','ascend');
export(C,'xlsfile','Output\ManTotalAge1');
clc
