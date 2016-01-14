public class insertJob{

public String jsonString1 = '{"name":"Test","url":"job/Test/","build":{"full_url":"http://localhost:8080/job/Test/23/","number":23,"queue_id":8,"phase":"FINALIZED","status":"SUCCESS","url":"job/Test/23/","scm":{"url":"https://github.com/manishyadav867/test2.git","branch":"origin/master","commit":"a8550c9e562f90c0ecb68a48a6d5bc39bad2872b"},"log":"","artifacts":{}}}';

public void insertJobDetails(String jsonString){
        JSONParser parser = JSON.createParser(jsonString);
        JSON2Apex jsonCls = new JSON2Apex(parser);

        Jenkins_Job__c jenkinJobDetails = new Jenkins_Job__c();
        JSON2Apex.Build build = new JSON2Apex.Build();
        JSON2Apex.scm scm = new JSON2Apex.scm();
        
        jenkinJobDetails.name = jsonCls.name;
        jenkinJobDetails.Job_Name__c = jsonCls.name;
        jenkinJobDetails.Job_URL__c = jsonCls.url;
        jenkinJobDetails.Build_Number__c = build.number_Z;
        jenkinJobDetails.Git_Branch__c = scm.branch;
        jenkinJobDetails.Git_Commit_Id__c = scm.commit_Z;
        jenkinJobDetails.Phase__c = build.phase;
        jenkinJobDetails.queue_id__c = build.queue_id;
        jenkinJobDetails.scm__c = scm.url;
        jenkinJobDetails.Status__c = build.status;
        
        insert jenkinJobDetails;
        System.debug('Job details****'+jenkinJobDetails);
    }
//jsonCls.insertJobDetails();

}