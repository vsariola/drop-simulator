# drop-simulator

This repository contains the code related to the paper:

Liimatainen et al. "Mapping microscale wetting variations on biological and synthetic water repellent surfaces" *Nature Communications*, 2017.

Please cite the code by referring to that paper.

What is it?
===========

This repository contains the code to compute the adhesive force of a drop between two surfaces. The solved problem is axially symmetric (2D). The drop fulfills the Young-Laplace equation. Volume of the drop and boundary conditions should also be known. The force is computed as a sum of laplace and capillary terms. The boundary value problem is solved using a shooting method.

See the supplementary note of the paper for all details.

The code was written using and tested on Matlab R2016b, and uses the Simulink and Parallel computing toolboxes. If needed, dependency on the parallel computing toolbox can be removed quite easily, by replacing all `parfor` loops with `for` loops, with the expense of severe slow down of the code. Simulink is quite integral part of the `solveIVP.m` code, but it should be possible to implement the same behavior using `ode45` alone.

How to recreate the figures from the paper
==========================================

1. Download the code from https://github.com/vsariola/drop-simulator
2. Run the script (**the code needs write access to `<repository>/output` directory!**)

`src/process_data.m`

This will take the data in the .xls files, which are exactly as they were communicated originally, and compute the means and error bars for the data. This is somewhat slow operation, so the results are saved to disk, to a new folder `output`

3. Navigate to any of the folders `SFig_*` and run `simulate_*` and then `plot_*`. The first script always runs a lengthy simulation and saves the results to disk. The second script does only the plotting, which is much faster once the simulations have been done. Write access to `<repository>/output` is needed.

How to use the simulator in your own projects
=============================================

The only absolutely necessary functions are right under `src` directory. `solveIVP.m` and `dropmodel.mdl` are always needed. There are four different functions to compute the force, and depending on the use case, one or more of them are needed:

1. `force.m`

This computes the force when the contact radius and distance between the probe is known. Used for snap-in forces.

2. `force_pulloff.m`

This finds the maximum of the force as a function of distance when the contact radius at the substrate is known. Used for pull-off forces.

3. `force_ca.m`

This computes the force when the contact angle and distance between the probe is known. Used for snap-in forces on a flat substrate.

4. `force_ca_pulloff.m`

This finds the maximum of the force as a function of distance when the contact angle at the substrate is known. Used for pull-off forces.

Licensing
=========

See LICENSE.

The code uses the export_fig library, which is under the folder src/export_fig. See src/export_fig/LICENSE for it's license.

ploterr by Felix Zoergiebel, downloaded from https://se.mathworks.com/matlabcentral/fileexchange/22216-ploterr