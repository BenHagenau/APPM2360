%Author: Benjamin Hagenau - Zachary Talpas
%Created: 3/5/17

function [smallDATA] = SMALLData
%This function does small data processing on a given sub matrix

%define matrix
relation = [1 1 0 1 1; 1 1 0 0 0; 0 0 1 1 1; 1 0 1 1 1; 1 0 1 1 1];
%determine eigenvalues and eigenvectors
[V,D] = eig(relation);

D = diag(D);

smallDATA.eigVEC = V;
smallDATA.eigVAL = D;

%determine largest eigenvalue and corrosponding eigenvector
smallDATA.MAXeigVAL = max(D);
smallDATA.MAXeigVEC = V(:,find(D == max(D)));