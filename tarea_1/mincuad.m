function [r, theta] =mincuad(y,fi)
[n,m]=size(fi);%n=número de renglones, m=número de columnas
theta=[1:m]'; %vector columna de parámetros
theta(1)=0; %Condición inicial del vector de parámetros
psi=[1:m]'; %vector columna de observaciones
P=eye(m)*10e20; %matriz de covarianza P
r=eye(n,m); %registro para los parámetros estimados
    for k=1:n % algoritmo recursivo de mínimos cuadrados
        for i=1:m %se forma el regresor  
            psi(i,1)=fi(k,i);
        end
        e=y(k)-theta'*psi;%error de regresión
        theta= theta+(P*psi*e)/(1+psi'*P*psi);%vector estimado
        P=P-(P*psi*(psi')*P)/(1+psi'*P*psi);%matriz de covariancia
        for i=1:m
            r(k,i)=theta(i,1); %registro por cada iteración de parámetros estimados
        end
    end
end
