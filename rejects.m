function Rejects = rejects(adjMatrix) %agentPositions

    m = size(adjMatrix); 
    Rejects = cell(1,1);
    for i = 1:m 
        r = 0; 
        for j = 1:m 
            if (adjMatrix(i,j) == 1 && i ~= j)
                r = r +1;
            end
        end
        
        if r == 0
            if isempty(Rejects{1})
                Rejects{1} = i;
            else 
                s = size(Rejects,2);
                Rejects{s + 1} = i;
            end
        end
    end
end

%newCell{i} = [0,1];
