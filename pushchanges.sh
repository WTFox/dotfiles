# Push changes up to GH
if [[ $(git status -s) ]] 
then
    echo "Pushing new changes up"
    git add . && git commit -m "`date`"
    git push origin master -f
fi
