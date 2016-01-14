public with sharing class ParseXML {

public String responseXML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="http://soap.sforce.com/2006/04/metadata"><soapenv:Body><deployResponse><result><checkOnly>true</checkOnly><done>false</done><id>0Afe000000GvYANCA3</id><numberComponentErrors>0</numberComponentErrors><numberComponentsDeployed>0</numberComponentsDeployed><numberComponentsTotal>0</numberComponentsTotal><numberTestErrors>0</numberTestErrors><numberTestsCompleted>0</numberTestsCompleted><numberTestsTotal>0</numberTestsTotal><state>Queued</state><stateDetailLastModifiedDate>2016-01-13T10:38:01.403Z</stateDetailLastModifiedDate></result></deployResponse></soapenv:Body></soapenv:Envelope>';

public List<String> ParseXML(){
	
	System.debug('responseXML*****'+responseXML);
	
	Map<String,String> responseInfo=new Map<String,String>();
	
	Dom.Document doc = new Dom.Document();
	
	doc.load(responseXML);
	
	Dom.XMLNode Envelope = doc.getRootElement();
	
	Dom.XMLNode Body= Envelope.getChildElements()[0];
	
	for(Dom.XMLNode child : Body.getChildElements()) {
	
		responseInfo.put(child.getName(),child .getText());
	
	}
	System.debug('response Info ****'+responseInfo);
	//return responseInfo;
	return null;
}
}