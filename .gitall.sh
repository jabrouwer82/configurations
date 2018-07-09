#! /bin/bash
echo -e '\033[1;36mAdding all files...\033[0m'
git add -A -v

echo -e '\033[1;36mLook good?\033[0m'
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo -e '\033[1;36mCommiting...\033[0m'
git commit -m `git current | sed 's/--.*//'`

echo -e "\033[1;36mMerge from $(git defaultname)?\033[0m"
select yn in "Yes" "No"; do
    case $yn in
      Yes ) echo -e "\033[1;36mMerging $(git defaultname)...\033[0m"; git catchup; break;;
        No ) break;;
    esac
done

echo -e '\033[1;36mPushing...\033[0m'
git push -u origin $(git current)
