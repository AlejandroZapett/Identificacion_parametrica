

%% Sistema uno
clc;
clear all;
close all;

% Definición del sistema
t=[0:0.1:50];
a=20;
b=3.1416;
%Vector de medición
y=a*sin(t)+b*cos(t);
% Estimación paramétrica
p=2;
%theta=[1:p]'; %en este renglon se genera el vector de parámetros
%con las dimensiones adecuadas, por eso tuve que utilizar el transpuesto '
%al mismo tiempo se le dan unos parámetros inciales cualesquiera
theta = [1;1];
Psi=[p:1];
P=eye(p);
[m,n]=size(t);
for i=1:n
    Psi(1)=sin(t(i));
    Psi(2)=cos(t(i));
    Psi=[Psi(1);Psi(2)];
    est(i) = Psi'*theta;
    e=y(i)-Psi'*theta;
    theta=theta+(P*Psi*e)/(1+Psi'*P*Psi);
    P=P-(P*Psi*Psi'*P)/(1+Psi'*P*Psi);
    % rastreo de los parámetros
    r(i,1)=theta(1);
    r(i,2)=theta(2);
end
theta

% Comparación
plot(t,y);hold on;
plot(t,theta(1)*sin(t)+theta(2)*cos(t));
legend('medición','modelo');
xlabel('tiempo [s]');

%% Sistema dos 

clc;
clear all;
close all;

% Definición del sistema
t=[0:0.1:10];
y=t;
a=20;
b=3.1416;
%Vector de medición
y=a*t.^2+b*(t.^(1/2));
% Estimación paramétrica
p=2;
theta=[1:p]'; %en este renglon se genera el vector de parámetros
%con las dimensiones adecuadas, por eso tuve que utilizar el transpuesto '
%al mismo tiempo se le dan unos parámetros inciales cualesquiera
%theta = [1;1];
Psi=[p:1];
P=eye(p);
[m,n]=size(t);
for i=1:n
    Psi(1)=(t(i))^2;
    Psi(2)=t(i)^(1/2);
    Psi=[Psi(1);Psi(2)];
    est(i) = Psi'*theta;
    e=y(i)-Psi'*theta;
    theta=theta+(P*Psi*e)/(1+Psi'*P*Psi);
    P=P-(P*Psi*Psi'*P)/(1+Psi'*P*Psi);
    % rastreo de los parámetros
    r(i,1)=theta(1);
    r(i,2)=theta(2);
end
theta

% Comparación
plot(t,y);hold on;
plot(t,theta(1)*t.^2+theta(2)*t.^(1/2));
legend('medición','modelo');
xlabel('tiempo [s]');

%% Sistema tres
clc;
clear all;
close all;

% Condiciones iniciales
dt = 0.01;
tf = 5;
x0 = [1];
% Parametros del sistema
a = 0.3;
b = -0.9;

ts=0:dt:tf;
% Solución numérica de la ec. diferencial
[t,x]=ode45('xpto',ts,x0);
plot(t,x);xlabel('tiempo [s]');ylabel('x');
% Vector de mediciones
y = xpto(t,x);
% Vector de predicción
pred = [sin(x) x.^2];
[nob,l] = size(t);
[l,n] = size(y);
[l,p] = size(pred);
[r,theta]=mincuadm(y,pred,nob,p,n); % medición, prediccón
theta
%r

% Comparación
figure;plot(t,y);hold on;
plot(t,theta(1)*sin(x)+theta(2)*x.^2);
legend('medición','modelo');
xlabel('tiempo [s]');


%% Plot seccion

% Comportamiento del sistema y el modelo
plot(t,y);
% Rastreo de la estimación
figure; plot(t,r(:,1));xlabel('tiempo [s]');ylabel('alpha');
figure; plot(t,r(:,2));xlabel('tiempo [s]');ylabel('beta');
