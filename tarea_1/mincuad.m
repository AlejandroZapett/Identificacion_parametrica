function [r, theta] =mincuad(y,fi)
[n,m]=size(fi);%n=n�mero de renglones, m=n�mero de columnas
theta=[1:m]'; %vector columna de par�metros
theta(1)=0; %Condici�n inicial del vector de par�metros
psi=[1:m]'; %vector columna de observaciones
P=eye(m)*10e20; %matriz de covarianza P
r=eye(n,m); %registro para los par�metros estimados
    for k=1:n % algoritmo recursivo de m�nimos cuadrados
        for i=1:m %se forma el regresor  
            psi(i,1)=fi(k,i);
        end
        e=y(k)-theta'*psi;%error de regresi�n
        theta= theta+(P*psi*e)/(1+psi'*P*psi);%vector estimado
        P=P-(P*psi*(psi')*P)/(1+psi'*P*psi);%matriz de covariancia
        for i=1:m
            r(k,i)=theta(i,1); %registro por cada iteraci�n de par�metros estimados
        end
    end
end
