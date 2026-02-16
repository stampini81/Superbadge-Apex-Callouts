@isTest
global class BillingCalloutServiceMock implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNamespace,
        String responseName,
        String responseType
    ) {
        // Cria o elemento de resposta do proxy gerado por WSDL2Apex
        BillingServiceProxy.billProjectResponse_element resp =
            new BillingServiceProxy.billProjectResponse_element();
        resp.status = 'Complete';

        // Chave obrigatória que o proxy usa internamente
        response.put('response_x', resp);
    }
}
