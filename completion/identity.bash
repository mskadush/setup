#https://opensource.com/article/18/3/creating-bash-completion-script
# add the following options to login script
#complete -W "now tomorrow never" identity

_company_completions()
{
  if [ "$COMP_CWORD" == "1" ]; then
    # completion reply list
    COMPREPLY=($(compgen -W "lipa skadush" "${COMP_WORDS[COMP_CWORD]}"))
  elif [ "$COMP_CWORD" == "2" ]; then
    if [ "${COMP_WORDS[1]}" == "lipa" ]; then
      COMPREPLY=($(compgen -W "developer-minenhle-dev-env operator-minenhle-dev-env" "${COMP_WORDS[COMP_CWORD]}"))
    elif [  "${COMP_WORDS[1]}" == "skadush"  ]; then
      COMPREPLY=($(compgen -W "minenhle" "${COMP_WORDS[COMP_CWORD]}"))
    fi
  fi
}

complete -F _company_completions identity