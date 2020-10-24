function y = Apartenenta(x, val1, val2)
    % Function takes parameters x, val1, val2 and returns the value of the member function in x
    % 0 <= x <= 1 
    a = 1 / (val2 - val1);
    b = -val1 / (val2 - val1);
    if x < val1
        y = 0;
    else if x > val2
        y = 1;
    else
        y = a * x + b;
    end
end