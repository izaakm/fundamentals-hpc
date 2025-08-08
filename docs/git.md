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

    mkdir example
    cd example
    git init .
    echo "# My Project" >> README.md
    git add README.md
    git commit -m "Add README"

## Step-by-step

    mkdir example
    cd example

Check the contents of the directory:

    ls -la

Then, initialize the Git repository:

    git init .

Check the contents of the directory again:

    ls -la

You should see a new directory, `.git`; that's your "git repository".

    echo "# My Project" >> README.md
    git add README.md
    git commit -m "Add README"

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

    git config --global user.name=<your name>
    git config --global user.email=<your email>

Verify the settings:

    git config --global --list


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

    mkdir src/example
    touch src/example/__init__.py
    git add src/example/__init__.py
    git commit -m "Initialize example package"


## Example: Add bash scripts

    touch src/01-fetch-data.sh
    chmod +x src/01-fetch-data.sh
    touch src/02-verify-data.sh
    chmod +x src/02-verify-data.sh
    git add src/
    git commit -m "Add scripts to fetch and verify source data"


# Let's review your project history

    git log
    

![][xkcd_git_commit]

[xkcd_git_commit]: https://imgs.xkcd.com/comics/git_commit.png


    mkdir data
    touch data/.gitkeep
    git add data/.gitkeep
    git commit -m "Keep data directory"

    echo "*.csv" >> .gitignore
    git add .gitignore
    git commit -m "Ignore *.csv files"

    echo "Source data from SOURCE" >> README.md

    git status
    git diff

    git commit --all -m 'Update README'

    git log
    git log --patch

    echo "mkdir data/derived" >> src/03-proc-data.sh
    echo "cp data/raw/*.csv data/derived/" >> src/03-proc-data.sh
    chmod +x src/03-proc-data.sh
    git add src
    git commit --all -m 'Add process script'

    ./src/03-proc-data.sh
    ls data
    ls -R data

    git status
    # Notice that csv files do not show up

# Finding stuff

    git log
    # opens in your pager (less), you can search etc.

    git log | grep
    # also works

    git grep
    # how is this different?

# Recovering

    git checkout <commit>
    # ... now what???

    # Find the version you want first (see above), then ...
    git checkout <commit> <filename>

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
