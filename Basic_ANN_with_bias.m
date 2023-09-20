clc
clear all
%================================================================%
%            Import Data                                         %
%================================================================%
filename='SampleData-01';
data=xlsread(filename);
%================================================================%
%            Initialization                                      %
%================================================================%
eta=0.9;
lowerlimit=-10;
upperlimit=10;
w=lowerlimit+rand(3,1)*(upperlimit-lowerlimit);
b=lowerlimit+rand*(upperlimit-lowerlimit);

%================================================================%
%            Training with GDA                                   %
%================================================================%
for i=1:100
    for j=1:size(data,1)
        x=data(j,1:3);
        o=x*w+b;
        delw=eta*(data(j,4)-o)*x';
        delb=eta*(data(j,4)-o);
        w=w+delw;
        b=b+delb;
    end
end

%================================================================%
%            Error Calc.                                         %
%================================================================%
error=0;
for j=1:size(data,1)
        x=data(j,1:3);
        o=x*w+b;
        error=error+abs(o-data(j,4));
end
fprintf('Mean Absolute Error=%f\n',error/size(data,1));
%================================================================%
%            Predictions                                         %
%================================================================%
x1=input('enter x1 value');
x2=input('enter x2 value');
x3=input('enter x3 value');
o=[x1,x2,x3]*w+b;
fprintf('predicted output=%f',o);
%================================================================%
%            End                                                 %
%================================================================%
