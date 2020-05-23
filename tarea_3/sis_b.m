function dxdt=sis_b(t,x)
global u
u = 0.2*sin(0.1*t)+sin(0.5*t);
a = -10;
b = 3;
c = 2.5;
d = 0.1;
e = 2.5;
dxdt = [a*sin(x(1))+b*x(2).^(1/2)*c*u; d*x(1)+e*x(2)];