function R = Algebraic(name, d)
    % Algebraic Page Rank
    % Inputs: 
    %	-> name: name of the input file;
    %	-> d: the probability of a user to continue the navigation to the next page.
    % Outputs:
    %	-> R: Page Rank vector that contains the ranking for each page
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
    
    M = transpose(K * A);
    X = (eye(N) - d * M);
    X_inv = PR_Inv(X);
    R = X_inv * ((1 - d) / N) * ones(N, 1);    
end  