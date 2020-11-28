function V = skew(v)

% Skew-symmetric matrix for cross product

V = [
    0 -v(3) v(2)
    v(3) 0 -v(1)
    -v(2) v(1) 0
    ];

end