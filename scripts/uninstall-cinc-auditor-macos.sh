#!/bin/sh

if [ $(osascript -e 'application "Cinc Auditor" is running') = 'true' ]; then
  echo "Closing Cinc-Auditor..."
  sudo osascript -e 'quit app "Cinc Auditor"' > /dev/null 2>&1;
fi
echo "Uninstalling Cinc Auditor..."
echo "  -> Removing files..."
sudo rm -rf '/opt/cinc-auditor'
sudo rm -rf '/Applications/Cinc Auditor.app'
echo "  -> Removing binary links in /usr/local/bin..."
sudo find /usr/local/bin -lname '/opt/cinc-auditor/*' -delete
echo "  -> Forgeting com.cinc-project.pkg.cinc-auditor package..."
sudo pkgutil --forget com.cinc-project.pkg.cinc-auditor > /dev/null 2>&1;
echo "Cinc Auditor Uninstalled."
