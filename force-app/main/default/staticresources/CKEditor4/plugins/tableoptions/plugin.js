CKEDITOR.plugins.add('tableoptions', {
  requires: 'table',
  init: function(editor) {
    //console.log('tableoptions.init');

    /* eslint-disable-next-line new-cap */
    editor.addCommand('tableOptions', new CKEDITOR.dialogCommand('tableoptionsDialog'));

    CKEDITOR.dialog.add('tableoptionsDialog', this.path + 'dialogs/tableoptions.js');

    if (editor.addMenuItems) {
      editor.addMenuGroup('tableVariants', 100);

      editor.addMenuItems({
        tick: {
          label: 'Nodhom Table Options',
          group: 'tableVariants',
          order: 101,
          getItems: function() {
            return {
              tableVariants_baseTable: CKEDITOR.TRISTATE_OFF,
              tableVariants_stripedRows: CKEDITOR.TRISTATE_OFF,
              tableVariants_columnsDividers: CKEDITOR.TRISTATE_OFF,
            };
          },
        },
        tableVariants_baseTable: {
          label: 'Variants',
          group: 'tableVariants',
          command: 'tableOptions',
          order: 102,
        },
      });
    }

    if (editor.contextMenu) {
      editor.contextMenu.addListener( function( element ) {
        //console.log(element);
        if ( element.getAscendant( 'table', false ) ) {
          return {tick: CKEDITOR.TRISTATE_OFF};
        }
      });
    }
  },
});