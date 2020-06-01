function [Tl_p,Tt_p]=estimacion_modelo_termico(theta,Tl,Tt)
global  Ta V qp;

Tm=(Tl+Tt)./2;

Tl_p= theta(1)*V-theta(2)*(qp.*(Tl-Tt))-theta(3)*(Tm-Ta);
Tt_p= theta(4)*(qp.*(Tl-Tt))-theta(5)*(Tt-Ta);

end
