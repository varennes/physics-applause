% Parameter scan over various values of K
% starting at Ki, to Kf in step sizes dk

clear all

N = 500;
D = 1.0;

D = 2.0*pi/3.0;
Kcrit = sqrt(2.0/pi^3)*D;
omegaMean = 4*pi;

dt = 0.05;
tmax = 10;
nt = floor(tmax/dt) + 1;

Ki = 0.0;
Kf = 10.0;
dk = 0.5;
nk = floor((Kf-Ki)/dk) + 1;

for i = 1:nk;
    Kmat(i) = Ki + dk*(i-1);
end

for i = 1:nt;
    t(i) = dt*(i-1);
end

for x = 1:nk
    
    K = Kmat(x);

    for i = 1:N;
        theta(i) = rand*2.0*pi;
    end

    for i = 1:N;
%         omegaNtr(i) = 0.0;
        omegaNtr(i) = sqrt(D)*randn + omegaMean;
    end

    for i = 1:nt;
        for j = 1:N;
            % first calc coupling interaction
            int = 0.0;
            for k = 1:N;
                int = int + sin( theta(k) - theta(j));
            end
            int = K * int / N;
        
            theta(j) = theta(j) + (omegaNtr(j) + int)*dt + sqrt(dt)*randn;
        end
    
        % calc order parameter
        r(i)  = 0.0;
        rc = 0.0;
        rs = 0.0;
        for j = 1:N;
            rc = rc + cos( theta(j));
            rs = rs + sin( theta(j));
        end
        r(i) = sqrt( rc^2 + rs^2) / N;
    end

    rRun(x) = mean(r(floor(3*nt/4):nt));

end

plot(Kmat,rRun)
title('Kuramoto model Parameter Scan')
xlabel('Coupling Strength, K')
ylabel('Order parameter, r')