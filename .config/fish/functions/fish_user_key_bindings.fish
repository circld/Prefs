function fish_user_key_bindings
  fzf_key_bindings
  bind \cr _atuin_search
  bind -M insert \cr _atuin_search

  # temporary workaround until 4.0.3
  bind \ef nextd-or-forward-word
  bind -M insert \ef nextd-or-forward-word
  bind -M visual \ef nextd-or-forward-word

end
