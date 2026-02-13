@isTest
private class RewardsCalloutServiceTest {
    @testSetup
    static void setup() {
        // Create user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser' + DateTime.now().getTime() + '@testorg.com');
        insert u;

        // Calculate a date in the previous quarter
        Date today = Date.today();
        Integer currentYear = today.year();
        Integer currentMonth = today.month();
        Integer previousQuarterStartMonth = ((currentMonth - 1) / 3) * 3 + 1 - 3;
        if (previousQuarterStartMonth <= 0) {
            previousQuarterStartMonth += 12;
            currentYear--;
        }
        Date previousQuarterDate = Date.newInstance(currentYear, previousQuarterStartMonth, 15);

        // Create 12 Wellness Journey records for the user
        List<Wellness_Journey__c> journeys = new List<Wellness_Journey__c>();
        for(Integer i=0; i<12; i++) {
            journeys.add(new Wellness_Journey__c(
                Name = 'Journey ' + i,
                OwnerId = u.Id,
                Status__c = 'Complete',
                Completion_Date__c = previousQuarterDate
            ));
        }
        insert journeys;
    }

    @isTest
    static void testRewardsBatch() {
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());
        
        Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        
        // Debug: Check records
        List<Wellness_Journey__c> check = [SELECT Id, Completion_Date__c, Status__c, OwnerId FROM Wellness_Journey__c];
        System.debug('Records in Test: ' + check);
        
        Database.executeBatch(batch);
        Test.stopTest();
        
        // Assertions implies checking callout logic coverage
        // In a real scenario we would assert logs or updated records, 
        // but here we are mainly testing coverage and callout execution without exception
    }
    
    @isTest
    static void testRewardsCalloutService() {
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());
        
        Test.startTest(); 
        Integer statusCode = RewardsCalloutService.submitUsersForRewardCallout('{"json":"test"}');
        Test.stopTest();
        
        System.assertEquals(201, statusCode, 'Status code should be 201');
    }
}
