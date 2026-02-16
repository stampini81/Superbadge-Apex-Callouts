public with sharing class AccessibilityProjectBilling {
    @future(callout=true)
    public static void callBillingService(Set<Id> projectIds) {

        List<Accessibility_Project__c> projs = [
            SELECT Id, Amount__c
            FROM Accessibility_Project__c
            WHERE Id IN :projectIds
        ];

        BillingServiceProxy.InvoicesPortSoap11 proxy =
            new BillingServiceProxy.InvoicesPortSoap11();

        for (Accessibility_Project__c proj : projs) {
            try {
                BillingServiceProxy.project p = new BillingServiceProxy.project();
                p.projectid  = (String) proj.Id;
                p.billAmount = (proj.Amount__c == null) ? 0 : (Double) proj.Amount__c;

                // Merge fields exigidos pelo desafio
                p.username = '{!$Credential.BillingServiceCredential.username}';
                p.password = '{!$Credential.BillingServiceCredential.password}';

                String status = proxy.billProject(p);
                System.debug('SOAP status: ' + status);
            } catch (Exception e) {
                System.debug('Erro no callout SOAP: ' + e.getMessage());
            }
        }
    }
}
