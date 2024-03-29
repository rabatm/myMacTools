#!/bin/bash
echo 'Empty the Trash on all mounted volumes and the main HDD...'
sudo rm -rfv /Volumes/*/.Trashes/* &>/dev/null
sudo rm -rfv ~/.Trash/* &>/dev/null

echo 'Clear System Log Files...'
sudo rm -rfv /private/var/log/asl/*.asl &>/dev/null
sudo rm -rfv /Library/Logs/DiagnosticReports/* &>/dev/null
sudo rm -rfv /Library/Logs/Adobe/* &>/dev/null
rm -rfv ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/* &>/dev/null
rm -rfv ~/Library/Logs/CoreSimulator/* &>/dev/null
sudo rm -rf /Library/Caches/*
sudo rm -rf ~/Library/Caches/*

echo 'Clear Adobe Cache Files...'
sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null

echo 'Cleanup iOS Applications...'
rm -rfv ~/Music/iTunes/iTunes\ Media/Mobile\ Applications/* &>/dev/null

echo 'Remove iOS Device Backups...'
rm -rfv ~/Library/Application\ Support/MobileSync/Backup/* &>/dev/null

echo 'Cleanup XCode Derived Data and Archives...'
rm -rfv ~/Library/Developer/Xcode/DerivedData/* &>/dev/null
rm -rfv ~/Library/Developer/Xcode/Archives/* &>/dev/null

echo 'Cleanup pip cache...'
rm -rfv ~/Library/Caches/pip

echo 'Vider les fichiers temporaires'
sudo rm -rf /private/var/folders/*/*/*/com.apple.LaunchServices*
sudo rm -rf /private/var/folders/*/*/*/com.apple.iconservices*
sudo rm -rf /private/var/folders/*/*/*/com.apple.notificationcenter*
sudo rm -rf /private/var/folders/*/*/*/com.apple.systempreferences*
sudo rm -rf /private/var/folders/*/*/*/com.apple.universalaccess*
sudo rm -rf /private/var/folders/*/*/*/com.apple.appstore*
sudo rm -rf /private/var/folders/*/*/*/com.apple.Safari*
sudo rm -rf /private/var/folders/*/*/*/com.apple.iTunes*
sudo rm -rf /private/var/folders/*/*/*/com.apple.mail*
sudo rm -rf /private/var/folders/*/*/*/com.apple.Maps*
sudo rm -rf /private/var/folders/*/*/*/com.apple.iBooks*
sudo rm -rf /private/var/folders/*/*/*/com.apple.PhotoBooth*
sudo rm -rf /private/var/folders/*/*/*/com.apple.iPhoto*
sudo rm -rf /private/var/folders/*/*/*/com.apple.iMovie*
sudo rm -rf /private/var/folders/*/*/*/com.apple.Keynote*
sudo rm -rf /private/var/folders/*/*/*/com.apple.Numbers*
sudo rm -rf /private/var/folders/*/*/*/com.apple.Pages*
sudo rm -rf /private/var/folders/*/*/*/com.apple.iWork*

# Vider le cache système
sudo purge

# Vider le cache DNS
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

if type "brew" &>/dev/null; then
    echo 'Update Homebrew Recipes...'
    brew update
    echo 'Upgrade and remove outdated formulae'
    brew upgrade
    echo 'Cleanup Homebrew Cache...'
    brew cleanup -s &>/dev/null
    #brew cask cleanup &>/dev/null
    rm -rfv $(brew --cache) &>/dev/null
    brew tap --repair &>/dev/null
fi

if [ "$PYENV_VIRTUALENV_CACHE_PATH" ]; then
    echo 'Removing Pyenv-VirtualEnv Cache...'
    rm -rfv $PYENV_VIRTUALENV_CACHE_PATH &>/dev/null
fi

if type "npm" &> /dev/null; then
    echo 'Cleanup npm cache...'
    npm cache clean --force
fi

if type "yarn" &> /dev/null; then
    echo 'Cleanup Yarn Cache...'
    yarn cache clean --force
fi

echo 'Purge inactive memory...'
sudo purge

echo 'Success!'