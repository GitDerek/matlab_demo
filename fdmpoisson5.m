%FDMPOSSITION5
%   Solve the Poisson problem u_{xx} + u_{yy} = f(x,y) on [0,1] x [0,1].  
%   The 5-point Laplacian is used at interior grid points. 
%   This system of equations is then solved using backslash.
clear

%% example 1
f = @(x, y) (5 / 4) * exp(x + (y / 2));
ue = @(x, y) exp(x + (y / 2));

%% Spatial dispersion
n = 64                                  % numbers of cell
h = 1 / n;                              % mesh size
m = n - 1;                              % numbers of unknows
x = linspace(0, 1, n + 1);              % grid points x including boundaries
y = linspace(0, 1, n + 1);              % grid points y including boundaries
[X, Y] = ndgrid(x, y);                  % convert to 2D mesh structure
Iint = 2:n;                             % indices of interior points in x
Jint = 2:n;                             % indices of interior points in y

%% Initialization

uexact = ue(X, Y);                      % true solution for test problem

uh = uexact;                            % This sets full array, but only boundary values
                                        % are used below.  For a problem where utrue
                                        % is not known, would have to set each edge of
                                        % usoln to the desired Dirichlet boundary values.
                            
%% form matrix A: 
A = sparse(m*m, m*m);
for i = 1:m*m
    
    % center
    A(i, i) = -4;
    
    % right
    if i+1 <= m*m && mod(i, m) ~= 0
        A(i,i+1) = 1;
    end
    
    % upper
    if i+m <= m*m
        A(i,i+m) = 1;
    end
    
    % left
    if i-1 >=1 && mod(i-1, m) ~= 0
        A(i,i-1) = 1;
    end
       
    % bottom
    if i-m >=1
        A(i,i-m) = 1;
    end
end

% assemble the righ hand side vector
rhs = h^2 * f(X(Iint, Jint), Y(Iint, Jint));        % evaluate f at interior points for right hand side

% adjust the rhs to include boundary terms:
rhs(:, 1) = rhs(:, 1) - ue(x(Iint), 0)';                  % bottom
rhs(:, m) = rhs(:, m) - ue(x(Iint), 1)';                  % upper
rhs(1, :) = rhs(1, :) - ue(0, y(Iint));                   % left
rhs(m, :) = rhs(m, :) - ue(1, y(Iint));                   % right

% convert the 2d grid function rhs into a column vector for rhs of system
rhs = reshape(rhs, m*m, 1);

%% Solving linear system
usol = A\rhs;

% reshape vector solution usol as a grid function and 
% insert this interior solution into uh for plotting purposes:
% (recall boundary conditions in usoln are already set) 
uh(Iint, Jint) = reshape(usol,m,m);


%% assuming true solution is known and stored in uexact:
maxerr = max(max(abs(uh-uexact)));   
L1error = h*h*sum(sum(abs(uh - uexact)));
L2error = sqrt(h*h*sum(sum(abs(uh - uexact).^2)));
fprintf('h = 1/%d , max error= %10.6e\n',n,maxerr)
fprintf('h = 1/%d , L1  error= %10.6e\n',n,L1error)
fprintf('h = 1/%d , L2  error= %10.6e\n',n,L2error)


%% Plot
figure(1)
mesh(X,Y,uh);
xlabel('x');
ylabel('y');
title('Numerical Solution')

figure(2)
mesh(X,Y,uexact);
xlabel('x');
ylabel('y');
title('Exact solution')