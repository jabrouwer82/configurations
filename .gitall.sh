#! /bin/bash
git diff --check
git_check_output=$(git --no-pager diff --check)
if [[ ! -z $git_check_output ]]; then
  echo -e '\033[1;36mFix errors from `git diff --check` first.\033[0m'
  exit
fi

git status
echo -e '\033[1;36mCurrent state, do you want to continue?\033[0m'
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo -e '\033[1;36mAdding all files...\033[0m'
git add -A -v

echo -e '\033[1;36mWhat you have so far...\033[0m'
git status

echo -e '\033[1;36mLook good?\033[0m'
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo -e '\033[1;36mCommiting...\033[0m'
git commit -m ""

echo -e "\033[1;36mMerge from $(git defaultname)?\033[0m"
select yn in "Yes" "No"; do
    case $yn in
      Yes ) echo -e "\033[1;36mMerging $(git defaultname)...\033[0m"; git catchup; break;;
      No ) break;;
    esac
done

# If the rebase worked, then pull and push

echo -e '\033[1;36mPushing...\033[0m'
git push -u origin $(git currentname)

echo -e '\033[1;36mHows it look?\033[0m'
git status
