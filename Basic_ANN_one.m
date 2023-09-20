clc
clear all
eta=0.9;
filename='SampleData-00';
data=xlsread(filename);
lowerlimit=-10;
upperlimit=10;
w=lowerlimit+rand(3,1)*(upperlimit-lowerlimit);
for i=1:100
    for j=1:size(data,1)
        x=data(j,1:3);
        o=x*w;
        delw=eta*(data(j,4)-o)*x';
        w=w+delw;
    end
end

x1=input('enter x1 value');
x2=input('enter x2 value');
x3=input('enter x3 value');
o=[x1,x2,x3]*w;
fprintf('predicted output=%f',o);
