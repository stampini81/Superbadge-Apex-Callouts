@IsTest
global class RewardsCalloutServiceMock implements HttpCalloutMock {
    protected Integer code;
    protected String status;
    protected String body;

    global RewardsCalloutServiceMock(Integer code, String status, String body) {
        this.code = code;
        this.status = status;
        this.body = body;
    }

    // Default constructor for success case
    global RewardsCalloutServiceMock() {
        this.code = 201;
        this.status = 'Created';
        this.body = '{"status":"success"}';
    }

    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(this.code);
        res.setStatus(this.status);
        res.setBody(this.body);
        return res;
    }
}
