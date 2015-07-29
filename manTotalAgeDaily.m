delete Output/ManTotal1.xls
clear all
load 'Output\Total.mat';
A.x24=cellfun(@(x) x(6:end),A.x5,'uniformoutput', false);
C=grpstats(A,{'x24', 'x16'},{'sum','mean'},'DataVars',{'x7', 'x8'});
% C(:,'GroupCount') = [];
C.Properties.ObsNames=[];
C.Properties.VarNames{1} = 'Date';
C.Properties.VarNames{2} = 'Age';
C.Properties.VarNames{3} = 'NumTrans';
C.Properties.VarNames{4} = 'TotalValue';
C.Properties.VarNames{5} = 'MeanValue';
C.Properties.VarNames{6} = 'SumPrice';
C.Properties.VarNames{7} = 'Mean';
C = sortrows(C,'Date','ascend');
% clear A B D
export(C,'xlsfile','Output\ManTotal1');
% C=dataset('xlsfile','Output\ManTotal11.xls');
D=unique(C.Age);
for i=1:length(D)
    P=C.Mean(strcmp(C.Age, D{i}));
    if length(P)==1
        continue;
    end
    Ptrend=hpfilter(P,6400);
    Ptrend(:,2)=P;
    Stat(1)=mean(P);
    Stat(2)=min(P);
    Stat(3)=max(P);
    Pgrowth=(Ptrend(end,2)-Ptrend(1,2))*100\Ptrend(1,2);
    HousePrice.(['Age' num2str(i)]).P=P;
    HousePrice.(['Age' num2str(i)]).Ptrend=Ptrend;
    HousePrice.(['Age' num2str(i)]).Pgrowth=Pgrowth;
    HousePrice.(['Age' num2str(i)]).Stat=Stat;
end
save('HousePriceAgeTotal.mat', 'HousePrice');
clc
