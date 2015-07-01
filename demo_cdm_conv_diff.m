epsilon = 0.01;
ue = @(x) (x - exp((x-1)/epsilon) - x .* exp(-1 / epsilon) + exp(-1 / epsilon)) / (1 - exp(-1/epsilon));

% Define boundary condition
u0 = 0;
u1 = 0;

% Crate mesh
n = 100;
h = 1 / n;
m = n - 1;
x = linspace(0, 1, n + 1);

% Assemble linear system

left_coef = -epsilon / (h * h) - 1 / (2 * h);
right_coef = -epsilon / (h * h) + 1 / (2 * h);
center_coef = (2 * epsilon) / (h * h);

A = zeros(m, m);
for i = 1:m
    for j = 1:m
        
        if (i == j)
            A(i, j) = center_coef;
        end
    
        if (j == i - 1)
            A(i, j) = left_coef;
        end
    
        if (j == i + 1)
            A(i, j) = right_coef;
        end
    end
end

b = zeros(m, 1);
for i = 1:m
    
    b(i) = 1;
    
    if (i == 1)
        b(i) = b(i) - left_coef * u0;
    end
    
    if (i == m)
        b(m) = b(m) - right_coef * u1;
    end
end

% Solving linear system
cdm_sol = A\b;
cdm_sol = [u0; cdm_sol; u1];

% Plot solution
plot(x, cdm_sol, '-o',x, ue(x), 'r')
title('Central difference method')
xlabel('x')
