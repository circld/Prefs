// Configure CodeMirror Keymap (for Jupyter + jupyter_vim_binding)
// https://github.com/lambdalisue/jupyter-vim-binding/wiki/Customization
// https://codemirror.net/doc/manual.html
// https://github.com/jupyter/notebook/blob/5.4.x/notebook/static/notebook/js/actions.js

require([
  'base/js/namespace',
  'codemirror/keymap/vim',
  'nbextensions/vim_binding/vim_binding'   // depends your installation
], function(ns) {

  var cm_config = require("notebook/js/cell").Cell.options_default.cm_config;
  delete cm_config.extraKeys['Ctrl-C'];

  Jupyter.notebook.get_cells().map(function(cell) {
      var cm = cell.code_mirror;
      if (cm) {
          delete cm.getOption('extraKeys')['Ctrl-C'];
      }
  });

  CodeMirror.Vim.defineAction("nohl-normal-mode", function(cm) {
    CodeMirror.Vim.handleKey(cm, "<Esc>")
    CodeMirror.Vim.handleEx(cm, ":noh");
  })

  CodeMirror.Vim.defineAction("jupyter-command-mode", function(cm) {
    CodeMirror.Vim.handleEx(cm, ":noh");
    ns.notebook.command_mode();
    ns.notebook.focus_cell();
  })

  CodeMirror.Vim.defineAction("comment_line", function(cm) {
    let curStart = cm.getCursor("from");
    let curEnd = cm.somethingSelected() ? cm.getCursor("to") : curStart;
    console.log(cm.somethingSelected());
    console.log(curEnd);
    cm.toggleComment(curStart, curEnd);
  });

  CodeMirror.Vim.mapCommand("gcc", "action", "comment_line", {}, {"isEdit": true});
  CodeMirror.Vim.mapCommand("<C-c>", "action", "nohl-normal-mode", {}, {"context": "insert", "isEdit": false})
  CodeMirror.Vim.mapCommand("<C-c>", "action", "jupyter-command-mode", {}, {"context": "normal", "isEdit": false})
});

/* Example of a custom EX command */
// require([
//   'base/js/namespace',
//   'codemirror/keymap/vim',
//   'nbextensions/vim_binding/vim_binding'
// ], function(ns) {
//   CodeMirror.Vim.defineEx("quit", "q", function(cm){
//     ns.notebook.command_mode();
//     ns.notebook.focus_cell();
//   });
// });
