public class RewardsCalloutService{

    public static Integer submitUsersForRewardCallout(String jsonBody) {
        //Set Endpoint from Named Credential
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:IntegrationSB__BalancedLiving/rewards');
        req.setMethod('POST');

        req.setBody(jsonBody);
        
        //Make HTTP Callout
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        //Update to return response status code
        return res.getStatusCode();
    }
}