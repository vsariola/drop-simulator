function simulate_snapins_and_pulloffs

% The simulations are exactly the same as in the
% supplementary figures

orig = cd();
cd ../SFig_13_Radius_vs_Snapin_adjusted
simulate_pillar_adjusted_snapins

cd ../SFig_15_Radius_vs_Pulloff
simulate_pillar_pulloffs

cd(orig);