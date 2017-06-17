function [ index ] = cc( vector_a, vector_b )
    vector_b = [vector_b, zeros(1, length(vector_b))];
    min_err = 10000;
    index = 0;
    for i = 1:length(vector_a)
        temp_err = 0;
        for j = 1:length(vector_a)
            temp_err = temp_err + ...
                (vector_a(1, j) - vector_b(1, i + j - 1)).^2;
        end
        if (temp_err < min_err)
            min_err = temp_err;
            index = i - 1;
        end
    end
    if (max(vector_a) > max(vector_b)) 
        index = index * (-1);
    end    
%     [val_a, i_a] = max(vector_a);
%     [val_b, i_b] = max(vector_b);
%     index = i_a - i_b;
end

