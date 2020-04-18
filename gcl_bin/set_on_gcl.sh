source ./gcl_bin/gcl_check.sh

for_trunc()
{
    size=$(stat -c%s "$binaries")
    let "size -= 3"
    truncate -s $size  $binaries
}

new_main_user()
{
    check_default_user
    if [ $? -eq 0 ]; then
        read -p 'Voulez vous le mettre par défaut ? [o/n] ' ans
        if [ -n $ans ] && [ $ans = 'o' ]; then
            echo -e "\n" >> $binaries
            sed -i "1iDEFAULT_USER:" $binaries
            sed -i "2i$lin$user\n" $binaries
            echo -e "L'utilisateur par défaut est $user et le répertoire est $repo"
            for_trunc
            return 1
        fi
    fi
    return 0
}

new_reccurent_user()
{
    if [[ -z $ans ]] || [[ $ans != 'o' ]]; then
	    check_reccurent_users
        if [ $? -eq 0 ]; then
            echo -e "RECCURENT_USERS:" >> $binaries
        fi
    fi
    echo -e "$user" >> $binaries
}