%Author: Benjamin Hagenau
%Created: 4/12/17
%APPM 2360
%Project 3: Zombies!!!

function out = NUKE2(t, y, alpha, beta, gamma, N0,rho)
% Evaluates the right hand side of the SZR model for equations S(t) and Z(t).
% Here, y(t) = [S(t); Z(t)], so y(1) = S(t) and y(2) = Z(t).

%NUKE 'EM
out = [(1/8)*t^2; 0];


