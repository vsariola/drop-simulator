function simulate_ca_snapins

addpath('..');
addpath('../helpers');

% Simulation parameters

mintheta = 60;
maxtheta = 175;

a = 0.5e-3; % Radius of the probe disk, in m (SI-units)
gamma = 72e-3; % Surface tension, in N/m (SI-units)
F = 15e-6; % N
g = 9.81; % m/s^2
rho = 1000; % kg/m^3

% Calculate volume from the weight, density and gravitational constant
V = F/(g*rho);
Vt = V/a^3;

sim_wat = linspace(1+cosd(maxtheta),1+cosd(mintheta),50);
sim_theta = acos(sim_wat-1);

k = nthroot(3*Vt/pi + sqrt(1 + (3*Vt/pi)^2),3);
ht = k - 1 / k; 

ret = par_sim_fun('dropmodel',@(theta) nth_output([1 4 5],@force_ca,theta,ht,Vt),sim_theta);
sim_ca_snapin = ret(:,1) * gamma * a / 1e-6; % in uN
sim_ca_results = [sim_theta' ret];

if ~exist('../../output','dir')
    mkdir('../../output');
end

save('../../output/ca_snapin_simulations.mat','sim_theta','sim_ca_snapin','sim_ca_results','a','gamma');

rmpath('..');
rmpath('../helpers');