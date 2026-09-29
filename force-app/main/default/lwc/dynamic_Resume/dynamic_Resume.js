import { LightningElement,track,api } from 'lwc';
import resume_logo from '@salesforce/resourceUrl/Resumelogo'
export default class Dynamic_Resume extends LightningElement {
    resumeLogoUrl=resume_logo;
    @api getShowContainer = false;
 
    showContainerData(event){
      this.getShowContainer = true;
      window.console.log('getShowContainer # ' + this.getShowContainer);
    }
 
    hideContainerData(event){
        this.getShowContainer = false;
      }
    
 


    
}