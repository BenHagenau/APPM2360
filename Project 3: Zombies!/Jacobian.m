%Author: Benjamin Hagenau
%Created: 4/12/17
%APPM 2360
%Project 3: Zombies!!!

function [J1,J2,V1,V2,D1,D2] = Jacobian(N0,gamma,beta,alpha,rho)

%Equ. for no antidote: 1:(0,0), 2:(0,N0)
J = @(Z,S) [-beta*Z -beta*S; beta*Z-gamma-alpha*Z beta*S-gamma-alpha*S];

%find jiacobian
J1 = J(0,0);
J2 = J(0,N0);

%find eigenstuff
[V1,D1] = eig(J1);
[V2,D2] = eig(J2);

%extract eigenvalues 
D1 = diag(D1);
D2 = diag(D2);

%write output
fprintf('If one eig value is real and positive equ. point is unstable\n')
fprintf('For equilibrium point (0,0): \n')
fprintf('Eigenvalues: %d, %d\n',D1(1),D1(2))
fprintf('Eigenvecters: \n')
V1

fprintf('For equilibrium point (0,N0): \n')
fprintf('Eigenvalues: %d, %d\n',D2(1),D2(2))
fprintf('Eigenvecters: \n')
V2




