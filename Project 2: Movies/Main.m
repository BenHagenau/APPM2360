%Author: Benjamin Hagenau - Zachary Talpas
%Created: 3/5/17

%Project II: PG - MOVIES

clc 
clear all

%Main
load('pg_movies.mat');

%summary of year length and budget
summary(pg_movies(:,2:4));

%small data...
[smallDATA] = SMALLData;

%relate movies with eachother and determine Eiginvalues
[bigDATA,V,D] = BIGData(pg_movies);

%create spy graphs
figure(1)
spy(bigDATA.Action)
title('Sparsity Pattern for Action Movies')
saveas(gcf,'ActionSpy','epsc')
figure(2)
spy(bigDATA.Comedy)
title('Sparsity Pattern for Comedy Movies')
saveas(gcf,'ComedySpy','epsc')

%HERE ARE THE VALUES NEEDED
%%%%%%%%%%%%%%%%%%%%%%%%% SMALL DATA %%%%%%%%%%%%%%%%%%%%%%%%%
%max eigen value = smallDATA.MAXeigVAL
%max eigen vector = smallDATA.MAXeigVEC


%%%%%%%%%%%%%%%%%%%%%%%%% BIGGER DATA %%%%%%%%%%%%%%%%%%%%%%%%%
%best film = bigDATA.allSTATS.top
%Movies for Jonny Boy = bigDATA.johnSTATS.top (best on top third best on bottom)

%found largest eigenvalue and corrosponding eigen vector -> found max of
%eigenvector
%   -> if multiple max values, take the movie with the top rating
%   -> if single max value thats easy money and you have the recommended
%   movie right there under you nose. 
close all






