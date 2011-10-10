#!/bin/bash
cd "`dirname $0`"

sudo rm -rf ./_/MailLabels/DEBIAN/control
echo "Package: com.unlimapps.maillabels" >> ./_/MailLabels/DEBIAN/control
echo "Name: Color Mail Labels" >> ./_/MailLabels/DEBIAN/control
echo "Version: $1" >> ./_/MailLabels/DEBIAN/control
echo "Architecture: iphoneos-arm" >> ./_/MailLabels/DEBIAN/control
echo "Depends: mobilesubstrate, firmware (>= 4.0), preferenceloader" >> ./_/MailLabels/DEBIAN/control
echo "Description:Color Mail Labels is a tweak that allows you to customize the way you view your email accounts. It allows you to give each account its own color-just as you can in gmail!" >> ./_/MailLabels/DEBIAN/control
echo "Homepage: http://moreinfo.thebigboss.org/moreinfo/depiction.php?file=colormaillabelsData" >> ./_/MailLabels/DEBIAN/control
echo "Sponsor: thebigboss.org <http://thebigboss.org>" >> ./_/MailLabels/DEBIAN/control
echo "Maintainer: Enea Gjoka <UnlimApps@yahoo.com>" >> ./_/MailLabels/DEBIAN/control
echo "Author: Enea Gjoka <UnlimApps@yahoo.com>" >> ./_/MailLabels/DEBIAN/control
echo "Section: Utilities" >> ./_/MailLabels/DEBIAN/control
echo "Tag: cydia::commercial, purpose::extension" >> ./_/MailLabels/DEBIAN/control

cd ./maillbl
make clean
make
cd ..
cp ./maillbl/.theos/obj/maillbl.dylib ./_/MailLabels/Library/MobileSubstrate/DynamicLibraries/
cp -rf ~/Documents/Builds/Active/MailLabels/Products/Release-iphoneos/MailLabels.app ./_/MailLabels/Applications

ldid -S ./_/MailLabels/Applications/MailLabels.app/MailLabels
ldid -s ./_/MailLabels/Applications/MailLabels.app/MailLabels

cd ./_/
find . -name '*.DS_Store' -type f -delete
dpkg-deb -b MailLabels ./MailLabels.deb