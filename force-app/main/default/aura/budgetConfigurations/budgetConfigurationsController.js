({
    doInit : function(component, event, helper) {
        console.log(' doInit -> ');                
        var action = component.get("c.fetchDetails");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var wrapperData = response.getReturnValue();
                component.set("v.userRecords", wrapperData.userRecords);
                component.set("v.clientRatingOptions", wrapperData.clientRatingOptions);
                component.set("v.tradeCategoryOptions", wrapperData.tradeCategoryOptions);
                component.set("v.industryOptions", wrapperData.industryOptions);
                component.set("v.stateOptions", wrapperData.stateOptions);
                var clientRatingOptions = [];
                for (var i = 0; i < wrapperData.clientRatingOptions.length; i++) {
                    clientRatingOptions.push({
                        value: wrapperData.clientRatingOptions[i],
                        label: wrapperData.clientRatingOptions[i]
                    });
                }
                component.set("v.clientRatingOptions", clientRatingOptions);
            }
        });
        $A.enqueueAction(action);
    },
    
    
    handlePicklistChange : function(component, event, helper) {
        var selectedUserId = component.find("picklist").get("v.value");
        component.set("v.selectedUserId", selectedUserId);
        console.log('selectedUserId	-> ',selectedUserId );
    },
    
    
    handleDateChange : function(component, event, helper) {
        var inputName = event.getSource().get("v.name");
        var inputValue = event.getSource().get("v.value");
        console.log(inputName, ' ->  ',inputValue );
        if (inputName === "startDate") {
            var startDate = component.get("v.startDate");
            var finishDate = component.get("v.finishDate");
            if (finishDate && startDate > finishDate) {
                component.set("v.finishDate", startDate);
                component.set("v.warningMessage", "Finish date cannot be before start date.");
            } else {
                component.set("v.warningMessage", "");
            }   
        } else if (inputName === "finishDate") {
            var startDate = component.get("v.startDate");
            var finishDate = component.get("v.finishDate");
            if (startDate && startDate > finishDate) {
                component.set("v.startDate", finishDate);
                component.set("v.warningMessage", "Start date cannot be after finish date.");
            } else {
                component.set("v.warningMessage", "");
            }
        } else if (inputName === "currency"){
            component.set("v.currencyValue", inputValue);
        }
    },
    
    
    handleInputChange: function(component, event, helper) {
        var changedValue = event.getSource().get("v.value");
        var monthName = event.getSource().get("v.name");
        console.log("Changed value: ", changedValue);
        console.log("Month value: ", monthName);
    },
    
    
    handleClientRatingChange: function(component, event, helper) {
        event.preventDefault();
        var selectedClientRatingValue = event.getParam("value");
        console.log('selectedClientRatingValue -> ', selectedClientRatingValue);
        
        var picklistAuraId = event.getSource().getLocalId();
        var index = picklistAuraId.split('_')[1];
        
        var clientRatingOptions = component.get('v.clientRatingOptions');
        clientRatingOptions = clientRatingOptions.filter(option => option.value !== selectedClientRatingValue);
        component.set('v.clientRatingOptions', clientRatingOptions);
    },
    
    
    
    
    
    handleTradeCategoryChange : function(component, event, helper) {
        var selectedTradeCategoryValue = component.find("tradeCategory").get("v.value");
        console.log('selectedTradeCategoryValue	-> ',selectedTradeCategoryValue );
    },
    
    
    handleIndustryChange : function(component, event, helper) {
        var selectedIndustryValue = component.find("industry").get("v.value");
        console.log('selectedIndustryValue	-> ',selectedIndustryValue );
    },
    
    
    handleStateChange : function(component, event, helper) {
        var selectedStateValue = component.find("state").get("v.value");
        console.log('selectedStateValue	-> ',selectedStateValue );
    },
    
    addRowOnClientRating : function(component, event, helper) {
        var rows = component.get("v.rowsClientRating");
        rows.push({});
        component.set("v.rowsClientRating", rows);
    },
    
    addRowOnTradeCategory : function(component, event, helper) {
        var rows = component.get("v.rowsTradeCategory");
        rows.push({});
        component.set("v.rowsTradeCategory", rows);
    },
    
    addRowOnIndustry : function(component, event, helper) {
        var rows = component.get("v.rowsIndustry");
        rows.push({});
        component.set("v.rowsIndustry", rows);
    },
    
    addRowOnState : function(component, event, helper) {
        var rows = component.get("v.rowsState");
        rows.push({});
        component.set("v.rowsState", rows);
    },
})