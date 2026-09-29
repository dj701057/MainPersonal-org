import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class AccodianCheck extends LightningElement {
    @track accounts;
    isIconHidden = false; // Flag to prevent repeated execution

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error('Error fetching accounts:', error);
            this.accounts = null;
        }
    }

connectedCallback() {
    this.template.addEventListener('load', () => {
        const icons = this.template.querySelectorAll('lightning-primitive-icon');
        icons.forEach(icon => {
            icon.style.display = 'none';
        });
    });
}


    renderedCallback() {
        // Prevent repeated execution of this logic
        if (this.isIconHidden || !this.accounts) {
            return;
        }

        try {
            const accordionSections = this.template.querySelectorAll('lightning-accordion-section');

            if (accordionSections.length === 0) {
                console.log('No accordion sections found');
                return;
            }

            console.log('Accordion Sections:', accordionSections);

            accordionSections.forEach((section) => {
                if (section.shadowRoot) {
                    const iconElement = section.shadowRoot.querySelector('lightning-primitive-icon');
                    if (iconElement) {
                        iconElement.style.display = 'none'; // Hide the icon
                        console.log('Icon hidden for section:', section);
                    } else {
                        console.log('No icon found for section:', section);
                    }
                } else {
                    console.warn('Shadow root not accessible for section:', section);
                }
            });

            this.isIconHidden = true; // Mark as done
        } catch (error) {
            console.error('Error hiding icons:', error);
        }
    }
}