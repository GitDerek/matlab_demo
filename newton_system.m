%NEWTON_SYSTEM - Demo of Newton's method for 2-dimensional problem
% March 25, 2015  

clear all;

% Define target functions and their devierates
f1   = @(x, y) 4 * x.^2 - y.^2;
f2   = @(x, y) 4 * x * y.^2 - x - 1;
dxf1 = @(x, y) 8 * x;
dyf1 = @(x, y) -2 * y;
dxf2 = @(x, y) 4 * y.^2 - 1;
dyf2 = @(x, y) 8 * x .* y;

x = 0;                          % initial guess
y = 1;                          % initial guess
maxIter = 100;                  % maximum number of iterations
tolFun  = 1e-12;                % termination tolerance on the function value
tolX    = 1e-12;                % termination tolerance on x

f1val = f1(x, y);
f2val = f2(x, y);
for iter = 1:maxIter
    fprintf('Before iteration %d, (x, y) = (%f, %f), f1(x) = %e, f2(x) = %e\n', iter-1, x, y, f1val, f2val)
    x0 = x;
    y0 = y;
    
    % Jacobian matrix
    jac = [dxf1(x, y) dyf1(x, y);
           dxf2(x, y) dyf2(x, y)];
    
    % Solve linear system for delta_h
    delta_h = jac \ -[f1val; f2val];
    
    % Update solutions
    x = x0 + delta_h(1);
    y = y0 + delta_h(2);
    f1val = f1(x, y);
    f2val = f2(x, y);
    
    % Check termination tolerance on x and the function value,
    if (abs(x - x0) < tolX && abs(y - y0) < tolX) || (abs(f2val) < tolFun && abs(f1val) < tolFun)
        break
    end
end
fprintf(' After iteration %d, (x, y) = (%f, %f), f1(x) = %e, f2(x) = %e\n', iter, x, y, f1val, f2val)
