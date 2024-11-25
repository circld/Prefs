function work_layout
  set notes_dir ~/process
  set work_dir ~/work

  tmux new-session -d -s notes -c $notes_dir
  tmux new-session -d -s work -c $work_dir

  tmux split-window -d -t "notes:0.0" -l 20 -c $notes_dir
  tmux send-keys -t "notes:0.0" 'taskell kanban.md' C-m
  tmux send-keys -t "notes:0.1" 'nvim today.md' C-m
  tmux rename-window -t notes daily_tasks

  tmux split-window -d -t "work:0.0" -l 80 -c $work_dir

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
  set found (fd $argv[1..-1] --type=f --full-path --color=never | preview)
  if test $status -eq 0
    nvim $found
  end
end

function cdf --description 'fuzzy find a directory or subdirectory and move there'
  # sort matching directories from least to most nested
  set found (fd $argv[1..-1] --full-path --type=d --color=never |
    awk '{ split($0, parts, "/"); print length(parts), $0 }' |
    sort -n |
    awk '{ print $2 }' |
    fzf --layout reverse \
       --preview "fd --color=always --base-directory {1} ." \
       --bind=shift-down:preview-half-page-down,shift-up:preview-half-page-up
  )
  if test $status -eq 0
    cd $found
  end
end

function browse --description 'file browser'
  fd --full-path --type=file . | fzf \
    --layout=reverse \
    --bind shift-down:preview-half-page-down,shift-up:preview-half-page-up,"space:execute(bat --paging=always {})","enter:execute(nvim {})","tab:accept" \
    --preview 'bat --force-colorization --theme "base16" --terminal-width=$FZF_PREVIEW_COLUMNS --style=changes,header,numbers {1}' \
    --preview-window=right:70%:wrap \
    || true 
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

# FIXME allow `on_change` to take a directory
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

# FIXME too many files to watch results in a lot of garbage spewed to the terminal (data-process); update to limit watch files to specific dir
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

function root
    set project_root (git rev-parse --show-toplevel)
    if test $status -eq 0
        cd $project_root
    end
end

function format_sql
    set input_file "$argv[1]"
    set output_file "$argv[2]"
    if test (count $argv) -eq 3
        set dialect "--read $argv[3]"
    end

    set command (string join " " -- "~/work/tools_exploration/sqlglot/venv/bin/python -m sqlglot" $dialect '$query' ">" '$output_file')
    cat $input_file | read -fz query
    eval $command
end

function then
    set last_cmd_args (string split " " $history[1])
    set new_cmd (string join " " $argv[1] $last_cmd_args[2..])
    vi $new_cmd
end
