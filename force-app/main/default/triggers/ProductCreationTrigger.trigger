trigger ProductCreationTrigger on Product2 (after insert) {
    
    public static void createPricebookEntries(List<Product2> newProducts) {
        List<PricebookEntry> pricebookEntriesToInsert = new List<PricebookEntry>();
        System.debug('Creating Pricebook Entries for new Products');

        // Get the Standard Pricebook Id
        Id standardPricebookId = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1].Id;
        System.debug('Standard Pricebook Id: ' + standardPricebookId);

        for (Product2 newProduct : newProducts) {
            // Check if the product is active
            if (newProduct.IsActive) {
                // Create a new PricebookEntry for the Standard Pricebook
                PricebookEntry newPricebookEntry = new PricebookEntry(
                    Pricebook2Id = standardPricebookId,
                    Product2Id = newProduct.Id,
                    UnitPrice = 10, 
                    IsActive = true
                );
                System.debug('New Pricebook Entry: ' + newPricebookEntry);

                pricebookEntriesToInsert.add(newPricebookEntry);
            }
        }

        // Insert the PricebookEntry records
        if (!pricebookEntriesToInsert.isEmpty()) {
            insert pricebookEntriesToInsert;
            System.debug('Pricebook Entries Inserted: ' + pricebookEntriesToInsert);
        }
    }

    // Trigger handler for after insert
    public static void afterInsertHandler(List<Product2> newProducts) {
        System.debug('After Insert Handler Triggered');
        createPricebookEntries(newProducts);
    }

    // Trigger entry point
    public void onAfterInsert(List<Product2> newProducts) {
        System.debug('After Insert Triggered');
        afterInsertHandler(newProducts);
    }
}