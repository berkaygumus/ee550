function [output_layer_o_values] = test_data(input,weight,layers)
    layer_size = size(layers,2);
    max_node = max(layers);
    m = size(input,1);
    s_values = zeros(m,layer_size,max_node);
    o_values = zeros(m,layer_size,max_node);
    
    %% forward propagation
        for i=1:layers(1)
            for sample = 1:m
                s_values(sample,1,i) = input(sample,i);
                o_values(sample,1,i) = (s_values(sample,1,i));
            end
        end

        %layer k >> node i
        %layer k+1 >> node j



        %for layer k+1 : 2 >> output layer = layer_size
        for k=1:layer_size-1
            for j=1:layers(k+1)
                s_values(:,k+1,j) = 0;
                for i=1:layers(k)
                    s_values(:,k+1,j) = s_values(:,k+1,j) + o_values(:,k,i)*weight(k,i,j);
                end
                for sample = 1:m
                    o_values(sample,k+1,j) = f(s_values(sample,k+1,j));
                end
            end       
        end
    %output_layer_o_values = zeros(m,layers(layer_size));
    output_layer_o_values = squeeze(o_values(:,layer_size,1:layers(layer_size)));
end

