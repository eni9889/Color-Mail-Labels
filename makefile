cd ./maillbl/
make clean
make
cp ./obj/maillbl.dylib /Users/egjoka/Documents/Builds/Cydia/MailLabels/Library/MobileSubstrate/DynamicLibraries/
cd ../MailLabels/
xcodebuild -alltargets -activeconfiguration
cp -rf /Users/egjoka/Documents/Builds/Active/MailLabels/Release-iphoneos/MailLabels.app /Users/egjoka/Documents/Builds/Cydia/MailLabels/Applications
cd /Users/egjoka/Documents/Builds/Cydia/MailLabels/Applications/MailLabels.app
ldid -S ./MailLabels
cd /Users/egjoka/Documents/Builds/Cydia/
find . -name '*.DS_Store' -type f -delete
dpkg-deb -b MailLabels ./MailLabels.deb
cp ./MailLabels.deb /RepoMaker/deb/

if [ "$1" == "r" ]; then
sudo rm -rf /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Package: com.unlimapps.maillabels" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Name: Color Mail Labels" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Version: $2" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Architecture: iphoneos-arm" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Depends: mobilesubstrate, firmware (>= 4.0), preferenceloader" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Description:Color Mail Labels is a tweak that allows you to customize the way you view your email accounts. It allows you to give each account its own color-just as you can in gmail!" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Homepage: http://moreinfo.thebigboss.org/moreinfo/depiction.php?file=colormaillabelsData" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Sponsor: thebigboss.org <http://thebigboss.org>" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Maintainer: Enea Gjoka <UnlimApps@yahoo.com>" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Author: Enea Gjoka <UnlimApps@yahoo.com>" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Section: Utilities" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
echo "Tag: cydia::commercial, purpose::extension" >> /Users/egjoka/Documents/Builds/Cydia/MailLabels/DEBIAN/control
/usr/bin/scp ./MailLabels.deb root@i4iphones.info:/home/iiphones/repo/cydia/deb/
ssh root@i4iphones.info '/home/iiphones/repo/makedebs'
elif [ "$1" == "pod" ]; then
scp ./MailLabels.deb root@iPod4Dev.local:/tmp/
ssh root@iPod4Dev.local "dpkg -i /tmp/MailLabels.deb"
ssh root@iPod4Dev.local "killall SpringBoard"
else
scp ./MailLabels.deb root@iPhone4Dev.local:/tmp/
ssh root@iPhone4Dev.local "dpkg -i /tmp/MailLabels.deb"
ssh root@iPhone4Dev.local "killall SpringBoard"
fi