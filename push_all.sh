git switch incoming-hyprland
git add .
git commit -m "daily $(date +'%Y-%m-%d %H:%M')"
git push
git checkout main
git merge incoming-hyprland
git push
git switch incoming-hyprland
