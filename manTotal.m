clear all
load 'Output\Total.mat';
A.x24=cellfun(@(x) x(6:end),A.x5,'uniformoutput', false);
A.x25=cellfun(@(x) x(6:7),A.x5,'uniformoutput', false);
C=grpstats(A,{'x24','x2'},'mean','DataVars','x8');
% C(:,'GroupCount') = [];
C.Properties.ObsNames=[];
C.Properties.VarNames{1} = 'Date';
C.Properties.VarNames{2} = 'District';
C.Properties.VarNames{3} = 'NumTrans';
C.Properties.VarNames{4} = 'Mean';
D=grpstats(C,'Date','mean','DataVars','Mean');
% D(:,'GroupCount') = [];
D.Properties.ObsNames=[];
D.Properties.VarNames{2} = 'NumTrans';
D.Properties.VarNames{3} = 'Mean';
D.District=zeros(size(D,1),1);
C=[C;D];
clear A B D
C = sortrows(C,'Date','ascend');
export(C,'xlsfile','Output/ManTotal1');

for i=0:22
    P=C.Mean(C.District==i);
    if length(P)==1
        continue;
    end
    Ptrend=hpfilter(P,6400);
    Ptrend(:,2)=P;
    Stat(1)=mean(P);
    Stat(2)=min(P);
    Stat(3)=max(P);
    Pgrowth=(Ptrend(end,2)-Ptrend(1,2))*100/Ptrend(1,2);
    HousePrice.(['District' num2str(i)]).P=P;
    HousePrice.(['District' num2str(i)]).Ptrend=Ptrend;
    HousePrice.(['District' num2str(i)]).Pgrowth=Pgrowth;
    HousePrice.(['District' num2str(i)]).Stat=Stat;
end
clc
