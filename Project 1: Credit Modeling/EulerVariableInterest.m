function [AmountOwed_table,P500,P750,A,tfinal] = EulerVariableInterest(P)
%EulerVariable does Euler approximation for a differential equation with a
%variable interest rate
%define payment function
P1 = @(t) P(1)*12; %multiply by 12 to get payments in terms of months
%define ODE 
dAdt1 = @(y,r,P) r*y - P;
%define initial conditions
t1(1) = 0;
A1(1) = 10000;
%define step size
h = 0.01;

%Euler's Approximation
i = 1;
while A1(i) > 0
    % Define the variable interest function
    if t1(i) <= 12
        r1 = @(t) 0;
    else
        r1 = @(t) .185;
    end
    A1(i+1) = A1(i) + h*dAdt1(A1(i),r1(i),P1(i));
    t1(i+1) = t1(i) + h;
    i = i+1;
end
    
%calculate time to pay off debt
tfinal(1) = (i-1)*h*12; %[months]

%calculate total interest payed

%define payment function
P2 = @(t) P(2)*12; %multiply by 12 to get payments in terms of months
%define ODE 
dAdt2 = @(y,r,P) r*y - P;
%define initial conditions
t2(1) = 0;
A2(1) = 10000;
%define step size
h = 0.01;

%Euler's Approximation
j = 1;
while A2(j) > 0
    % Define the variable interest function
    if t2(j) <= 12
        r2 = @(t) 0;
    else
        r2 = @(t) .185;
    end
    A2(j+1) = A2(j) + h*dAdt2(A2(j),r2(j),P2(j));
    t2(j+1) = t2(j) + h;
    j = j+1;
end
A = [A1 A2];
%calculate time to pay off debt
tfinal(2) = (j-1)*h*12; %[months]
%plot
figure
plot(t1*12,A1,t2*12,A2)
ylim([0,10000])
title('Amount of Money Owed v.s. Time')
xlabel('Time, months')
ylabel('Amount Owed, $')
legend('P = $500','P = $750');

%determine the amount own for each method
P500 = trapz(t1*12,A1);
P750 = trapz(t2*12,A2);
I500 = 10000 - P500;
I750 = 10000 - P750;

AmountOwed_table = struct2table(struct('Type',['Time    '; 'Interest'],...
    'P500',[tfinal(1); abs(I500)],'P750',[tfinal(2); abs(I750)]));
end








