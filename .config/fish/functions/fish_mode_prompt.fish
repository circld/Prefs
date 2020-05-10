function fish_mode_prompt
  set -l tomita_vi_mode "$TOMITA_VI"

  if test -z (string match -ri '^no|false|0$' $tomita_vi_mode)
    switch $fish_bind_mode
      case default
        set_color --bold red
        printf '['
        printf 'n'
        printf '] '
      case insert
        set_color --bold green
        printf '['
        printf 'i'
        printf '] '
      case visual
        set_color --bold magenta
        printf '['
        printf 'v'
        printf '] '
    end
    set_color normal
  end

end
