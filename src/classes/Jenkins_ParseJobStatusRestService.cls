@RestResource(urlMapping='/JobStatus/*')
global without sharing class Jenkins_ParseJobStatusRestService {
  
   @HttpGet
    global static String doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        System.debug('req.requestBody******'+req.requestBody);
        return 'Success';
    }
    
  @HttpPost
    global static String doPost() {
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        System.debug('req.requestBody******'+req.requestBody.toString());
        System.debug('req******'+req);
        System.debug('req.requestURI******'+req.requestURI);
        System.debug('req.requestParams******'+req.params);
        
        JSON2Apex_Clone jsonapex =  new JSON2Apex_Clone (System.JSON.createParser(req.requestBody.toString()));
        return 'Success';
    }
}