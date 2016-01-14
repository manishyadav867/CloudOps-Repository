public class JSON2Apex_Clone {
    public Jenkins_Job__c jenkinJobDetails = new Jenkins_Job__c();
    
    public static void consumeObject(JSONParser parser) {
        Integer depth = 0;
        do {
            JSONToken curr = parser.getCurrentToken();
            if (curr == JSONToken.START_OBJECT || 
                curr == JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == JSONToken.END_OBJECT ||
                curr == JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }
    
    /*
    public void insertJobDetails(){
        Jenkins_Job__c jenkinJobDetails = new Jenkins_Job__c();
        Build build = new Build();
        scm scm = new scm();
        
        jenkinJobDetails.name = name;
        jenkinJobDetails.Job_Name__c = name;
        jenkinJobDetails.Job_URL__c = url;
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
    */
    
    public class Artifacts {

        public Artifacts(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        {
                            System.debug(LoggingLevel.WARN, 'Artifacts consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public String name {get;set;} 
    public String url {get;set;} 
    public Build build {get;set;} 

    public JSON2Apex_Clone(JSONParser parser) {
        while (parser.nextToken() != JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != JSONToken.VALUE_NULL) {
                    if (text == 'name') {
                        name = parser.getText();
                    } else if (text == 'url') {
                        url = parser.getText();
                    } else if (text == 'build') {
                        build = new Build();
                        jenkinJobDetails = build.buildFunction(parser,jenkinJobDetails);
                    } else {
                        System.debug(LoggingLevel.WARN, 'Root consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
        jenkinJobDetails.name = name;
        jenkinJobDetails.Job_Name__c = name;
        jenkinJobDetails.Job_URL__c = url;
        insert jenkinJobDetails;
        System.debug('Job details****'+jenkinJobDetails);
    }
    
    public class Build {
        public String full_url {get;set;} 
        public Integer number_Z {get;set;} // in json: number
        public Integer queue_id {get;set;} 
        public String phase {get;set;} 
        public String status {get;set;} 
        public String url {get;set;} 
        public Scm scm {get;set;} 
        public String log {get;set;} 
        public Artifacts artifacts {get;set;} 
        
        public Build(){}
        public Jenkins_Job__c BuildFunction(JSONParser parser,Jenkins_Job__c jenkinJobDetails) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'full_url') {
                            full_url = parser.getText();
                        } else if (text == 'number') {
                            number_Z = parser.getIntegerValue();
                            jenkinJobDetails.Build_Number__c = number_Z;
                        } else if (text == 'queue_id') {
                            queue_id = parser.getIntegerValue();
                            jenkinJobDetails.queue_id__c = queue_id;
                        } else if (text == 'phase') {
                            phase = parser.getText();
                            jenkinJobDetails.Phase__c = phase;
                        } else if (text == 'status') {
                            status = parser.getText();
                            jenkinJobDetails.Status__c = status;
                        } else if (text == 'url') {
                            url = parser.getText();
                        } else if (text == 'scm') {
                            scm = new Scm();jenkinJobDetails = scm.ScmFunction(parser,jenkinJobDetails);
                        } else if (text == 'log') {
                            log = parser.getText();
                        } else if (text == 'artifacts') {
                            artifacts = new Artifacts(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Build consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        return jenkinJobDetails;
        }
    }
    
    public class Scm {
        public String url {get;set;} 
        public String branch {get;set;} 
        public String commit_Z {get;set;} // in json: commit
        
        public Scm(){}
        public Jenkins_Job__c ScmFunction(JSONParser parser,Jenkins_Job__c jenkinJobDetails) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'url') {
                            url = parser.getText();
                            jenkinJobDetails.scm__c = url;
                        } else if (text == 'branch') {
                            branch = parser.getText();
                            jenkinJobDetails.Git_Branch__c = branch;
                        } else if (text == 'commit') {
                            commit_Z = parser.getText();
                            jenkinJobDetails.Git_Commit_Id__c = commit_Z;
                        } else {
                            System.debug(LoggingLevel.WARN, 'Scm consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
            return jenkinJobDetails;
        }
    }
    
    
    public static JSON2Apex parse(String json) {
        return new JSON2Apex(System.JSON.createParser(json));
    }
}