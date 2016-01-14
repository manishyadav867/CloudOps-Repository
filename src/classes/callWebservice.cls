public with sharing class callWebservice {
   
   public callWebservice(){
       string username = 'smita@personalorg.com';
       string password = 'accen@123';
       string sectoken = 'ni8o6UMlqXyHnXhuif5DHdIR2';
       string endpoint = 'https://ap2.salesforce.com/services/Soap/u/25.0/00De0000005VYFt';
       
       String metadataserverurl = 'https://ap2.salesforce.com/services/Soap/m/25.0/00De0000005VYFt';
       String serverUrl = 'https://ap2.salesforce.com/services/Soap/m/25.0/00De0000005VYFt';
       String sessionID = WebServiceCaller.loginToSFDC(username,password,sectoken,endpoint);
       String deploymentid = '0Af2800000EG0V2';
       
       String jsonResponse = WebServiceCaller.checkDeployResultSFDC(sessionid,serverurl,metadataserverurl,deploymentid);
   }
}