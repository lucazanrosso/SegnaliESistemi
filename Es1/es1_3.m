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

t = -1.99:0.01:10;                          % time
u = 0 * t;                                      % creates a zero valued functions
uL = 0 * t;
yL = 0 * t;

T = 1;
T0 = 4;

i = 1;  
for j=-1.99:0.01:10                        % it creates the original signal
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
for j=-1.99:0.01:10                      
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
% for k=-L:1:L
%     yk = T/T0*sinc(k*T/T0)^2;
%     [mag,phase,wout] = bode(P, k/T0)
%     mag*exp(phase)
%     yk = yk*exp(2*pi*1i*k*t/T0)*mag*exp(phase);
%     yL = yL + yk;                      
% end
yL = 0 * t;
for k=1:L
    yk = T/T0*sinc(k*T/T0)^2;
    [mag,phase,wout] = bode(P, k/T0);
    yk = yk*cos(2*pi*k*t/T0 + phase )*mag;
    yL = yL + yk;                      
end
yL = T/T0 + 2*yL;
for i=1:1:200
    yL(i) = 0;
end

%% In the end we simulated the output signals
 
y = lsim(P,u,t);

eL = y - yL';                                    % calculate the MSE
plot(t, eL);
MSE = 0;
for i=800:1:1000
   MSE = MSE + abs(eL(i))^2*0.01; 
end
MSE = MSE/T0

% Py = 0;                                         % verify if the MSE is correct
% for i=800:1:1000
%    Py = Py + abs(y(i))^2*0.01; 
% end
% Py = Py/T0;
% PyL = 0;
% for i=800:1:1000
%    PyL = PyL + abs(yL(i))^2*0.01; 
% end
% PyL = PyL/T0;
% 
% MSE2 = Py - PyL

plot(t, y, 'Color', [0 0.5 1],'LineWidth', 1);
hold on;
plot(t, yL, 'Color', [1 0.5 0],'LineWidth', 1); 
hold on
plot(t, eL, 'Color', [0.5 1 0.5],'LineWidth', 1);
hold off