function [VariablePayment_table,A,tfinal] = EulerVariablePayment()
%Euler does Euler approximation for a differential equation

%define payment and interest functions
r = @(t) .185;
P = @(t) (800 + (10*12*t)); %multiply by 12 to get payments in terms of months
%define ODE 
dAdt = @(y,r,P) r*y - P*12;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculate how large of a loan can be paid off in twenty years
%Euler's Approximation
t20(1) = 0;
A20(1) = 10;
while tfinal < 20*12
    A20(1) = A20(1) + 1000;
    t20(1) = 0;
    i = 1;
    while A20(i) > 0
        A20(i+1) = A20(i) + h*dAdt(A20(i),r(i),P(i));
        t20(i+1) = t20(i) + h;
        i = i+1;
    end
    %calculate time to pay off debt
    tfinal = (i-1)*h*12; %[months]
end

%plot data and define output struct
DATA = struct('Amount_Paid',A20,'Time',t20);
clc
VariablePayment_table = struct2table(struct('Time_to_Pay_10000',tfinal,'Initial_Value',A20(1),'Amount_Paid',trapz(t20,A20),'Time',floor(t20(end))));

figure
hold on
plot(t20,A20)
ylim([0 8*10^5])
title('Largest Amount of Money Payed off in 20 Years')
xlabel('Time, hours')
ylabel('Amount Owed, $')
hold off










