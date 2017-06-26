% Calcolo della trasformata di Fourier via FFT.
% per il segnale Pi(t) (segnale ``rettangolare'' da -1/2 a 1/2)
% Pi(t) = 1 |t|<1/2, Pi(t)=0 |t|>1/2

%close all
clear all

Tc = 0.001; %passo di campionamento nel tempo
T = 2; % ripetizione periodica
tp=-T/2:Tc:T/2; %solo per disegnare il segnale
t=0:Tc:T-Tc; 
N=T/Tc; %campioni in un periodo
y = rect(t)+rect(t-T); %segnale calcolato per 0<t<4

plot(y)

%%
% i = 1;
% t = -0.99:0.01:1;                     % time
% y = 0 * t;
% for x=-0.99:0.01:1                        % creates the original signal
%     if (x >= -T/4) && (x <= T/4)
%         y(i) = 1;
%     end
%     i=i+1;
% end
% 
% plot(t, y)

%%

Fc=1/Tc; %periodo di ripetizione in frequenza   
F=1/T; %passo di campionamento in frequenza
f=-Fc/2:F:Fc/2-F; %valori della trasformata nella ``banda pratica''

Y = sinc(f); % trasformata ``ideale'', per confronto 

figure
% plot(tp,rect(tp)),title(['Segnale T_c=',num2str(Tc),', T=',num2str(T)]),axis([-2 2 -.1 1.1]);
figure 
plot(f,Y),title(['Trasformata (blu), via FFT (nero tratteggiato), F_c=1/Tc=',num2str(1/Tc),', F=1/T=',num2str(1/T)]);;
hold

Yfft = T/N*fft(y); %trasformata

Yfftord =[Yfft(:,N/2+1:N) Yfft(:,1:N/2)]; %riordina i campioni...
Yfftord1 = fftshift(Yfft);

plot(f,Yfftord,'k-.')

figure

plot(f,Y),hold,plot(f,Yfftord,':g'),plot(f,abs(Y-Yfftord),'r:')
title(['Trasformata ``vera'' (blu), via FFT (verde), errore (rosso) F_c=1/Tc=',num2str(1/Tc),', F=1/T=',num2str(1/T)])