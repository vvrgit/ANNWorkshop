clc
clear all
%================================================================%
%            Import Data                                         %
%================================================================%
filename='SampleData-03';
data=xlsread(filename);
%================================================================%
%            Initialization                                      %
%================================================================%
eta=0.001;
lowerlimit=-10;
upperlimit=10;
wij=lowerlimit+rand(3,5)*(upperlimit-lowerlimit);
wjk=lowerlimit+rand(5,1)*(upperlimit-lowerlimit);

%================================================================%
%            Training with GDA                                   %
%================================================================%
for i=1:100000
    for j=1:size(data,1)
        x=data(j,1:3);
        oh=x*wij;
        ok=oh*wjk;
        delwjk=eta*(data(j,4)-ok)*oh';
        wjk=wjk+delwjk;
        del_wij=zeros(3,5);
        for h=1:5
            del_wij(:,h)=eta*(data(j,4)-ok)*wjk(h,1)*x';
        end
        wij=wij+del_wij;
    end
end

%================================================================%
%            Error Calc.                                         %
%================================================================%
error=0;
for j=1:size(data,1)
        x=data(j,1:3);
        oh=x*wij;
        ok=oh*wjk;
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
oh=x*wij;
ok=oh*wjk;
fprintf('predicted output=%f',ok);
%================================================================%
%            End                                                 %
%================================================================%
