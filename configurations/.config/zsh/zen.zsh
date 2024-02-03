# zen

zen() {

    # Function to display a confirmation prompt
    confirm() {
    echo "Are you sure you want to proceed? (y/n) \c"
    read choice
    case "$choice" in
        y|Y ) return 0;;
        n|N ) return 1;;
        * ) echo "Invalid choice. Please enter 'y' or 'n'."; return 1;;
    esac
    }

    case $1 in
        
        "-apt")
            shift
            
            case $1 in
                "install")
                    shift 
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/apt install $*"
                    ;;
                "search")
                    shift 
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/apt search $1"
                    ;;    
                "remove")
                    shift 
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/apt remove --purge $*"
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
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  /usr/bin/$1
                    ;;
                "export")
                    shift 
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1"
                    ;;
                "delete")
                    shift 
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1 --delete"
                    ;;    
                "raw")
                    shift
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "$*"
                    ;;
                *)
                    echo "Please enter a valid apt command"
                    ;;    
            esac                    
            ;;

        "-dnf")
            shift
             
             case $1 in
                "install")
                    shift 
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf install $*"
                    ;;
                "search")
                    shift 
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf search $1"
                    ;;    
                "remove")
                    shift 
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf remove $*"
                    ;;
                "update")
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf update"
                    ;;    
                "clean")
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/dnf clean packages"
                    ;;    
                "run")
                    shift
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  /usr/bin/$1
                    ;;  
                "export")
                    shift 
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1"
                    ;;
                "delete")
                    shift 
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1 --delete"
                    ;;    
                "raw")
                    shift
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "$*"
                    ;;
                *)
                    echo "Please enter a valid dnf command"
                    ;;    
            esac 
            ;;

        "-aur")
            shift
              
              case $1 in
                "install")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/paru -S $*"
                    ;;
                "search")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/paru -Ss $1"
                    ;;    
                "remove")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/paru -Rns $*"
                    ;;
                "update")
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/paru -Syu"
                    ;;    
                "clean")
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/paru -Scc"
                    ;;    
                "run")
                    shift
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  /usr/bin/$1
                    ;;       
                "export")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1"
                    ;;
                "delete")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1 --delete"
                    ;;    
                "raw")
                    shift
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "$*"
                    ;;
                *)
                    echo "Please enter a valid pacman or paru command"
                    ;;    
            esac 
            ;;
        
        "init")
            shift
            if confirm; then
                if [[ "$1" = "--nvidia" ]] ; then
                    echo "nvidia selected"
                    # debian
                    /usr/bin/distrobox-create --nvidia -n debian --image docker.io/library/debian:12
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "echo 'Hello world'"

                    #arch
                    /usr/bin/distrobox-create --nvidia -n arch --image quay.io/toolbx-images/archlinux-toolbox:latest
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "echo 'Hello world'"

                    # fedora
                    /usr/bin/distrobox-create --nvidia -n fedora
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "echo 'Hello world'"
                else
                    echo "nvidia not selected"
                    # debian
                    /usr/bin/distrobox-create -n debian --image docker.io/library/debian:12
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "echo 'Hello world'"

                    # arch
                    /usr/bin/distrobox-create -n arch --image quay.io/toolbx-images/archlinux-toolbox:latest
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "echo 'Hello world'"

                    # fedora
                    /usr/bin/distrobox-create -n fedora
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "echo 'Hello world'"
                fi
            else
                echo "Action canceled."
            fi
            ;;

        "update")
            if confirm; then
                /usr/bin/distrobox-upgrade -v --all
            else
                echo "Action canceled."
            fi
            ;;

        "stop")
            if confirm; then
                echo "y" | /usr/bin/distrobox-stop arch
                echo "y" | /usr/bin/distrobox-stop debian
                echo "y" | /usr/bin/distrobox-stop fedora
            else
                echo "Action canceled."
            fi    
            ;;

        *)
            echo "Please specify a valid distribution: -apt, -dnf, or -aur"
            ;;
    esac
}