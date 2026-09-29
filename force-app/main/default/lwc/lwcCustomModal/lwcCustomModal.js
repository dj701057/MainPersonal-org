import { LightningElement,track,api,wire} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
//import getAccounts from '@salesforce/apex/lwcApexController.searchAccountNameMethod';
const DELAY = 100;
import saveFile from '@salesforce/apex/LWCExampleController.saveFile';
import releatedFiles from '@salesforce/apex/LWCExampleController.releatedFiles';


const columns = [
    {label: 'Title', fieldName: 'Title'}
];

export default class LwcCustomModal extends LightningElement {
    @track chooseOptionName = 'Owned by Me';
    @track sizeofOptionList;
    @track customFormModal = false; 
    @track contentDoc = [];
   
    @track searchKey ='';
    

    
    customShowModalPopup() {            
        this.customFormModal = true;
    }
 
    customHideModalPopup() {    
        
        this.customFormModal = false;
    }

    filterObj(arrayOfObject,string){
        Console.log('I am in filter',arrayOfObject);
        return arrayOfObject.filter(obj => 
            Object.keys(obj).some(k => obj[k].toLowerCase().includes(string.toLowerCase())));
    
    }
       
        @api recordId;
        @track columns = columns;
        @track FileTableList;
        @track fileName = '';
        @track UploadFile = 'Upload File';
        @track showLoadingSpinner = false;
        @track isTrue = false;
        selectedRecords;
        filesUploaded = [];
        file;
        fileContents;
        fileReader;
        content;
        MAX_FILE_SIZE = 1500000;

        handleSearch(event){
            this.searchKey = event.target.value;
            console.log('Incoming Value',this.searchKey);
                this.getRelatedFiles();
                console.log('Related Files Value',this.getRelatedFiles);
        }

        handleSearch(events){
            this.searchKey=events.target.value;
            console.log('incoming Value',this.searchKey);
            this.getRelatedFiles();
            console.log('Related files value',this.getRelatedFiles);

        }

        handleOptionClick(event){
           this.chooseOptionName = event.target.value;
           console.log(this.chooseOptionName);
           if(this.chooseOptionName.includes("Owned")){
               this.getFiles();
               console.log("Owned :-",this.getFiles);
           }
        }
        getFile(){
            releatedFiles({userId : this.userId})
                   .then(result => {
                       if(result.length >0){
                       const contentList = result;
                       this.sizeofOptionList = result.length;
                       console.log('This is Option List size ',this.sizeofOptionList);
                       let ownerName;
                       let titleUrl;
                       this.contentDoc = contentList.map(row => {
                        titleUrl = `/${row.Id}`;
                        ownerName = row.Owner.Name;
                        return {...row,titleUrl,ownerName}
                       });
                       console.log(this.contentDoc);
                       }
                   })
                   .catch(error => {
                       console.log(error);
                       this.contentDoc = [];
                   });
        
        }
        connectedCallback() {
            this.getRelatedFiles();
        }
    
        // getting file 
        handleFilesChange(event) {
            if(event.target.files.length > 0) {
                this.filesUploaded = event.target.files;
                this.fileName = event.target.files[0].name;
            }
        }
    
        handleSave() {
            if(this.filesUploaded.length > 0) {
                this.uploadHelper();
            }
            else {
                this.fileName = 'Please select file to upload!!';
            }
        }
    
        uploadHelper() {
            this.file = this.filesUploaded[0];
           if (this.file.size > this.MAX_FILE_SIZE) {
                console.log('File Size is to long');
                return ;
            }
            this.showLoadingSpinner = true;
            // create a FileReader object 
            this.fileReader= new FileReader();
            // set onload function of FileReader object  
            this.fileReader.onloadend = (() => {
                this.fileContents = this.fileReader.result;
                let base64 = 'base64,';
                this.content = this.fileContents.indexOf(base64) + base64.length;
                this.fileContents = this.fileContents.substring(this.content);
                
                // call the uploadProcess method 
                this.saveToFile();
            });
        
            this.fileReader.readAsDataURL(this.file);
        }
    
        // Calling apex class to insert the file
        saveToFile() {
            saveFile({ idParent: this.recordId, strFileName: this.file.name, base64Data: encodeURIComponent(this.fileContents)})
            .then(result => {
                window.console.log('result ====> ' +result);
                // refreshing the datatable
                this.getRelatedFiles();
    
                this.fileName = this.fileName + ' - Uploaded ';
                this.UploadFile = 'File Uploaded ';
                this.isTrue = true;
                this.showLoadingSpinner = false;
    
                // Showing Success message after file insert
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: this.file.name + ' - Uploaded ',
                        variant: 'success',
                    }),
                );
    
            })
            .catch(error => {
                // Showing errors if any while inserting the files
                window.console.log(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error while uploading File',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
        }
        
        // Getting releated files of the current record
        getRelatedFiles() {
            releatedFiles({idParent: this.recordId,searchKey: this.searchKey})
            .then(data => {
                this.FileTableList = data;
                console.log('FileTableList ----->',JSON.stringify(this.FileTableList));
            })
            .catch(error => {
                
            });
        }
    
        // Getting selected rows to perform any action
        getSelectedRecords(event) {
            let conDocIds;
            const selectedRows = event.detail.selectedRows;
            conDocIds = new Set();
            // Display that fieldName of the selected rows
            for (let i = 0; i < selectedRows.length; i++){
                conDocIds.add(selectedRows[i].ContentDocumentId);
            }
    
            this.selectedRecords = Array.from(conDocIds).join(',');
    
            window.console.log('selectedRecords =====> '+this.selectedRecords);
        }
    
    }