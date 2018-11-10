@echo off

IF NOT "%USE_SCCACHE%" == "false" (
    cd peter_jiachen
    attrib -s -h -r . /s /d
    rmdir /s /q .git

    git config --global user.name "Azure DevOps"
    git config --global user.email peter_jiachen@163.com
    git init
    git remote add origin %SCCACHE_REPO_URL%
    git add .
    git commit -m "Update cache"
    git push origin master -f
)
