function [E] = calculate_energy(v1,v2,lambda)
    E = -v1*v2 - 4/(pi*pi*lambda)*( log((cos(pi*v1/2))) + log((cos(pi*v2/2))));
end

