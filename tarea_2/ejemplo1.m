function xp=ejemplo1(t,x)
global u
u = 0.2*sin(0.1*t)+0.5*sin(10*t);
a=10;
b=20;
xp=-(a)*(x)+(b)*u;
end