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


# outline

    mkdir example
    cd example
    git init .
    echo "# My Project" >> README.md
    git add README.md
    git commit -m "Add README"


    mkdir src/example
    touch src/example/__init__.py
    git add src/example/__init__.py
    git commit -m "Initialize example package"

    touch src/01-fetch-data.sh
    chmod +x src/01-fetch-data.sh
    touch src/02-verify-data.sh
    chmod +x src/02-verify-data.sh
    git add src/
    git commit -m "Add scripts to fetch and verify source data"

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
