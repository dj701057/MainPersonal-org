import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

const columns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    // Add more fields as needed
];

export default class Datatable extends LightningElement {
    @track data = [];
    @track columns = columns;
    @track currentPage = 0;
    @track pageSize = 10;
    @track totalRecords;
    @track isFirstPage = true;
    @track isLastPage = false;
    @track isNightMode = false;

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.totalRecords = data.length;
            this.data = this.paginate(data);
            this.isLastPage = this.totalRecords <= this.pageSize;
        } else if (error) {
            console.error(error);
        }
    }

    paginate(records) {
        return records.slice(this.currentPage * this.pageSize, (this.currentPage + 1) * this.pageSize);
    }

    previousPage() {
        this.currentPage--;
        this.isFirstPage = this.currentPage === 0;
        this.isLastPage = false;
        this.data = this.paginate(this.wiredAccounts.data);
    }

    nextPage() {
        this.currentPage++;
        this.isFirstPage = false;
        this.isLastPage = (this.currentPage + 1) * this.pageSize >= this.totalRecords;
        this.data = this.paginate(this.wiredAccounts.data);
    }

    toggleMode() {
        this.isNightMode = !this.isNightMode;
        this.template.querySelector('.lgc-bg').classList.toggle('night-mode', this.isNightMode);
    }
}