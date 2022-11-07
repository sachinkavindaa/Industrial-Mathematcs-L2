% Problem parameters

k1=100; % Mass 1 spring constant (i/m)
k2=200; % Mass 2 spring constant (i/m)
k3=300; % Mass 2 spring constant (i/m)
m1=100; % Mass 1 mass (kg)
m2=100; % Mass 2 mass (kg)

%Mass matrix
M = diag([m1 m2]); 

%Spring stifness matix
K1 = diag([-k1, k2 + k3, k3]) ;
K2 = diag([-k2, -k3], 1) ;
K = K1 + K2 ;



% Set time step stuff
h=0.01; % simulation time step
t = 0:h:50;

%Inatial Conditions 
x1 = zeros(1,numel(t)); 
y1 = x1;
x1(1) = 0.01;
x2(1) = 0;

%ODE equations
f1=@(x1,x2) (-(k1*x1-k2*(x2-x1))/m1);
f2=@(x1,x2) (-(k2*(x2-x1)+k3*x2)/m2);



%Loop
for i=1:(length(t)-1)
    
    k1x1 = f1(x1(i),  x2(i));
    k1x2 = f2(x1(i),  x2(i));
    
    k2x1 = f1(x1(i)+h/2*k1x1,  x2(i)+h/2*k1x2);
    k2x2 = f2(x1(i)+h/2*k1x1,  x2(i)+h/2*k1x2);
    
    k3x1 = f1(x1(i)+h/2*k2x1,  x2(i)+h/2*k2x2);
    k3x2 = f2(x1(i)+h/2*k2x1,  x2(i)+h/2*k2x2);
    
    k4x1 = f1(x1(i)+h*k3x1,  x2(i)+h*k3x2);
    k4x2 = f2(x1(i)+h*k3x1,  x2(i)+h*k3x2);
    
    x1(i+1)=x1(i)+h/6 *(k1x1 + 2*k2x1 + 2*k3x1 + k4x1);
    x2(i+1)=x2(i)+h/6 *(k1x2 + 2*k2x2 + 2*k3x2 + k4x2);
    
end

%Plotting 
hold on
plot(t,x1,'r')
xlabel('Time (s)','fontweight','bold')
ylabel('Mass Positioin (m)','fontweight','bold')
plot(t,x2,'b')
legend('Mass 1','Mass 2')
title('Two Mass Spriig Mass System');


