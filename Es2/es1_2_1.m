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
f = 0:0.1:20;
% f = 0.8;
t0 = 10;
sigma = .3;
U = sqrt(pi*sigma^2)*exp(-1i*2*pi*f*t0-pi^2*sigma^2*f.^2);
Y = P*U;
modulo = zeros(1,201);
mag2 = zeros(1,201);
for i=1:1:201 
    [mag,phase,~] = bode(P, i/100*2*pi);
    mag2(i) = mag;
    modulo(i) = mag*U(i);
end
plot(f, U)
hold on
plot(f, mag2)
hold on
plot(f, modulo)
hold off
t= 0:0.01:20;
% plot(t,impulse(Y,t));
% hold off