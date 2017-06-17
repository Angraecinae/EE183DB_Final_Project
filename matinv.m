function [ inv ] = matinv( mat )
    inv(1, 1) = mat(2, 2) * mat(3, 3) - mat(2, 3) * mat(3, 2);
    inv(1, 2) = mat(1, 3) * mat(2, 3) - mat(1, 2) * mat(3, 3);
    inv(1, 3) = mat(1, 2) * mat(2, 3) - mat(1, 3) * mat(2, 2);
    inv(2, 1) = mat(2, 3) * mat(3, 1) - mat(2, 1) * mat(3, 3);
    inv(2, 2) = mat(1, 1) * mat(3, 3) - mat(1, 3) * mat(3, 1);
    inv(2, 3) = mat(1, 3) * mat(2, 1) - mat(1, 1) * mat(2, 3);
    inv(3, 1) = mat(2, 1) * mat(3, 2) - mat(2, 2) * mat(3, 1);
    inv(3, 2) = mat(1, 2) * mat(3, 1) - mat(1, 1) * mat(3, 2);
    inv(3, 3) = mat(1, 1) * mat(2, 2) - mat(1, 2) * mat(2, 1);
    
    d = mat(1, 1) * inv(1, 1) ...
        - mat(1, 2) * (mat(2, 1) * mat(3, 3) - mat(2, 3) * mat(3, 1)) ...
        + mat(1, 3) * inv(3, 1);
    
    inv = inv / d;
end

