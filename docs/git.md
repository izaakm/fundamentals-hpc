---
title: Project organization and Git
---

# Why?

    analysis.R
    analysis-vers3.R
    analysis2.R
    analysis_redo.R
    thesis-vers1.docx
    thesis-vers2_CD+GM+SW_edits.docx
    thesis-vers3_CD_edits.docx

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
    git commit --all -m README.md



