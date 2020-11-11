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

function vif --description 'open a file found in specified dir using `fzf`'
  set found (ls -alt $argv[1] | fzf)
  if test $status -eq 0
    set name (echo $found | awk '{print $9}')
    vi (string join / $argv[1] $name)
  end
end

# inspired by:
# https://github.com/srid/neuron/blob/master/neuron/src-bash/neuron-search
function rf --description 'interactive file contents `rg` searching via `fzf`'
  set match (rg -i --no-heading --no-line-number --with-filename --sort path $argv[1] | fzf)
  if test $status -eq 0
    echo $match | awk -F: "{printf \$1}" | xargs -I {} nvim {}
  end
end
