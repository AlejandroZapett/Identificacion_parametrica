clc;
clear all;
close all;
global u;

tf=50;
dt=0.001;
ts=0:dt:tf;

condiciones_iniciales=[5];
[t,x]=ode45('ejemplo1',ts,condiciones_iniciales);

y=ejemplo1(t,x);
pred=[x,u];
[r,theta]=mincuad(y,pred);
theta

%% Plot area
plot(t,y);hold on;xlabel('tiempo [s]');
plot(t,theta(1)*x+theta(2)*u);legend('medición','modelo');
% Rastreo de la estimación
figure; plot(t,r(:,1));xlabel('tiempo [s]');ylabel('alpha');
figure; plot(t,r(:,2));xlabel('tiempo [s]');ylabel('beta');