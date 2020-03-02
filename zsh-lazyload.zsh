function lazyload {  
  local seperator='--'
  local seperator_index=${@[(ie)$seperator]}
  local cmd_list=(${@:1:(($seperator_index - 1))}); 
  local load_cmd=${@[(($seperator_index + 1))]};    
  if (( ${cmd_list[(I)${funcstack[2]}]} ))
  then
    unfunction $cmd_list
    eval "$load_cmd"
  else
    local cmd
    for cmd in $cmd_list
    do
      eval "function $cmd {
        lazyload $cmd_list \
          -- ${(qqqq)load_cmd}
        $cmd \"\$@\"
      }"
    done
  fi
}

