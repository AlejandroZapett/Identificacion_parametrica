function [Tl,Tt,Tl_p,Tt_p,Ta,qp] = filtro_de_mediciones(t,Tl,Tt,Tl_p,Tt_p,Ta,qp,fc,fs)
figure;
subplot(3,2,1);
plot(t,Tl);hold on;
xlabel('Tiempo');
ylabel('Tl');

subplot(3,2,2);
plot(t,Tt);hold on;
xlabel('Tiempo');
ylabel('Tt');

subplot(3,2,3);
plot(t,Tl_p);hold on;
xlabel('Tiempo');
ylabel('Tlp');

subplot(3,2,4);
plot(t,Tt_p);hold on;
xlabel('Tiempo');
ylabel('Tlp');

subplot(3,2,5);
plot(t,Ta);hold on;
xlabel('Tiempo');
ylabel('Ta');

subplot(3,2,6);
plot(t,qp);hold on;
xlabel('Tiempo');
ylabel('qp');

Tl_p = lowpass(Tl_p,fc,fs);
Tt_p = lowpass(Tt_p,fc,fs);
Ta = lowpass(Ta,fc,fs);
qp = lowpass(qp,fc,fs);
Tl = lowpass(Tl,fc,fs);
Tt = lowpass(Tt,fc,fs);

subplot(3,2,1);
plot(t,Tl);
xlabel('Tiempo');
ylabel('Tl');

subplot(3,2,2);
plot(t,Tt);
xlabel('Tiempo');
ylabel('Tt');

subplot(3,2,3);
plot(t,Tl_p);
xlabel('Tiempo');
ylabel('Tlp');

subplot(3,2,4);
plot(t,Tt_p);
xlabel('Tiempo');
ylabel('Tlp');

subplot(3,2,5);
plot(t,Ta);
xlabel('Tiempo');
ylabel('Ta');

subplot(3,2,6);
plot(t,qp);
xlabel('Tiempo');
ylabel('qp');

end