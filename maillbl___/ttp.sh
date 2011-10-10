cd ~/Documents/MobileSubstrate/maillbl/
make clean
make
cp ~/Documents/MobileSubstrate/maillbl/obj/maillbl.dylib ~/Documents/Builds/Cydia/MailLabels/Library/MobileSubstrate/DynamicLibraries/
cp -rf ~/Documents/Builds/Active/MailLabels/Products/Release-iphoneos/MailLabels.app ~/Documents/Builds/Cydia/MailLabels/Applications
cd ~/Documents/Builds/Cydia/MailLabels/Applications/MailLabels.app
ldid -S ./MailLabels
cd ~/Documents/Builds/Cydia/
find . -name '*.DS_Store' -type f -delete
dpkg-deb -b MailLabels ./MailLabels.deb
#cp ./MailLabels.deb /RepoMaker/deb/
#repo -r

sudo rm -rf ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Package: com.unlimapps.maillabels" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Name: Color Mail Labels" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Version: $2" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Architecture: iphoneos-arm" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Depends: mobilesubstrate, firmware (>= 4.0), preferenceloader" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Description:Color Mail Labels is a tweak that allows you to customize the way you view your email accounts. It allows you to give each account its own color-just as you can in gmail!" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Homepage: http://moreinfo.thebigboss.org/moreinfo/depiction.php?file=colormaillabelsData" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Sponsor: thebigboss.org <http://thebigboss.org>" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Maintainer: Enea Gjoka <UnlimApps@yahoo.com>" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Author: Enea Gjoka <UnlimApps@yahoo.com>" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Section: Utilities" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Tag: cydia::commercial, purpose::extension" >> ~/Documents/Builds/Cydia/MailLabels/DEBIAN/control

if [ "$1" == "r" ]; then
/usr/bin/scp ./MailLabels.deb root@204.45.133.2:/home/iiphones/repo/cydia/deb/
ssh root@204.45.133.2 '/home/iiphones/repo/makedebs'
elif [ "$1" == "pod" ]; then
scp ./MailLabels.deb root@iPod4Dev.local:/tmp/
ssh root@iPod4Dev.local "dpkg -i /tmp/MailLabels.deb"
ssh root@iPod4Dev.local "killall SpringBoard"
else
scp ./MailLabels.deb root@iPhone4Dev.local:/tmp/
ssh root@iPhone4Dev.local "dpkg -i /tmp/MailLabels.deb"
ssh root@iPhone4Dev.local "killall SpringBoard"
fi