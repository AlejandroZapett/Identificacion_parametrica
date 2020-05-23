function dxdt=sis_a(t,x)
global u;
u = 0.2*sin(0.1*t)+sin(0.5*t);
a = -5;
b = 1;
c = 0.5;
d = -10;
e = 1;
dxdt = [a*x(1)+b*x(2)*c*u; d*x(2)+e*u];