import { LightningElement, wire } from 'lwc';
import { getObjectInfos } from 'lightning/uiObjectInfoApi';

export default class ObjectListDropdown extends LightningElement {
    selectedObject;
    selectedIconName;
    objectList = [];

    @wire(getObjectInfos)
    wiredObjectInfos({ data, error }) {
        if (data) {
            this.objectList = Object.values(data).map(obj => ({
                label: obj.label,
                value: obj.apiName,
                icon: obj.themeInfo.iconUrl
            }));
        } else if (error) {
            console.log(error);
        }
    }

    handleChange(event) {
        const selectedObj = event.detail.value;
        this.selectedObject = selectedObj;
        this.selectedIconName = this.objectList.find(obj => obj.value === selectedObj).icon;
    }
}