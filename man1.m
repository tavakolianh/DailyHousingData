clear all;
xfile=dir('*.xls');
xfile={xfile.name};
HousePrice=struct();
for k=1:length(xfile)

A=xlsread(xfile{k});
P=[];
ini=1.02;
count=0;
index=1;
su=0;
for i=1:size(A,1)
    
    if A(i,4)==ini
        H=A(i,20);
        su=su+H;
        count=count+1;
    else
        P(index,1)=ini;
        P(index,2)=su/count;
        ini=A(i,4);
        index=index+1;
        su=A(i,20);
        count=1;
    end
    
end
P(index,1)=ini;
P(index,2)=su/count;
Ptrend=hpfilter(P,6400);
Ptrend(:,1)=P(:,2);
mean_man1=mean(A(:,20));
min_man1=min(A(:,20));
max_man1=max(A(:,20));
Pgrowth=(Ptrend(end,2)-Ptrend(1,2))*100/Ptrend(1,2);
HousePrice.(['District' num2str(k)]).P=P;
HousePrice.(['District' num2str(k)]).Ptrend=Ptrend;
HousePrice.(['District' num2str(k)]).Pgrowth=Pgrowth;
plot(Ptrend(:,1:2));
end

