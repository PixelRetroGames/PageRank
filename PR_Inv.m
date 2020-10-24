function B = PR_Inv(A)
    % Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
    % Dupa ce aflu Q si R folosind Gram-Schmidt, completez coloana cu coloana
    % matricea B, aplicand SST cu matricea R si cate o coloana din matricea Q transpusa
    N = size(A, 1);
    [Q, R] = Gram_schmidt(A);
    Q_t = transpose(Q);
    B = zeros(N, N);
    for i = 1 : N
        B(:, i) = SST(R, Q_t(:, i));
    end
end
    
function [Q, R] = Gram_schmidt(A)
    [n, m] = size(A);
    Q = zeros(n, m);
    for i = 1 : m
        q = A(1 : n, i);
        col_i = q;
        for j = 1 : i - 1
            sp = sum(col_i .* Q(:, j));
            q = q - sp * Q(1 : n, j);
        end
        q = q / norm(q);
        Q(:, i) = q;
    end
    R = transpose(Q) * A;    
end  

function [x] = SST(A, b)
    [n, m] = size(A);
    x = zeros(m, 1);
    
    x(m) = b(m) / A(m, m);
    
    for i = (m - 1) : -1 : 1
        x(i) = (b(i) - A(i, i + 1 : m) * x(i + 1 : m)) / A(i, i);
    end
end