import { LightningElement, wire, api, track } from "lwc";

import getfields from "@salesforce/apex/dynamicObjectList.getfields";

export default class TestComponent extends LightningElement {

 @track data1 = [];
  @track selected = [];
  @api value = "";
  @api fieldsValue = [];

 get selectFields() {
    return this.data1;
  }
  get selected() {
    return this.selected.length ? this.selected : "none";
  }		
		 @wire(getfields,{
		 objectname: 'Account'})
  wiredClass({ data, error }) {
    if (data) {
     let Testdata = JSON.parse(JSON.stringify(data));
        let lstOption = [];
      for (var i = 0;i < Testdata.length;i++) {
          lstOption.push({value: Testdata[i].QualifiedApiName,label: Testdata[i].DeveloperName
          });
        }
        this.data1 = lstOption;
        this.showLoadingSpinner = false;
    } else if (error) {
      this.error = error;
    }
  }
  
   handleSelectFields(event) {
    this.selected = event.detail.value;
    this.fieldsValue = event.detail.value;
    if(this.fieldsValue.length > 0 ){
      this.disableGetRecords = false;
    }else{
      this.disableGetRecords = true;
    }
    
  }
  
  }