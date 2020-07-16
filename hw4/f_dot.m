function [y] = f_dot(x)
    y = f(x)*(1-f(x));
end

