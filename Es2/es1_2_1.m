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
% f= 0:0.01:20;
syms f;
t0 = 10;
sigma = 0.3;
% 
U = sqrt(pi*sigma^2)*exp(-1i*2*pi*f*t0-pi^2*sigma^2*f.^2);
U = tf(U, 1);
% Y = P*U;

% plot(f, impulse(Y, f));


syms t
u = cos(5*t);
U = laplace(u)
% Y = P*laplace(u)
% a= 0:0.01:10;
% impulse (a, impulse(Y,a));



% L=5;                                            % it creates the approximate signal
% for k=-L:1:L
%     yk = T/T0*sinc(k*T/T0)^2;
%     [mag,phase,wout] = bode(P, 2*pi*k/T0);
%     yk = yk*exp(1i*(2*pi*k*t/T0 + phase*pi/180))*mag;
%     yL = yL + yk;                      
% end