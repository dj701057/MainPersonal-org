import { LightningElement } from 'lwc';
import PARSER from '@salesforce/resourceUrl/papaParse';
import { loadScript } from 'lightning/platformResourceLoader';
export default class AccountBulkUpload extends LightningElement {
    parserInitialized = false;
    renderedCallback () {
        if (!this.parserInitialized) {
            loadScript(this, PARSER).then(() => {
                console.log('parser loaded');
                this.parserInitialized = true;
                console.log('parser status',this.parserInitialized);
            }).catch((error) => {
                console.error('Failed to load PapaParse:', error);
            });
        }
    }

    parseFile(file) {
        console.log('parseFile');
        console.log(file);
        return new Promise((resolve) => {
            Papa.parse(file, {
                quoteChars: '"',
                delimiter: ',', //additional 
                header: true,
                skipEmptyLines: true,
                complete: function (results) {
                    console.log(results);
                    resolve(results);
                }
            })
        })
    }

    handleCsvUpload(event) {
        const file = event.target.files[0];
        if (file) {
            this.parseFile(file)
                .then((data) => {
                    console.log('Parsed data:', data);
                })
                .catch((error) => {
                    console.error('Error parsing file:', error);
                });
        } else {
            console.error('No file selected.');
        }
    }
}