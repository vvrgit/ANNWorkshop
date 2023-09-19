clc
clear cll
f=[-6;-5];
A=[1 1;3 2];
b=[5;12];
Aeq=[];
beq=[];
lb=[0;0];
ub=[inf;inf];
options = optimoptions('linprog','Algorithm','interior-point');
x=linprog(f,A,b,Aeq,beq,lb,ub,[],options);
%'dual-simplex',  'interior-point-legacy',  or  'interior-point'.
