function work_layout
  tmux new-session -d -s notes -c ~/notes
  tmux new-session -d -s work -c ~/work

  tmux split-window -d -t "notes:0.0" -l 20 -c ~/notes
  tmux send-keys -t "notes:0.0" 'taskell kanban/(date +"%y%m%d")_kanban.md' C-m
  tmux send-keys -t "notes:0.1" 'nvim (date +"%y%m%d")_notes.md' C-m

  tmux attach -t notes
end

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

# e.g., rg --color=never -l <pattern> | preview | xargs nvim
function preview --description 'preview files using fzf'
  argparse 'l/line' -- $argv

  if test -n "$_flag_l"
    fzf -i -d ':' --with-nth=1,3 \
      --bind=shift-down:preview-half-page-down,shift-up:preview-half-page-up \
      --layout=reverse \
      --preview 'bat --force-colorization --theme "base16" --terminal-width=$FZF_PREVIEW_COLUMNS --style=changes,header,numbers --highlight-line {2} {1}' \
      --preview-window +{2}-/2:right:70%:wrap
  else
    fzf -i \
      --bind=shift-down:preview-half-page-down,shift-up:preview-half-page-up \
      --layout=reverse \
      --preview 'bat --force-colorization --theme "base16" --terminal-width=$FZF_PREVIEW_COLUMNS --style=changes,header,numbers {1}' \
      --preview-window=right:70%:wrap
  end
end

function vif --description 'fuzzy find a file in directory or subdirectories and open in neovim'
  set found (fd $argv[1..-1] --type=f --color=never | preview)
  if test $status -eq 0
    nvim $found
  end
end

function cdf --description 'fuzzy find a directory or subdirectory and move there'
  set found (fd $argv[1..-1] --absolute-path --type=d --color=never |
    fzf --preview "fd --color=always --base-directory {1} ."
  )
  if test $status -eq 0
    cd $found
  end
end

# inspired by:
# https://github.com/srid/neuron/blob/master/neuron/src-bash/neuron-search
function rf --description 'interactive file contents `rg` searching via `fzf`'
  if not argparse --name=rf "o/=+" -- $argv
    return 1
  end

  # pass optional flags to `rg` (e.g., --no-ignore)
  set rg_options (string join -- " " $_flag_o)

  # if no pattern provided, match all
  set query (string join " " $argv)
  if test -z $query
      set query "."
  end

  set match (
    eval "rg -i --color=never --no-heading --with-filename --line-number --sort path $rg_options '$query'" \
    | preview -l
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
    set command (string join '; ' $argv[1] 'sleep 5')
    set find_cmd "fd . -e '$argv[2]'"
    for ftype in $argv[3..-1]
        set find_cmd $find_cmd "-e '$ftype'"
    end
    eval $find_cmd | entr -cs $command
end

# utility for running `pytest` within a running container
# usage: $ pipeline_tests pipeline_tests ~/work/octane-lending-data-process/sot_contract_pipeline test_create_contract_df [--pdb]
function pipeline_tests
  set container_name "$argv[1]"
  set pipeline_path "$argv[2]"
  set test_name "$argv[3]"
  set pytest_args (string join -- " " $argv[4..-1])

  set repo_path (dirname $pipeline_path)
  set pipeline (basename $pipeline_path)

  cd $repo_path
  if test 1 -eq (docker ps --filter="name=$container_name" | wc -l)
      docker rm $container_name &> /dev/null
      docker-compose run --rm -d -e "TERM=xterm-256color" --name $container_name pipelines /bin/bash
  end
  # TODO eventually want to watch json or python files
  on_change "docker exec -it -e 'TERM=xterm-256color' $container_name python3 -m pytest -vv --show-capture=no $pytest_args -k '$test_name' $pipeline" py
end
