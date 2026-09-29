CKEDITOR.dialog.add('tableoptionsDialog', function(editor) {
  /**
     * Get table element.
     * @param {Object} editor instance.
     *
     * @return {Object} table element.
     */
  function getTable(editor) {
    // Detect if there's a selected table.
    const selection = editor.getSelection();
    const ranges = selection.getRanges();
    let table;

    const selected = selection.getSelectedElement();
    if ( selected && selected.is( 'table' ) ) {
      table = selected;
    } else if ( ranges.length > 0 ) {
      // Webkit could report the following range on cell selection (https://dev.ckeditor.com/ticket/4948):
      // <table><tr><td>[&nbsp;</td></tr></table>]
      if ( CKEDITOR.env.webkit ) {
        ranges[0].shrink( CKEDITOR.NODE_ELEMENT );
      }

      table = editor.elementPath( ranges[0].getCommonAncestor( true ) ).contains( 'table', 1 );
    }
    return table;
  }

  const setClass = function(value, className, table) {
    const classes = (table.getAttribute('class') || '').split(' ');
    const classIndex = classes.indexOf(className);
    if (classIndex > -1) {
      classes.splice(classIndex, 1);
    }

    if (value) {
      classes.push(className);
    }
    table.setAttribute('class', classes.join(' '));
  };

  const commitValue = function( data ) {
    const id = this.id;
    if ( !data.info ) {
      data.info = {};
    }
    data.info[id] = this.getValue();
  };

  const hasClass = function(table, className) {
    const classes = (table.getAttribute('class') || '').split(' ');
    return (classes.indexOf(className) > - 1);
  };

  const variantClasses = {
    stripedRows: 'slds-table_striped',
    bordered: 'slds-table_bordered',
  };

  return {
    title: editor.lang.table.title,
    resizable: CKEDITOR.DIALOG_RESIZE_BOTH,
    minWidth: 500,
    minHeight: 70,
    contents: [{
      id: 'tableVarants',
      label: 'Variants',
      elements: [{
        type: 'hbox',
        widths: ['50%', '50%'],
        children: [{
          id: 'stripedRows',
          label: 'Striped Rows',
          type: 'checkbox',
          value: variantClasses.stripedRows,
          setup: function(table) {
            this.setValue(hasClass(table, variantClasses.stripedRows));
          },
          commit: commitValue,
        }, {
          id: 'bordered',
          label: 'Bordered',
          type: 'checkbox',
          value: variantClasses.bordered,
          setup: function(table) {
            this.setValue(hasClass(table, variantClasses.bordered));
          },
          commit: commitValue,
        }],
      }],
    }],
    onShow: function() {
      const table = getTable(editor);
      this._.selectedElement = table;
      this.setupContent(table);
    },
    onOk: function() {
      const table = this._.selectedElement;
      const data = {};

      this.commitContent(data, table);

      if ( data.info ) {
        setClass((data.info && data.info.stripedRows), variantClasses.stripedRows, table);
        setClass((data.info && data.info.bordered), variantClasses.bordered, table);
      }
    },
  };
});