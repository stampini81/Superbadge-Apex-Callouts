public with sharing class RewardsCalloutService {
    public static Integer submitUsersForRewardCallout(String jsonBody) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setMethod('POST');
        req.setEndpoint('callout:IntegrationSB__BalancedLiving/rewards');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonBody);

        HttpResponse res = http.send(req);
        System.debug('RewardsCalloutService statusCode: ' + res.getStatusCode());
        return res.getStatusCode();
    }
}
