
% Problem parameters
k1=100; % Mass 1 spring constant (i/m)
k2=200; % Mass 2 spring constant (i/m)
k3=300; % Mass 2 spring constant (i/m)
m1=100; % Mass 1 mass (kg)
m2=100; % Mass 2 mass (kg)

% Set time step stuff
simTime=9; % simulation time (s)
h=0.01; % simulation time step
iteration=simTime/h;

%Motion
f1=@(t,x1,x2) (-(k1*x1-k2*(x2-x1))/m1);
f2=@(t,x1,x2) (-(k2*(x2-x1)+k3*x2)/m2);

%Inatial Conditions
t(1) = 0;
x1(1) = 0.01;
x2(1) =0;



% iterative process of solviing the ODE's with Rungekutta 4th order Method

for i = 1:iteration
    t(i+1) = t(i)+h;
    
    k1x1 = f1(t(i) ,  x1(i),  x2(i));
    k1x2 = f2(t(i) ,  x1(i),  x2(i));
    
    k2x1 = f1(t(i)+h/2 ,  x1(i)+h/2*k1x1,  x2(i)+h/2*k1x2);
    k2x2 = f2(t(i)+h/2 ,  x1(i)+h/2*k1x1,  x2(i)+h/2*k1x2);
    
    k3x1 = f1(t(i)+h/2 ,  x1(i)+h/2*k2x1,  x2(i)+h/2*k2x2);
    k3x2 = f2(t(i)+h/2 ,  x1(i)+h/2*k2x1,  x2(i)+h/2*k2x2);
    
    k4x1 = f1(t(i)+h ,  x1(i)+h*k3x1,  x2(i)+h*k3x2);
    k4x2 = f2(t(i)+h ,  x1(i)+h*k3x1,  x2(i)+h*k3x2);
    
    x1(i+1)=x1(i)+h/6 *(k1x1 + 2*k2x1 + 2*k3x1 + k4x1);
    x2(i+1)=x2(i)+h/6 *(k1x2 + 2*k2x2 + 2*k3x2 + k4x2);
    
end
  
  %Plotting 

  hold on;
  plot(t,x1,'r')
  plot(t,x2,'b')
  ylabel('Mass Positioin (m)')
  xlabel('Time')
  legend('Mass 1','Mass 2')
  title('Two Mass Spriig Mass System');
 
  
