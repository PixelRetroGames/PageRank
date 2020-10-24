function R = Iterative(name, d, eps)
    % Recursive Page Rank that calculates the R vector
    % Inputs:
    %	-> name: name of input file;
    %	-> d: the probability of a user to continue the navigation to the next page.
    %	-> eps: acceptable error;
    % Outputs:
    %	-> R: Page Rank vector that contains the ranking for each page. 
    in = fopen(name, "rt");
    N = fscanf(in, "%d ", 1);
    A = zeros(N, N);
    K = zeros(N, N);
    for j = 1 : N
        [sq] = fscanf(in, "%d %d ", 2);
        i = sq(1);
        nr = sq(2);
        K(i, i) = nr;
        while nr > 0
            nr--;
            node = fscanf(in, "%d ", 1);
            A(i, node) = 1;
        end
        % If the node has link to itself
        if A(i, i) == 1
            A(i, i) = 0;
            K(i, i)--;
        end    
        K(i, i) = 1 / K(i, i);
    end
    fclose(in);
    
    % Iterative algorithm
    M = transpose(K * A);
    R = ones(N, 1);
    R = R ./ norm(R, 1);
    prev_R = inf * ones(N, 1);
    M2 = (d * M) + (((1 - d) / N) * ones(N, N));
    while norm(R - prev_R, 2) > eps
        prev_R = R;
        R = M2 * prev_R;
    end  
    R = prev_R;
end  
