function [commCells,adjMatrix,r] = communication(agentPositions,rComm)
%% communication
% Determines the adjacency matrix and communication cells of all agents
%
% Parameters:
%   agentPositions
%     n-by-2 vector of the x, y positions for n agents
%   rComm
%     Radius of communication for all agents
%
% Returns:
%   commCells
%     Cell array, where each cell is one communication group
%   adjMatrix
%     The symmetric adjacency matrix 

    m = size(agentPositions,1); 

    commCells = cell(1,2); 
    adjMatrix = zeros(m,m);

    %This is the function for the adjency Matrix which assign a 1 to all the
    %agents that are able to communicate with ech other

    for i = 1:m
        for  j = 1:m
            if ((agentPositions(i,1) - agentPositions(j,1))^2 + (agentPositions(i,2)- agentPositions(j,2))^2) <= rComm^2       
            adjMatrix(i,j) = 1;
            end 
        end
    end

        %Once the matrix is done, you need to group together all the agents that are able to communicate with each other 

        for i = 1: m
            for j = 1: m
                if adjMatrix(i,j) == 1 && (i ~= j)   %If 2 agents are able to communicate with each other (and they are not the same)
                    array1 = contain(commCells,i); %This checks if the first agent is already in a commmunication group
                    array2 = contain(commCells,j); %This checks if the other agent is already in a communication group

                    %1st possibility = [0,1]

                    if array1(1) == 0              %If the first agent is not in a communication group already
                        if(array2(1) == 1)         %But the first agent is, than we put the first agent in the group where the second agent is
                            p = array2(2);
                            commCells{p} = [commCells{p}; i];

                    %2nd possibility = [0,0]      %If the both agents are not in any cell array, put both of them in a new Cell Array  

                        else
                            if isempty(commCells{1}) %if the first cell in the cell array is empty put both values in there
                                commCells{1} = [i; j];
                            else
                                s = size(commCells,1); %If the first cell in the cell array is not empty, put both values in the next space in the cell array
                                commCells{s+1} = [i; j];
                            end
                        end

                     %3rd possibility = [1,0]     

                    else 
                        if array2(1) == 0         %If the first agent is is already in a cell array but the other agent isn't.....
                            p = array1(2);        %Find the location of the 1st agent 
                            commCells{p} = [commCells{p}; j]; %Add agent j to the cell of the first agent

                     %4th possibility = [1,1]  

                        %Which means that both agents
                        %are already in a communication group, in that case you
                        %want to place all the values from one agent's
                        %communciation group into the other. 
                        else 
                            q = array2(2);        %Find the location of the second agent
                            p = array1(2);        %Find the location of the first agent
                            if p ~= q   %This makes sure that they are both not already in the same area
                                if p < q
                                    new = commCells{q};               %Take all the values from the second agent's cell
                                    commCells{p} = [commCells{p}  new]; %Copy them into the cell of the first agent
                                    commCells{q} = [];                 %Delete all the values in the second agent's cell
                                else 
                                    new = commCells{p};                 %Take all the values from the first agent's cell
                                    commCells{q} = [commCells{q} new];   %Copy them into the cell of the second agent
                                    commCells{p} = [];                  %Delete all the values in the firs agent's cell
                                end
                            end
                        end
                    end
                end 
            end 
        end 

        r = rejects(adjMatrix); 
        
        commCells(end + 1:end+length(r)) = r; %This gives an array of all the agents that communicate independantly (which means they only communicate with themselves)


        commCells = commCells(~cellfun('isempty',commCells));  %Delete any empty cells in the commCells array
end
