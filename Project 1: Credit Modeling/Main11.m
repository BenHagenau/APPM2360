%Author: Benjamin Hagenau
%Created: 2/4/17

%This is the main script for the APPM 2360 project 1: Credit Modeling.

clear all
close all
clc

%Main
tic
%define equations
compounded = @(r,n,A0,t) (1 + (r/n)).^(n*t) * (A0);
continous = @(r,n,A0,t) (A0*exp(r*t));


%determine credit model for fixed credit
[fixedCredit_table] = fixedCredit(compounded,continous);

%Euler's Method
[A,tfinal] = Euler();

%Euler's Method with a variable interest rate, P = $500 and $750
P = [500 750];
[AmountOwed_table,P500,P750,A2,tfinal2] = EulerVariableInterest(P);

%Euler's Method with variable payment rate
[VariablePayment_table,A,tfinal3] = EulerVariablePayment();

%table: 
%2.1: fixedCredit_table
%2.2: tfinal (time to pay off initial debt of $10,000 be
    %paid of %10,000 , with a constant interest rate of 14% and a monthly payment $750)
%2.3: tfinal2(1) (time to pay off 10,000 with $500 dollar monthly payments APR)
    %tfinal2(2) (time to pay off 10,000 with $750 dollar monthly payments APR)
    %Interest in each case above
%2.4: tfinal3 (time to pay off 10000 with variable payment)
    %DATA (size of loan payed in 20 years)

Table22 = struct2table(struct('Time_to_Pay_10000',tfinal));

TABLES = struct('Table21',fixedCredit_table,'Table22',Table22,'Table23',AmountOwed_table,...
'Table24',VariablePayment_table);
toc


