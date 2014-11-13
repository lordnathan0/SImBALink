B = 10;
C = 1.9;
D = 1;
E = 0.97;
k = [0:.01:1];
u = D.*sin(C.*atan(( B.*k - E.*(B.*k - atan(B.*k)))));

figure
plot(k,u);