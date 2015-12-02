% Run a simulation which corresponds to the figure 6 in the "Physics of
% Rhythmic Applause" paper.

clear all

N = 70;
K = 3.2;
D = 4.0*pi/3.0;
Kcrit = sqrt(2.0/pi^3)*D;
omegaMean = 8*pi;

dt = 0.05;
tmax = 65;
nt = floor(tmax/dt) + 1;

for i = 1:N;
    theta(i) = rand*2.0*pi;
end

for i = 1:N;
    omegaNtr(i) = sqrt(D)*randn + omegaMean;
end


pd = fitdist(omegaNtr','Normal');
x_values = linspace( min(omegaNtr), max(omegaNtr));
y = pdf(pd,x_values);
figure
histogram(omegaNtr,10,'Normalization','probability')
hold on
plot(x_values,y)
title('Distribution of Natrual Frequencies')


% set-up increments to increase frequencies
tmid = tmax - 30;
for i = 1:N;
    domega(i) = (omegaNtr(i)/2.0) / (tmax - tmid);
end

mtheta = [theta];
momega = [];

r = [];
t = [];
for i = 1:nt;
    
    if i*dt == 21;
        omegaNtr = omegaNtr./2.0;
    end
    
    if i*dt > 35;
        omegaNtr = omegaNtr + domega*dt;
    end
    
    for j = 1:N;
        % first calc coupling interaction
        wMin = 0.0;
        for k = 1:N;
            wMin = wMin + sin( theta(k) - theta(j));
        end
        wMin = K * wMin / N;
        
        theta(j) = theta(j) + (omegaNtr(j) + wMin)*dt + sqrt(dt)*randn;
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
        
        mtheta = [mtheta ; theta];
    end
end

xt = length(mtheta(:,1));
for i = 1:N;
    for j = 2:xt;
        momega(j-1,i) = mtheta(j,i) - mtheta(j-1,i);
    end
end

%% plot sample frequency trajectories

% figure
% plot( t, momega(:,1))
% hold on
% for i = 1:10:N
%     plot( t, momega(:,i))
% end


%% mean sound intensity

for i = 1:length(t);
    int(i) = mean(momega(i,:));
end

%% time averaged intensity and order parameter
m = length(t);

dm = 10;

mi = [];
mr = [];
mt = [];
for i = 1:m;
   if( mod(i,dm) == 0)
       mt = [ mt; t(i)];
       mr = [ mr; mean(r(i-dm+1:i))];
       mi = [ mi; mean(int(i-dm+1:i))];
   end  
end


%% plot stuff

figure
subplot(2,1,1)
ylabel('\omega (1/s)')

plot(t, momega(:,1), t, momega(:,N-3), t, momega(:,floor(N/2)))
hold on
plot(mt,mi,'linewidth',2.0)
xlim([15, 65])
ylabel('Intensity (1/s)')
xlabel('time (s)')

subplot(2,1,2)
plot(mt, mr)
ylabel('<q>')
xlabel('time (s)')
xlim([15, 65])
ylim([0, 1])
