---
title: Intro to Command Line
---


# Command Line Basics


# What do you need to know to get started?

<!-- You need to know ... -->

1. How to work with files and directories: move around with `cd`
1. The most common unix/linux commands: `cat`, `ls`, `mkdir`, `mv`, `rm`
1. How to change a program's behavior with options ("flags"), e.g. `ls` vs `ls -l`
1. The meaning of **absolute** and **relative** paths: how to access files located in directories
1. How to get help: how to find out more about what a Unix command does, `man`
1. Use the wildcard ("glob" `*`) to gather multiple files or directories
1. How to redirect the output of one program into the input of the other


# Terminology

terminal (aka, "terminal emulator)
: a program that runs a shell [...?]

shell  
: a program that allows a user to pass commands to the operating system of their computer

```
$ echo "Hello world!"
Hello world!
$
```

Type commands at the prompt `$`. If you don't see the prompt, the computer is
still doing something.

The prompt shows basic login information followed by a `$` or `%`.

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

Angled brackets (aka, "greather than" and "less than" symbols) often indicate
some information specific to you that you need to enter, e.g., your NetID:

```bash
ls /nfs/home/<netid>
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

- `ssh` via your computer's Terminal application (or similar).<br/>
    *For more information, see: [Access and Login on ISAAC-NG][]*
- Open OnDemand > "Clusters" > "ISAAC Shell Access"

[Access and Login on ISAAC-NG]: https://oit.utk.edu/hpsc/isaac-open-enclave-new-kpb/access-and-login-isaac-ng/

# Exercise: Get a terminal -- Use Open OnDemand (optional)

1. Go to <www.oit.utk/hpsc>
2. Click the button "Open OnDemand" on the left-hand side
3. Click "Clusters" > ISAAC Shell Access"


# Exercise: Get a terminal -- Log in to the cluster with `ssh` (optional)

1.  On macOS or Linux, open your "Terminal" app.
2.  Use the `ssh` command to connect to ISAAC-NG:
    ```
    $ ssh <YOUR NETID>@login.isaac.utk.edu
    ```
3.  If this is your first time logging in, type `yes` to accept the key.
4.  Enter your password (note that the cursor will NOT move as you type).
5.  When prompted, use DUO to authenticate by typing `1` and then press the <kbd>Enter</kbd> key.


# Where am I?

In your shell, all commands are relative to the *current working directory*.

The `pwd` command *print the working directory*.

Type the command `pwd` at the prompt, then press the <kbd>Return</kbd> or
<kbd>Enter</kbd> key to run it.

```
$ pwd
/nfs/home/jmill165
$
```


# What's in the current working directory?

Type the command `ls` at the prompt, then press the <kbd>Return</kbd> or
<kbd>Enter</kbd> key to run it:

On my personal machine:

```
$ ls
Applications   Library     Public
Desktop        Movies      Videos
Documents      Music
Downloads      Pictures
$
```

On the cluster:

```
$ ls
[Varies. If this is your first time using the cluster, there may be nothing here.]
$
```


# Some commands give you information

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


# Some commands change things

| Command                      | What it does |
| ----                         | ---- |
| `cd`                         | change the current working directory to your home directory |
| `cd <dirname>`               | change the current working directory to `<dirname>` |
| `mkdir <dirname>`            | make directory `<dirname>` |
| `cp <source> <target>` \*    | create a copy of file `<source>` named `<target>` |
| `mv <source> <directory>` \* | move `<source>` (file or directory) into `<directory>` |
| `mv <source> <target>` \*\*  | rename `<source>` (file or directory) to `<target>` |
| `rm -i <filename>`           | remove (delete\*) file named `<file>` |
| `echo <your text> >> <filename>`        | write `<your text>` to the file `<filename>` |

**Special characters**

Some characters do different things depending on the context. Be careful before
typing running commands with these characters:

     . / > \ | ~ * $

... and many more!


\* Be careful not to overwrite existing files when using `cp` and `mv`.

\*\* There is no "trash" or "recycle bin"!!! You cannot recover deleted files.


# Change to your scratch directory

```bash
cd /lustre/isaac24/scratch/<netid>
```


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

```
$ cd $SCRATCHDIR
$ pwd
/lustre/isaac24/scratch/jmill165
```

# Change the working directory with `cd`

`cd` to your home directory

```
$ cd
$ pwd
/nfs/home/jmill165
```

# Change the working directory with `cd`

`cd` back to the directory you were in previously

```
$ cd -
$ pwd
/lustre/isaac24/scratch/jmill165
```

# There are lots of commands!

Check out this [bash Cheatsheet](https://quickref.me/bash.html)


# Options and Arguments

List the contents of your home directory with extra information:

    $ ls -l /nfs/home/<netid>
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


# Exercise: Deleting files

1.  Create a test file `foo.txt`
2.  Run `rm foo.txt` ... what happens?


# Exercise: Deleting directories

1. Create a test directory `bar`
3. Remove the directory with `rm bar` ... what happens?
    - Use `rm` for deleting *files*.
    - Use `rmdir` to delete *empty directories* (safer option).
    - Use `rm -r` to delete directories *and their contents* (**use with caution!**).


[^1]: <https://oit.utk.edu/hpsc/isaac-open-enclave-new-kpb/system-overview-cluster-at-kpb/>


# Absolute and relative paths


Absolute path

```bash
cd
mkdir foo bar
cd /nfs/home/<netid>/foo
cd /nfs/home/<netid>/bar
```

```bash
cd ~
```

```bash
cd /lustre/isaac24/scratch/<netid>
cd $SCRATCHDIR
```

Relative path

```bash
cd
mkdir foo bar
cd foo
cd ../bar
```

`.`
: The current working directory

`..`
: The parent directory relative to the current working directory

```bash
ls -la
```

`.<something>`
: A hidden file or directory


# Tab completion

```bash
cd /lu<TAB>
```

```bash
cd /lustre
```

```bash
cd /lustre/<TAB>
```

???


# Glob `*`

```bash
cd
touch foo bar buzz
echo f*
echo b*
```

Use `echo` to test commands:

```bash
echo rm b*
```

If it looks good, just use the up arrow to show the command again, then delete
the `echo`.


# Read the manual

Manual `man` pages and `less`

```bash
man cp
```

(Or Google `linux man cp`.)

Manual `man` pages will open in a program called `less`. Use the arrows to
scroll up/down, and type <kbd>q</kbd> to quit. Type <kbd>?</kbd> for help.

# Exercise: File and Directory Manipulation

Q: What command line options could you use with `cp`, `mv` to avoid
accidentally overwriting files?

Q: What command line options could you use with `rm` to avoid accidentally
deleting files?


# Redirect the out put of a command ...

... to a file and append to the file (if it exists, otherwise, create it):

```bash
echo "foo bar" >> foo.txt
```

... to a file and OVERWRITE that file:

```bash
echo "foo bar" > foo.txt
```

... to another command:

```bash
echo "foo bar" | grep foo
```


# Exercise: File and Directory Manipulation

1.  Create a `tmp` directory and `cd` into it.
2.  Create some test files, `a`, `b`, and `c`, and add some sample text to each one.
3.  Run `cp a b` ...
    - Check the file contents ... what happened?
4.  Run `mv a c` ...
    - Check the file contents ... what happens?


# Exercise: File and Directory Manipulation

```
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




<!-- END -->
