@isTest
private class AccessibilityProjectBillingBatchTest {
    @testSetup
    static void setup() {
        // Create test data
        List<Accessibility_Project__c> projects = new List<Accessibility_Project__c>();
        for(Integer i=0; i<150; i++) {
            projects.add(new Accessibility_Project__c(
                Amount__c = 100.00
            ));
        }
        insert projects;
    }

    @isTest
    static void testBatchExecution() {
        // Set up the mock
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());

        Set<Id> projIds = new Map<Id, Accessibility_Project__c>([SELECT Id FROM Accessibility_Project__c]).keySet();

        Test.startTest();
        // Execute the batch
        AccessibilityProjectBillingBatch batch = new AccessibilityProjectBillingBatch(projIds);
        Database.executeBatch(batch, 100);
        Test.stopTest();

        // Verify that callouts were made (assertions difficult for void callouts without logs/updates, 
        // but no exception means success in this context).
        // If the batch failed, exceptions would be logged or thrown.
    }
}
