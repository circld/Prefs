function . --description '`cd` up $argv[1] times and then to path in $argv[2]'
  for d in (seq $argv[1])
    set d_list $d_list '..'
  end
  set d_list $d_list $argv[2]
  cd (string join / $d_list)
end

function brb --description 'cd into a directory, execute a command, then cd back. n.b., must escape wildcards with `\` or use quotes.'
  cd $argv[1] && eval $argv[2..-1]
  cd -
end