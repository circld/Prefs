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

function vif --description 'fuzzy find a file in directory or subdirectories and open in neovim'
  set found (fd $argv[1..-1] --type=f --color=never | fzf -i \
      --bind=shift-down:preview-half-page-down,shift-up:preview-half-page-up \
      --layout=reverse \
      --preview 'bat --force-colorization --theme "base16" --terminal-width=$FZF_PREVIEW_COLUMNS --style=changes,header,numbers {1}' \
      --preview-window=right:70%:wrap
)
  if test $status -eq 0
    vi $found
  end
end

# inspired by:
# https://github.com/srid/neuron/blob/master/neuron/src-bash/neuron-search
function rf --description 'interactive file contents `rg` searching via `fzf`'
  # if no pattern provided, match all
  set query (string join " " $argv)
  if test -z $query
      set query "."
  end
  set match (\
    rg -i --color=never --no-heading --with-filename --line-number --sort path $query \
    | fzf -i -d ':' --with-nth=1,3 \
      --bind=shift-down:preview-half-page-down,shift-up:preview-half-page-up \
      --layout=reverse \
      --preview 'bat --force-colorization --theme "base16" --terminal-width=$FZF_PREVIEW_COLUMNS --style=changes,header,numbers --highlight-line {2} {1}' \
      --preview-window +{2}-/2:right:70%:wrap
  )
  # open nvim on line of match
  if test $status -eq 0
    set args (string split ":" $match)[1..2]
    echo nvim +$args[2] $args[1]
    nvim +$args[2] $args[1]
  end
end

# e.g., $ on_change 'cargo run' rs toml
#       $ on_change 'pytest -vv' '*'
function on_change --description 'execute argv[1] whenever files with file types argv[2..-1] change'
    set command (string join '; ' $argv[1] 'sleep 1')
    set find_cmd "find . -name '*.$argv[2]'"
    for ftype in $argv[3..-1]
        set find_cmd $find_cmd "-o -name '*.$ftype'"
    end
    eval $find_cmd | entr -cs $command
end

# https://github.com/circld/cli_ide
function dev --description 'Open an IDE with the current path in `/src`. Supplying a name as an argument creates a non-ephemeral named container.'
  docker images | rg 'cli_dev' &> /dev/null
  if test $status -eq 0
      set pwd (pwd)
      if test -n "$argv[1]"
          # non-ephemeral ide container
          set name "ide_$argv[1]"
          docker ps | rg $name &> /dev/null
          if test $status -eq 0
              echo "Container $name is running already; connecting to $name."
              docker exec -it $name fish
          else
              docker run -dit --name $name --mount type=bind,src=$pwd,dst=/root/src cli_dev:latest && docker exec -it $name fish
          end
      else
          # ephemeral ide container
          set name (string join "" (string split '/' $pwd)[-1] '_' (random))
          docker run --name ide_$name --rm -it --mount type=bind,src=$pwd,dst=/root/src cli_dev:latest
      end
  else
      echo '`cli_dev:latest` docker image not found.'
  end
end
