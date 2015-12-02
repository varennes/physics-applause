% Get order parameter 'r' as a function of time

clear all

N = 500;
K = 4.0;
D = 1.0;

dt = 0.1;
tmax = 20;
nt = floor(tmax/dt) + 1;

for i = 1:N;
    theta(i) = rand*2.0*pi;
end

for i = 1:N;
    omegaNtr(i) = 0.0;
end

r = [];
t = [];
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
    if mod(i*dt, 5*dt) == 0
        rc = 0.0;
        rs = 0.0;
        for j = 1:N;
            rc = rc + cos( theta(j));
            rs = rs + sin( theta(j));
        end
        r = [r ; sqrt( rc^2 + rs^2) / N];
        t = [t ; i*dt];
    end
end

plot(t,r)
title('Time Evolution of Synchronization')
xlabel('time (s)')
ylabel('Order parameter, r')