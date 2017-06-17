function [ dist ] = dist( a, b )
    dist = ((a(1, 1) - b(1, 1)).^2 ...
        + (a(1, 2) - b(1, 2)).^2 + (a(1, 3) - b(1, 3)).^2).^0.5;
end

