t = -1.999:0.001:2;
v = 0 * t;
vL = 0 * t; 

T = 1;
T0 = 4;

i = 1;                     
for x=-2:0.001:2
    if (x >= -T0-T) && (x <= -T0+T)
        v(i) = 1 - sqrt(((x+T0)/T)^2);
    end
    if (x >= -T) && (x <= T)
        v(i) = 1 - sqrt((x/T)^2);
    end
    if (x >= T0-T) && (x <= T0+T)
        v(i) = 1 - sqrt(((x-T0)/T)^2);
    end
    i=i+1;
end

L=5;
%for k=-L:1:L
%    if k == 0
%        ck = T/T0;
%    else
%        ck = ((T0/(2*(pi*k)^2*T))*(1 - cos(2*pi*k*T/T0)));
%    end
%    vk = ck*exp(2*pi*1i*k*t/T0);
%    vL = vL + vk;                                
%end
for k=-L:1:L
    ck = T/T0*(sinc(k*T/T0))^2;
    vk = ck*exp(2*pi*1i*k*t/T0);
    vL = vL + vk;                                
end
for k=1:L
    %ck = ((T0/(2*(pi*k)^2*T))*(1 - cos(2*pi*k*T/T0)));
    %vk = ck*cos(2*pi*k*t/T0);
    %vL = vL + vk;                                
end
%vL = T/T0 + 2*vL

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
plot(t, vL, 'Color', [1 0.5 0],'LineWidth', 2);
hold off
axis([-2 2 -0.2 1.2])
grid on;
xlabel('t');
ylabel('f(t)');
title(strcat('Fourier synthesis of the triangle wave function with n=', int2str(L), ' harmonics.' ));