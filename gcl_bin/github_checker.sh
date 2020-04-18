
parse_github_infos()
{
    cu='https://github.com/'$user'?tab=repositories'
    hr='<a href="/'$user'/'
    curl -s $cu > url
    cat url | grep "$hr" > project
    (tr -d '"' < project) > url
    (tr -d ' ' < url) > project
    (tr -d '=' < project) > url
    (tr -d '<' < url) > project
    (tr -d '>' < project) > url
}

github_checker()
{
    if [[ $repo = "github" ]]; then
        parse_github_infos
        read result < url
        if [[ ${#result} -eq 0 ]]; then
            echo -e "I found that $user doesn't have any public Github repository"
            exit
        else
            echo -e "I found that $user own repositories below"
            while read rp; do
                let "max = ${#rp} - 26 - ${#user} - 6"
                echo ${rp:7 + ${#user}:max - 1}
            done < url
        fi
        rm -rf project res url
    fi
}