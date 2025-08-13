---
title: Slurm
---

# Writing scripts for Slurm

## Log in to the cluster

You can use `ssh` from your terminal:

```bash
ssh <netid>@login.isaac.utk.edu
```

Or you can get a shell from Open OnDemand

<https://oit.utk.edu/hpsc/> > "Open OnDemand" > "Clusters" > "ISAAC Shell Access"

```bash
cd $SCRATCHDIR
mkdir -p example
cd example
```

# Get some data

We're going to write scripts to run fastqc ... we need some data.

```bash
mkdir -p data/raw
cd data/raw
cp -r /lustre/isaac24/examples/data/fastq ./fastq
```

# We need some compute resources

Get an **interactive** compute session. Best for testing.

```
salloc --account acf-utk0011 --qos short --partition short --cpus-per-task 8 --time 3:00:00
```

- Slurm will print a message showing you which compute resources have been allocated.
- Look for the **Node** name, then `ssh` to that node.

```
salloc: Granted job allocation 3918678
salloc: Waiting for resource configuration
salloc: Nodes il1339 are ready for job
```

```bash
ssh "il1339"
```

<div style="border: 1px solid black; padding: 20px;">

***Don't forget to `exit` your allocation when you're done.***

1. `exit` your `ssh` session
1. `exit` your Slurm allocation

For example:

```
[jmill165@il1339 ~]$ exit
logout
Connection to il1339 closed.
[jmill165@login2 fastq]$ exit
exit
salloc: Relinquishing job allocation 3918678
salloc: Job allocation 3918678 has been revoked.
[jmill165@login2 ~]$
```

</div>


# Write a script


```bash
cd $SCRATCHDIR/example
nano qc.sh
```

<!-- SCRIPT -->

```bash
#!/usr/bin/env bash

module load fastqc

mkdir -p fastqc
fastqc ./data/raw/fastq/*.fastq.gz -o ./fastqc
```


1. Every script should start with a **shebang**: `#!/usr/bin/env bash` or
  `#!/bin/bash` are common conventions.
1. Load research software using the `module` command.
    - Check the output of `module avail` to see if your software is installed.
1. Run your software!


# Run a script

***Don't do this on a log in node***

*Check the output of the command `hostname` to confirm that you are on a
compute node and **not** a login node.*

```bash
bash qc.sh
```

# It's working!

Once your script is working, you can tell Slurm to run it for you using the
`sbatch` command.

But you need to make a few changes to the script so that Slurm knows how to run
it.


# Simple job -- Single CPU

```bash
nano qc-simple.sh
```

```bash
#!/usr/bin/env bash
#SBATCH --account acf-utk0011  # Required in every script
#SBATCH --qos short            # Required in every script
#SBATCH --partition short      # Required in every script
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1

module load fastqc

mkdir -p fastqc
fastqc ./data/raw/fastq/*.fastq.gz -o ./fastqc
```

Submit that script.

```bash
sbatch qc.sh
```

- A similar script is available in `/lustre/isaac24/examples/jobs/fastqc`.
- Example fastq files are available in `/lustre/isaac24/examples/data/fastq`.


# Simple job -- Single CPU

```bash
#SBATCH <account,partition,qos>  # See details above
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1

<your Python or R script> <args>
```

# Simple job

- The default memory (RAM) per CPU is ~3.8 GB
- Want more RAM? => Request more CPUs.

```bash
#SBATCH --cpus-per-task 1
```

```bash
#SBATCH --cpus-per-task 8
```

# Multi-threaded -- More than one CPU

```bash
nano qc-multithreaded.sh
```

```bash
#SBATCH <account,partition,qos>  # See details above
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 8

module load fastqc

echo "SLURM_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK"

mkdir -p fastqc
fastqc ./data/raw/fastq/*.fastq.gz -o ./fastqc --threads "$SLURM_CPUS_PER_TASK"
```


# Parallel

Alternatively, we can run fastqc in **parallel** using `--ntasks` and `srun`.

Why? Fastqc can already run multi-threaded ....

<!--If you have *a lot* of fastq files, the bottleneck for **multi-threading** may become max CPUs.-->


# Parallel

Run `fastqc` up to 8 times, independently, in parallel:

```bash
nano qc-parallel.sh
```

```
#SBATCH <account,partition,qos>  # See details above
#SBATCH --nodes 1                # This is the default
#SBATCH --ntasks 8
#SBATCH --cpus-per-task 1

module load fastqc

mkdir -p fastqc
for fq in ./data/raw/fastq/*.fastq.gz ; do
    echo "$(date) Running $fq ..."
    srun --ntasks 1 --cpus-per-task 1 fastqc "$fq" -o ./fastqc &
done
wait
```


# Parallel -- Increase **CPUs per task**

```
#SBATCH <account,partition,qos>  # See details above
#SBATCH --nodes 1                # This is the default
#SBATCH --ntasks 8
#SBATCH --cpus-per-task 4        # More CPUs

module load fastqc

mkdir -p fastqc
for fq in ./data/raw/fastq/*.fastq.gz ; do
    echo "$(date) Running $fq ..."
    srun --ntasks 1 --cpus-per-task 4 fastqc "$fq" -o ./fastqc &
    #                               ^
done
wait
```


# Parallel -- Take advantage of multiple nodes

```
#SBATCH <account,partition,qos>  # See details above
#SBATCH --nodes 6                # More nodes for the job
#SBATCH --ntasks 8
#SBATCH --cpus-per-task 4

module load fastqc

mkdir -p fastqc
for fq in ./data/raw/fastq/*.fastq.gz ; do
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

sbatch
: `$ sbatch --array 0-3`

bash
: `$ seq 0 3`

R
: `> seq(0,3)`

Python
: `>>> range(0,3)`


# Job Arrays

```bash
nano example-array.sh
```

```bash
#!/usr/bin/env bash
#SBATCH <account,partition,qos>  # See details above
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

~ <https://slurm.schedmd.com/sbatch.html#OPT_array>


# Job Arrays -- Fastqc

```bash
nano qc-array.sh
```

```bash
#!/usr/bin/env bash
#SBATCH <account,partition,qos>  # See details above
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --array 0-8

module load fastqc

i=$SLURM_ARRAY_TASK_ID

fastq_files=( data/raw/fastq/*.fastq.gz )

echo "Found ${#fastq_files[@]} fastq files."

mkdir -p fastqc
fastqc "${fastq_files[$i]}" -o ./fastqc
```



<!-- END -->
