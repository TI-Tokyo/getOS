#!/bin/sh
## Get "OS" from uname to check for OSX
os=$(uname -a | cut -d " " -f 1)

if [ "$os" = "Darwin" ]
then
  ## Now we know it's OSX, use Apple specific commands to get details
  os="osx"
  version=$(sw_vers -productVersion)
  ospretty=$(sw_vers -productName)
else
  ## As all other POSIX systems tried have /etc/os-release with useful details, use those
  os=$(grep "^ID=" /etc/os-release | cut -d "=" -f 2 | sed "s@\"@@g")
  version=$(grep "^VERSION_ID=" /etc/os-release | cut -d "=" -f 2 | sed "s@\"@@g")
  ospretty=$(grep "^PRETTY_NAME=" /etc/os-release | cut -d "=" -f 2 | sed "s@\"@@g")
fi

## Get architecture
arch=$(uname -m)
bit=$(getconf LONG_BIT)

echo "We have detected that you are using:"
echo "Operating system: $ospretty ($bit bit)"
echo "Version: $version"
echo "Architecture: $arch"
