function simulate_pillar_pulloffs

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

% Calculate normalized volume from the weight, density and gravitational
% constant and probe disk radius
V = F/(g*rho*a^3);

sim_pillar_radius = exp(linspace(log(minradii),log(maxradii),50));

rt = sim_pillar_radius * 1e-6 / a;

ret = par_sim_fun('dropmodel',@(rt) nth_output([1 4 5 6],@force_pulloff,rt,V),rt);

sim_pillar_pulloff = ret(:,1) * gamma * a / 1e-6; % in uN
sim_results = [rt' ret];

if ~exist('../../output','dir')
    mkdir('../../output');
end

save('../../output/pillar_pulloff_simulations.mat','sim_pillar_radius','sim_pillar_pulloff','sim_results');

rmpath('..');
rmpath('../helpers');
