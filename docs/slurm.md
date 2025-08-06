---
title: Slurm
---

# Log in

```bash
ssh <netid>@login.isaac.utk.edu
```

Or

<oit.utk.edu/hpsc> > Open OnDemand > Clusters > ISAAC NG

```bash
cd $SCRATCHDIR/projects/example
```

# Get some data

We're going to write scripts to run fastqc ... we need some data.

```bash
mkdir -p data/raw
cd data/raw
wget <some data>
```

# We need some compute resources

Get an interactive compute session. Best for testing.

```
salloc [...]
```

# Write a script


<!-- command -->

```bash
nano qc.sh
```

<!-- script -->

```bash
#!/usr/bin/env bash

module load fastqc

fastqc ./data/*.fastq.gz -o ./fastqc
```

# Run a script

***Don't do this on a log in node***

```bash
bash qc.sh
```

# It's working! => sbatch


# Simple job -- Single CPU

```bash
#!/usr/bin/env bash
#SBATCH <account,partition,qos>
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1

module load fastqc

fastqc ./data/*.fastq.gz -o ./fastqc
```

Submit that script.

```bash
sbatch qc.sh
```

<div class="footnote">
- A similar script is available in `/lustre/isaac/examples/jobs/fastqc`.
- Example fastq files are available in `/lustre/isaac/examples/data/fastq`.
</div>


# Simple job -- Single CPU

```bash
#SBATCH <account,partition,qos>
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1

<your Python or R script> <args>
```

# Simple job -- More memory (RAM)

```bash
#SBATCH --cpus-per-task 1
```

```bash
#SBATCH --cpus-per-task 8
```

Default memory per CPU is usually ~3.8 GB, so you may want to request more CPUs
(e.g., increase `--cpus-per-task`) or set `--mem` to request more memory.


# Multi-threaded -- More than one CPU

```bash
#SBATCH <account,partition,qos>
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 8

module load fastqc

echo "SLURM_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK"

fastqc ./data/*.fastq.gz -o ./fastqc --threads "$SLURM_CPUS_PER_TASK"
```


# Parallel

Alternatively, we can run fastqc in **parallel** using `--ntasks` and `srun`.

Why? Fastqc can already run multi-threaded ....

If you have *a lot* of fastq files, the bottleneck for **multi-threading** may become max CPUs.


# Parallel

Run `fastqc` up to 8 times, independently, in parallel:

```
#SBATCH <account,partition,qos>
#SBATCH --nodes 1                # This is the default
#SBATCH --ntasks 8
#SBATCH --cpus-per-task 1

module load fastqc

for fq in ./data/*.fastq.gz ; do
    echo "$(date) Running $fq ..."
    srun --ntasks 1 --cpus-per-task 1 fastqc "$fq" -o ./fastqc &
done
wait
```


# Parallel -- Increase **CPUs per task**

```
#SBATCH <account,partition,qos>
#SBATCH --nodes 1                # This is the default
#SBATCH --ntasks 8
#SBATCH --cpus-per-task 4        # More CPUs

module load fastqc

for fq in ./data/*.fastq.gz ; do
    echo "$(date) Running $fq ..."
    srun --ntasks 1 --cpus-per-task 4 fastqc "$fq" -o ./fastqc &
    #                               ^
done
wait
```


# Parallel -- Take advantage of multiple nodes

```
#SBATCH <account,partition,qos>
#SBATCH --nodes 6                # More nodes for the job
#SBATCH --ntasks 8
#SBATCH --cpus-per-task 4

module load fastqc

for fq in ./data/*.fastq.gz ; do
    echo "$(date) Running $fq ..."
    srun --ntasks 1 --cpus-per-task 4 fastqc "$fq" -o ./fastqc &
    #        This ^ is still 1 task
done
wait
```


# Job Arrays


# Job Arrays: What are they?

Slurm will run the same batch script many times, automatically.

**Each instance of that script has access to a special counter variable.**


# Job Arrays: Why?

When you need to run basically the same command on many different files
**independently**, these tasks can be run in **parallel**.


# Job Arrays: How?

1. Use the `--array` argument to specify a sequence of integers, e.g., `--array 0-3`.
1. Use a special variable `$SLURM_ARRAY_TASK_ID` in your script, which will take on the values in the array sequence.


# Job Arrays: For comparison ...

The following would be analogous:

- sbatch:</br>
  `$ sbatch --array 0-3`
- bash:</br>
  `$ seq 0 3`
- R:</br>
  `> seq(0,3)`
- Python:</br>
  `>>> range(0,3)`


# Job Arrays

```bash
#!/usr/bin/env bash
#SBATCH <account,partition,qos>
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --array 0-3

i=$SLURM_ARRAY_TASK_ID

world=( "Charles" "Rosalind" "George" "Rachel" )

echo "Hello ${world[$i]}! Your SLURM_ARRAY_TASK_ID is $i"
```


# Job Arrays

```bash
# This script will be run four times, because the array is expanded to `0,1,2,3`.
#SBATCH --array 0-3

# Each instance of the script, Slurm will set the special variable to those
# values (0,1,2,3). We'll save that as a new variable `i` because it's easier to
# type.
i=$SLURM_ARRAY_TASK_ID

# Here, we set the variable `world` to a list of names:
world=( "Charles" "Rosalind" "George" "Rachel" )

# Finally, use the special variable to get the `i`th item from the list `world`.
echo "Hello ${world[$i]}! Your SLURM_ARRAY_TASK_ID is $i"
```


# Job Arrays

Multiple values may be specified using a comma separated list and/or a range of
values with a "-" separator. For example:

- `--array=0-15`
- `--array=0,6,16-32`

A step function can also be specified with a suffix containing a colon and
number. For example:

- `--array=0-15:4` is equivalent to `--array=0,4,8,12`.

<div class="footnote">
~ <https://slurm.schedmd.com/sbatch.html#OPT_array>
</div>


# Job Arrays -- Fastqc

<div style="font-size: 0.9em;">
```bash
#!/usr/bin/env bash
#SBATCH <your sbatch directives>
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --array 0-8

module load fastqc

i=$SLURM_ARRAY_TASK_ID

fastq_files=( data/*.fastq.gz )

echo "Found ${#fastq_files[@]} fastq files."

fastqc "${fastq_files[$i]}" -o ./fastqc
```
</div>



<!-- END -->
