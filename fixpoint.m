%FIXPOINT - Demo of fixpoint iteration
% March 25, 2015  

clear all;

% Define target function and its devierate
f  = @(x) sqrt(10 ./ (4+x));

x0       = 2;           % initial guess
maxIter = 100;          % maximum number of iterations
tol     = 1e-12;        % termination tolerance on x

iter = 1;
fprintf('Before iteration %d, x = %16.15f \n', 0, x0)
while iter <= 16
    
    x1 = f(x0);

    % Check termaination tolerance on x
    if (abs(x0 - x1) < tol)
        break
    end
    fprintf('Before iteration %d, x = %16.15f \n', iter, x1)
    
    % Update next iteration
    x0 = x1;
    iter = iter + 1;
end
fprintf('After iteration %d, the approximate solution x = %16.15f is obtained. \n', iter, x1)