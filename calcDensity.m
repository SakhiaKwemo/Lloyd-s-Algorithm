function density = calcDensity(iteration,sides,partitions)
%% calcDensity
% Calculates the density matrix for the given iteration
%
% Parameters:
%   D
%     Symbolic function of x, y, t, or matrix of symbolic functions of t
%   iteration
%     The current iteration
%   (optional) sides
%     Side length of the arena
%   (optional) partitions
%     Number of subdivisions within each unit length of the arena
%
% Returns:
%   density
%     (sides*partitions)-by-(sides*partitions) matrix of doubles
%     representing discretized density for the given iteration

    m = sides*partitions;
    density = zeros(m,m);
    
    if m <= 100
        for i = 1:m
            for j = 1:m
                density(i,j) = calculateD(i,j,iteration);
            end 
        end
    end 
    
    function D = calculateD(x,y,t) 
        a = sides/2; 
        b = a + (sides/4);
        if (x > (a+t-5) && y > (a+t)) && (x < (b+t+10) && y < (b+t))
            D = 1;
            
        else 
            D = 0.5;
        end
    end 
end

%Can we use this as a density function, although it is not really a density
%function?

%How do you imcoporate the density time in the function??
