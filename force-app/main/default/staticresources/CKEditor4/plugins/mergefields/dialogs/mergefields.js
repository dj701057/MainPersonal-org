CKEDITOR.dialog.add('mergefieldsDialog', function(editor) {
  const commitValue = function( data ) {
    const id = this.id;
    if ( !data.info ) {
      data.info = {};
    }
    data.info[id] = this.getValue();
  };

  const objectsFields = [];
  const objectsContent = [];
  const objectsFieldsElements = [];
  const contents = [];

  objectsFieldsData.sort(function compare( a, b ) {
    if ( a.name < b.name ) {
      return -1;
    }
    if ( a.name > b.name ) {
      return 1;
    }
    return 0;
  }).forEach(function(objectData) {
    objectsContent.push([objectData.name, objectData.value]);
    objectsFieldsElements.push(objectData.value + 'Fields');

    objectsFields.push({
      'type': 'vbox',
      'id': objectData.value + 'Fields',
      'children': [{
        type: 'hbox',
        widths: ['100%'],
        children: [{
          'id': objectData.value + 'Field',
          'type': 'select',
          'label': 'Select ' + objectData.name + ' field:',
          'items': objectData.fields.sort(function compare( a, b ) {
            if ( a[0] < b[0] ) {
              return -1;
            }
            if ( a[0] > b[0] ) {
              return 1;
            }
            return 0;
          }),
          'required': !0,
          'commit': commitValue,
        }],
      }],
      'setup': function() {
        this.getElement().hide();
      },
    });
  });

  objectsFields.push({
    'type': 'vbox',
    'id': 'labelAndValue',
    'children': [{
      type: 'hbox',
      widths: ['33%', '33%', '33%'],
      children: [{
        'id': 'showLabel',
        'type': 'checkbox',
        'label': 'Show field Label',
        'required': !0,
        'commit': commitValue,
        'setup': function() {
          this.setValue(false);
        }},
      {
        'id': 'showValue',
        'type': 'checkbox',
        'label': 'Show field Value',
        'required': !0,
        'commit': commitValue,
        'setup': function() {
          this.setValue(true);
        }},
      {
        'id': 'hideIfEmpty',
        'type': 'checkbox',
        'label': 'Hide If Empty',
        'required': !0,
        'commit': commitValue,
        'setup': function() {
          this.setValue(false);
        }}],
    }],
  });

  contents.push({
    id: 'obj-fields',
    name: '',
    label: 'obj',
    elements: [{
      'id': 'object',
      'type': 'select',
      'label': 'Select Object',
      'items': objectsContent,
      'required': !0,
      'commit': commitValue,
      'onChange': function() {
        selectedValue = '';

        const a = this.getDialog();
        const b = objectsFieldsElements;
        const r = this.getValue();

        for (let f = 0; f < b.length; f++) {
          //console.log(r + 'Fields', b[f]);
          let m = a.getContentElement('obj-fields', b[f], b[f] == r + 'Fields');
          m && (m = m.getElement(), ((b[f] == r + 'Fields') ? m.show() : m.hide()));
        }
        a.layout();
      },
    }].concat(objectsFields),
  });

  return {
    title: 'Insert Merge Field',
    resizable: CKEDITOR.DIALOG_RESIZE_BOTH,
    minWidth: 500,
    minHeight: 70,
    contents: contents,
    onShow: function() {
      const a = this.getParentEditor();
      const b = a.getSelection();
      this.setupContent(b);
    },
    onOk: function() {
      const data = {};

      this.commitContent(data);

      let selections = [];
      if ( data.info ) {
        const objectName = data.info.object;
        const fieldName = data.info[objectName + 'Field'];
        const showLabel = data.info.showLabel;
        const showValue = data.info.showValue;
        const hideIfEmpty = data.info.hideIfEmpty;

        if (objectName && fieldName) {
          selections.push([objectName, fieldName].join('.'));
          if (showLabel) {
            selections.push('showLabel');
          }
          if (showValue) {
            selections.push('showValue');
          }
          if (hideIfEmpty) {
            selections.push('hideIfEmpty');
          }

          if (!showLabel && !showValue && !hideIfEmpty) {
            selections = [];
          }
        }
      }

      if (selections.length > 0) {
        editor.insertText('{{{' + selections.join('|') + '}}}');
      }
    },
  };
});