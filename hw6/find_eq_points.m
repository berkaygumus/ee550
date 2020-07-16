function [eq_point1,eq_point2] = find_eq_points(lambda)
    v1_array = [];
    v2_array = [];
    v1_dot_array = [];
    v2_dot_array = [];
    for v1 = -1.0:0.001:1.0
       for v2 = -1.0:0.001:1.0
            v1_dot = abs(-v1 + 2/pi*atan(lambda*pi*v2/2));
            v2_dot = abs(-v2 + 2/pi*atan(lambda*pi*v1/2));
            if v1_dot < 0.001 && v2_dot < 0.001
                v1_array = [v1_array v1];
                v2_array = [v2_array v2];
                v1_dot_array = [v1_dot_array v1_dot];
                v2_dot_array = [v2_dot_array v2_dot];
            end
       end
    end
        
    [xs, index] = sort(v1_dot_array);
    if v1_array(index(2)) < v1_array(index(3))
        eq_point1 = [v1_array(index(2)) ; v2_array(index(2))];
        eq_point2 = [v1_array(index(3)) ; v2_array(index(3))];
    else
        eq_point2 = [v1_array(index(2)) ; v2_array(index(2))];
        eq_point1 = [v1_array(index(3)) ; v2_array(index(3))];
    end
end

