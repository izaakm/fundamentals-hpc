---
title: Orientation to ISAAC-NG
---

# HPSC Homepage

<img src="https://docs.google.com/drawings/d/e/2PACX-1vRR3ZAfT-OBAAbvKqJqeb7HHIh6_Z-eArWF_PMZEaJdiFy-eG3Gk2wyWuWkZRkCdRXG2AOyQB9LOcQX/pub?w=1920&h=1080" />

![][img_bang_hompage]

![][img_test]

[img_bang_hompage]: https://docs.google.com/drawings/d/e/2PACX-1vRR3ZAfT-OBAAbvKqJqeb7HHIh6_Z-eArWF_PMZEaJdiFy-eG3Gk2wyWuWkZRkCdRXG2AOyQB9LOcQX/pub?w=1920&h=1080

[img_test]: https://docs.google.com/drawings/d/e/2PACX-1vR2-LDotag4dteY8d1w0aZqchJacez2jK-oT2obe6xUmIBUfo9svB6rdb9LlbRRe68wvKyeclo5u7s6/pub?w=960&h=720

# How to get help

1.  Join us in Office Hours
    - TR 11 AM – 12 PM
    - Zoom link: <https://tiny.utk.edu/BCSOfficeHours>
2.  Submit a Service Request
    - See the OIT HPSC Homepage <https://oit.utk.edu/hpsc>
3.  OIT HPSC Workshop Recordings: <https://oit.utk.edu/hpsc/overview/workshop-recordings/>

:telephone_receiver: Or call the OIT Help Desk at (865) 974-9900

<div class="footer">

:point_up: It’s on the OIT HPSC homepage: <https://oit.utk.edu/hpsc>

</div>


# Submit a Service Request (aka Ticket)

<!-- slide:twopanel -->

|      |      |
| :--: | ---- |
| <https://oit.utk.edu/hpsc><br/>Click on<br/>“**Submit HPSC Service Request**” | ![](assets/images/screenshots/oit-utk-edu-hpsc/oit-utk-com-hpsc.png) |

|      |      |
| :--: | ---- |
| <https://oit.utk.edu/hpsc><br/>Click on<br/>“**Submit HPSC Service Request**” | ![](assets/images/screenshots/oit-utk-edu-hpsc/oit-utk-com-hpsc.png) |

<div class="footer">

:point_up: It’s on the OIT HPSC homepage: <https://oit.utk.edu/hpsc>

</div>

# Orientation to ISAAC-NG

1.  ISAAC-NG: *What is a cluster, anyway?*
2.  Accessing ISAAC-NG with Open OnDemand (web app)
3.  Transferring data with Globus
4.  ISAAC-NG in the cloud: Desktop, Jupyter, Rstudio

# Getting Started with ISAAC-NG

# Request an ISAAC user account

Do this first! Required to access ISAAC resources!

1.  Go to the HPSC homepage: <https://oit.utk.edu/hpsc/>
2.  Click button “Request an ISAAC Account” (left side bar)
3.  Click button “I have a UT NetID”
4.  Wait for approval email (~24 hours)

More Details: <https://oit.utk.edu/hpsc/overview/requesting-an-account/>

# Request an ISAAC user account

## Click “Request an ISAAC Account”

![](assets/images/screenshots/oit-utk-edu-hpsc/oit-utk-com-hpsc.png)

# Request an ISAAC user account

## Click “I have a UT NetID”

![](assets/images/nics-portal-request-account.png)

# High Performance Computing with ISAAC-NG

# HPC in a nutshell

HPC gives you access to many physical computers (**nodes**) and a lot of data storage (**file system**).

# HPC Terminology

## *What is a cluster, anyway?*

Important terms

- Cluster
- Node
- Partition
- QoS
- File System

# *What is a cluster, anyway?*

<table>

<tr>

<td>

A **cluster** is made up many physical computers that all work together. Each individual physical computer is called a **node**.
</td>

<td>

<img src="https://upload.wikimedia.org/wikipedia/commons/c/c5/MEGWARE.CLIC.jpg" />
</td>

</tr>

</table>

# 

## UTK has 2 clusters

![](assets/images/misc/66-figure-isaac-compute-resources/main.png)

# The ISAAC-NG Cluster

![](assets/images/misc/34-isaac-ng-cluster/main.png)

# What are nodes?

nodes  
physical computers that work together as a **cluster**

Nodes can be assigned a particular function, eg:

<table>

<tr>

<td>

- login nodes
- data transfer nodes (DTN)
- compute nodes

</td>

<td>

![](assets/images/misc/34-isaac-ng-cluster/main.png)
</td>

</tr>

</table>

# The ISAAC-NG Cluster

- 2 login nodes (`login1`, `login2`)
- 2 data transfer nodes (`dtn1`, `dtn2`)
- \>200 compute nodes<br/> Homepage \> ISAAC Next Gen \> System Overview [^1]

# Compute nodes

## Partition and QoS

# Partitions and QoS …

The **<u>compute</u> nodes** are further divided into groups called **partitions**.

partition  
a group of compute nodes on the cluster, e.g., `campus`, `short`, `campus-gpu`, `campus-bigmem`

quality of service (QoS)  
a rule that determines how long you can use a certain **partition**

# Partitions and QoS …

###### *why should I care?*

- Run compute-intensive software on **<u>compute</u> nodes** (*not* on the **login nodes**) … *“and how do I do that?”*
- Tell the **scheduler** (Slurm) which **partition** (and matching **QoS**) to use, e.g.:

| your job …       | Partition       | QoS          |
|------------------|-----------------|--------------|
| quick?           | `short`         | `short`      |
| lots of memory?  | `campus-bigmem` | `campus`     |
| GPU?             | `campus-gpu`    | `campus-gpu` |
| nothing special? | `campus`        | `campus`     |

# Data Storage

file system  
handles data storage

enables multiple physical computers (nodes) to read/write data to multiple physical hard drives

There are two **file systems** on ISAAC-NG:

NFS `/nfs`  
Think of NFS as your normal hard drive on your computer.

Lustre `/lustre`  
Think of Lustre as an external hard drive where you put all of your research data that’s too big to fit on your computer’s normal hard drive.

# Data Storage

| Name    | Quota                       | Location (path)                  |
|---------|-----------------------------|----------------------------------|
| Home    | 50 Gigabytes :frowning:     | `/nfs/home/USERNAME`             |
| Scratch | **10 Terabytes** :thumbsup: | `/lustre/isaac/scratch/USERNAME` |
| Project | **1 Terabyte**              | `/lustre/isaac/proj/PROJECT`     |

<div class="footnote">

<mark> IMPORTANT: Put all your stuff on Lustre because *NFS is slow and doesn’t have much disk space!!!* </mark>

</div>

<div class="footnote">

- There are two **file systems**: NFS (`/nfs`) and Lustre (`/lustre`). You can think of these as two different hard drives.
- Project directories are owned by the Principal Investigator. Any user that has been *added to the project* will have access to this project directory. There is no project directory for the default account.
- “storage” $`\neq`$ “memory”

</div>

# HPC Terminology

## Recap

- Cluster
- Node (login, compute, DTN)
- Partition
- QoS
- File System

# Intro to Open OnDemand

\[<a href="open-ondemand.html" target=_blank>Go to slides.</a>\]

# Intro to Globus

\[<a href="globus.html" target=_blank>Go to slides.</a>\]

# Thank you!

## Questions?

# Bonus!

## Command line

# Command Line Basics

## Terminology

# What is *a shell*?

shell  
a program that allows a user to pass commands to the operating system of their computer

Command line **shell** programs:

- bash (the default on Linux)
- zsh (the default on MacOS)

# What is *the prompt*?

The **prompt** is where you enter commands for the **shell**.

<div style="border: 1px solid black; margin: 1em; padding: 1em;">

shell, Command Line Interface (CLI)

``` bash
$
```

</div>

- When you see the prompt, the shell is ready for your command.
- If you do *not* see the prompt, the shell is waiting for your command to finish.

# What is *the prompt*?

It shows basic login information followed by a `$` (or `%`).

The default prompt on ISAAC-NG:

``` bash
[USERNAME@login1] $
```

In examples, you will often see only the dollar sign `$`:

``` bash
$
```

# Enter commands at the shell prompt

Type the command `ls`, then press the <kbd>Return</kbd> (or <kbd>Enter</kbd>) key to run it:

``` bash
$ ls
```

``` bash
Applications        Movies
Desktop             Music
Documents           Pictures
Downloads           Public
Library             Videos
```

``` bash
$
```

When the command is complete, the shell will display your prompt.

# What is the *working directory*?

**In your shell, all commands are relative to the *current working directory*.**

Use the `pwd` command to print the working directory:

``` bash
$ pwd
/nfs/home/jmill165
$
```

# Most common shell commands

<div style="font-size: 0.8em">

| Command | What it does |
|----|----|
| `pwd` | print current working directory |
| `ls` | list files in the current working directory |
| `cat <filename>` | print the contents of the file `<filename>` |
| `cd` | change the current working directory to your home directory |
| `cd <dirname>` | change the current working directory to `<dirname>` |
| `mkdir <dirname>` | make directory `<dirname>` |
| `cp <source> <target>` | create a copy of file `<source>` named `<target>` |
| `mv <source> <directory>` | move `<source>` (file or directory) into `<directory>` |
| `mv <source> <target>` | rename `<source>` (file or directory) to `<target>` |
| `rm -i <filename>` | remove (delete\*) file named `<file>` |

</div>

<div class="footnote">

\* There is no “trash” or “recycle bin”!!! You cannot recover deleted files.

</div>

# Open OnDemand

## Shell Access Demo

# OnDemand – Shell Access

![](assets/images/open-ondemand-clusters-menu.png)

# OnDemand – Shell Access

![](assets/images/screenshots/open-ondemand-clusters-shell-access-terminal/main.png)

[^1]: <https://oit.utk.edu/hpsc/isaac-open-enclave-new-kpb/system-overview-cluster-at-kpb/>
