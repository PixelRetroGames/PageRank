function [R1 R2] = PageRank(name, d, eps)
    % Computes the Page Rank vector using both the Algebraic and the Iterative method
    % Sorts the pages in order of importance and computes the appartenance factor
    % Output: name.out
    in = fopen(name, "rt");
    N = fscanf(in, " %d ", 1);
    for i = 1 : N
        fgets(in);
    end
    val1 = fscanf(in, " %f ", 1);
    val2 = fscanf(in, "%f", 1);
    fclose(in);
    
    name_out = [name ".out"];
    out = fopen(name_out, "wt");
    fprintf(out, "%d\n\n", N);
    
    R1 = Iterative(name, d, eps);
    fprintf(out, "%.6f\n", R1);
    fprintf(out, "\n");
    
    R2 = Algebraic(name, d);
    fprintf(out, "%.6f\n", R2);
    fprintf(out, "\n");
    
    [R2_s, index] = sort(R2, 'descend');
    
    for  i = 1 : N
        fprintf(out, "%d %d %f\n", i, index(i), Appartenance(R2_s(i), val1, val2));
    end 
    fclose(out);    
end  