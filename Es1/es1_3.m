%% First, we created the system

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

%% In the second part we created the input signals

t = -1.9999:0.0001:10;                          % time
u = 0 * t;                                      % creates a zero valued functions
uL = 0 * t; 

T = 1;
T0 = 2;

i = 1;  
for j=-1.9999:0.0001:10                        % it creates the original signal
    if (j >= 0)
        for k=0:6
            if (j >= k*T0-T) && (j<= k*T0)
                u(i) = 1 - abs((j-k*T0)/T);
            end
        end
    end
    i=i+1;
end
i = 1;  
for j=-1.9999:0.0001:10                      
    if (j >= 0)
        for k=0:6
            if (j >= k*T0) && (j<= k*T0+T)
                u(i) = 1 - abs((j-k*T0)/T);
            end
        end
    end
    i=i+1;
end

L=5;                                            % it creates the approximate signal
%for k=0:L
%    vL = vL + (-1)^k*(sin(2*pi*(2*k+1)*t*0.5))/(2*k+1)^2;
    %vL = vL + (-1)^((k-1)/2)*(sin((k*pi*t)))/(k)^2;
%end
%vL = 8/(pi)^2*vL;
for k=1:L
    ck = ((T0/(2*(pi*k)^2*T))*(1 - cos(2*pi*k*T/T0)));
    vk = ck*cos(2*pi*k*t/T0);
    uL = uL + vk;                                
end
uL = T/T0 + 2*uL;
i = 1;
for j=-1.9999:0.0001:10
    if j < 0
        uL(i) = 0;
    end
    i = i+1;
end

%% In the end we simulated the output signals

y = lsim(P,u,t);
yL = lsim(P,uL,t);

eL = y - yL;                                    % calculate the MSE
plot(t, eL);
MSE = 0;
for i=80000:1:100000
   MSE = MSE + abs(eL(i))^2*0.0001; 
end
MSE = MSE/T0;

Py = 0;                                         % verify if the MSE is correct
for i=80000:1:100000
   Py = Py + abs(y(i))^2*0.0001; 
end
Py = Py/T0;
PyL = 0;
for i=80000:1:100000
   PyL = PyL + abs(yL(i))^2*0.0001; 
end
PyL = PyL/T0;

MSE
MSE2 = Py - PyL

plot(t, y, 'Color', [0 0.5 1],'LineWidth', 1);
hold on;
plot(t, yL, 'Color', [1 0.5 0],'LineWidth', 1);
hold on
plot(t, eL, 'Color', [0.5 1 0.5],'LineWidth', 1);
hold off