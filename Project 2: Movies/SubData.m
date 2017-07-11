function [subDATA] = SubData(movie)
%This function relates the movies to eachtoher based on genre and computes
%the eiginvalues of this symmetric matrix

%extract movie genre data 
genre = zeros(212,7);
for i = 1:7
    if i == 1
        field = 'Action';
    elseif i == 2
        field = 'Animation';
    elseif i == 3
        field = 'Comedy';
    elseif i == 4
        field = 'Drama';
    elseif i == 5
        field = 'Documentary';
    elseif i == 6
        field = 'Romance';
    elseif i == 7
        field = 'Short';
    end
    genre(:,i) = movie.(field);
end
%extract movie name data 
name = movie.title;

%determine which movies share genre types
relation = cell(213,213);
relation(2:end,1) = name;
relation(1,2:end) = name;

for i = 1:length(genre) %loop through all movies
    for j = 1:7         %check which genre the movie is
        if genre(i,j) == 1  %if it has the genre...
            for k = 1:length(genre) %loop through all other movies to see if they share genres
                rel = [];           %reset the stored relationship positions
                nonrel = [];        %store positions of no relation
                if genre(k,j) == 1 %check if other movies share the genre
                    rel = [rel k]; %if they share the genre save the movie position
                else
                    nonrel = [nonrel k];    %save postion if not related
                end
                %fill in ones and zeros base don relations 
                if isempty(rel) == 0    %check if the are shared relationships
                    relation{i+1,rel+1} = 1; %store relationship in cell
                end
                if isempty(nonrel) == 0 
                    relation{i+1,nonrel+1} = 0; %place zeros in non related
                end
            end
        end
    end
end
%fill in zeros if there is no movie relation
for w = 1:212
    for l = 1:212
        if isempty(relation{w+1,l+1})
            relation{w+1,l+1} = 0;
        end
    end
end
%extract data matrix of movie relationships
subDATA.relation.mat = cell2mat(relation(2:end,2:end));
subDATA.relation.cell = relation;

%determine Eigenvalues and Eigenvectors of the matrix
[V,D] = eig(cell2mat(relation(2:end,2:end)));
D = diag(D);

subDATA.eigVEC = V;
subDATA.eigVAL = D;

%determine largest eigenvalue and corrosponding eigenvector
subDATA.MAXeigVAL = max(D);
subDATA.MAXeigVEC = V(:,find(D == max(D)));

end
