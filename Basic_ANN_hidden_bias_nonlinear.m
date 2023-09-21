clc
clear all
%================================================================%
%            Import Data                                         %
%================================================================%
filename='SampleData-04';
data=xlsread(filename);
%================================================================%
%            Initialization                                      %
%================================================================%
eta=0.001;
lowerlimit=-10;
upperlimit=10;
wij=lowerlimit+rand(3,5)*(upperlimit-lowerlimit);
wjk=lowerlimit+rand(5,1)*(upperlimit-lowerlimit);
bj=lowerlimit+rand(5,1)*(upperlimit-lowerlimit);
bk=lowerlimit+rand*(upperlimit-lowerlimit);

%================================================================%
%            Training with GDA                                   %
%================================================================%
for i=1:100000
    for j=1:size(data,1)
        x=data(j,1:3);
        neth=x*wij+bj';
        oh=1./(1+exp(-neth));
        netk=oh*wjk+bk;
        ok=1./(1+exp(-netk));
        delwjk=eta*(data(j,4)-ok)*ok*(1-ok)*oh';
        delbk=eta*(data(j,4)-ok)*ok*(1-ok);
        wjk=wjk+delwjk;
        bk=bk+delbk;
        
        del_wij=zeros(3,5);
        delbj=zeros(5,1);
        for h=1:5
            del_wij(:,h)=eta*(data(j,4)-ok)*ok*(1-ok)*wjk(h,1)*oh(1,h)*(1-oh(1,h))*x';
            delbj(h,1)=eta*(data(j,4)-ok)*ok*(1-ok)*wjk(h,1)*oh(1,h)*(1-oh(1,h));
        end
        wij=wij+del_wij;
        bj=bj+delbj;
        
    end
end

%================================================================%
%            Error Calc.                                         %
%================================================================%
error=0;
for j=1:size(data,1)
        x=data(j,1:3);
        neth=x*wij+bj';
        oh=1./(1+exp(-neth));
        netk=oh*wjk+bk;
        ok=1./(1+exp(-netk));
        error=error+abs(ok-data(j,4));
end
fprintf('Mean Absolute Error=%f\n',error/size(data,1));
%================================================================%
%            Predictions                                         %
%================================================================%
x1=input('enter x1 value');
x2=input('enter x2 value');
x3=input('enter x3 value');

x=[x1,x2,x3];
        neth=x*wij+bj';
        oh=1./(1+exp(-neth));
        netk=oh*wjk+bk;
        ok=1./(1+exp(-netk));
fprintf('predicted output=%f',ok);
%================================================================%
%            End                                                 %
%================================================================%
