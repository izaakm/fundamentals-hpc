---
title: Project organization and Git
---

# Version control

![][phdcomics_finaldoc]

[phdcomics_finaldoc]: https://phdcomics.com/comics/archive/phd101212s.gif

<!--analysis.R-->
<!--analysis-vers3.R-->
<!--analysis2.R-->
<!--analysis_redo.R-->
<!--thesis-vers1.docx-->
<!--thesis-vers2_CD+GM+SW_edits.docx-->
<!--thesis-vers3_CD_edits.docx-->


# Git

![][xkcd_git]

[xkcd_git]: https://imgs.xkcd.com/comics/git.png


# A simple example

## Overview

```bash
mkdir example
cd example
git init .
echo "# My Project" >> README.md
git add README.md
git commit -m "Add README"
```

## Step-by-step

```bash
mkdir example
cd example
```

Check the contents of the directory:

```bash
ls -la
```

Then, initialize the Git repository:

```bash
git init .
```

Check the contents of the directory again:

```bash
ls -la
```

You should see a new directory, `.git`; that's your "git repository".

```bash
echo "# My Project" >> README.md
git add README.md
git commit -m "Add README"
```

`git init`
: This command creates an empty Git repository - basically a .git directory that stores all of Git's internal files and versions of your files. (~ `man git-init`)
: Running `git init` in an existing repository **is safe**. It will not overwrite things that are already there. (~ `man git-init`)

`git add <filename>`
: This command updates the "index" using the current content found in the working tree. (~ `man git-add`)
: The "index" holds a snapshot of the content of the working tree, and it is this snapshot that is taken as the contents of the next commit. (~ `man git-add`)

`git commit -m "<message>"`
: Create a new commit containing the current contents of the index and the given log message describing the changes. (~ `man git-commit`)


## One-time set up

If this is your first time using Git, it may warn you about your username and
email address. Git always includes this information in commits, but you can
enter anything you like. Git will prompt you if these are not already set.
Keep in mind that **this information will be public** if you are using, e.g.,
GitHub.

```bash
git config --global user.name=<your name>
git config --global user.email=<your email>
```

Verify the settings:

```bash
git config --global --list
```


# Exercise: Add some more files and directories

An example project structure (see [Cookiecutter Data
Science][cookiecuttier_directories] for more details):

[cookiecuttier_directories]: https://cookiecutter-data-science.drivendata.org/#directory-structure
    "Directory structure"


    ├── AUTHORS            <- List of authors and collaborators for this project.
    ├── CITATION.cff       <- Plain text file with citation information for software and datasets.
    ├── LICENSE            <- Open-source license if one is chosen
    ├── Makefile           <- Makefile with convenience commands like `make data` or `make train`
    ├── README.md          <- The top-level README for developers using this project.
    ├── data               <- Raw data, derived data, etc.
    ├── docs               <- A default mkdocs project; see www.mkdocs.org for details
    ├── notebooks          <- Jupyter notebooks. Naming convention is a number (for ordering),
    ├── references         <- Data dictionaries, manuals, and all other explanatory materials.
    ├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
    ├── requirements.txt   <- The requirements file for reproducing the analysis environment, e.g. generated with `pip freeze > requirements.txt`
    └── src                <- Source code for use in this project.


## Example: Set up a python module

```bash
mkdir src/example
touch src/example/__init__.py
git add src/example/__init__.py
git commit -m "Initialize example package"
```


## Example: Add bash scripts

```bash
touch src/01-fetch-data.sh
chmod +x src/01-fetch-data.sh
touch src/02-verify-data.sh
chmod +x src/02-verify-data.sh
git add src/
git commit -m "Add scripts to fetch and verify source data"
```


# Let's review your project history

```bash
git log
    
```

![][xkcd_git_commit]

[xkcd_git_commit]: https://imgs.xkcd.com/comics/git_commit.png


# Track 'empty' directories

```bash
mkdir data
touch data/.gitkeep
git add data/.gitkeep
git commit -m "Keep data directory"
```


# Ignoring things

## Do NOT track large files

Tracking large files (e.g., data files) is considered **bad practice** with
git. Furthermore, if you're using a Git host (e.g., GitHub), the maximum file
size may be small (e.g., 100 MB); if you add a file larger than this, the Git
host will ***reject all changes***.

```bash
echo "*.csv" >> .gitignore
git add .gitignore
git commit -m "Ignore *.csv files"
mkdir -p data/raw
touch data/raw/table.csv
```

```bash
git status
# Notice that csv files do not show up
```


# Changing existing files

```bash
echo "Source data from SOURCE" >> README.md
```

```bash
git status
git diff
```

```bash
git commit --all -m 'Update README'
```

```bash
git log
git log --patch
```


# Track your code, not your data

```bash
nano src/03-proc-data.sh
```

```text
#!/usr/bin/env bash

mkdir -p data/derived
cp -n data/raw/*.csv data/derived/
```

```bash
chmod +x src/03-proc-data.sh
git add src
git commit --all -m 'Add process script'
```

```bash
./src/03-proc-data.sh
ls data
ls -R data
```

```bash
git status
# Notice that csv files do not show up
```

# Finding stuff

```bash
git log
# opens in your pager (less), you can search etc.
```

```bash
git log | grep
# also works
```

```bash
git grep
# how is this different?
```

# Recovering

```bash
git checkout <commit>
# ... now what???
```

```bash
# Find the version you want first (see above), then ...
git checkout <commit> <filename>
```

# others ???

# GitHub

You've already got a repo, let's put that on GitHub.

1. Go to github.com or github.utk.edu (???)
1. Create a new repository
1. Follow the instructions ....
1. Do some work ...
1. Then `git push`
1. Make another copy of that repo somewhere else ...
1. Make changes in that copy ...
1. `git push`
1. Go back to original ...
1. `git pull`

You want to create a new repository starting from GitHub

1. Go to github.com or github.utk.edu (???)
1. Create a new repository
1. Follow the instructions ....
1. Then, `git clone`

You want to work on a shared respository

1. `git clone`
1. work
1. First, `git pull --rebase`, then `git push`

Or, if you're using the typical GitHub workflow (aka, "GitHub Flow")

1. fork the repo
1. `git clone` from your fork
1. work ...
1. `git push`
1. Open a pull request


# Remotes (optional)

1. Go to your shared ISAAC project directory (optionally, create a dummy project dir)
1. `git clone --bare <original> repos/example.git` your original to the shared dir
1. Go back to the original
1. `git remote add proj <url>`
1. make changes ...
1. `git push`

<!-- END -->
