check_default_user()
{
    while read -r line ; do
        if [ -n $line ] && [ $line = "DEFAULT_USER:" ]; then
            return 1
        fi
    done < $binaries
    return 0
}

check_reccurent_users()
{
    while read -r line; do
        if [[ -n $line  && $line = "RECCURENT_USERS:" ]]; then
            return 1
        fi
    done < $binaries
    return 0
}

check_files()
{
    binaries=~/.my_scripts/gcl/gcl_info
    if ! [ -f '~/.my_scripts/gcl/gcl_info' ]; then
        touch $binaries
    fi
}

take_main_user()
{
    while read -r m_user; do
        if [[ $m_user = "DEFAULT_USER:" ]]; then
            read -r m_user
            return
        fi
    done < $binaries
}

use_main_user()
{
    if [[ $1 = "-m" ]]; then
        take_project
        take_main_user
        $m_user'/'$project
        exit
    fi
}

want_reset()
{
    if [[ $1 = "--reset" ]]; then
        truncate -s 0 $binaries
        echo -e "Le fichier de configuration a été correctement supprimé"
        exit
    fi
}
