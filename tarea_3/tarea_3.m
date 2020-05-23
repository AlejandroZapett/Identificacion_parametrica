%% Sistema A
clc;
clear all;
close all;

global u;

dt = 0.001;
tf = 10;
ts = 0:dt:tf;
condiciones_iniciales = [0;0];
[t,x]=ode45('sis_a',ts,condiciones_iniciales);

a = -5;
b = 1;
c = 0.5;
d = -10;
e = 1;
u = 0.2*sin(0.1*t)+0.5*sin(10*t);
y1 = a*x(:,1)+b*x(:,2)+c*u; 
y2 = d*x(:,2)+e*u;
y = [y1 y2];

[ren,col]=size(t);
mediciones = ren;
z=zeros(ren,1);
pred = [x(:,1) x(:,2) u z z;z z z x(:,2) u];
[r,theta] = mincuadm(y,pred,mediciones,5,2);
theta

y1_e = theta(1)*x(:,1)+theta(2)*x(:,2)+theta(3)*u; 
y2_e = theta(4)*x(:,2)+theta(5)*u;
y_e = [y1_e y2_e];

%% Sistema B
clc;
clear all;
close all;

global u;

dt = 0.001;
tf = 10;
ts = 0:dt:tf;
condiciones_iniciales = [1;0];
[t,x]=ode45('sis_b',ts,condiciones_iniciales);

u = 0.2*sin(0.1*t)+sin(0.5*t);
a = -10;
b = 3;
c = 2.5;
d = 0.1;
e = 2.5;
y1 = a*sin(x(:,1))+b*x(:,2).^(1/2)+c*u; 
y2 = d*x(:,1)+e*x(:,2);
y = [y1 y2];

[ren,col]=size(t);
mediciones = ren;
z=zeros(ren,1);
pred = [sin(x(:,1)) x(:,2).^(1/2) u z z;z z z x(:,1) x(:,2)];
[r,theta] = mincuadm(y,pred,mediciones,5,2);
theta

y1_e = theta(1)*sin(x(:,1))+theta(2)*x(:,2).^(1/2)+theta(3)*u; 
y2_e = theta(4)*x(:,1)+theta(5)*x(:,2);
y_e = [y1_e y2_e];


%% Plot area

% Antes de ejecutar esta sección, se debe ejecutar el Sistema A o B

% Integración numérica
plot(t,x);
legend('x1','x2');
xlabel('tiempo [s]');
% Rastreo de las estimaciones
figure;plot(t,r);
legend('a','b','c','d','e');
xlabel('tiempo [s]');
% Comparación
figure;plot(t,y);
hold on; plot(t,y_e);
legend('x1 medición','x2 medición','x1 modelo','x2 modelo');
xlabel('tiempo [s]');




