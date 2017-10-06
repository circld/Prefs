from IPython import get_ipython
from prompt_toolkit.keys import Keys
from prompt_toolkit.key_binding.bindings.named_commands import clear_screen
from prompt_toolkit.filters import ViInsertMode, EmacsInsertMode


ip = get_ipython()
insert_mode = ViInsertMode() | EmacsInsertMode()

# Register the shortcut if IPython is using prompt_toolkit
if getattr(ip, 'pt_cli'):
    registry = ip.pt_cli.application.key_bindings_registry
    registry.add_binding(Keys.ControlSpace)(clear_screen)
