import { LightningElement,track ,wire} from 'lwc';
import getProfiles from '@salesforce/apex/PicklistHelper.getProfiles';
import getAllfields from '@salesforce/apex/PicklistHelper.getAllfields';

export default class DynamicTableAssignment extends LightningElement {
    profileOptionsList;
    selectedProfile;
    getAllfieldsList;
    selectedAllFields;
    @track openModal = false;
    showModal() {
        this.openModal = true;
        
    }
    closeModal() {
        this.openModal = false;
    }
    get options(){
        return[
            
            
        ]
    }

    
    @wire(getProfiles) 
    retrieveProfiles({error,data}){
        let tempArray = [];
        if(data){
            for(let key in data){
                tempArray.push({label:data[key],value:key});
            }
        }
        this.profileOptionsList=tempArray;
    }

    handleProfileChange(event){
        this.selectedProfile = event.target.value;
        this.template.querySelector("[data-id='selectId']").value = this.selectedProfile;
    }

    handleChange(event){
        this.value=event.detail.value;

    }
    @wire(getAllfields)
    retrieveAllFields({data}){
        let tempArray2 = [];
        if(data){
            for(let key2 in data){
                tempArray2.push({label:data[key2],value:key2});
            }
        }
        this.getAllfieldsList = tempArray2;
    }
    handleProfileChange(event){
        this.selectedAllFields = event.target.value;
        this.template.querySelector("[data-id='selectId']").value = this.selectedAllFields;
    }
    handleGetProfiles(e){
        this.selectedAllFields=e.target.value;
    }
    showForm = false;
    newRecord () {
        this.showForm = true
    }
}