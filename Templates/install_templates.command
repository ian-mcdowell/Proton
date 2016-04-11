#!/bin/bash -e
clear
echo "============================================"
echo "Proton Template Install Script"
echo "============================================"
echo "Menu: "
echo "   i: Install templates"
echo "   u: Uninstall templates"
echo ""
echo "Enter a command: "
read -e command
if [ "$command" == i ] ; then

echo "============================================"
echo "Installing templates..."
echo "============================================"

mkdir -p ~/Library/Developer/Xcode/Templates/File\ Templates/Source

cp -rf ./Proton\ Page.xctemplate ~/Library/Developer/Xcode/Templates/File\ Templates/Source

echo "Done."

else

echo "============================================"
echo "Uninstalling templates"
echo "============================================"

rm -rf ~/Library/Developer/Xcode/Templates/File\ Templates/Source/Proton\ Page.xctemplate

echo "Done."

fi
