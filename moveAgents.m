function [agentPositions, distanceTravelled, energy] = moveAgents(agentPositions,...
    centroids, dt, sides, energy, velocityType, maxVelocity, scaleFactor)
%% moveAgents
% Moves each agent towards its assigned centroid. Must ensure agents don't
% move out of bounds.
% 
% Parameters:
%   agentPositions
%     n-by-2 vector of the x, y positions for n agents before moving
%   centroids
%     n-by-2 vector of the x, y centroid locations that agents move towards
%   dt
%     Simulated time step
%   sides
%     Side length of the arena
%   energy
%     n-by-1 vector of agent energy before moving
%   velocityType
%     Either "Constant Velocity" or "Proportional Velocity" as determined
%     in the GUI
%   maxVelocity
%     If velocityType = "Constant Velocity", this is the constant velocity
%     Otherwise, this is the maximum velocity at which agents can travel
%   scaleFactor
%     Used for "Proportional Velocity". Velocity is proportional to 
%     distance between agent and centroid, scaled by the scale factor
%
% Returns:
%   agentPositions
%     n-by-2 vector of x, y positions of for the n agents after moving
%   distanceTravelled
%     1-by-1 vector of distance travelled by each agent this iteration
%   energy
%     n-by-1 vector of agent energy after moving

    n = size(agentPositions, 1);
    distanceTravelled = zeros(n,1);
    direction = zeros(n,2);
    vel = zeros(n,1);

    for i = 1:n
        oldx = agentPositions(i,1);
        oldy = agentPositions(i,2);
        x = oldx - centroids(i,1); 
        y = oldy - centroids(i,2);
        hyp = ((x^2) + (y^2))^0.5; 
        direction(i,1)  = x/hyp; 
        direction(i,2)  = y/hyp; 

        if velocityType == "Constant Velocity"      
                                                                  
            vel(i,1) = maxVelocity;
        end 
        
        if velocityType == "Proportional Velocity" 
            vel(i,1) = hyp*scaleFactor;      
            
        end 
    end 
    
    b = velocityFunction(direction,vel,dt);
    
    for j = 1:n
       
        dx = b(j,1);
        dy = b(j,2);
        newx = oldx + dx; 
        newy = oldy + dy;
         
        d = ((dx^2) + (dy^2))^0.5;
        distanceTravelled = distanceTravelled + d;
        e = energyFunction(b,dt);
        energy(j) = energy(j) + e(j);
        
        if newx > sides 
            agentPositions(j,1) = sides;
        else 
            agentPositions(j,1) = newx; 
        end
        
        if newy > sides
            agentPositions(j,2) = sides;
        else 
            agentPositions(j,2) = newy;
        end
        
        if newx < 0
            agentPositions(j,1) = 0; 
        else 
            agentPositions(j,1) = newx; 
        end
        
        if newy < 0
            agentPositions(j,2) = 0;  
        else 
            agentPositions(j,2) = newy;
        end  
    end
    
    distanceTravelled = sum(distanceTravelled);
end 

%What do you need to use the side parameter for in this??
