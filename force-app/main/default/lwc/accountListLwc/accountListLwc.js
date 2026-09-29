import { LightningElement,track,wire } from 'lwc';
import fetchAccounts from '@salesforce/apex/AccountListCtrl.fetchAccounts';
import {deleteRecord} from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import submitScoreAction from '@salesforce/apex/AccountListCtrl.submitScoreAction';
import newTaskCreated from '@salesforce/apex/AccountListCtrl.newTaskCreated';

import SubjectPicklist from '@salesforce/apex/AccountListCtrl.SubjectPicklist';
import StatusPicklist from '@salesforce/apex/AccountListCtrl.StatusPicklist';
import PriorityPicklist from '@salesforce/apex/AccountListCtrl.PriorityPicklist';

const COLUMNS = [
    {
        label: 'Name', fieldName: 'AccountURL', type: 'url',
        typeAttributes: {
            label: {
                fieldName: 'Name'
            }
        }
    },
    {label: 'Type', fieldName: 'Type', type: 'text'},
    {label: 'AccountNumber', fieldName: 'AccountNumber', type: 'text'},
    {label: 'Industry', fieldName: 'Industry', type: 'text'},
    {label: 'Phone', fieldName: 'Phone', type: 'phone',
     
        cellAttributes: { 
            iconName: 'utility:phone_portrait' 
        }
      
    },
    {label: 'Delete',type: "button", typeAttributes: {
        label: 'Delete',
        name: 'delete',
        title: 'Delete',
        disabled: false,
        value: 'delete',
        variant: 'destructive',
        iconPosition: 'left'
    }},
    {label: 'Create Contact',type: "button", typeAttributes: {
        label: 'Contact',
        name: 'CreateContact',
        title: 'CreateContact',
        disabled: false,
        value: 'CreateContact',
        variant: 'brand',
        iconPosition: 'left'
    }},
    {label: 'Create Task',type: "button", typeAttributes: {
        label: 'Task',
        name: 'CreateTask',
        title: 'CreateTask',
        disabled: false,
        variant: 'brand',
        value: 'CreateTask',
    }}
];
export default class AccountListLwc extends LightningElement {
    @track lstAccounts;
    lstColumns = COLUMNS;
    @wire (fetchAccounts) getAccount;
    @track bShowModal = false;
    @track TaskShowModal = false;
    @track conObFirstName;
    @track conObLastName;
    @track conObPhone;
    @track conObEmail;
    @track conRecoreId;
    @track taskRecoreId;
    @track errorMsg;
    @track recId;
    @track picklistVal;
    @track picklistVal1;
    @track picklistVal2;
    @track selectedOption;
 
    @wire(SubjectPicklist, {uiObjectInfoApi: {'sobjectType' : 'Task'},
    selectPicklistApi: 'Subject'}) selectTargetValues;

    @wire(StatusPicklist, {uiObjectInfoApi: {'sobjectType' : 'Task'},
    selectPicklistApi: 'Status'}) selectTargetValues1;

    @wire(PriorityPicklist, {uiObjectInfoApi: {'sobjectType' : 'Task'},
    selectPicklistApi: 'Priority'}) selectTargetValues2;

    TaskHandleChange(event) {
        if(event.target.name == 'SubjectList'){
        this.picklistVal = event.target.value;
        }
        if(event.target.name == 'StatusList'){
            this.picklistVal1 = event.target.value;
        }
        if(event.target.name == 'PriorityList'){
            this.picklistVal2 = event.target.value;
        }

    }

    connectedCallback(){
        fetchAccounts().then(response => {
            this.lstAccounts = response;
            if(this.lstAccounts){
                this.lstAccounts.forEach(item => item['AccountURL'] = '/lightning/r/Account/' +item['Id'] +'/view');
                
            }
        }).catch(error => {
            console.log('Error: ' +error);
        });
    }
    handelRowAction(event){
        this.recId =  event.detail.row.Id;  
        const actionName = event.detail.action.name;  
        if ( actionName === 'delete' ) { 
            deleteRecord(this.recId) 
            .then(() =>{
        
               const toastEvent = new ShowToastEvent({
                   title:'Record Deleted',
                   message:'Record deleted successfully',
                   variant:'success',
               })
               this.dispatchEvent(toastEvent);
                
               fetchAccounts().then(response => {
                this.lstAccounts = response;
                if(this.lstAccounts){
                    this.lstAccounts.forEach(item => item['AccountURL'] = '/lightning/r/Account/' +item['Id'] +'/view');
                    
                }
            })
               
            })
            .catch(error =>{
                window.console.log('Unable to delete record due to ' + error.body.message);
            });
        }
        
        if(actionName === 'CreateContact'){
            this.bShowModal = true;
            this.recId = event.detail.row.Id;
            
        }
        if(actionName ==='CreateTask'){
            this.TaskShowModal = true;
            this.recId = event.target.row.Id;
        }

    }
    closeModal(){
        this.bShowModal = false;
    }
    closeModalTask(){
        this.TaskShowModal = false;
    }



    conHandleChange(event){
        
        if(event.target.name == 'conFirstName'){
        this.conObFirstName = event.target.value;  
        
        }
        if(event.target.name == 'conLastName'){
        this.conObLastName = event.target.value;  
        }

        if(event.target.name == 'conEmail'){
        this.conObEmail = event.target.value;  
        }
        if(event.target.name == 'conPhone'){
        this.conObPhone = event.target.value;  
        }
        if (event.target.name === 'optionSelect') {
            this.selectedOption = event.target.value;
                
             
        }
     
    }
    submitAction(){   
        //window.console.log('recId ##' + this.recId);
        submitScoreAction({cardFirstName:this.conObFirstName,cardLastName:this.conObLastName ,cardEmail:this.conObEmail,cardPhone:this.conObPhone, accId:this.recId})
        .then(result=>{
            this.conRecoreId = result.Id;
            window.console.log('scoreRecoreId##Vijay2 ' + this.conRecoreId);       
            const toastEvent = new ShowToastEvent({
                title:'Success!',
                message:'Record created successfully',
                variant:'success'
              });
              this.dispatchEvent(toastEvent);
              this.bShowModal = false;
              //alert("you have selected : " + this.selectedOption);
              if(this.selectedOption === 'Account'){
                window.location.href = '/lightning/r/'+this.selectedOption+'/'+this.recId+'/view';
              }
              else if(this.selectedOption ==='Contact'){
                window.location.href = '/lightning/r/'+this.selectedOption+'/'+this.conRecoreId+'/view';
              }
              else if(this.selectedOption === 'Task'){
                window.location.href = '';
              }
              else{
                window.location.href = '';
              }
    
        })
        .catch(error =>{
           this.errorMsg=error.message;
           window.console.log(this.error);
        });
    
    }

    
    submitActionTask(){
        newTaskCreated({subjectPick:this.picklistVal, statusPick:this.picklistVal1, priorityPick:this.picklistVal2, accId:this.recId})
        .then(result=>{
            this.taskRecoreId = result.Id;
            //window.console.log('scoreRecoreId##Vijay2 ' + this.conRecoreId);       
            const toastEvent = new ShowToastEvent({
                title:'Success!',
                message:'Record created successfully',
                variant:'success'
              });
              this.dispatchEvent(toastEvent);
              this.TaskShowModal = false;

              if(this.selectedOption === 'Account'){
                window.location.href = '/lightning/r/'+this.selectedOption+'/'+this.recId+'/view';
              }
              else if(this.selectedOption ==='Task'){
                window.location.href = '/lightning/r/'+this.selectedOption+'/'+this.taskRecoreId+'/view';
              }
              else if(this.selectedOption === 'Contact'){
                window.location.href = '';
              }
              else{
                window.location.href = '';
              }
    
        })
        .catch(error =>{
           this.errorMsg=error.message;
           window.console.log(this.error);
        });
    }
}