import { LightningElement } from "lwc";

export default class RecordPickerWithFilter extends LightningElement {
  matchingInfo = {
    primaryField: { fieldPath: "Name" },
    additionalFields: [{ fieldPath: "Title" }],
  };
  displayInfo = {
    additionalFields: ["Title"],
  };
  // filter Contacts having Accounts starting with "Madison"
  filter = {
    criteria: [
      {
        fieldPath: "Account.Name",
        operator: "like",
        value: "jaiswal%",
      },
    ],
  };

  handleChange(event) {
    console.log(`Selected record: ${event.detail.recordId}`);
  }
}