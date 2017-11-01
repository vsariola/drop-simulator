function simulate_pillar_snapins

addpath('..');
addpath('../helpers');

% Simulation parameters

minradii = 10; % Smallest pillar size to simulate, in µm
maxradii = 400; % Largest pillar size to simulate, in µm
a = 0.5e-3; % Radius of the probe disk, in m (SI-units)
gamma = 72e-3; % Surface tension, in N/m (SI-units)
F = 15e-6; % N
g = 9.81; % m/s^2
rho = 1000; % kg/m^3

% Calculate volume from the weight, density and gravitational constant
V = F/(g*rho);
Vt = V/a^3;

sim_pillar_radius = exp(linspace(log(minradii),log(maxradii),50));

k = nthroot(3*Vt/pi + sqrt(1 + (3*Vt/pi)^2),3);
ht = k - 1 / k; 

rt = sim_pillar_radius * 1e-6 / a;

ret = par_sim_fun('dropmodel',@(rt) nth_output([1 4 5],@force,rt,ht,Vt),rt);
sim_pillar_snapin = ret(:,1) * gamma * a / 1e-6; % in uN
sim_results = [rt' ret];

if ~exist('../../output','dir')
    mkdir('../../output');
end

save('../../output/pillar_snapin_simulations.mat','sim_pillar_radius','sim_pillar_snapin','sim_results','a','gamma');

rmpath('..');
rmpath('../helpers');
