import { LightningElement, track } from 'lwc';
import fetchApexClass from '@salesforce/apex/SearchaApexClassExplorerController.fetchApexClass';

const DELAY = 50;
export default class SearchApexClass extends LightningElement {
    @track apexClasses;
    error;

    handleKeyChange(event) {
        // Debouncing this method: Do not actually invoke the Apex call as long as this function is
        // being called within a delay of DELAY. This is to avoid a very large number of Apex method calls.
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout = setTimeout(() => {
            fetchApexClass({ searchKey: searchKey })
                .then((result) => {
                    result.forEach(element => {
                        element.showCode = false;
                    });
                    this.apexClasses = result;
                    this.error = undefined;
                })
                .catch((error) => {
                    this.error = error;
                    this.apexClasses = undefined;
                });
        }, DELAY);
    }

    handleView(event) {
        const dataid = event.target.dataset.id;
        console.log('dataid::',dataid);
        this.apexClasses = this.apexClasses.map(x => {
            if (x.Id == dataid) {
                x.showCode = true;
            }
            return x;
        });
    }

    handleHide(event) {
        const dataid = event.target.dataset.id;
        this.apexClasses = this.apexClasses.map(x => {
            if (x.Id == dataid) {
                x.showCode = false;
            }
            return x;
        });
    }

    handleEdit(event) {
        const url = window.location.origin + '/lightning/setup/ApexClasses/page?address=%2F' + event.target.dataset.url;
        console.log('url::',url);
        console.log('url::',event.target.dataset.url);
        console.log('url::',window.location.origin);
        window.open(url);
    }
}