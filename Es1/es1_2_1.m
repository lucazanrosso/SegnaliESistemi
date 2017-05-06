t = -1.999:0.001:2;                     % time
v = 0 * t;                              % creates a zero valued functions
vL = 0 * t; 

T = 1;
T0 = 4;

i = 1;  
for x=-2:0.001:2                        % creates the original signal
    if (x >= -T0-T/2) && (x <= -T0+T/2) || (x >= -T/2) && (x <= T/2) || (x >= T0-T/2) && (x <= T0+T/2)
        v(i) = 1;
    end
    i=i+1;
end

L=5;                                    % number of harmonics
for k=-L:1:L
    ck = (T/T0*sinc(k*T/T0));           % computes the k-th Fourier coefficient of the exponential form
    vk = ck*exp(2*pi*1i*k*t/T0);        % k-th term of the series
    vL = vL + vk;                       % adds the k-th term to f
end

eL = v - vL;
MSE = 0;
for i=1:1:4000
   MSE = MSE + abs(eL(i))^2*0.001; 
end
MSE/T0

Pv = 0;
for i=1:1:4000
   Pv = Pv + abs(v(i))^2*0.001; 
end
Pv = Pv/T0;
PvL = 0;
for i=1:1:4000
   PvL = PvL + abs(vL(i))^2*0.001; 
end
PvL = PvL/T0;
Pv - PvL

plot(t, v, 'Color', [0 0.5 1],'LineWidth', 2);
hold on;
plot(t, real(vL), 'Color', [1 0.5 0],'LineWidth', 2);
hold off
axis([-2 2 -0.2 1.2])
grid on;
xlabel('t');
ylabel('f(t)');
title(strcat('Fourier synthesis of the square wave function with n=', int2str(L), ' harmonics.' ));