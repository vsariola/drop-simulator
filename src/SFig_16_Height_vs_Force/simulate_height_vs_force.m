function simulate_height_vs_force

addpath('..');
addpath('../helpers');

hmin = 1.5;
angle_hmax = [130 2.02;135 1.975;140 1.935;145 1.90;150 1.865];
Vnorm = 5.44;

results = [];

for i = 1:size(angle_hmax,1)
    h = hmin:0.005:angle_hmax(i,2);
    theta_rad = angle_hmax(i,1) * pi / 180;
    ret = par_sim_fun('dropmodel',@(h) force_ca(theta_rad,h,Vnorm),h);
    results_new = nan(max(size(results,1),length(ret)),size(results,2)+2);
    results_new(1:size(results,1),1:size(results,2)) = results;
    results_new(1:length(ret),(end-1):end) = [h' ret];
    results = results_new;
end

if ~exist('../../output','dir')
    mkdir('../../output');
end

save('../../output/ca_height_vs_force.mat','results','angle_hmax');

rmpath('..');
rmpath('../helpers');