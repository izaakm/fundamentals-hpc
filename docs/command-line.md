---
title: Intro to Command Line
---

# Command Line Basics

> *How not to waste your time*
>
> Your solutions will always be more natural and more straightforward when done
> and automated with a simple shell script or a makefile.
>
> ~ Biostars Handbook

# Do you need to know how to use the command line?

Yes. The command line is a tool. The command line is to bioinformaticians what a hammer is to a carpenter.

# What do you need to know to get started?

<!-- You need to know ... -->

1. How to work with files and directories: move around with `cd`
3. The most common unix/linux commands: `cat`, `ls`, `mkdir`, `mv`, `rm`
5. How to change a program's behavior with options ("flags"), e.g. `ls` vs `ls -l`
2. The meaning of **absolute** and **relative** paths: how to access files located in directories
4. How to get help: how to find out more about what a Unix command does, `man`
6. What the terms **standard input** ("standard in") and **standard output** ("standard out") mean
7. How to redirect ("pipe") the output of one program into the input of the other

# What is a terminal?

terminal (aka, "terminal emulator)
: a program that runs a shell [...?]

# What is a shell?

shell  
: a program that allows a user to pass commands to the operating system of their computer

```sh
$ echo "Hello world!"
Hello world!
$
```

Type commands at the prompt `$`. If you don't see the prompt, the computer is
still doing something.

# What is the prompt?

It shows basic login information followed by a `$` or `%`.

```
[USERNAME@NODE] $
```

In examples, you will often see only the dollar sign `$`:

```
$ ls
```

Or just the command:

```bash
ls
```

# Disambiguation

command line interface (CLI)  
: a program that takes text as input and displays text as output

shell  
: a program that allows a user to pass commands to the operating system of their computer

terminal  
: a program that runs a shell program inside of it

Linux  
: an operating system

# Logging in

There are two ways to use the command line on ISAAC-NG:

- `ssh` via your computer's Terminal application (or similar). For more information, see: <br/><https://oit.utk.edu/hpsc/isaac-open-enclave-new-kpb/access-and-login-isaac-ng/>
- Open OnDemand \> "Clusters" \>  ISAAC Shell Access"


# Exercise: Get a terminal -- Use Open OnDemand (optional)

1. Go to <www.oit.utk/hpsc>
2. Click the button "Open OnDemand" on the left-hand side
3. Click "Clusters > ISAAC"


# Exercise: Get a terminal -- Log in to the cluster with `ssh` (optional)

1.  On macOS or Linux, open your "Terminal" app.
2.  Use the `ssh` command to connect to ISAAC-NG:
    ```bash
    $ ssh <YOUR NETID>@login.isaac.utk.edu
    ```
3.  If this is your first time logging in, type `yes` to accept the key.
4.  Enter your password (note that the cursor will NOT move as you type).
5.  When prompted, use DUO to authenticate by typing `1` and then press the <kbd>Enter</kbd> key.

# Some commands give you information

<div style="font-size: 0.8em">

| Command                   | What it does |
| ----                      | ---- |
| `pwd`                     | print current working directory |
| `ls`                      | list files in the current working directory |
| `cat <filename>`          | print the contents of the file `<filename>` |
| `head <filename>`         | first 10 lines of `<filename>` |
| `tail <filename>`         | last 10 lines of `<filename>` |
| `wc <filename>`           | number of characters, words, and lines in `<filename>` |
| `grep <query> <filename>` | search `<filename>` for text `<query>` |
| `history`                 | your command history |
| `echo <your text>`        | print `<your text>` to the terminal |

</div>

# Your first command!

Type the command `ls` at the prompt, then press the <kbd>Return</kbd> or <kbd>Enter</kbd> key to run it:

On my personal machine:

```bash
$ ls
Applications   Library     Public
Desktop        Movies      Videos
Documents      Music
Downloads      Pictures
$
```

On the cluster:

```bash
$ ls
[TODO]
$
```

# Special characters

:hand: Slow down! Be careful before typing running commands with these
characters:

     . / > \ | ~ * $

... and many more!

Special characters are context-dependent.


# What is the *working directory*?

In your shell, all commands are relative to the *current working directory*.

Use the `pwd` command to print the working directory:

```bash
$ pwd
/nfs/home/jmill165
$
```

# Some commands change things

<div style="font-size: 0.8em">

| Command                      | What it does |
| ----                         | ---- |
| `cd`                         | change the current working directory to your home directory |
| `cd <dirname>`               | change the current working directory to `<dirname>` |
| `mkdir <dirname>`            | make directory `<dirname>` |
| `cp <source> <target>` \*    | create a copy of file `<source>` named `<target>` |
| `mv <source> <directory>` \* | move `<source>` (file or directory) into `<directory>` |
| `mv <source> <target>` \*\*  | rename `<source>` (file or directory) to `<target>` |
| `rm -i <filename>`           | remove (delete\*) file named `<file>` |

</div>

<div class="footnote">

\* Be careful not to overwrite existing files when using `cp` and `mv`.

</div>

<div class="footnote">

\*\* There is no "trash" or "recycle bi" !!! You cannot recover deleted files.

</div>

# Make a new directory

```
$ mkdir example
$ ls
example
```

# Change the working directory with `cd`

```
$ cd example
$ pwd
/nfs/home/jmill165/example
```

# Change the working directory with `cd`

`cd` to your scratch directory.

**Variables** begin with a dollar sign `$` and are often (but not always) typed
in all uppercase:

```bash
$ cd $SCRATCHDIR
$ pwd
/lustre/isaac24/scratch/jmill165
```

# Change the working directory with `cd`

`cd` to your home directory

```bash
$ cd
$ pwd
/nfs/home/jmill165
```

# Change the working directory with `cd`

`cd` back to the directory you were in previously

```bash
$ cd -
$ pwd
/lustre/isaac24/scratch/jmill165
```

# There are lots of commands!

Check out this [bash Cheatsheet](https://quickref.me/bash.html)

# Options and Arguments

List the contents of your home directory with extra information:

    $ ls -l /nfs/home/NETID
         ^^                 option
            ^^^^^^^^^^^^^^^ argument

# Exercise: Navigating the Filesystem

1.  Login to the cluster and print the working directory.
2.  List the contents of the current directory.
    - Also show hidden files.
    - Who is the owner of the files?
3.  Change your working directory to your scratch directory:
    - Use the full path.
    - Use the `SCRATCHDIR` variable.

# Exercise: Setup your data directory

1.  Change your working directory to your scratch directory.
2.  Create a directory called "data".
3.  Inside the "data" directory, create three subdirectories: "raw", "downloads", and "pocessed".

# Exercise: File and Directory Manipulation

1.  Create a `tmp` directory and `cd` into it.
2.  Create some test files, `a`, `b`, and `c`, and add some sample text to each one.
3.  Run `cp a b` ...
    - Check the file contents ... what happened?
4.  Run `mv a c` ...
    - Check the file contents ... what happens?

# Exercise: File and Directory Manipulation

```bash
$ echo aa > a ; echo bb > b ; echo cc > c
$ ls
a   b   c
$ cat *
aa
bb
cc
$ cp a b
$ ls
a   b   c
$ cat *
aa
aa
cc
$ mv a c
$ ls
b   c
$ cat *
aa
aa
```

# Exercise: File and Directory Manipulation

Q: What command line options could you use with `cp`, `mv` to avoid
accidentally overwriting files?


# Exercise: Deleting files

1.  Create a test file `foo.txt`
2.  Run `rm foo.txt` ... what happens?


# Exercise: Deleting directories

1. Create a test directory `bar`
3. Remove the `bar` directory ...
    - Use `rm` for deleting *files*.
    - Use `rmdir` to delete *empty directories* (safer option).
    - Use `rm -r` to delete directories *and their contents* (**use with caution!**).


[^1]: <https://oit.utk.edu/hpsc/isaac-open-enclave-new-kpb/system-overview-cluster-at-kpb/>

<!-- END -->
