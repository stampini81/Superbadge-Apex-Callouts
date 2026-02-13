@isTest
private class BillingCalloutServiceTest {
  @isTest static void testCallout() {
    // Setup
    Accessibility_Project__c proj = new Accessibility_Project__c(
        Amount__c = 100.00
    );
    insert proj;
    
    // Set Mock
    Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
    
    // Test
    Test.startTest();
    AccessibilityProjectBilling.callBillingService(proj.Id, proj.Amount__c);
    Test.stopTest();
    
    // Assert
    // Verify that the future method executed and updated the record.
    // Note: In a real unit test context, future methods run synchronously after Test.stopTest()
    proj = [SELECT Status__c FROM Accessibility_Project__c WHERE Id = :proj.Id];
    System.assertEquals('Complete', proj.Status__c, 'Project status should be updated to Complete after successful callout');
  }
}
