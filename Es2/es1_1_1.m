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

t= 0:0.01:20;
t0 = 10;

sigma = 3;
u = exp(-(t-t0).^2/sigma^2);
y = lsim(P,u,t);
plot(t, y)
hold on

sigma = 1;
u = exp(-(t-t0).^2/sigma^2);
y = lsim(P,u,t);
plot(t, y)
hold on

sigma = .01;
u = exp(-(t-t0).^2/sigma^2);
y = lsim(P,u,t);
plot(t, u)
hold off