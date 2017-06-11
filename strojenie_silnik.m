clearvars;

J = 3.2284E-6;
b = 3.5077E-6;
K = 0.0274;
R = 4;
L = 2.75E-6;
s = tf('s');
P_motor = K/(s*((J*s+b)*(L*s+R)+K^2));

figure;
rlocus(P_motor)
title('Root Locus - P Control, full')
sgrid(.5, 0)
sigrid(100)

% redukcja ukladu o najszybsza skladowa
poles = pole(P_motor);
rP_motor = minreal(P_motor * (s/max(abs(poles)) + 1));

rlocus(rP_motor)
title('Root Locus - P Control, reduced')
sgrid(.5, 0)
sigrid(100)

% regulator calkujacy
C = 1/s;
rlocus(C*rP_motor)
title('Root Locus - I Control')
axis([ -300 100 -200 200])
sgrid(.5, 0)
sigrid(100)

% regulator PI
C = (s+20)/s;
rlocus(C*rP_motor)
title('Root Locus - PI Control')
axis([ -300 100 -200 200])
sgrid(.5, 0)
sigrid(100)

% regulator PID
C = (s+60)*(s+70)/s;
rlocus(C*rP_motor)
title('Root Locus - PID Control')
axis([ -300 100 -200 200])
sgrid(.5, 0)
sigrid(100)

k = 0.144;
sys_cl = feedback(k * C*rP_motor,1);
t = 0:0.0001:0.1;
step(sys_cl, t)
grid
ylabel('Position, \theta (radians)')
title('Response to a Step Reference with PID Control')
