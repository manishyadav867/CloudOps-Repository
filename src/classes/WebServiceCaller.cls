public class WebServiceCaller {
 
    public WebServiceCaller(){}
 
        public static String loginToSFDC(String username, String password, String sectoken, String endpointurl){
        String req = '';
        req += '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:partner.soap.sforce.com">';
        req +=   '<soapenv:Header>';
        //req +=      '<sch:API-KEY>'+API_KEY+'</sch:API-KEY>';
        //req +=   '<met:SessionHeader>';
        //req +=   '<met:sessionId>00De0000005VYFt!AQUAQC_VQO5c46E8WvwwXawplR660Mqcc2p21YgJd4vK6DkRon6h.XpVfxJ6JLcXPYUoCAblmrNVSc.dwB6FmNiTj1f3Wk8q</met:sessionId>';
        //req +=   '</met:SessionHeader>';
        req +=   '</soapenv:Header>';
        req +=   '<soapenv:Body>';
        req +=   '<urn:login>';
        req +=   '<urn:username>' + username + '</urn:username>';  
        req +=   '<urn:password>' + password + sectoken + '</urn:password>';  
        req +=   '</urn:login>';   
        req +=   '</soapenv:Body>';
        req += '</soapenv:Envelope>';
 
        Http h = new Http();
        HttpRequest reqhttp = new HttpRequest();
        reqhttp.setMethod('POST');
        reqhttp.setHeader('Accept-Encoding','gzip,deflate');
        reqhttp.setHeader('Content-Type','text/xml;charset=UTF-8');
        reqhttp.setHeader('SOAPAction', endpointurl); //'https://dcpn--DEVh.cs15.my.salesforce.com/services/Soap/u/25.0/00De0000005VYFt'
        reqhttp.setHeader('User-Agent','Jakarta Commons-HttpClient/3.1');
 
 
        /*Blob headerValue = Blob.valueOf(USERNAME + ':' + PASSWORD);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        */
        reqhttp.setEndpoint(endpointurl); //'https://dcpn--DEVh.cs15.my.salesforce.com/services/Soap/u/25.0/00De0000005VYFt'
 
        String requestString = req;
 
        reqhttp.setHeader('Content-Length',String.valueOf(requestString.length()));
 
        reqhttp.setBody(requestString);
        HttpResponse res = h.send(reqhttp);
        string bodyRes=res.getBody();
         Map<String,String> responseInfo = parseXML(bodyRes);
        System.debug('**** HTTP RESPONSE : ' + bodyRes);
        return responseInfo.get('sessionId');
    }
 
    public static String checkDeployResultSFDC(String sessionid, String serverurl, String metadataserverurl, String deploymentid){
 
        String req = '';
        req += '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:met="http://soap.sforce.com/2006/04/metadata">';
        req +=   '<soapenv:Header>';
        //req +=      '<sch:API-KEY>'+API_KEY+'</sch:API-KEY>';
        req +=   '<met:SessionHeader>';
        //req +=   '<met:sessionId>00De0000005VYFt!AQUAQC_VQO5c46E8WvwwXawplR660Mqcc2p21YgJd4vK6DkRon6h.XpVfxJ6JLcXPYUoCAblmrNVSc </met:sessionId>'; // replace by sessionid
        req += '<met:sessionId>'+sessionid+'</met:sessionId>';
        req +=   '</met:SessionHeader>';
        req +=   '</soapenv:Header>';
        req +=   '<soapenv:Body>';
        req +=      '<met:checkStatus>';
        //req +=         '<met:asyncProcessId>0Afe000000GvQyACAV</met:asyncProcessId>';   // replace by deploymentid
        req += '<met:asyncProcessId>'+deploymentid+'</met:asyncProcessId>';
        req +=      '</met:checkStatus>';
        req +=      '</soapenv:Body>';
        req += '</soapenv:Envelope>';
 
        Http h = new Http();
        HttpRequest reqhttp = new HttpRequest();
        reqhttp.setMethod('POST');
        reqhttp.setHeader('Accept-Encoding','gzip,deflate');
        reqhttp.setHeader('Content-Type','text/xml;charset=UTF-8');
        //reqhttp.setHeader('SOAPAction', 'https://dcpn--DEVh.cs15.my.salesforce.com/services/Soap/m/25.0/00De0000005VYFt');      // replace by metadataserverurl
        reqhttp.setHeader('SOAPAction',metadataserverurl);
        reqhttp.setHeader('User-Agent','Jakarta Commons-HttpClient/3.1');
 
 
        /*Blob headerValue = Blob.valueOf(USERNAME + ':' + PASSWORD);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        */
        //reqhttp.setEndpoint('https://dcpn--DEVh.cs15.my.salesforce.com/services/Soap/m/25.0/00De0000005VYFt');
         reqhttp.setEndpoint(serverurl);
        String requestString = req;
 
        reqhttp.setHeader('Content-Length',String.valueOf(requestString.length()));
 
        reqhttp.setBody(requestString);
        HttpResponse res = h.send(reqhttp);
        string bodyRes=res.getBody();
        
        Map<String,String> responseInfo = parseXML(bodyRes);
        String jsonResponse = JSON.serialize(responseInfo);
       
        System.debug('**** HTTP XML RESPONSE : ' + bodyRes);
        System.debug('**** HTTP JSON RESPONSE : ' + jsonResponse); 
        return jsonResponse;
 
    }
 
        public class LoginResponse{
                String sessionid;
                String serverurl;
                //… all other login response attributes
       
        }
        
    public static Map<String,String> parseXML(String responseXML){
        
        System.debug('responseXML*****'+responseXML);
        
        Map<String,String> responseInfo=new Map<String,String>();
        
        Dom.Document doc = new Dom.Document();
        
        doc.load(responseXML);
        
        Dom.XMLNode Envelope = doc.getRootElement();
        
        Dom.XMLNode Body= Envelope.getChildElements()[0];
        
        for(Dom.XMLNode child : Body.getChildElements()[0].getChildElements()[0].getChildElements()) {
        
            responseInfo.put(child.getName(),child .getText());
        
        }
        System.debug('response Info ****'+responseInfo);
        
        return responseInfo;
   }
 
}