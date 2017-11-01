function simuate_volume_snapin

addpath('..');
addpath('../helpers');

% Simulation parameters

minVt = 5;
maxVt = 20;
radius = 100; % Smallest pillar size to simulate, in µm
a = 0.5e-3; % Radius of the probe disk, in m (SI-units)
gamma = 72e-3; % Surface tension, in N/m (SI-units)

sim_Vt = linspace(minVt,maxVt,50);

k = nthroot(3*sim_Vt/pi + sqrt(1 + (3*sim_Vt/pi).^2),3);
ht = k - 1 ./ k;

rt = radius * 1e-6 / a;
n = length(sim_Vt);
ret = par_sim_fun('dropmodel',@(i) nth_output([1 4 5],@force,rt,ht(i),sim_Vt(i)),1:n);
sim_pillar_snapin = ret(:,1) * gamma * a / 1e-6; % in uN
sim_results = [sim_Vt' ret];
sim_V = sim_Vt * a^3;

if ~exist('../../output','dir')
    mkdir('../../output');
end

save('../../output/volume_snapin_simulations.mat','sim_V','sim_pillar_snapin','sim_results','a','gamma');

rmpath('..');
rmpath('../helpers');