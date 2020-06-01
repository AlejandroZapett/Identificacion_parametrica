function  [r,theta] =mincuadm(y,fi,Nob,p,n)
theta=[1:p]'; %vector columna de parámetros
  
%condición inicial del vector de parámetros
theta(1) = 0.0102; % ht/cl
theta(2) = 0.1786; % rho*cp/cl
theta(2) = 1;
theta(4) = 0.0666;
theta(5) = 1;

psi=zeros(p,n); %vector columna de observaciones
P=eye(p,p);%10e3; %matriz de covarianza P

%Condición inicial de la matriz de covarianza
P(1,1) = 0.01;
P(2,2) = 0.01;
P(4,4) = 0.01;


I=eye(n,n); %matriz identidad
ys=zeros(n,1);

  for k=1:Nob
    for j=1:n
        for i=1:p %se forma el regresor
            psi(i,j)=fi(k+Nob*(j-1),i);
        end
        for i=1:n 
            ys(i,1)=y(k+Nob*(i-1));    
        end
    end
    
%     for o=1:p
%         r(k,o) = theta(o);
%     end
    
    e=ys-psi'*theta; %error de regresión
    theta= theta+P*psi*(I+psi'*P*psi)^(-1)*e;%vector estimado
    P=P-(P*psi*(I+psi'*P*psi)^(-1)*(psi')*P);%Matriz de covarianza
  end
  r = 0;
end