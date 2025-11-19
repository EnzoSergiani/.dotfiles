mkdir -p "$HOME/.config/Code/User/"
cp VSCode/* "$HOME/.config/Code/User/"
cat extensions.txt | xargs -n 1 code --install-extension

