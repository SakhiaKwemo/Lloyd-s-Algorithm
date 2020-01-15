%Basically, if the number is contained in the area, this function function will spit out a 1, 
%if it is not contained in the solution the function will spit out a 0.

function array = contain(myCell,ag)

    n = size(myCell,1); 
    a = 0; 
    p = 0;
    for i = 1:n
        array = myCell{i,1};
        m = size(array,1); 
        for j = 1:m
            if array(j) == ag  %Here we are checking the x coordinate point only.  
                a = 1; 
                p = i;  
            end
        end 
    end
    
    array = [a,p];
end
