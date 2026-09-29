import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub' ; 
export default class PubClass extends LightningElement {
    handleClick(){
        window.console.log('Event Firing..... ');
        let message = {
            "message" : 'Hello PubSub'
        }
        pubsub.fire('simplevt', message );
        window.console.log('Event Fired ');
    }
}