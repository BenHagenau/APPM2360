%Author: Benjamin Hagenau
%Created: 2/7/17

function [A,tfinal] = Euler()
%Euler does Euler approximation for a differential equation

%define payment and interest functions
r = @(t) .14;
P = @(t) 750*12; %multiply by 12 to get payments in terms of months
%define ODE 
dAdt = @(y,r,P) r*y - P;
%define initial conditions
t(1) = 0;
A(1) = 10000;
%define step size
h = 0.01;

%Euler's Approximation
i = 1;
while A(i) > 0
    A(i+1) = A(i) + h*dAdt(A(i),r(i),P(i));
    t(i+1) = t(i) + h;
    i = i+1;
end

%calculate time to pay off debt
tfinal = (i-1)*h*12; %[months]
%plot
figure
plot(t*12,A)
ylim([0,10000])
title('Amount of Money Owed v.s. Time')
xlabel('Time, months')
ylabel('Amount Owed, $')


