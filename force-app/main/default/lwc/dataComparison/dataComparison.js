import { LightningElement, track } from 'lwc';
import fetchSalesforceData from '@salesforce/apex/YourApexClass.fetchSalesforceData';
import fetchComData from '@salesforce/apex/YourApexClass.fetchComData';

export default class DataComparison extends LightningElement {
    @track searchValue = '';
    @track salesforceData = [];
    @track comData = [];

    // Computed property to check if searchValue is empty
    get isSearchValueEmpty() {
        return this.searchValue.trim() === '';
    }

    handleSearchInputChange(event) {
        this.searchValue = event.target.value;
    }

    handleSearch() {
        if (this.isSearchValueEmpty) {
            // Do not proceed with search if input is empty
            return;
        }
        this.fetchSalesforceRecords();
        this.fetchComRecords();
    }

    fetchSalesforceRecords() {
        fetchSalesforceData({ searchKey: this.searchValue })
            .then(result => {
                this.salesforceData = result;
            })
            .catch(error => {
                console.error('Error fetching Salesforce data:', error);
                this.salesforceData = [];
            });
    }

    fetchComRecords() {
        fetchComData({ searchKey: this.searchValue })
            .then(result => {
                this.comData = result;
            })
            .catch(error => {
                console.error('Error fetching COM data:', error);
                this.comData = [];
            });
    }

    handleModify() {
        // Logic for modifying records can be implemented here
    }
}