This is my jekyll powered blog/online resume. Deploying to GitHub is as easy 
as committing, GH does everything for you. Just use rsync to deploy to a 
normal server rsync -v -rz --checksum --delete _site/ user@server:/path/

Because this project uses a resume submodule when cloning run the command

```
git clone --recursive https://github.com/gpwclark/gpwclark.github.io
```

to auto-clone the submodule too. If you have already cloned and noticed
the submodule is empty, run the commands

```
git submodule init  #uses info from the .gitmodules file
git submodule update  #initializes submodules
```


To periodically get updates from the submodule just cd to the
submodules directory and run

```
git fetch
git merge origin/master
```
