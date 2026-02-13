global class AccessibilityProjectBilling{
    
    @future(callout=true)
    public static void callBillingService(String projectId, Decimal billingAmount){
        BillingServiceProxy.project project = new BillingServiceProxy.project();
        project.username = '{!$Credential.IntegrationSB__BillingInvoiceService.username}';
        project.password = '{!$Credential.IntegrationSB__BillingInvoiceService.password}';
        project.projectid = projectId;
        project.billAmount = billingAmount;
        
        BillingServiceProxy.InvoicesPortSoap11 soap = new BillingServiceProxy.InvoicesPortSoap11();
        String response = soap.billProject(project);
        
        if(response != null && response.equalsIgnoreCase('ok')){
            Accessibility_Project__c accProject = [SELECT Id, Status__c FROM Accessibility_Project__c WHERE Id = :projectId];
            accProject.Status__c = 'Complete';
            update accProject;
        }
    }
}