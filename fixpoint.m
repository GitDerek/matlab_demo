%FIXPOINT - Demo of fixpoint iteration
% March 25, 2015  

clear all;
format long

% Define target function and its devierate 
f  = @(x) sqrt(10/(4+x));

x0      = 1.5;           % initial guess
maxIter = 100;          % maximum number of iterations
tol     = 1e-12;        % termination tolerance on x

iter = 1;
[0, x0]
while iter <= maxIter
    
    x1 = f(x0);

    % Check termaination tolerance on x
    if (abs(x0 - x1) < tol)
        break
    end
    [iter, x1]
    
    % Update next iteration
    x0 = x1;
    iter = iter + 1;
end
[iter, x1]