trigger ProjectTrigger on Accessibility_Project__c (after insert) {
    Set<Id> projIds = new Set<Id>();
    for (Accessibility_Project__c proj : Trigger.new) {
        if (proj.Amount__c != null) {
            projIds.add(proj.Id);
        }
    }
    if (!projIds.isEmpty()) {
        Database.executeBatch(new AccessibilityProjectBillingBatch(projIds), 100);
    }
}
