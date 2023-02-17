<div align="center">
   
  <h1>pbAmp-seek 🔬</h1>
  
  **_Identify and count PacBio Hifi amplicons_**

  [![tests](https://github.com/OpenOmics/pbAmp-seek/workflows/tests/badge.svg)](https://github.com/OpenOmics/pbAmp-seek/actions/workflows/main.yaml) [![docs](https://github.com/OpenOmics/pbAmp-seek/workflows/docs/badge.svg)](https://github.com/OpenOmics/pbAmp-seek/actions/workflows/docs.yml) [![GitHub issues](https://img.shields.io/github/issues/OpenOmics/pbAmp-seek?color=brightgreen)](https://github.com/OpenOmics/pbAmp-seek/issues)  [![GitHub license](https://img.shields.io/github/license/OpenOmics/pbAmp-seek)](https://github.com/OpenOmics/pbAmp-seek/blob/main/LICENSE) 
  
  <i>
    This is the home of the pipeline, pbAmp-seek. Its long-term goals: to identify and count PacBio Hifi amplicons like no pipeline before!
  </i>
</div>

## Overview
Welcome to pbAmp-seek! Before getting started, we highly recommend reading through [pbAmp-seek's documentation](https://openomics.github.io/pbAmp-seek/).

The **`./pbAmp-seek`** pipeline is composed several inter-related sub commands to setup and run the pipeline across different systems. Each of the available sub commands perform different functions: 

 * [<code>pbAmp-seek <b>run</b></code>](https://openomics.github.io/pbAmp-seek/usage/run/): Run the pbAmp-seek pipeline with your input files.
 * [<code>pbAmp-seek <b>unlock</b></code>](https://openomics.github.io/pbAmp-seek/usage/unlock/): Unlocks a previous runs output directory.
 * [<code>pbAmp-seek <b>cache</b></code>](https://openomics.github.io/pbAmp-seek/usage/cache/): Cache remote resources locally, coming soon!

**pbAmp-seek** is a comprehensive pipeline to identify and count PacBio Hifi amplicons. It relies on technologies like [Singularity<sup>1</sup>](https://singularity.lbl.gov/) to maintain the highest-level of reproducibility. The pipeline consists of a series of data processing and quality-control steps orchestrated by [Snakemake<sup>2</sup>](https://snakemake.readthedocs.io/en/stable/), a flexible and scalable workflow management system, to submit jobs to a cluster.

The pipeline is compatible with data generated from PacBio long-read sequencing technologies. As input, it accepts a set of FastQ files and can be run locally on a compute instance or on-premise using a cluster. A user can define the method or mode of execution. The pipeline can submit jobs to a cluster using a job scheduler like SLURM (more coming soon!). A hybrid approach ensures the pipeline is accessible to all users.

Before getting started, we highly recommend reading through the [usage](https://openomics.github.io/pbAmp-seek/usage/run/) section of each available sub command.

For more information about issues or trouble-shooting a problem, please checkout our [FAQ](https://openomics.github.io/pbAmp-seek/faq/questions/) prior to [opening an issue on Github](https://github.com/OpenOmics/pbAmp-seek/issues).

## Dependencies
**Requires:** `singularity>=3.5`  `snakemake>=6.0` `conda/mamba`

At the current moment, the pipeline uses a mixture of enviroment modules, conda environments, and docker images; however, this will be changing soon! In the very near future, the pipeline will only use docker images. With that being said, [snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html) and [singularity](https://singularity.lbl.gov/all-releases) must be installed on the target system. Snakemake orchestrates the execution of each step in the pipeline. To guarantee the highest level of reproducibility, each step of the pipeline will rely on versioned images from [DockerHub](https://hub.docker.com/orgs/nciccbr/repositories). Snakemake uses singularity to pull these images onto the local filesystem prior to job execution, and as so, snakemake and singularity will be the only two dependencies in the future. Conda can be installed following [these](https://conda.io/projects/conda/en/latest/user-guide/install/index.html#) instructions. 

## Installation
This pipeline requires conda and mamba to be installed and exist in your path variables. Instruction to install conda and memba is provided below:
**download** 

wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
**install**

bash Mambaforge-Linux-x86_64.sh -p /data/$USER/conda -b
**source**

source /data/$USER/conda/etc/profile.d/conda.sh && source /data/$USER/conda/etc/profile.d/mamba.sh

Please clone this repository to your local filesystem using the following command:
```bash
# Clone Repository from Github
git clone https://github.com/OpenOmics/pbAmp-seek.git
# Change your working directory
cd pbAmp-seek/
# Add dependencies to $PATH
# Biowulf users should run
module load snakemake singularity
which conda || echo 'Error: conda not installed!'
which mamba || echo 'Error: mamba not installed!'
# If the errors above occurred, please source the conda & mamba init file:
source /data/$USER/conda/etc/profile.d/conda.sh && source /data/$USER/conda/etc/profile.d/mamba.sh

# note that 
# Get usage information
./pbAmp-seek -h
```

## Contribute 
This site is a living document, created for and by members like you. pbAmp-seek is maintained by the members of OpenOmics and is improved by continous feedback! We encourage you to contribute new content and make improvements to existing content via pull request to our [GitHub repository](https://github.com/OpenOmics/pbAmp-seek).

## References
<sup>**1.**  Kurtzer GM, Sochat V, Bauer MW (2017). Singularity: Scientific containers for mobility of compute. PLoS ONE 12(5): e0177459.</sup>  
<sup>**2.**  Koster, J. and S. Rahmann (2018). "Snakemake-a scalable bioinformatics workflow engine." Bioinformatics 34(20): 3600.</sup>  
