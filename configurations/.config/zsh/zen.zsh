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
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/apt update && /usr/bin/sudo /usr/bin/apt upgrade"
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
                    if [[ "$1" = "-a" ]] ; then 
                        shift
                        /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1"
                    elif [[ "$1" = "-b" ]] ; then
                        shift
                        /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/distrobox-export --bin /usr/bin/$1 --export-path $HOME/.local/bin"
                    fi        
                    ;;
                "delete")
                    shift
                    if [[ "$1" = "-a" ]] ; then 
                        shift
                        /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1 --delete"
                    elif [[ "$1" = "-b" ]] ; then
                        shift
                        /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "/usr/bin/distrobox-export --bin /usr/bin/$1 --export-path $HOME/.local/bin --delete"
                    fi        
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
                    if [[ "$1" = "-a" ]] ; then 
                        shift
                        /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1"
                    elif [[ "$1" = "-b" ]] ; then
                        shift
                        /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/distrobox-export --bin /usr/bin/$1 --export-path $HOME/.local/bin"
                    fi        
                    ;;
                "delete")
                    shift
                    if [[ "$1" = "-a" ]] ; then 
                        shift
                        /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1 --delete"
                    elif [[ "$1" = "-b" ]] ; then
                        shift
                        /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "/usr/bin/distrobox-export --bin /usr/bin/$1 --export-path $HOME/.local/bin --delete"
                    fi        
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

        "-paru")
            shift
              
              case $1 in
                "install")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/paru -S $*"
                    ;;
                "search")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/paru -Ss $1"
                    ;;    
                "remove")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/paru -Rns $*"
                    ;;
                "update")
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/paru -Syu"
                    ;;    
                "clean")
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/paru -Scc"
                    ;;    
                "run")
                    shift
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  /usr/bin/$1
                    ;;       
                "export")
                    shift
                    if [[ "$1" = "-a" ]] ; then 
                        shift
                        /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1"
                    elif [[ "$1" = "-b" ]] ; then
                        shift
                        /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --bin /usr/bin/$1 --export-path $HOME/.local/bin"
                    fi        
                    ;;
                "delete")
                    shift
                    if [[ "$1" = "-a" ]] ; then 
                        shift
                        /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1 --delete"
                    elif [[ "$1" = "-b" ]] ; then
                        shift
                        /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --bin /usr/bin/$1 --export-path $HOME/.local/bin --delete"
                    fi        
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

        "-pac")
            shift
              
              case $1 in
                "install")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -S $*"
                    ;;
                "search")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -Ss $1"
                    ;;    
                "remove")
                    shift 
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -Rs $*"
                    ;;
                "update")
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -Syu"
                    ;;    
                "clean")
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/sudo /usr/bin/pacman -Scc"
                    ;;    
                "run")
                    shift
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  /usr/bin/$1
                    ;;       
                "export")
                    shift
                    if [[ "$1" = "-a" ]] ; then 
                        shift
                        /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1"
                    elif [[ "$1" = "-b" ]] ; then
                        shift
                        /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --bin /usr/bin/$1 --export-path $HOME/.local/bin"
                    fi        
                    ;;
                "delete")
                    shift
                    if [[ "$1" = "-a" ]] ; then 
                        shift
                        /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --app $1 --delete"
                    elif [[ "$1" = "-b" ]] ; then
                        shift
                        /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "/usr/bin/distrobox-export --bin /usr/bin/$1 --export-path $HOME/.local/bin --delete"
                    fi        
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

        "enter")
            shift
            /usr/bin/distrobox enter $1
            ;;    

        "stop")
            shift
            if [[ "$1" = "all" ]] ; then
                if confirm; then
                    echo "y" | /usr/bin/distrobox-stop arch
                    echo "y" | /usr/bin/distrobox-stop debian
                    echo "y" | /usr/bin/distrobox-stop fedora
                else
                    echo "Action canceled."
                fi
            else
                /usr/bin/distrobox-stop $1
            fi
            ;;

        "start")
            shift
            if [[ "$1" = "all" ]] ; then
                if confirm; then
                    /usr/bin/distrobox-enter  -n debian -- /bin/sh -l -c  "echo 'Started Debian Container\n'"
                    /usr/bin/distrobox-enter  -n fedora -- /bin/sh -l -c  "echo -e 'Started Fedora Container\n'"
                    /usr/bin/distrobox-enter  -n arch -- /bin/sh -l -c  "echo -e 'Started Arch Container\n'" 
                else
                    echo "Action canceled."
                fi
            else
                /usr/bin/distrobox-enter  -n $1 -- /bin/sh -l -c  "echo 'Started $1 container'"
            fi
            ;;

        "list")
            /usr/bin/distrobox list
            ;;

        *)
            echo "Please specify a valid package manager: -apt, -dnf, -paru or -pac"
            ;;
    esac
}
