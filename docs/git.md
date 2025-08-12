---
title: Project organization and Git
---

# Git

## Version control

There are many methods and tools for tracking versions of files. 

![][phdcomics_finaldoc]

[phdcomics_finaldoc]: https://phdcomics.com/comics/archive/phd101212s.gif

<!--analysis.R-->
<!--analysis-vers3.R-->
<!--analysis2.R-->
<!--analysis_redo.R-->
<!--thesis-vers1.docx-->
<!--thesis-vers2_CD+GM+SW_edits.docx-->
<!--thesis-vers3_CD_edits.docx-->


# A simple example

## Overview

The core `git` commands:

<!-- REMINDER: More detailed descriptions of these commands are below. -->

1. `git init` -- Initialize a repository
1. `git add <filename>` -- Add a version of the file
1. `git commit -m "<message>"` -- Store that version in the repository


```bash
mkdir example
cd example
git init .
echo "# My Project" >> README.md
git add README.md
git commit -m "Add README"
```

![][xkcd_git]

[xkcd_git]: https://imgs.xkcd.com/comics/git.png


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
git config --global user.name "<your name>"
git config --global user.email "<your email>"
```

Verify the settings:

```bash
git config --global --list
```

# Track 'empty' directories

Git tracks files, *not* directories. Adding a `.gitkeep` file to an otherwise
empty directory is a common convention.

```bash
mkdir data
touch data/.gitkeep
git add data/.gitkeep
git commit -m "Keep data directory"
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
    ├── data/              <- Raw data, derived data, etc.
    ├── docs/              <- A default mkdocs project; see www.mkdocs.org for details
    ├── notebooks/         <- Jupyter notebooks. Naming convention is a number (for ordering),
    ├── references/        <- Data dictionaries, manuals, and all other explanatory materials.
    ├── reports/           <- Generated analysis as HTML, PDF, LaTeX, etc.
    ├── requirements.txt   <- The requirements file for reproducing the analysis environment,
    │                         e.g. generated with `pip freeze > requirements.txt`
    └── src/               <- Source code for use in this project.


## Example: Set up a python module

```bash
mkdir src/example
touch src/example/__init__.py
git add src/example/__init__.py
git commit -m "Initialize Python package"
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


# View your project history

```bash
git log
```

![][xkcd_git_commit]

[xkcd_git_commit]: https://imgs.xkcd.com/comics/git_commit.png


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

Instead of using `git add` followed by `git commit`, you can use `git commit
--all` to *add* and *commit* all changes:

```bash
git commit --all -m 'Update README'
```

```bash
git log
git log --patch
```

| Option/flag       | Description  |
| :-                | :---- |
| `--all` | Searches across all branches and tags. |
| `--oneline` | Provides a concise, single-line summary of each commit. |
| `-p` or `--patch` | Shows the diff for each commit. |
| `--name-only` | Lists only the names of files changed in each commit. |



# Track your code, not your data

Make some example data:

```bash
touch data/raw/{a,b,c}.csv
```

Create an example 'processing' script (it just copies data from 'raw' to
'output'):

```bash
nano src/03-proc-data.sh
```

```text
#!/usr/bin/env bash

mkdir -p data/output
cp -n data/raw/*.csv data/output/
```

```bash
chmod +x src/03-proc-data.sh
git add src
git commit --all -m 'Add process script'
```

Run your 'processing' script and verify the output data:

```bash
./src/03-proc-data.sh
ls data
ls -R data
```


```bash
git status
```

# Finding things in your Git history


```bash
git log
# opens in your pager (less), you can search etc.
```

*`git log` commands usually show commits in reverse chronological order (most recent first).*


## Viewing your commit history

| Command       | Description  |
| :-                | :---- |
| `git log` | Displays a list of all commits in the current branch, showing the commit hash, author, date, and commit message. |
| `git log --oneline` | Provides a more concise view, displaying the first seven characters of the commit hash and the commit message on a single line. |
| `git log -n` | Displays only the last `n` number of commits (e.g., `git log -10` for the last 10 commits).  |
| `git log --graph --oneline --decorate` | Creates an ASCII graph visualizing branches, merges, and commits for a clearer understanding of your repository's structure. |


## Viewing your commit history: Filtering by Date

| Command       | Description  |
| :-                | :---- |
| `git log --after="<date-range>"` | Shows commits made after a relative date (e.g., "1 week ago"). |
| `git log --before="<date-range>"` | Shows commits made before a relative date.  |
| `git log --since="<date>"` | Shows commits made after a specific date. |
| `git log --until="<date>"` | Shows commits made before a specific date. |
| `git log --after="<date>" --before="<date>"` | Filters commits within a specific date range. |


## Viewing your commit history: For a specific file

| Command       | Description  |
| :-                | :---- |
| `git log <file_path>` | Shows the commit history for a specific file. |
| `git log --follow <file_path>` | Tracks the history of a file even if it has been renamed. |
| `git blame <file_path>` | Shows who last modified each line of a file. |


# Searching your commit history

```bash
git log | grep <pattern>
```

## Searching Commit Messages

| Command       | Description  |
| :-                | :---- |
| `git log --grep="<pattern>"` | Filters commits by a pattern in their commit messages (can use regex). |
| `git log --all --grep="<pattern>"` | Searches commit messages across all branches. |


## Searching for Changes in Code (Diffs)

| Command       | Description  |
| :-                | :---- |
| `git log -p -G <pattern>` | Searches for changes (introductions or removals) in the code that match a regex pattern. |
| `git log -p -S <string>` | Searches for commits that add or remove a specific string. |
| `git log -L :<function_name>:<file_path>`| This allows you to view the history of a specific function or block of code within a file. |


# Searching file contents

```bash
git grep <pattern>
```

This command searches for a specific pattern within the current working directory.

It's kind of like:

```bash
find . -type f | xargs grep <pattern>
```

## The nuclear option

To search within the ***entire commit history***, you can combine it with `git rev-list --all`:

```bash
git grep <pattern> $(git rev-list --all)
```

This will search the contents of every version of every file in the repo.


# Undo or recover changes


| Command           | Description  |
| :-                | :----        |
| `git revert <commit>`       | Creates a **new commit** that undoes the changes of a specific commit, without deleting or altering previous history, [according to CloudBees](https://www.cloudbees.com/blog/git-revert-explained). |
| `git reset --hard <commit>` | DANGEROUS! Resets your branch pointer to a previous commit, discarding all changes made after that commit from the index and working directory. |
| `git reset --soft <commit>` | Moves the branch pointer to a previous commit, but keeps changes staged (in the index). |
| `git reset --mixed <commit>` | Moves the branch pointer to a previous commit and unstages changes, but keeps them in the working directory.  |

`git revert` is generally preferred over `git reset` for undoing changes in shared repositories because it preserves history.

Be cautious with `git reset --hard`, as it can lead to data loss if used improperly.


# Branching

> **Branching** means you diverge from the main line of development and continue to do work without messing with that main line. [1][]

[1]: https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell

The default branch is usually `main`. One-time setup:

```bash
git config --global init.defaultbranch "main"
```

Two main use-cases for branches:

- If you're collaborating on a repo, you'll want to do your work on a branch,
  and then merge it back into the `main` branch.
- For personal (non-collaborative) projects, you'll want to create a branch
  when you think to yourself, "I wonder what would happen if I tried [X]...."


Create a new branch and switch to it at the same time:

```bash
git switch -c <branch name>
```

Switch to an existing branch:

```bash
git switch <branch name>
```

Switch to the previous branch:

```bash
git switch -
```

List branches:

```bash
git branch
git branch --all
```


## Use-case: Collaboration

```bash
git switch -c feature
# Write code ...
# It works, amazing!
git commit --all -m "Amazing!"
git switch -
git pull --rebase
git merge -
git push
git branch -d feature
```

## Use-case: Personal projects

*"I wonder what would happen if ..."*

```bash
git switch -c this-will-probably-break
# Write code ...
# Test it ...
# It's not working right ...
# Take a break ...
git commit --all -m "In progress ..."
git switch -
# Back on the main branch, still working as normal
```


# GitHub for personal use

## You've already got a repo, let's put that on GitHub

1. Go to [github.com][github] and sign in or create an account.
1. Create a new repository
1. Follow the instructions ...
1. Make changes in your local directory ...
1. `git push`


## You want to create a local copy of a GitHub repository

1. Go to [github.com][github] and sign in or create an account.
1. Create a new repository
1. Follow the instructions ...
1. Then, `git clone "<remote_URL>"`


# GitHub for collaboration

## You want to work on a shared respository

*The repo owner on GitHub will have to grant you access to the repo for this
to work.*

1. `git clone "<remote_URL>"`
1. Work ...
1. First, `git pull --rebase`, then `git push`


Or, if you're using [the typical GitHub workflow (aka, "GitHub
Flow"][github_flow]):

[github_flow]: https://docs.github.com/en/get-started/using-github/github-flow
[github_flow_old]: https://githubflow.github.io/

1. Fork the repo on GitHub
1. `git clone` from your fork
1. Work ...
1. `git push`
1. Open a pull request

<!-- # Remotes (optional)-->
<!---->
<!--1. Go to your shared ISAAC project directory (optionally, create a dummy project dir)-->
<!--1. `git clone --bare <original> repos/example.git` your original to the shared dir-->
<!--1. Go back to the original-->
<!--1. `git remote add proj <url>`-->
<!--1. make changes ...-->
<!--1. `git push`-->


# Git reference material

- [Official Documentation][gitdocs]
- [Dangit, Git!?!][ohshitgit]

<!--[ohshitgit]: https://ohshitgit.com/-->
[ohshitgit]: https://dangitgit.com/en
[gitdocs]: https://git-scm.com/doc
[github]: https://github.com/

<!-- END -->
