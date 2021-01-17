# dependencies:
#   - https://github.com/circld/cli_ide
#   - docker
#   - fd
#   - rg
function dev --description 'Open an CLI-based dev environment with the current path mounted in `/src`.'
  function is_valid_image
    contains -- "$argv[1]" (fd --no-ignore --base-directory="$CLI_IDE_PATH" --exact-depth=2 *Dockerfile | xargs -I{} dirname {})
  end

  if set -q $CLI_IDE_PATH
      echo "The CLI_IDE_PATH environment variable must be defined."
  end

  # parsing arguments
  if not argparse --name=dev --max-args=3 'h/help' 'n/name=' -- $argv
      return 1
  end
  if set -q _flag_help
      echo "Start a containerized development environment with the current directory and sub-directories bind mounted." \n
      echo "Usage: dev [build] [image] [session_name]" \n
      echo "Positional arguments:"
      echo "    build - Rebuild steps in the container from CACHEBUST onward."
      echo "    image - Use the image with this name (latest tag). Must correspond to a cli_ide environment directory. If omitted, uses the Dockerfile in the cli_ide root."
      echo "    session_name - persist running countainer with the name ide_<session_name>. Omitting this argument runs an ephemeral container." \n
      return 0
  end
  set nargs (count $argv)
  set next_arg 1
  if test "$argv[1]" = "build"
      set build 1
      set next_arg (math $next_arg+1)
  else
      set build 0
  end
  if test $next_arg -le $nargs; and is_valid_image "$argv[$next_arg]"
      set image "$argv[$next_arg]"
      set next_arg (math $next_arg+1)
  else
      echo "No valid image specified. If needed, will use cli_dev:latest."
      set image "cli_dev"
  end
  if test $next_arg -eq $nargs
      set session_name "$argv[$next_arg]"
  end
  if set -q DEBUG
      echo "[DEBUG] build: $build"
      echo "[DEBUG] image: $image"
      if set -q session_name
          echo "[DEBUG] session_name: $session_name"
      else
          echo "[DEBUG] session_name: (ephemeral)"
      end
  end

  # core logic
  set image_w_tag "$image:latest"
  set image_exists (docker images | rg "$image\s+latest")
  if test $build -eq 1 -o -z "$image_exists"
      if test -n "$image_exists"
          docker rmi "$image_w_tag"
      end
      if test "$image" = "cli_dev"
          set build_path "$CLI_IDE_PATH"
      else
          set build_path "$CLI_IDE_PATH/$image"
      end
      docker build --build-arg CACHEBUST=(date "+%Y-%m-%dT%H:%M:%S") -f "$build_path/Dockerfile" -t "$image_w_tag" "$build_path"
  end
  set pwd (pwd)
  if test -n "$session_name"
      # non-ephemeral ide container
      set name "ide_$session_name"
      if docker ps | rg "$name" &> /dev/null
          echo "Container $name is running already; connecting to $name."
          docker exec -it $name fish
      else
          docker run -dit --name "$name" --mount type=bind,src=$pwd,dst=/root/src "$image_w_tag" && docker exec -it "$name" fish
      end
  else
      # ephemeral ide container
      set name (string join "" (string split '/' $pwd)[-1] '_' (random))
      docker run --name "ide_$name" --rm -it --mount type=bind,src=$pwd,dst=/root/src "$image_w_tag"
  end
end
