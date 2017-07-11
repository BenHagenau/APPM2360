%Author: Benjamin Hagenau
%Created: 2/4/17

function [fixedCredit_table] = fixedCredit(compounded,continous)
%FIXEDCREDIT calculates the credit model for a fixed credit compounded
%interest

%define initial condition and fixed rate.
r = 0.14;
A0 = 10000; %[$]
t = linspace(1,5,100); %[years]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Determine credit debt after 5 years: compound 1,2,4,12 times a year
%without any payments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%define compound rates
n = [1 2 4 12];

%calculate credit as a function of time
for i = 1:length(n)
    y{i} = compounded(r,n(i),A0,t);
    %OUTPUT size of debt after 5 years
    owed(i) = trapz(t,y{i});
end
%plot
figure
for i = 1:length(n)
    hold on
    plot(t,y{i},'-')    
end
title('Fixed Credit Debt')
xlabel('Time, years')
ylabel('Compounded Debt, $')
legend('Compound 1 times per year','Compound 2 times per year','Compound 4 times per year',...
    'Compound 12 times per year','Location','Best');
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%determine if continuous compounding is a good model for time step compounding 
%of 365 times a year.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%determine compounded debt using time step and continous methods
n = 365;
n365 = compounded(r,n,A0,t); 
cont = continous(r,n,A0,t);
%plot
figure
plot(t,n365,t,cont)
title('Compounding Continuously v.s. Compounding per Day')
xlabel('Time, years')
ylabel('Compounded Debt, $')
legend('Compound per day','Compound continuously','Location','Best');
%calculate deviation of continous from compounding per day
for i = 1:length(t)
    dev(i) = abs(n365(i) - cont(i));
end
%plot deviation
figure
plot(t,dev)
title('Deviation of Compounding Continuously from Compounding per Day')
xlabel('Time, years')
ylabel('Deviation, $')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%determine if continuous compounding is a good model for time step compounding 
%of 365 times a year.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%YES

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot direction field of equation 3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DONE ON MATHEMATICA
%VectorPlot[{t, .14*y - 9000}, {t, 0, 10000}, {y, 0, 10000},AxesLabel -> {Debt, Time}]


%when dydt is negative money is being lost, when it is positive it is being
%gained. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%define table output
n = [1 2 4 12];
fixedCredit_table = struct2table(struct('Annual_Compound_Rates',n','Amount_Owed_After_Five_years',owed'));
end

