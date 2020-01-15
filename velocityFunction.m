function deltaPosition = velocityFunction(direction, velocity, dt)
%% velocityFunction
% Determines how much agents move, given a direction and magnitude of
% velocity over one time step
%
% Parameters:
%   direction
%     n-by-2 vector of normalized direction vectors for n agents
%   velocity
%     n-by-1 vector of magnitudes of velcoity of each agent
%   dt
%     Simulated time step
%
% Returns:
%   deltaPosition
%     n-by-2 vector of change in position (deltaX, deltaY) for n agents

    n = size(direction,1); 
    deltaPosition = zeros(n,2); 

   
    for i = 1:n
        if any(isinf(direction(i,:))) && any(isnan(direction(i,:)))  
             deltaPosition(i,1) = 0; 
             deltaPosition(i,2) = 0;
        else
            deltaPosition(i,1) = dt * velocity(i,1) * direction(i,1);
            deltaPosition(i,2) = dt * velocity(i,1) * direction(i,2); 
        end
    end
end
