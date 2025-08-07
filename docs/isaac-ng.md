---
title: Orientation to ISAAC-NG
---


# HPSC Homepage

<!--<img src="https://docs.google.com/drawings/d/e/2PACX-1vRR3ZAfT-OBAAbvKqJqeb7HHIh6_Z-eArWF_PMZEaJdiFy-eG3Gk2wyWuWkZRkCdRXG2AOyQB9LOcQX/pub?w=1920&h=1080" />-->

[ ![][img_bang_hompage] ][hpsc_homepage]

[hpsc_homepage]: https://oit.utk.edu/hpsc/
[img_bang_hompage]: https://docs.google.com/drawings/d/e/2PACX-1vRR3ZAfT-OBAAbvKqJqeb7HHIh6_Z-eArWF_PMZEaJdiFy-eG3Gk2wyWuWkZRkCdRXG2AOyQB9LOcQX/pub?w=1920&h=1080


# How to get help

***It's on the OIT HPSC homepage: <https://oit.utk.edu/hpsc>***

- Join us in Office Hours: TR 11 AM -- 12 PM
    - <https://tiny.utk.edu/BCSOfficeHours> (opens in Zoom)
- Submit a Service Request
    - <https://utk.teamdynamix.com/TDClient/2277/OIT-Portal/Requests/ServiceDet?ID=45020&_gl=1*1qj81om*_ga*MTA0OTQ5MTE2Ny4xNzUxMDMxNzE3*_ga_275S8CRNYW*czE3NTQ1ODEzMDIkbzQ1JGcwJHQxNzU0NTgxMzAyJGo2MCRsMCRoMA..>
- HPSC Instructional Videos
    - <https://oit.utk.edu/hpsc/overview/workshop-recordings/>
- Or call the OIT Help Desk
    - (865) 974-9900


# Orientation to ISAAC-NG

1. ISAAC-NG: *What is a cluster, anyway?*
2. Accessing ISAAC-NG with Open OnDemand (web app)
3. Transferring data with Globus
4. ISAAC-NG in the cloud: Desktop, Jupyter, Rstudio

# Getting Started: Request an ISAAC user account

Do this first! Required to access ISAAC resources!

1. Go to the HPSC homepage: <https://oit.utk.edu/hpsc/>
2. Click button "Request an ISAAC Account" (left side bar)
3. Click button "I have a UT NetID"
4. Wait for approval email (~24 hours)

More Details: <https://oit.utk.edu/hpsc/overview/requesting-an-account/>


# High Performance Computing (HPC) with ISAAC-NG

***HPC in a nutshell:***

HPC gives you access to many physical computers (**compute nodes**) and a lot of data storage.


# UTK has 2 clusters

![][img_figure_isaac_compute_resources]

[img_figure_isaac_compute_resources]: https://docs.google.com/drawings/d/e/2PACX-1vQBiMxhBdMieJiyBhqaHv8zAH1Y6rXN7aahVbu9JzjXsnqTHzaYtpWIaThPkckBJFgdFGR5fhGkUJm0/pub?w=1440&h=1080

# HPC Terminology

***What is a cluster, anyway?***


- Cluster
- Node
- Partition
- QoS
- File System

cluster
: a collection of physical computers that all work together

node
: a physical computer in a cluster

Nodes can be assigned a particular function, eg:

- login nodes
- data transfer nodes (DTN)
- compute nodes


# The ISAAC-NG Cluster

<!--![](assets/images/misc/34-isaac-ng-cluster/main.png)-->

![][img_isaacng_cluster]

[img_isaacng_cluster]: https://docs.google.com/drawings/d/e/2PACX-1vTAWXOCVwjlC6jtMIFi26SzfQIPxEAmDHc6mGSm6u3VdY8kLT6eHXkaLSlWFS9AzKdw6TtaXlQ9JHQe/pub?w=1440&h=1080

- 2 login nodes (`login1`, `login2`)
- 2 data transfer nodes (`dtn1`, `dtn2`)
- \>200 compute nodes<br/> Homepage \> ISAAC Next Gen \> System Overview [^1]


# Compute nodes

# Partitions and QoS ...

The **<u>compute</u> nodes** are further divided into groups called **partitions**.

partition  
: a group of compute nodes on the cluster, e.g., `campus`, `short`, `campus-gpu`, `campus-bigmem`

quality of service (QoS)  
: a rule that determines how long you can use a certain **partition**

# Partitions and QoS ...

- Run compute-intensive software on **<u>compute</u> nodes** (*not* on the **login nodes**)
- Tell the **scheduler** (Slurm) which **partition** (and matching **QoS**) to use, e.g.:

| your job ...       | Partition       | QoS          |
|------------------|-----------------|--------------|
| quick?           | `short`         | `short`      |
| lots of memory?  | `campus-bigmem` | `campus`     |
| GPU?             | `campus-gpu`    | `campus-gpu` |
| nothing special? | `campus`        | `campus`     |

# Data Storage

file system  
: handles data storage on one or more hard drives
: multiple physical computers (nodes) can read/write data at the same time

There are two **file systems** on ISAAC-NG:

NFS `/nfs`  
: Think of NFS as your normal hard drive on your computer.

Lustre `/lustre`  
: Think of Lustre as an external hard drive where you put all of your research data that's too big to fit on your computer's normal hard drive.

# Data Storage

| Name    | Quota                       | Location (path)                              |
|---------|-----------------------------|----------------------------------            |
| Home    | 50 Gigabytes :frowning:     | `/nfs/home/<netid>`                         |
| Scratch | **10 Terabytes** :thumbsup: | `/lustre/isaac24/scratch/<netid>`            |
| Project | **1 Terabyte**              | `/lustre/isaac24/proj/<project account>`     |

- There are two **file systems**: NFS (`/nfs`) and Lustre (`/lustre`).
- **IMPORTANT:** Put your data on Lustre because *NFS is slow and doesn't have
  much disk space!!!*
- Project directories are owned by the Principal Investigator. Any user that
  has been *added to the project* will have access to this project directory.
  (The default account `ACF-UTK0011` does NOT have a project directory.)

# Intro to Open OnDemand

\[<a href="open-ondemand.html" target=_blank>Go to slides.</a>\]

# OnDemand - Shell Access

![](assets/images/open-ondemand-clusters-menu.png)

# OnDemand - Shell Access

![](assets/images/screenshots/open-ondemand-clusters-shell-access-terminal/main.png)

[^1]: <https://oit.utk.edu/hpsc/isaac-open-enclave-new-kpb/system-overview-cluster-at-kpb/>

# Intro to Globus

\[<a href="globus.html" target=_blank>Go to slides.</a>\]

# Thank you!



<!-- LINKS -->

[img_test]: https://docs.google.com/drawings/d/e/2PACX-1vR2-LDotag4dteY8d1w0aZqchJacez2jK-oT2obe6xUmIBUfo9svB6rdb9LlbRRe68wvKyeclo5u7s6/pub?w=1440&h=1080

<!-- END -->
