%Author: Benjamin Hagenau
%Created: 4/12/17
%APPM 2360
%Project 3: Zombies!!!

clear all
clc

%main
plotsettings

%Assign parameter values
alpha = 0.00001; beta = 0.00003; gamma = 0.00001; N0 = 50000; rho = 0.4;

%Equations
    %without antidote
    dSdt = @(S,Z) -beta*Z*S;
    dZdt = @(S,Z) beta*Z*S + gamma*(N0 - S - Z) - alpha*Z*S;
    %with antidote
    dSdtA = @(S,Z) -beta*Z*S + rho*Z;
    dZdtA = @(S,Z) beta*Z*S + gamma*(N0 - S - Z) - alpha*Z*S - rho*Z;

%% 4: Analysis
% Set length of simulation
tspan = [0 35];
% Set initial conditions
y0 = [49999; 1; 49999; 1];
% Solve system
[t,y] = ode45(@(t,y) szr(t,y,alpha,beta,gamma,N0,rho), tspan, y0);

%% plot solutions to differential equations (with and without antidote)
[S,Z] = meshgrid(0:1000:49999,0:1000:49999); 
%without antidote
figure
hold on
plot(t,y(:,1:2))
title('Susceptibles vs Zombies: without antidote')
xlabel('time, days')
ylabel('population')
legend('Susceptibles','Zombies')
hold off

%with antidote
figure
hold on
plot(t,y(:,3:4))
title('Susceptibles vs Zombies: with antidote')
xlabel('time, days')
ylabel('population')
legend('Susceptibles','Zombies')
hold off

%phase portrait without antidote
figure
hold on
plot(y(:,1),y(:,2))
plot(y(1,1),y(1,2),'or')
plot([0 0], [0 5*10^4],'--r') %nullcline
plot([0 5*10^4], [0 0],'--r') %nullcline
quiver(S,Z,-beta.*Z.*S,beta.*Z.*S + gamma*(N0 - S - Z) - alpha.*Z.*S)
title('Susceptibles vs Zombies: phase portrait without antidote')
xlabel('susceptable')
ylabel('zombie')
legend('growth','starting point','verticle nullcline','horizontal nullcline')
hold off

%phase portrait with antidote
%define equilibrium point
S_equ = rho/beta; 
Z_equ = (gamma*N0 - gamma*S_equ)/(gamma - alpha*S_equ);
%plot
figure
hold on
plot(S_equ,Z_equ,'*k')
plot(y(:,3),y(:,4))
plot(y(1,3),y(1,4),'or')
quiver(S,Z,-beta.*Z.*S + rho.*Z,beta.*Z.*S + gamma.*(N0 - S - Z) - alpha.*Z.*S - rho.*Z)
title('Susceptibles vs Zombies: phase portrait with antidote')
xlabel('susceptable')
ylabel('zombie')
legend('Equilibrium Point')
hold off

%determine jacobian and evaluate them at equilibrium points (c) find eigen values of jacobian at each equilibrium point
[J1,J2,V1,V2,D1,D2] = Jacobian(N0,gamma,beta,alpha,rho);

%% loop through and solve DE for many starting conditions
%with antidote
figure
for i = 1:50
    [S,Z] = meshgrid(0:1000:49999,0:1000:49999); 
    %randomly determine starting conditions
    z0 = randi(49999);
    s0 = randi(49999);
    % Set length of simulation
    tspan = [0 35];
    % Set initial conditions
    y0 = [s0; z0; s0; z0];
    % Solve system
    [t,y] = ode45(@(t,y) szr(t,y,alpha,beta,gamma,N0,rho), tspan, y0);
    %plot equilibrium points
    hold on
    plot(S_equ,Z_equ,'*k')
    plot(y(:,3),y(:,4))
    plot(y(1,3),y(1,4),'or')
    %plot phasae portrait
    quiver(S,Z,-beta.*Z.*S + rho.*Z,beta.*Z.*S + gamma.*(N0 - S - Z) - alpha.*Z.*S - rho.*Z)
    title('Susceptibles vs Zombies: phase portrait with antidote')
    xlabel('susceptable')
    ylabel('zombie')
    ylim([0 50000])
    xlim([0 50000])
    legend('Equilibrium Point')
end
hold off

%without antidote
figure
for i = 1:100
    [S,Z] = meshgrid(0:1000:49999,0:1000:49999); 
    %randomly determine starting conditions
    z0 = randi(49999);
    s0 = randi(49999);
    % Set length of simulation
    tspan = [0 35];
    % Set initial conditions
    y0 = [s0; z0; s0; z0];
    % Solve system
    [t,y] = ode45(@(t,y) szr(t,y,alpha,beta,gamma,N0,rho), tspan, y0);
    %plot
    hold on
    plot(y(:,1),y(:,2))
    plot(y(1,3),y(1,4),'or')
    quiver(S,Z,-beta.*Z.*S, beta.*Z.*S + gamma.*(N0 - S - Z) - alpha.*Z.*S)
    title('Susceptibles vs Zombies: phase portrait without antidote')
    xlabel('susceptable')
    ylabel('zombie')
    ylim([0 50000])
    xlim([0 50000])
end
hold off

%% NUKE THESE GOD DAMN ZOMBIES (southern accent)
%use nuke to enielate the contained zombie problem so the rest of the world
%can live

%solve progression before nuke
y0 = [49999; 1];
tspan = [0 13];
[t1,y1] = ode45(@(t,y) NUKE1(t,y,alpha,beta,gamma,N0,rho), tspan, y0);

%solve progression post nuke
tspan = [13 35];
y0 = [1000; 0]; %100 surevive the nuke
[t2,y2] = ode45(@(t,y) NUKE2(t,y,alpha,beta,gamma,N0,rho), tspan, y0);

%plot
figure
hold on
plot(t1,y1(:,1),'b')
plot(t1,y1(:,2),'r')
plot(t2,y2(:,1),'b')
plot(t2,y2(:,2),'r')
plot([13 13], [0 5*10^4],'--k')
title('Nuke Solution')
xlabel('time, days')
ylabel('population')
legend('Susceptibles','Zombies')
hold off









