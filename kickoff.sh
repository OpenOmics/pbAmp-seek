#! /bin/bash


set -e

###################
#
# Launching shell script for Pacbio Amplicon Analysis Pipeline
#
###################
module load python/3.7
module load snakemake/7.19.1

R=$2
echo $R

mkdir -p $R/snakejobs
mkdir -p $R/reports

##
## Test commandline arguments
##
if [ $# -ne 2 ]; then
    echo " "
    echo "Requires a single commandline argument: npr or process"
    echo " "
    exit
fi

if [ $1 != "npr" ] && [ $1 != "process" ] ; then
    echo " "
    echo "Invalid commandline option: $1"
    echo "Valid commandline options include: npr or process"
    echo " "
    exit
fi

# and be sure this directory and all subdirectories are writable
#chmod -fR g+rwx .
#chmod +rwx .

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

echo $SCRIPT
echo $SCRIPTPATH

##
## Run snakemake
##

echo "Run snakemake"
source /data/NCBR/apps/genome-assembly/conda/etc/profile.d/conda.sh

CLUSTER_OPTS="sbatch --gres {cluster.gres} --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name={params.rname} -e snakejobs/slurm-%j_{params.rname}.out -o snakejobs/slurm-%j_{params.rname}.out"

if [ $1 == "npr" ]
then
    snakemake -npr --snakefile $R/snakefile -j 1 --configfile $R/config.json 
fi

if [ $1 == "process" ]
then
    snakemake --use-envmodules --use-conda --latency-wait 120  -s $R/snakefile -d $R --configfile $R/config.json --printshellcmds --cluster-config $R/cluster.json --keep-going --restart-times 1 --cluster "$CLUSTER_OPTS" -j 500 --rerun-incomplete --stats $R/reports/snakemake.stats | tee -a $R/reports/snakemake.log
fi
