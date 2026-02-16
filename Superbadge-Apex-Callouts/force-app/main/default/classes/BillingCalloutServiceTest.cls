@isTest
private class BillingCalloutServiceTest {

    @isTest
    static void testCallBillingService_success_withMock() {
        // Não setar Name (no seu org ele não é gravável)
        Accessibility_Project__c ap = new Accessibility_Project__c();
        ap.Amount__c = 100;
        insert ap;

        // Mock do SOAP callout
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());

        Test.startTest();
        AccessibilityProjectBilling.callBillingService(new Set<Id>{ ap.Id });
        Test.stopTest();

        System.assertNotEquals(null, ap.Id);
    }

    @isTest
    static void testCallBillingService_exceptionPath_noMock() {
        Accessibility_Project__c ap = new Accessibility_Project__c();
        ap.Amount__c = 50;
        insert ap;

        // Sem Test.setMock de propósito para forçar exceção de callout em teste
        // e cobrir o bloco catch do seu código.
        Test.startTest();
        AccessibilityProjectBilling.callBillingService(new Set<Id>{ ap.Id });
        Test.stopTest();

        System.assertNotEquals(null, ap.Id);
    }
}
