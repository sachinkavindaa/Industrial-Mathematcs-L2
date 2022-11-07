% Coefficients
m = 3 ;         % Mass, kg
k = 20 ;        % Spring constant, N/m
c = 2 ;         % Damper constant, Ns/m
f0= 10 ;        % Excitation force amplitude, N
f = 0.5;        % Excitation force frequency, Hz

% Degrees of freedom
N = 3 ;

% Solver inputs
tmax = 30 ;     % Maximum solution time
vi = 0 ;        % Initial velocity of 1st DoF

% Matrices
M = diag(repmat(m, 1, N)) ;
K = tridiag(repmat(k, 1, N+1)) ;
C = tridiag(repmat(c, 1, N+1)) ;
F = diag(repmat(f0, 1, N)) ; 
Phi = linspace(2*pi/N,2*pi,N)' ; % <-- Change to [1 2 3]'

% ODE Solution
tspan = [0 tmax] ;
y0 = [zeros(1, N) vi zeros(1, N-1)] ;

[t, y] = ode45(@(t, y) odefcn(t, y, M, K, C, F, Phi, f, N), tspan, y0) ;

[Ec, En, Ee] = energy(t, y, M, K, C, F, Phi, f, N) ;

% Plotting
fig = figure;
gcf = fig ;
fig.Color = 'w' ;
fig.Position = [400 200 900 500] ;

subplot(2, 1, 1)
    yyaxis right
    plot(t, y(:,1:N))
    ylabel('Displacement (m)') ;

yyaxis left
    plot(t, y(:,N+1:2*N))
    ylabel('Velocity (m/s)') ; xlabel('Time (s)') 
    legend(sprintfc('Mass %d',1:N),'Location','Northoutside','Orientation','Horizontal')
    grid on

subplot(2, 1, 2)
    yyaxis right
    plot(t, [Ec En Ee])
    ylabel('Energy (J)') ;

    yyaxis left
    plot(t, sum([Ec En -Ee], 2))
    legend('Total Energy', 'Kinetic + Potential Energy', 'Dissipated Energy','Input Energy','Location','Northoutside','Orientation','Horizontal') 
    ylabel('Energy (J)') ;  xlabel('Time (s)')
    grid on

% Energy function
function [Ec, En, Ee] = energy(t, ymat, M, K, C, F, Phi, f, N) 

% Indexes
i = N ; 
j = N+1 ; 
k = 2*N ; 

% Extract Variables
y  = ymat(:, 1:i)' ;
dy = ymat(:, j:k)' ;

% Energy/Power Equations
KE = 0.5 * dy' * M * dy ;                       % Kinetic energy
PE = 0.5 * y' * K * y ;                         % Potential energy
DP = dy' * C * dy ;                             % Dissipated power
EP = abs(dy' * F*sin(2*pi*f*t' - Phi)) ;        % Excitation power

Ec = diag(KE + PE) ;                            % Sum of potential & kinetic energy
En = cumtrapz(t,diag(DP)) ;                     % Integrated dissipated power over time
Ee = cumtrapz(t,diag(EP)) ;                     % Integrated excitation power

end

% ODE function
function dydt = odefcn(t, y, M, K, C, F, Phi, f, N)

% Indexes
i = N ;
j = N+1 ;
k = 2*N ;

% Preallocate
dydt = zeros(k, 1) ;

% Equation
dydt(1:i) = y(j:k) ;
dydt(j:k) = M \ (-C*y(j:k) -  K*y(1:i) + F*sin(2*pi*f*t - Phi)) ;

end

% Tri-diagonal matrix function
function X = tridiag(x_c)

 x(:,:,1) = diag(x_c(1:end-1)) ;
 x(:,:,2) = diag(x_c(2:end)) ;
 x(:,:,3) = diag(-x_c(2:end-1), -1);
 x(:,:,4) = diag(-x_c(2:end-1), 1) ;

 X = sum(x,3) ;

end