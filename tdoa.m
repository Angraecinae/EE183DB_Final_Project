function [ x1, y1, z1, x2, y2, z2 ] = tdoa( tdoa_12, tdoa_13, tdoa_14 )
    sspeed = 34000.29; % [cm/s]
    smplfreq = 1000000; % [Hz]
    vt_12 = (tdoa_12 / smplfreq) * sspeed;
    vt_13 = (tdoa_13 / smplfreq) * sspeed;
    vt_14 = (tdoa_14 / smplfreq) * sspeed;
    m1 = [0, 0, 0];
    m2 = [-300.^0.5, 10, 0];
    m3 = [-300.^0.5, -10, 0];
    m4 = [-300.^0.5 + 10*tand(30), 0, ...
        (400 - (-300.^0.5 + 10*tand(30)).^2).^0.5];
    M = [m2;
         m3;
         m4]; 
    M = -matinv(M);
    V = [vt_12;
         vt_13;
         vt_14];
    K = 0.5.*[vt_12.^2 - dist(m1, m2).^2;
              vt_13.^2 - dist(m1, m3).^2;
              vt_14.^2 - dist(m1, m4).^2];
    H = M*V;
    C = M*K;
    a = H(1, 1).^2 + H(2, 1).^2 + H(3, 1).^2 - 1;
    b = 2*(H(1, 1)*C(1, 1) + H(2, 1)*C(2, 1) + H(3, 1)*C(3, 1));
    c = C(1, 1).^2 + C(2, 1).^2 + C(3, 1).^2;
    r1 = (-b + (b.^2 - 4*a*c)^(1/2))/(2*a);
    r2 = (-b - (b.^2 - 4*a*c)^(1/2))/(2*a);
    x1 = H(1, 1) * r1 + C(1, 1);
    y1 = H(2, 1) * r1 + C(2, 1);
    z1 = H(3, 1) * r1 + C(3, 1);
    x2 = H(1, 1) * r2 + C(1, 1);
    y2 = H(2, 1) * r2 + C(2, 1);
    z2 = H(3, 1) * r2 + C(3, 1);
%     
%     M = -([m3(1, 2), -m2(1, 2); ...
%           -m3(1, 1), m2(1, 1)]);
%     M = (1/(m2(1, 1)*m3(1, 2) - m2(1, 2)*m3(1, 1))).*M; 
%     
%     V = [vt_12; ...
%          vt_13];
%      
%     K = (0.5).*[vt_12.^2 - m2(1, 1).^2 - m2(1, 2).^2; ...
%          vt_13.^2 - m3(1, 1).^2 - m3(1, 2).^2; 
%          ];
%      
%     H = M*V;
%     C = M*K;
%     
%     a = H(1, 1).^2 + H(2, 1).^2 - 1;
%     b = 2*(H(1, 1)*C(1, 1) + H(2, 1)*C(2, 1));
%     c = C(1, 1).^2 + C(2, 1).^2;
%     
%     r1 = (-b + (b.^2 - 4*a*c)^(1/2))/(2*a);
%     r2 = (-b - (b.^2 - 4*a*c)^(1/2))/(2*a);
%     
%     x1 = H(1, 1) * r1 + C(1, 1);
%     y1 = H(2, 1) * r1 + C(2, 1);
%     x2 = H(1, 1) * r2 + C(1, 1);
%     y2 = H(2, 1) * r2 + C(2, 1);
end


