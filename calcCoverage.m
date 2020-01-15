function coverage = calcCoverage(agentPoints, partitions,density, totalMass)
%% coverage
% Calculates how much of the arena is being observed as a percentage.
% Considers a weighted average of the density matrix.
%
% Parameters:
%   agentPoints
%     n-by-1 cell array, where each cell is ni-by-2 list of (x,y) points
%     the ith agent is observing
%   partitions
%     Number of subdivisions within each unit length of the arena
%   density
%     (sides*partitions)-by-(sides*partitions) matrix of the density for
%     the current iteration
%   totalMass
%     Mass of entire arena
%
% Returns
%   coverage
%     Percent value between 0 and 1 representing coverage

    totalCovered = 0;

    m = calcMass(agentPoints,density,partitions); 
    n = size(m,1);

    for k = 1:n
        totalCovered = totalCovered + m(k,1);

    end

    coverage = (totalCovered/totalMass); 

end 
