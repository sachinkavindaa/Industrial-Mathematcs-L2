load jc input1D slow.mat;

N=length(m);
w square=zeros(N,1);
w square(1)=(k(1)+k(N))/m(1);
for counter=2:1:N
    w square(counter)=(k(counter)+k(counter-?1))/m(counter);
end
c square=zeros(N,1);
for counter=1:1:N
c_square(counter)=k(counter)/m(counter);
end
%setup S matrix such that S*A=omegaˆ2*A
figure;
S=diag(w_square);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%below three lines is the mass-?mechanical ground springs
for counter=1:1:N
S(counter,counter)=S(counter,counter)+2*ks(counter)/m(counter);
end
for gamma=0:pi/N/1000:pi/N
S(1,2)=-c_square(1,1)*exp(i*gamma);
for counter=2:1:N-1
S(counter,counter+1)=-c_square(counter,1)*exp(i*gamma);
S(counter,counter-1)=-(w_square(counter,1) ...
-c_square(counter,1))*exp(-i*gamma);
end
S(N,N-1)=-(w_square(N,1) -c_square(N,1))*exp(-i*gamma);
%periodic BC
S(1,N)=-(w_square(1,1) -c_square(1,1))*exp(-i*gamma);
S(N,1)=-c_square(N,1)*exp(i*gamma);
[a b]=eig(S);
for points=1:1:N
plot(gamma*N,sqrt(b(points,points))/2/3.14);

hold on;
end
end
% Create xlabel
xlabel('Reduced wavenumber, ngammaN','FontSize',14,'FontName','Arial');
% Create ylabel
ylabel('Frequency (Hz)','FontSize',14,'FontName','Arial');
% Create title
axis([0 pi 0 4.5e6]);
