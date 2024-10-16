#!/bin/bash

branches=("aziz-dev" "arslan-dev" "sami-dev" "shahzeb-dev")

handle_conflict() {
    echo "Merge conflict detected. Please resolve the conflict manually."
    echo "After resolving the conflict, run the script again with the appropriate checkpoint."
    exit 1
}

echo ">>> git push <<<"
git push

echo ">>> git fetch origin <<<"
git fetch origin

if [ "$1" == "1" ] || [ -z "$1" ]; then
    echo ""
    echo ">>> git checkout main <<<"
    git checkout main
    echo ""
    echo ">>> git pull origin main <<<"
    git pull origin main
    echo ""
fi

echo ""
echo "*** Checkpoint 1 Passed ***"
echo ""

if [ "$1" == "2" ] || [ -z "$1" ]; then
    for branch in "${branches[@]}"; do
        echo ""
        echo ">>> git merge $branch <<<"
        git merge $branch || handle_conflict
        echo ""
    done
fi

echo ""
echo "*** Checkpoint 2 Passed ***"
echo ""

if [ "$1" == "3" ] || [ -z "$1" ]; then
    echo ""
    echo ">>> git push origin main <<<"
    git push origin main
    echo ""
fi

echo ""
echo "*** Checkpoint 3 Passed ***"
echo ""

if [ "$1" == "4" ] || [ -z "$1" ]; then
    for branch in "${branches[@]}"; do
        echo ""
        echo ">>> git checkout $branch <<<"
        git checkout $branch
        echo ""
        echo ">>> git pull origin $branch <<<"
        git pull origin $branch
        echo ""
        
        echo ">>> git merge main <<<"
        git merge main || handle_conflict
        echo ""
        echo ">>> git push origin $branch <<<"
        git push origin $branch
        echo ""
    done
fi

echo ""
echo "*** Checkpoint 4 Passed ***"
echo ""

echo ""
echo "All branches have been updated."
echo ""