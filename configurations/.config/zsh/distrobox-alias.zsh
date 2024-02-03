# apt

apt(){
    case $1 in
        "install")
            shift 
            /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/apt install $@"
            ;;
        "search")
            shift 
            /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/apt search $@"
            ;;    
        "remove")
            shift 
            /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/apt remove --purge $@"
            ;;
        "update")
            shift
            /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/apt update"
            ;;    
        "autoremove")
            /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/apt autoremove"
            ;;    
        "run")
            shift
            /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  /usr/bin/$@
            ;;
        "export")
            shift 
            /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $@"
            ;;
        "delete")
            shift 
            /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $@ --delete"
            ;;    
        "raw")
            shift
            /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "$*"
            ;;
        *)
            echo "Please enter a valid apt command"
            ;;    
    esac                    
}


# dnf

dnf(){
    case $1 in
        "install")
            shift 
            /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf install $@"
            ;;
        "search")
            shift 
            /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf search $@"
            ;;    
        "remove")
            shift 
            /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf remove $@"
            ;;
        "update")
            /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf update"
            ;;    
        "clean")
            /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf clean packages"
            ;;    
        "run")
            shift
            /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  /usr/bin/$@
            ;;  
        "export")
            shift 
            /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $@"
            ;;
        "delete")
            shift 
            /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $@ --delete"
            ;;    
        "raw")
            shift
            /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "$*"
            ;;
        *)
            echo "Please enter a valid dnf command"
            ;;    
    esac                    
}


# arch

paru(){
    case $1 in
        "-S")
            shift 
            /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -S $@"
            ;;
        "-Ss")
            shift 
            /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -Ss $@"
            ;;    
        "-Rs")
            shift 
            /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -Rs $@"
            ;;
        "-Syu")
            /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -Syu"
            ;;    
        "clean")
            /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -Scc"
            ;;    
        "run")
            shift
            /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  /usr/bin/$@
            ;;       
        "export")
            shift 
            /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $@"
            ;;
        "delete")
            shift 
            /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $@ --delete"
            ;;    
        "raw")
            shift
            /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "$*"
            ;;
        *)
            echo "Please enter a valid pacman or paru command"
            ;;    
    esac                    
}
