import { LightningElement,track } from 'lwc';
export default class ConditionalRendering extends LightningElement {
    @track isVisible = false
    handleClick(){
        this.isVisible = !this.isVisible
    }
    handleClick2(){
        this.isVisible = !this.isVisible
    }
}