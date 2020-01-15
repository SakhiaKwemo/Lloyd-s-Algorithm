function centroids = calcCentroids(agentPoints, mass, density,...
    agentPositions,partitions)
%% calcCentroids
% Calculates the centroid of each agent's observed region
%
% Parameters:
%   agentPoints
%     n-by-1 cell array, where cell i contains agent i's observed points
%   mass
%     n-by-1 vector where the ith entry is the mass of agent i's observed
%     region
%   density
%     (sides*partitions)-by-(sides*partitions) matrix of the density for
%     the current iteration
%   agentPositions
%     n-by-2 vector of the x, y positions for n agents
%   partitions
%     Number of subdivisions within each unit length of the arena
%
% Returns:
%   centroids
%     n-by-2 vector of the x, y positions of the centroids of each region

      
    m = size(mass,1); 
    centroids = zeros(m,2);

    for i = 1: m
        a = 0; 
        b = 0;
        
        p = agentPoints{i};
        
        for j = 1: size(p,1)
            d = density(partitions*p(j,2),partitions*p(j,1)); 
            a = a + (p(j,1) * d); 
            b = b + (p(j,2) * d);
        end
        
        if isinf(mass(i)) == 1 || isnan(mass(i)) == 1
            
            a1 = 0; 
            b1 = 0; 
        else 
            a1 = a/mass(i);
            b1 = b/mass(i);
            centroids(i,1) = a1; 
            centroids(i,2) = b1; 
        end
    end 
end 
