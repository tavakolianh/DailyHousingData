delete Total.xls
clear all;
xfile=dir('Input\*.xls');
xfile={xfile.name};
HousePrice=struct();
A=dataset('xlsfile', ['Input\', xfile{1}]);
A.Properties.VarNames = {'x1', 'x2', 'x3', 'x4', 'x5', 'x6', 'x7', 'x8', 'x9', 'x10', 'x11', 'x12', 'x13', 'x14', 'x15', 'x16', 'x17', 'x18', 'x19', 'x20', 'x21', 'x22', 'x23'};

for k=2:length(xfile)
    
    B=dataset('xlsfile',['Input\', xfile{k}]);
    B.Properties.VarNames = {'x1', 'x2', 'x3', 'x4', 'x5', 'x6', 'x7', 'x8', 'x9', 'x10', 'x11', 'x12', 'x13', 'x14', 'x15', 'x16', 'x17', 'x18', 'x19', 'x20', 'x21', 'x22', 'x23'};
    A=[A;B];
end
export(A,'xlsfile','Output\Total');
save('Output\Total.mat', 'A');