
% Problem parameters
k1=10; % Mass 1 spring constant (i/m)
k2=30; % Mass 2 spring constant (i/m)
k3=50; % Mass 2 spring constant (i/m)
k4=70; % Mass 3 spring constant (i/m)
m1=5; % Mass 1 mass (kg)
m2=10; % Mass 2 mass (kg)
m3=20;% Mass 3 mass (kg)

% Set time step stuff
simTime=9; % simulation time (s)
h=0.01; % simulation time step
iteration=simTime/h;

%Motion of equations
f1=@(t,x1,x2)    (-(k1*x1-k2*(x2-x1))/m1);
f2=@(t,x1,x2,x3) (-(k2*(x2-x1)+k3*(x3-x2))/m2);
f3=@(t,x1,x2,x3) (-(k3*(x3-x2)+k4*x3)/m3);

%Inatial Conditions
t(1) = 0;
x1(1) = 1;
x2(1) = 5;
x3(1) = -10;


% iterative process of solviing the ODE's with Rungekutta 4th order Method

for i = 1:iteration
    t(i+1) = t(i)+h;
    
    k1x1 = f1(t(i) ,  x1(i),  x2(i));
    k1x2 = f2(t(i) ,  x1(i),  x2(i), x3(i));
    k1x3 = f2(t(i) ,  x1(i),  x2(i), x3(i));
    
    k2x1 = f1(t(i)+h/2 ,  x1(i)+h/2*k1x1,  x2(i)+h/2*k1x2);
    k2x2 = f2(t(i)+h/2 ,  x1(i)+h/2*k1x1,  x2(i)+h/2*k1x2, x3(i)+h/2*k1x3);
    k2x3 = f3(t(i)+h/2 ,  x1(i)+h/2*k1x1,  x2(i)+h/2*k1x2, x3(i)+h/2*k1x3);
    
    k3x1 = f1(t(i)+h/2 ,  x1(i)+h/2*k2x1,  x2(i)+h/2*k2x2);
    k3x2 = f2(t(i)+h/2 ,  x1(i)+h/2*k2x1,  x2(i)+h/2*k2x2, x3(i)+h/2*k2x3);
    k3x3 = f3(t(i)+h/2 ,  x1(i)+h/2*k2x1,  x2(i)+h/2*k2x2, x3(i)+h/2*k2x3);
    
    k4x1 = f1(t(i)+h ,  x1(i)+h*k3x1,  x2(i)+h*k3x2);
    k4x2 = f2(t(i)+h ,  x1(i)+h*k3x1,  x2(i)+h*k3x2, x3(i)+h/2*k3x3);
    k4x3 = f3(t(i)+h ,  x1(i)+h*k3x1,  x2(i)+h*k3x2, x3(i)+h/2*k3x3);
    
    x1(i+1)=x1(i)+h/6 *(k1x1 + 2*k2x1 + 2*k3x1 + k4x1);
    x2(i+1)=x2(i)+h/6 *(k1x2 + 2*k2x2 + 2*k3x2 + k4x2);
    x3(i+1)=x3(i)+h/6 *(k1x3 + 2*k2x3 + 2*k3x3 + k4x3);
    
end
  
  %Plotting 

  hold on;
  plot(t,x1,'r')
  plot(t,x2,'b')
  plot(t,x3,'g')
  ylabel('Mass Positioin (m)')
  xlabel('Time')
  legend('Mass 1','Mass 2','Mass 3')
  title('Three Mass Spriig Mass System');
 
  
