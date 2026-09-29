({
	 init: function(component, event, helper) {
        var action = component.get("c.getUsers");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var users = response.getReturnValue();
                console.log("users"+users);
                var userOptions = [];
                for (var i = 0; i < users.length; i++) {
                    userOptions.push({
                        value: users[i].Id,
                        label: users[i].Name
                    });
                }
                console.log("userOptions"+userOptions);
                component.set("v.userOptions", userOptions);
                console.log("James component bc TMKC 3 baar!!!!");
            } else {
                console.log("Failed to retrieve users");
            }
        });
        $A.enqueueAction(action);
    },
    
    handleSelection: function(component, event, helper) {
        var selectedUserId = component.get("v.selectedUserId");
        console.log("Selected User ID:", selectedUserId);
        // You can add further logic here based on the selected user
    }
    
})