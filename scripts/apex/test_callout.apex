String jsonBody = '[{"userId": "005...", "fullName": "Test", "email": "test@test.com", "username": "testuser"}]'; 
try { 
    Integer code = RewardsCalloutService.submitUsersForRewardCallout(jsonBody); 
    System.debug('Response Code: ' + code); 
} catch (Exception e) { 
    System.debug('Error: ' + e.getMessage()); 
}
