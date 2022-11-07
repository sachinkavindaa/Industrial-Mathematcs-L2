
function xdot = spring3(t,x,m1,m2,m3,k1,k2,k3,k4)
  xdot = zeros(6,1);
  k1 = 1;
  k2 = 1;
  k3 = 1;
  k4 = 1;
  m1 = 1;
  m2 = 1;
  m3 = 1;
  xdot(1) = x(2);
  xdot(2) = -(k1/m1)*x(1)+(k2/m1)*(x(3)-x(1));
  xdot(3) = x(4);
  xdot(4) = -(k2/m2)*(x(3)-x(1))+(k3/m2)*(x(5)-x(3));
  xdot(5) = x(6);
  xdot(6) = -(k3/m3)*(x(5)-x(3))-(k4/m3)*x(5);
  
  
  
function spring3_demo(time)
  
  [t,x] = ode45('spring3',[0 time],[1;0;-1;0;2;0]);
  plot(t,x)
  disp('press any key to continue ...')
  pause
  plot3(x(:,1),x(:,3),x(:,5))
  disp('press any key to continue ...')
  pause
  set(gca,'nextplot','replacechildren');
  for j=1:time-20
    plot(-20,0,'+',20,0,'+',-5+x(j+20,1),0,'o',x(j+20,3),0,'o', 5+x(j+20,5),0,'o ');
    F(j)=getframe;
  end
  disp('press any key to continue ...')
  pause
  movie(F);