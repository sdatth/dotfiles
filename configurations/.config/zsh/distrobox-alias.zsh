# for arch box
paru_run(){
    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  /usr/bin/"$@"
}

paru_install(){
    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "sudo /usr/bin/pacman -S '$@'"
}

paru_raw(){
    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "$*"
}

# for debian box
apt_run(){
    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  /usr/bin/"$@"
}

apt_install(){
    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "sudo /usr/bin/apt install '$@'"
}

apt_update(){
    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "sudo /usr/bin/apt update"
}

apt_raw(){
    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "$*"
}

# for fedora box
dnf_run(){
    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  /usr/bin/"$@"
}

dnf_install(){
    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "sudo /usr/bin/dnf install '$@'"
}

dnf_update(){
    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "sudo /usr/bin/dnf update"
}

dnf_raw(){
    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "$*"
}
