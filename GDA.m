clc
clear all
%=========================================================%
%             Gradient Descent Algorithm                  %
%=========================================================%
% Minimize 3x^2+4y^2+10
%=========================================================%
%             Initialization                              %
%=========================================================%
Lower_limit=-10;
Upper_limit=10;
x=Lower_limit+rand*(Upper_limit-Lower_limit);
y=Lower_limit+rand*(Upper_limit-Lower_limit);
eta=0.01;
iter_max=100;
f=zeros(1,iter_max);
%=========================================================%
for iter=1:iter_max
    [x_der,y_der] = derivative(x,y);
    x=x-eta*x_der;
    y=y-eta*y_der;
    f(iter)=3*x^2+4*y^2+10;
end

%=========================================================%
%             Printing Optimum values                     %
%=========================================================%
fprintf('optimum x value=%0.2f\n',x);
fprintf('optimum y value=%0.2f\n',y);
fprintf('mimum value of objective function=%0.2f\n',f);
plot(f);
%=========================================================%
%             Thank you                                   %
%=========================================================%
    
