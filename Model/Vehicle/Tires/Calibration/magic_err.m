function err = magic_err( x )
%x(1) = B
%x(2) = C
%x(3) = D
%x(4) = E
load Tire_Val
k = Slip;
u = x(3).*sin(x(2).*atan(( x(1).*k - x(4).*(x(1).*k - atan(x(1).*k)))));
n = length(k);
err = sqrt(((Fmax400./400 - u).^2));
end

