public with sharing class AccessibilityProjectBillingBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    private Set<Id> projectIds;

    public AccessibilityProjectBillingBatch(Set<Id> projectIds) {
        this.projectIds = projectIds;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Amount__c, Name 
            FROM Accessibility_Project__c 
            WHERE Id IN :projectIds
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Accessibility_Project__c> scope) {
        // Credenciais do Named Credential
        String username = '{!$Credential.BillingServiceCredential.username}';
        String password = '{!$Credential.BillingServiceCredential.password}';
        
        List<Accessibility_Project__c> projectsToUpdate = new List<Accessibility_Project__c>();

        for (Accessibility_Project__c proj : scope) {
            try {
                BillingServiceProxy.BillingServiceSoap proxy = new BillingServiceProxy.BillingServiceSoap();
                // Chamada do método do serviço SOAP
                String result = proxy.submitBilling(
                    String.valueOf(proj.Id),
                    proj.Amount__c,
                    username,
                    password
                );
                
                if (result != null && result.equalsIgnoreCase('Success')) {
                     // Determine success logic if any update is needed, e.g. status update
                     // logic not specified in initial code, assuming logging or no-op ok
                }
                
                System.debug('SOAP Billing Service result: ' + result);
            } catch(Exception e) {
                System.debug('Erro no callout SOAP: ' + e.getMessage());
            }
        }
    }

    public void finish(Database.BatchableContext bc) {
        // Optional: Send email or log completion
    }
}
