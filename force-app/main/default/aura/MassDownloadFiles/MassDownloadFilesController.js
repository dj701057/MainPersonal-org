({
    
    fetchFiles : function( component, event, helper ) {
        component.set( 'v.mycolumns', [{ label: 'Name', fieldName: 'documentName', type: 'text' }] );
        let action = component.get( "c.fetchRelatedFiles" );
        action.setParams({
            strRecordId : component.get( "v.recordId" )
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.filesList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
    },
    
    getSelectedName: function ( component, event) {
        let selectedRows = event.getParam('selectedRows');
        let selectedIds = [];
        for ( let i = 0; i < selectedRows.length; i++ ) {
            selectedIds.push(selectedRows[ i ].documentId);
        }
        component.set("v.selectedFileIds",selectedIds);
    },
    
    downloadFiles : function( component ) {      
                
        let selectedFiles = component.get("v.selectedFileIds");
        console.log('selectedFiles are',JSON.stringify( selectedFiles ));
        
        if ( selectedFiles.length > 0 ) {
            
            let navService = component.find("navService");
            let filesDownloadUrl = '/sfc/servlet.shepherd/version/download';
            for ( let item of selectedFiles ) {
                filesDownloadUrl += '/' + item;
            }     
            
            console.log( 'filesDownloadUrl is', filesDownloadUrl);  
            let pageReference = {
                type: 'standard__webPage',
                attributes: {
                    url: filesDownloadUrl
                }
            };
            navService.navigate(pageReference);
            let showToast = $A.get( "e.force:showToast" );
            showToast.setParams({
                title : 'File(s) Download',
                type : 'success',
                mode : 'sticky',
                message : 'File(s) Downloaded Successfully!!!'
            });
            showToast.fire(); 
        } else {
            
            let showToast = $A.get( "e.force:showToast");
            showToast.setParams({
                title : 'File(s) Download',
                type : 'error',
                mode : 'sticky',
                message : 'Please select File(s)'
            });
            showToast.fire(); 
        }
    }
})