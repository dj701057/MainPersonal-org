CKEDITOR.plugins.add('mergefields', {
  icons: 'mergefields',
  init: function(editor) {
    //console.log('mergefields.init');

    /* eslint-disable-next-line new-cap */
    editor.addCommand('mergefields', new CKEDITOR.dialogCommand('mergefieldsDialog'));

    editor.ui.addButton('Mergefields', {
      label: 'Insert Merge Field',
      command: 'mergefields',
      toolbar: 'insert',
    });

    CKEDITOR.dialog.add( 'mergefieldsDialog', this.path + 'dialogs/mergefields.js' );
  },
});