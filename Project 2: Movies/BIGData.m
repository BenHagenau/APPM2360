%Author: Benjamin Hagenau - Zachary Talpas
%Created: 3/5/17

function [bigDATA,D,V] = BIGData(movie)
%This function relates the movies to eachtoher based on genre and computes
%the eiginvalues of this symmetric matrix

for k = 1:7
    if k == 1
        field = 'Action';
    elseif k == 2 
        field = 'Animation';
    elseif k == 3
        field = 'Comedy';
    elseif k == 4
        field = 'Drama';
    elseif k == 5 
        field = 'Documentary';
    elseif k == 6
        field = 'Romance';
    elseif k == 7
        field = 'Short';
    end

    film = eye(212);
    pg_action_matrix = movie.(field);

    for i = 1:212
        if pg_action_matrix(i,1) == 1
            for j = 1:212
                if pg_action_matrix(j,1) == 1
                    film(i,j) = 1;
                end
            end
        end
    end
    bigDATA.(field) = film;
end
    
%create a matrix of all film genre relations
bigDATA.all = bigDATA.Action;    
%overlay the three relationship matrices for action, romance, and drama
for i = 1:212
    for j = 1:212
        if bigDATA.all(i,j) == 0 && bigDATA.Animation(i,j) == 1
            bigDATA.all(i,j) = 1;
        end
        if bigDATA.all(i,j) == 0 && bigDATA.Comedy(i,j) == 1
            bigDATA.all(i,j) = 1;
        end
        if bigDATA.all(i,j) == 0 && bigDATA.Drama(i,j) == 1
            bigDATA.all(i,j) = 1;
        end
        if bigDATA.all(i,j) == 0 && bigDATA.Documentary(i,j) == 1
            bigDATA.all(i,j) = 1;
        end
        if bigDATA.all(i,j) == 0 && bigDATA.Romance(i,j) == 1
            bigDATA.all(i,j) = 1;
        end
        if bigDATA.all(i,j) == 0 && bigDATA.Short(i,j) == 1
            bigDATA.all(i,j) = 1;
        end
    end
end

%determine Eigenvalues and Eigenvectors of the matrix
[V,D] = eig(bigDATA.all);
D = diag(D);

%save eigen vectors and values
bigDATA.allSTATS.eigVEC = V;
bigDATA.allSTATS.eigVAL = D;

%determine largest eigenvalue and corrosponding eigenvector
bigDATA.allSTATS.MAXeigVAL = max(D);
bigDATA.allSTATS.MAXeigVEC = V(:,find(D == max(D)));

%determine the maximum value in the eigen vector and its index
sorteig = sort(abs(bigDATA.allSTATS.MAXeigVEC),'descend');
bigDATA.allSTATS.index = find(abs(bigDATA.allSTATS.MAXeigVEC) == sorteig(1));

%determine movies corrosponding to index
bigDATA.allSTATS.selected = movie(bigDATA.allSTATS.index,:);
movie(bigDATA.allSTATS.index,:)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%determine the best movie for John's
john = bigDATA.Action;    
%overlay the three relationship matrices for action, romance, and drama
for i = 1:212
    for j = 1:212
        if john(i,j) == 0 && bigDATA.Drama(i,j) == 1
            john(i,j) = 1;
        end
        if john(i,j) == 0 && bigDATA.Romance(i,j) == 1
            john(i,j) = 1;
        end
    end
end

bigDATA.johnSTATS.relations = john;

%determine Eigenvalues and Eigenvectors of the matrix
[V,D] = eig(bigDATA.johnSTATS.relations);
D = diag(D);
%save eigenvectors and eigenvalues
bigDATA.johnSTATS.eigVEC = V;
bigDATA.johnSTATS.eigVAL = D;

%sort rows by descending order of eigenvectors and determine the top three
%eigenvalue. determine eigen vector corrosponding to the top three eigen values. 
s = sort(D,'descend');
bigDATA.johnSTATS.MAXeigVAL = s(1:3);
loc1 = find(D == s(1));
loc2 = find(D == s(2));
loc3 = find(D == s(3));
bigDATA.johnSTATS.MAXeigVEC(:,1:3) = V(:,[loc1 loc2 loc3]);

%determine max of each of these eigenvectors
sorteig1 = sort(abs(bigDATA.johnSTATS.MAXeigVEC(:,1)),'descend');
sorteig2 = sort(abs(bigDATA.johnSTATS.MAXeigVEC(:,2)),'descend');
sorteig3 = sort(abs(bigDATA.johnSTATS.MAXeigVEC(:,3)),'descend');
bigDATA.johnSTATS.index(1) = find(bigDATA.johnSTATS.MAXeigVEC(:,1) == sorteig1(1));
bigDATA.johnSTATS.index(2:3) = find(bigDATA.johnSTATS.MAXeigVEC(:,2) == sorteig2(1));
bigDATA.johnSTATS.index(4:6) = find(bigDATA.johnSTATS.MAXeigVEC(:,3) == sorteig3(1));

%determine the corrosponding movies to the eigenvector values and all of
%these movies stats
bigDATA.johnSTATS.top(1,:) = movie(bigDATA.johnSTATS.index(1),:);
bigDATA.johnSTATS.top(2,:) = movie(bigDATA.johnSTATS.index(2),:);
bigDATA.johnSTATS.top(3,:) = movie(bigDATA.johnSTATS.index(4),:);


end
