@IsTest
private class WellnessJourneyRewardsBatchTest {
    @IsTest
    static void testBatchEligibleUser() {
        User u = [SELECT Id FROM User WHERE IsActive = true LIMIT 1];
        
        // Use a date in the previous quarter
        Date previousQuarterDate = Date.today().addMonths(-3);
        
        List<Wellness_Journey__c> journeys = new List<Wellness_Journey__c>();
        for (Integer i = 0; i < 12; i++) {
            journeys.add(new Wellness_Journey__c(
                Name = 'Journey ' + i,
                OwnerId = u.Id,
                Status__c = 'Complete',
                Completion_Date__c = previousQuarterDate
            ));
        }
        insert journeys;
        
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock(201, 'Created', '{"status":"success"}'));
        
        Test.startTest();
        // Scope 200 is fine, 1 is also fine but 200 is more standard
        Database.executeBatch(new WellnessJourneyRewardsBatch(), 200);
        Test.stopTest();
    }

    @IsTest
    static void testBatchNotEligibleUser() {
        User u = [SELECT Id FROM User WHERE IsActive = true LIMIT 1];
        
        Date previousQuarterDate = Date.today().addMonths(-3);
        
        List<Wellness_Journey__c> journeys = new List<Wellness_Journey__c>();
        for (Integer i = 0; i < 5; i++) {
            journeys.add(new Wellness_Journey__c(
                Name = 'Journey ' + i,
                OwnerId = u.Id,
                Status__c = 'Complete',
                Completion_Date__c = previousQuarterDate
            ));
        }
        insert journeys;
        
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock(201, 'Created', '{"status":"success"}'));
        
        Test.startTest();
        Database.executeBatch(new WellnessJourneyRewardsBatch(), 200);
        Test.stopTest();
    }

    @IsTest
    static void testBatchFinish() {
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        Test.startTest();
        batch.finish(null);
        Test.stopTest();
    }
}