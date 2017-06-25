M1 = 400;
M2 = 40;
K1 = 17500;
K2 = 200000;
B1 = 2500;
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

t = 6:0.001:7;
modulo = zeros(1,1000);
Unum = [1 0];
for d=1:1:1000 
    Uden = [1 0 d^2];
    U = tf(Unum, Uden);
    Yf = U*P;
    yf = impulse(Yf,t);
    modulo(d) = max(yf);
end
% modulo = 20*log10(modulo);
plot(modulo)
% semilogx(modulo)