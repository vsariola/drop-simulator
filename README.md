# drop-simulator

This repository contains the code related to the paper:

Liimatainen et al. "Mapping microscale wetting variations on biological and synthetic water repellent surfaces" Nature Communications, 2017.

Please cite the code by referring to that paper.

Important notice:

Before the first use of the code, you have to run the script

src/process_data.m

This will take the data in the .xls files, which are exactly as they were communicated originally, and compute the means and error bars for the data. This is somewhat slow operation, so the results are saved to the disk, for faster plotting of the data later on.

See LICENSE for licensing information.

The code uses the export_fig library, which is included in full in the folder: src/export_fig. See src/export_fig/LICENSE for it's license.