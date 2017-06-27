M1 = 400;
M2 = 40;
K1 = 2500;
K2 = 100000;
B1 = 1000;
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

% t= 0:0.01:20;
% t0 = 10;
% 
% sigma = 3;
% u1 = exp(-((t-t0).^2)/sigma^2);
% sigma = 1;
% u2 = exp(-(t-t0).^2/sigma^2);
% sigma = .3;
% u3 = exp(-(t-t0).^2/sigma^2);

% lsim(P,u1,t);
% lsim(P,u2,t);
% lsim(P,u3,t);

% y1 = lsim(P,u1,t);
% y2 = lsim(P,u2,t);
% y3 = lsim(P,u3,t);

% plot(t, y1)
% hold on
% plot(t, y2)
% hold on
% plot(t, y3)
% hold off

%%

% f = -10:0.1:10;
% t0 = 10;
% 
% H = squeeze(freqresp(P, f*2*pi));
% 
% sigma = .3;
% U = sqrt(pi*sigma^2)*exp(-1i*2*pi*f*t0-pi^2*sigma^2*f.^2);
% Y = abs(U).*abs(H)';
% 
% plot(f, abs(U))
% hold on
% plot(f, abs(H))
% hold on
% plot(f, abs(Y))
% hold off

%%

t= 0:0.01:20;
t0 = 10;

sigma = 2;
u = exp(-((t-t0).^2)/sigma^2) + exp(-((t-4/3*t0).^2)/sigma^2);

lsim(P,u,t);

% y = lsim(P,u1,t);
% 
% plot(t, y)
% hold on

%%

f = -10:0.01:10;
t0 = 10;

H = squeeze(freqresp(P, f*2*pi));

sigma = .3;
U = sqrt(pi*sigma^2)*exp(-1i*2*pi*f*t0-pi^2*sigma^2*f.^2) + sqrt(pi*sigma^2)*exp(-1i*2*pi*f*4/3*t0-pi^2*sigma^2*f.^2);
Y = abs(U).*abs(H)';

plot(f, abs(U))
hold on
plot(f, abs(H))
hold on
plot(f, abs(Y))
hold off