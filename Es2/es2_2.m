M1 = 400;
M2 = 40;
K1 = 17500;
K2 = 200000;
B1 = 4500;
B2 = 0;

H = [1 0 0 0];
PHI = [0
    K2];
PSI = [0
    B2];
I = [1 0
    0 1];
M = [M1 0
    0 M2];
K = [K1 -K1
    -K1 K1+K2];
B = [B1 -B1
    -B1 B1+B2];

zeri= [0 0
    0 0];

zeri2 = [0 
     0];

F = [zeri I
    -inv(M)*K -inv(M)*B];

G1 = [0
      0
    M\PHI];

G2 = F*[0
    0
    M\PSI];

G = G1 + G2;

P = tf(ss(F,G,H,0));

%%

t0 = 10;
sigma = .3;

Tc = .01; %passo di campionamento nel tempo
T = 20; % ripetizione periodica
tp=-T/2:Tc:T/2; %solo per disegnare il segnale
t=0:Tc:T-Tc; 
N=T/Tc; %campioni in un periodo
Fc=1/Tc; %periodo di ripetizione in frequenza   
F=1/T; %passo di campionamento in frequenza
f=-Fc/2:F:Fc/2-F; %valori della trasformata nella ``banda pratica''

u = exp(-((t-t0).^2)/sigma^2);
y = lsim(P,u,t);

U = sqrt(pi*sigma^2)*exp(-1i*2*pi*f*t0-pi^2*sigma^2*f.^2);
H = squeeze(freqresp(P, f*2*pi));
Y = abs(U).*abs(H');

Ufft = T/N*fft(u);
Yfft = T/N*fft(y');

Ufftord =[Ufft(:,N/2+1:N) Ufft(:,1:N/2)];
Yfftord =[Yfft(:,N/2+1:N) Yfft(:,1:N/2)]; %riordina i campioni...
% Ufftord1 = fftshift(Ufft);
% Yfftord1 = fftshift(Yfft);

% plot(f,abs(U), 'Color', [0 0.5 1],'LineWidth', 0.5);
% hold on
% plot(f,abs(Ufftord), 'Color', [1 0.5 0],'LineWidth', 0.5);
% hold on
% plot(f,Y, 'Color', [0 0.5 1],'LineWidth', 0.5);
% hold on
% plot(f,abs(Yfftord), 'Color', [1 0.5 0],'LineWidth', 0.5);
% hold on
% plot(f,abs(Y)-abs(Yfftord), 'Color', [0.5 1 0.5],'LineWidth', 0.5);
% hold off
% plot(f, abs(H), 'Color', [0 0.5 1],'LineWidth', 0.5);
% hold on
H2 = Yfftord./Ufftord;
for i=1:1:size(U')
    if (abs(Ufftord(i)) < 0.00001)
        H2(i) = 0;
    end
end
% plot(f,abs(H2), 'Color', [0.5 1 0.5],'LineWidth', 0.5);
% hold off
h = impulse(P, t);
h2 = real(Fc*ifft(H2));
% h2 = h2./cos(2*pi*50*t)';
h2 = h2./cos(2*pi*Fc/2*t);
plot(t, h);
hold on
plot(t, h2);
hold off