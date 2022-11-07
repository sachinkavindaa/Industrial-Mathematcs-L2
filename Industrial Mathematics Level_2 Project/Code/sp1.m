function [x_new,y_new] = sp1(x0,y0,x1,y1,n,r)
x=x0:((x1-x0)/n):x1;
y=((y1-y0)/(x1-x0))*x+y0-((y1-y0)/(x1-x0))*x0;
m=(y1-y0)/(x1-x0);
T=abs(atan(m));
s=length(x);
x_new=zeros(1,s);
y_new=zeros(1,s);
for i=1:s
  x_new(i)=x(i)+r*(-1)^(i)*sin(T);
  y_new(i)=y(i)+r*(-1)^(i)*cos(T);
end

