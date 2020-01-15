function mass = calcMass(agentPoints,density,partitions)
%% calcMass
% Calculates the mass of the observed region for each agent
%
% Parameters:
%   agentPoints
%     n-by-1 cell array, where cell i contains agent i's observed points
%   density
%     (sides*partitions)-by-(sides*partitions) matrix of the density for
%     the current iteration
%   partitions
%     Number of subdivisions within each unit length of the arena

%
% Returns:
%   mass
%     n-by-1 vector array where the ith entry is the mass of agent i's observed
%     region (x) sum(density(partitions*[x(:,2) x(:,1)]),'all')
 
n = size(agentPoints, 1);
mass = zeros(n,1);

for i = 1: n        
    array = agentPoints{i}; 

    for j = 1: size(array,1)
        x = partitions*array(j,1);
        y = partitions*array(j,2);
        d = density(x,y);  
        mass(i,1) = mass(i,1) + d; 
    end
end

end
