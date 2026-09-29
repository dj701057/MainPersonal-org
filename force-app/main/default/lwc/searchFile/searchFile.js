import { LightningElement,track,api,wire} from 'lwc';
export default class SearchFile extends LightningElement {
    @track chooseOptionName = '';
    @track sizeofOptionList;
    @track contentDoc = [];
   // userId = Id;
    @track searchKey ='';
    columns = cols;
    
    handleSearch(event){
        this.searchKey = event.target.value;
        if(this.searchKey === ''){
            this.getFile();
        }
    
    }
    
    handleSearchButton(){
    
        if(this.contentDoc.length >0 && this.searchKey !=''){
           console.log('this is search key',this.searchKey);
           let doc = this.filterObj(this.contentDoc,this.searchKey);
           console.log('This is Content doc',this.doc);
        }
    }
    
    filterObj(arrayOfObject,string){
        Console.log('I am in filter',arrayOfObject);
        return arrayOfObject.filter(obj => 
            Object.keys(obj).some(k => obj[k].toLowerCase().includes(string.toLowerCase())));
    
    }
    
    handleEmpty(event){
        console.log('Close box is clicked');
    }
    
    handleOptionClick(event){
       this.chooseOptionName = event.target.text;
       console.log(this.chooseOptionName);
       if(this.chooseOptionName.includes("Owned")){
           this.getFile();
       }
    }
    
    getFile(){
        getFileOwned({userId : this.userId})
               .then(result => {
                   if(result.length >0){
                   const contentList = result;
                   this.sizeofOptionList = result.length;
                   console.log('This is Option List size ',this.sizeofOptionList);
                   let ownerName;
                   let titleUrl;
                   this.contentDoc = contentList.map(row => {
                   
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
    
    get content (){
        if(this.contentDoc){
            return true;
        }
    }
}