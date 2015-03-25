clc; clear all; format long 

% Define target function and its devierate
f  = @(x) sqrt(10 ./ (4+x));

x0       = 2; 
maxIter = 100;
tol     = 1e-12;

iter = 1;
while iter <= maxIter
    fprintf('Before iteration %d, x = %f \n', iter-1, x0)
    x1 = f(x0);
    if (abs(x0 - x1) < tol)
        break
    end
    x0 = x1;
    iter = iter + 1;
end
fprintf('After iteration %d, the approximate solution x = %f is obtained. \n', iter, x0)