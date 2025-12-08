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
  IS_FREEBSD_BASED=1
  echo "⚙️ FreeBSD detected"
elif [[ "$OS_TYPE" == "Darwin" ]]; then
  DISTRO="darwin"
  DISTRO_ID="darwin"
  IS_MAC_BASED=1
  echo "⚙️ MacOS detected"
fi

IS_DEBIAN_BASED=0
IS_RHEL_BASED=0
IS_ARCH_BASED=0
if [[ "$DISTRO_ID" == "debian" || "$DISTRO_ID" == "ubuntu" ]]; then
  IS_DEBIAN_BASED=1
elif [[ "$DISTRO_ID" == "rhel" || "$DISTRO_ID" == "centos" || "$DISTRO_ID" == "rocky" || "$DISTRO_ID" == "almalinux" ]]; then
  IS_RHEL_BASED=1
elif [[ "$DISTRO_ID" == "arch" || "$DISTRO_ID" == "manjaro" ]]; then
  IS_ARCH_BASED=1
fi

# Fallback if still undetermined
if [[ "$IS_DEBIAN_BASED" -ne 1 && "$IS_RHEL_BASED" -ne 1 && "$IS_ARCH_BASED" -ne 1 && "$IS_MAC_BASED" -ne 1 && "$IS_FREEBSD_BASED" -ne 1 ]]; then
  echo "⚠️ Could not detect base distro. Please choose:"
  select CHOICE in "Debian-based" "RHEL-based" "ARCH-based" "Exit"; do
    case "$CHOICE" in
      "Debian-based") IS_DEBIAN_BASED=1; break ;;
      "RHEL-based") IS_RHEL_BASED=1; break ;;
      "ARCH-based") IS_ARCH_BASED=1; break ;;
      "Exit") exit 1 ;;
    esac
  done
fi

echo

# 🛠 Install make based on distro
# gmake for macos
install_gmake() {
    local version="4.4.1"
    local tarball="make-$version.tar.gz"
    local url="https://ftp.gnu.org/gnu/make/$tarball"
    mkdir $HOME/gmake-tmp
    cd $HOME/gmake-tmp

    echo "📥 Downloading GNU Make $version ..."
    curl -LO "$url" || { echo "❌ Download failed"; return 1; }

    echo "📦 Extracting..."
    tar -xzf "$tarball" || { echo "❌ Extraction failed"; return 1; }

    cd "make-$version" || { echo "❌ Directory not found"; return 1; }

    echo "🔧 Configuring with program-prefix=g (installs as gmake)..."
    ./configure --program-prefix=g || { echo "❌ Configure failed"; return 1; }

    echo "🔨 Building..."
    make || { echo "❌ Build failed"; return 1; }

    echo "📀 Installing (sudo required)..."
    sudo make install || { echo "❌ Install failed"; return 1; }

    echo "🧹 Cleaning up..."
    cd $HOME
    rm -rf gmake-tmp


    echo "✅ Done! Installed as: /usr/local/bin/gmake"
    echo "➡️ Run: gmake --version"
}

# make for linux
install_make() {
  echo "🔧 Installing few dependencies"
  # 🛠️ Install make and related build tools
  if [[ "$IS_DEBIAN_BASED" -eq 1 ]]; then
    echo "🟢 Debian-based system detected."
    echo "🔧 Installing packages for Debian-based system..."
    sudo apt update && sudo apt install -y build-essential doas git

  elif [[ "$IS_RHEL_BASED" -eq 1 ]]; then
    if [[ "$DISTRO_ID" == "fedora" ]]; then
      echo "🔴 RHEL-based system detected."
      echo "🔧 Installing packages for Fedora..."
      sudo dnf groupinstall -y "Development Tools"
      sudo dnf install -y make git
    else
      echo "🔴 RHEL-based system detected."
      echo "🔧 Installing packages for RHEL-based system..."
      sudo yum groupinstall -y "Development Tools"
      sudo yum install -y git make
    fi

  elif [[ "$IS_ARCH_BASED" -eq 1  ]]; then
    echo "🔵 ARCH-based system detected."
    echo "🔧 Installing packages for Arch-based system..."
    sudo pacman -Sy --noconfirm base-devel git make

  elif [[ "$DISTRO_ID" == "freebsd" ]]; then
    echo "🟣 FreeBSD system detected."
    echo "🔧 Installing packages for FreeBSD..."
    sudo pkg install -y gmake git

  elif [[ "$DISTRO_ID" == "darwin" ]]; then
    if ! which gmake > /dev/null 2>&1; then
        install_gmake
    fi


  else
    echo "⚠️ Could not determine how to install make for '$DISTRO_ID'."
  fi

  echo "✅ make installed (or already available)."
}

install_make


# clone dotfiles repo
if [ -d "$HOME/dotfiles" ]; then
    rm -rf $HOME/dotfiles
    git clone https://github.com/sdatth/dotfiles.git
else
    cd $HOME
    git clone https://github.com/sdatth/dotfiles.git
fi

echo

# 📦 Package manager logic
if [[ "$ARCH" == "arm64" && "$DISTRO_ID" == "darwin" ]]; then
  echo "⚙️ MacOS detected installing brew package manager"
  cd $HOME/dotfiles
  gmake brew
  echo "✅ Brew installed."

elif [[ "$ARCH" == "arm64" && "$IS_MAC_BASED" -ne 1 ]]; then
  echo "⚙️ ARM architecture detected — installing Nix only."
  cd $HOME/dotfiles
  make nix
  echo "✅ Nix installed."

elif [[ "$IS_ARCH_BASED" -eq 1 || "$DISTRO_ID" == "freebsd" ]]; then
  echo "ℹ️ No package manager (Nix/Brew) will be installed on $DISTRO_ID."

else
  echo "Which package manager would you like to install?"
  select PM in "Nix" "Homebrew" "Exit"; do
    case $PM in
      Nix)
        echo "📦 Installing Nix package manager..."
        cd $HOME/dotfiles
        make nix
        echo "✅ Nix installed."
        break
        ;;
      Homebrew)
        echo "🍺 Installing Homebrew package manager..."
        cd $HOME/dotfiles
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
echo "Symlink Files"

if [[ "$IS_DEBIAN_BASED" -eq 1 ]]; then
  make ubuntu

elif [[ "$IS_RHEL_BASED" -eq 1 ]]; then
  make rhel

elif [[ "$IS_ARCH_BASED" -eq 1 ]]; then
  make arch

elif [[ "$DISTRO_ID" == "freebsd" ]]; then
  gmake freebsd

elif [[ "$DISTRO_ID" == "darwin" ]]; then
  gmake mac

else
  echo "⚠️ Unknown or unsupported distribution."
fi
