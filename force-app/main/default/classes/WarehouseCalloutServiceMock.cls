@isTest
global class WarehouseCalloutServiceMock implements HttpCalloutMock 
{
    // implement http mock callout
    global HttpResponse respond(HttpRequest respond)
    {
        System.assertEquals('https://th-superbadge-apex.herokuapp.com/equipment', 
        respond.getEndpoint());
        System.assertEquals('GET', respond.getMethod());

        //Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('content-type', 'text-xml');
        response.setBody('[{"_iD":"5002v00002R2QL1","replacement":false,"quantity":5,"name":"Generator 1000 kW","maintenanceperiod":365,"lifespan":120,"cost":5000,"sku":"100003"}]');
        response.setStatusCode(200);
        return response;
    }
}