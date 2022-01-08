*Note: newer versions of [qmk_firmware](https://github.com/qmk/qmk_firmware) have CLI commands to accomplish the largely manual steps below. See [docs](https://docs.qmk.fm/#/) for more information.*

# preonic rev3
1. upload json to QMK Configurator website + make adjustments
2. download json
3. compile `keymap.c` + download + unzip
4. copy `keymap.c` to `qmk_firmware/keyboards/preonic/keymaps/circld/keymap.c`
5. from `qmk_firmware` run: `$ make preonic/rev3:circld`
6. open `bin` file in QMK Toolbox
7. set keyboard into DFU mode (hold both shift keys and press `b`)
8. flash firmware

# iris rev4
1. upload json to QMK Configurator website + make adjustments
2. download json

if doing substantial re-work:
3a. compile `keymap.c`:
    1. change into qmk_firmware directory
    2. `$ bin/qmk compile <location of layout JSON>`
    3. this will create a `keymap.c` file in the `keyboards/iris/keymaps/<name in layout json>` directory.
    4. copy over custom tap dance logic and set tap dance calls to appropriate keys.

otherwise:
3b. modify keymap.c directly in `keyboards/iris/keymaps/circld`

4. `$ make keebio/iris/rev4:circld`
