clear all
close all

sspeed = 34000.29; % [cm/s]
ssfreq = 1000; % [Hz]
smplfreq = 1000000; % [Hz]
amp = 1; 

val = [0:1/smplfreq:2/ssfreq];
sig = amp * sin(2 * pi * ssfreq * val);
% noise = awgn(zeros(1, 1*length(sig)), 25);
% sig = [noise, sig];
% noise = awgn(zeros(1, 1*length(sig)), 25);
% sig = [sig, noise];

m1 = [0, 0, 0];
m2 = [-300.^0.5, 10, 0];
m3 = [-300.^0.5, -10, 0];
m4 = [-300.^0.5 + 10*tand(30), 0, ...
    (400 - (-300.^0.5 + 10*tand(30)).^2).^0.5];

ss = [40, 40, 40];

d1 = dist(m1, ss);
d2 = dist(m2, ss);
d3 = dist(m3, ss);
d4 = dist(m4, ss);

s1 = 0*[0:1/smplfreq:2 * max([d1, d2, d3, d4])/sspeed]; 
s1(1, floor(smplfreq*d1/sspeed)) = 2 - d1/max([d1, d2, d3, d4]);
g1 = conv(s1, sig);
s2 = 0*[0:1/smplfreq:2 * max([d1, d2, d3, d4])/sspeed]; 
s2(1, floor(smplfreq*d2/sspeed)) = 2 - d2/max([d1, d2, d3, d4]);
g2 = conv(s2, sig);
s3 = 0*[0:1/smplfreq:2 * max([d1, d2, d3, d4])/sspeed]; 
s3(1, floor(smplfreq*d3/sspeed)) = 2 - d3/max([d1, d2, d3, d4]);
g3 = conv(s3, sig);
s4 = 0*[0:1/smplfreq:2 * max([d1, d2, d3, d4])/sspeed]; 
s4(1, floor(smplfreq*d4/sspeed)) = 2 - d4/max([d1, d2, d3, d4]);
g4 = conv(s4, sig);

[t12] = cc(g1, g2);
[t13] = cc(g1, g3);
[t14] = cc(g1, g4);

[x1, y1, z1, x2, y2, z2] = tdoa(t12, t13, t14);
loc1 = [x1, y1, z1];
loc2 = [x2, y2, z2];

figure, hold on;
scatter3([m1(1), m2(1), m3(1), m4(1)], [m1(2), m2(2), m3(2), m4(2)], [m1(3), m2(3), m3(3), m4(3)], 'b');
plot3([m1(1), loc1(1)], [m1(2), loc1(2)], [m1(3), loc1(3)], 'r');
plot3([m2(1), loc1(1)], [m2(2), loc1(2)], [m2(3), loc1(3)], 'r');
plot3([m3(1), loc1(1)], [m3(2), loc1(2)], [m3(3), loc1(3)], 'r');
plot3([m4(1), loc1(1)], [m4(2), loc1(2)], [m4(3), loc1(3)], 'r');
plot3([m1(1), loc2(1)], [m1(2), loc2(2)], [m1(3), loc2(3)], 'm');
plot3([m2(1), loc2(1)], [m2(2), loc2(2)], [m2(3), loc2(3)], 'm');
plot3([m3(1), loc2(1)], [m3(2), loc2(2)], [m3(3), loc2(3)], 'm');
plot3([m4(1), loc2(1)], [m4(2), loc2(2)], [m4(3), loc2(3)], 'm');
plot3([m1(1), m2(1)], [m1(2), m2(2)], [m1(3), m2(3)], 'b');
plot3([m1(1), m3(1)], [m1(2), m3(2)], [m1(3), m3(3)], 'b');
plot3([m1(1), m4(1)], [m1(2), m4(2)], [m1(3), m4(3)], 'b');
plot3([m2(1), m3(1)], [m2(2), m3(2)], [m2(3), m3(3)], 'b');
plot3([m2(1), m4(1)], [m2(2), m4(2)], [m2(3), m4(3)], 'b');
plot3([m3(1), m4(1)], [m3(2), m4(2)], [m3(3), m4(3)], 'b');
scatter3(loc1(1), loc1(2), loc1(3), 'r');
scatter3(loc2(1), loc2(2), loc2(3), 'm');
scatter3(ss(1), ss(2), ss(3), 'g');