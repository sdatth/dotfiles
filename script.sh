#!/usr/bin/env bash

set -e

# 🧠 Detect CPU architecture
ARCH=$(uname -m)

case "$ARCH" in
  x86_64) ARCH="x86_64" ;;
  aarch64 | arm64) ARCH="arm64" ;;
  *) echo "❌ Unsupported architecture: $ARCH" && exit 1 ;;
esac

echo "🖥️ CPU Architecture: $ARCH"

# 🧠 Detect OS distribution
OS_TYPE=$(uname -s)
DISTRO="unknown"
DISTRO_ID="unknown"

if [[ "$OS_TYPE" == "Linux" ]]; then
  if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    DISTRO="${NAME,,}"
    DISTRO_ID="${ID,,}"
  elif [ -f /etc/lsb-release ]; then
    # shellcheck disable=SC1091
    . /etc/lsb-release
    DISTRO="${DISTRIB_ID,,}"
    DISTRO_ID="${DISTRIB_ID,,}"
  fi
elif [[ "$OS_TYPE" == "FreeBSD" ]]; then
  DISTRO="freebsd"
  DISTRO_ID="freebsd"
fi

echo "🐧 OS Distribution: $DISTRO ($DISTRO_ID)"

# 🎯 Print distro family message
echo
case "$DISTRO_ID" in
  rhel | centos | fedora | rocky | alma)
    echo "🔴 RHEL-based distribution detected."
    ;;
  debian | ubuntu | linuxmint | pop)
    echo "🟢 Debian/Ubuntu-based distribution detected."
    ;;
  arch | manjaro)
    echo "🔵 Arch-based distribution detected."
    ;;
  freebsd)
    echo "🟣 FreeBSD system detected."
    ;;
  *)
    echo "⚠️ Unknown or unsupported distribution."
    exit 1
    ;;
esac

echo

# 🛠 Install make based on distro
install_make() {
  echo "🔧 Installing 'make'..."
  case "$DISTRO_ID" in
    ubuntu | debian | linuxmint | pop)
      sudo apt update && sudo apt install -y build-essential doas git
      ;;
    rhel | centos | rocky | alma)
      sudo yum groupinstall -y "Development Tools"
      sudo yum install doas git
      ;;
    fedora)
      sudo dnf groupinstall -y "Development Tools"
      sudo dnf install make git
      ;;
    arch | manjaro)
      sudo pacman -Sy --noconfirm base-devel git
      ;;
    freebsd)
      sudo pkg install -y gmake git
      ;;
    *)
      echo "⚠️ Could not determine how to install make for $DISTRO_ID."
      ;;
  esac
  echo "✅ make installed (or already available)."
}

install_make
echo

# 📦 Package manager logic
if [[ "$ARCH" == "arm64" ]]; then
  echo "⚙️ ARM architecture detected — installing Nix only."
  cd $HOME
  rm -rf dotfiles
  git clone https://github.com/sdatth/dotfiles.git
  cd dotfiles
  make nix
  echo "✅ Nix installed."

elif [[ "$DISTRO_ID" == "arch" || "$DISTRO_ID" == "manjaro" || "$DISTRO_ID" == "freebsd" ]]; then
  echo "ℹ️ No package manager (Nix/Brew) will be installed on $DISTRO_ID."

else
  echo "Which package manager would you like to install?"
  select PM in "Nix" "Homebrew" "Exit"; do
    case $PM in
      Nix)
        echo "📦 Installing Nix package manager..."
        cd $HOME
        rm -rf dotfiles
        git clone https://github.com/sdatth/dotfiles.git
        cd dotfiles
        make nix
        echo "✅ Nix installed."
        break
        ;;
      Homebrew)
        echo "🍺 Installing Homebrew package manager..."
        cd $HOME
        rm -rf dotfiles
        git clone https://github.com/sdatth/dotfiles.git
        cd dotfiles
        make brew
        echo "✅ Homebrew installed."
        break
        ;;
      Exit)
        echo "👋 Exiting script."
        exit 0
        ;;
      *)
        echo "Invalid option. Please choose 1, 2, or 3."
        ;;
    esac
  done
fi

# 🎯 Symlink files
echo
cd $HOME/dotfiles
case "$DISTRO_ID" in
  rhel | centos | fedora | rocky | alma)
    echo "🔴 RHEL-based distribution detected."
    make rhel
    ;;
  debian | ubuntu | linuxmint | pop)
    echo "🟢 Debian/Ubuntu-based distribution detected."
    make ubuntu
    ;;
  arch | manjaro)
    echo "🔵 Arch-based distribution detected."
    make arch
    ;;
  freebsd)
    echo "🟣 FreeBSD system detected."
    gmake freebsd
    ;;
  *)
    echo "⚠️ Unknown or unsupported distribution."
    ;;
esac
