%% Carga de Prueba 1
clc;
clear all;
close all;

data = load('Prueba1_datos.mat');
fs = 1;

%% Carga de Prueba 2
clc;
clear all;
close all;

data = load('Prueba2_datos.mat');
fs = 1e3;

%% Identificación paramétrica

t = data.time;
global Ta 
Ta = data.Ta;
Tl = data.Tl;
Tt = data.Tt;
global qp 
qp = data.qp;
Tt_p = data.Tt_p;
Tl_p = data.Tl_p;
global V 
V = data.V;

[m,n] = size(t);
Z = zeros(m,1);

% Filtrado de la señal
fc = 10; %Hz
[Tl,Tt,Tl_p,Tt_p,Ta,qp] = filtro_de_mediciones(t,Tl,Tt,Tl_p,Tt_p,Ta,qp,fc,fs);

Tp = [Tl_p,Tt_p];

Tm=(Tl+Tt)./2;
p = [V,-(qp.*(Tl-Tt)),-(Tm-Ta),Z,Z;
     Z,Z,Z,(qp.*(Tl-Tt)),-(Tt-Ta)];

 % Identificación paramétrica
[r,theta] = mincuadm(Tp,p,m,5,2);
theta

% Reconstrucción de la señal usando el modelo
[Tl_p_est,Tt_p_est] = estimacion_modelo_termico(theta,Tl,Tt);

% Integración numérica de la señal usando el modelo
iTl = [Tl(1)];
iTt = [Tt(1)];

for i=2:1:m
    
    iTl(i) = iTl(i-1) + Tl_p_est(i-1);
    iTt(i) = iTt(i-1) + Tt_p_est(i-1);
    
end

%% Promedio de las pruebas 

theta_1 = [
    0.0029;
    1;
    0.0001;
    0.0667;
    0
];

theta_2 = [
    0.1860;
    0.996;
    0.1670;
    0.1443;
    -0.008;
];

theta = (theta_1 + theta_2).*(.5)
%theta = theta_1;

% theta(1) = 0.0102; % ht/cl
% theta(2) = 0.1786; % rho*cp/cl
% theta(4) = 0.0666;

[Tl_p_est,Tt_p_est] = estimacion_modelo_termico(theta,Tl,Tt);

% Integración numérica de la señal usando el modelo
iTl = [Tl(1)];
iTt = [Tt(1)];

for i=2:1:m
    
    iTl(i) = iTl(i-1) + Tl_p_est(i-1);
    iTt(i) = iTt(i-1) + Tt_p_est(i-1);
    
end


%% Plot area 

figure;
subplot(2,1,1);
plot(t,Tl_p);hold on;
plot(t,Tl_p_est);
legend('Medición Tl_p','Estimación Tl_p');
title('(A)');

subplot(2,1,2);
plot(t,Tt_p);hold on;
plot(t,Tt_p_est);
legend('Medición Tt_p','Estimación Tt_p');
title('(B)');

figure;
subplot(2,1,1);
plot(t,iTl');hold on;plot(t,Tl);
legend('modelo','medición');

subplot(2,1,2);
plot(t,iTt');hold on;plot(t,Tl);
legend('modelo','medición');

%% Plot area. Dos pruebas 

clc;
clear all;
close all;

figure;

data = load('Prueba1_datos.mat');

t = data.time;
Tl = data.Tl;
Tt = data.Tt;


subplot(2,2,1);
plot(t,Tl);
ylabel('Temperatura de T_l [ºC]');
xlabel('Tiempo');
title('Prueba 1. T_l');

subplot(2,2,2);
plot(t,Tt);
ylabel('Temperatura de T_t [ºC]');
xlabel('Tiempo');
title('Prueba 1. T_T');

data = load('Prueba2_datos.mat');

t = data.time;
Tl = data.Tl;
Tt = data.Tt;


subplot(2,2,3);
plot(t,Tl);
ylabel('Temperatura de T_l [ºC]');
xlabel('Tiempo');
title('Prueba 2. T_l');

subplot(2,2,4);
plot(t,Tt);
ylabel('Temperatura de T_t [ºC]');
xlabel('Tiempo');
title('Prueba 2. T_T');




