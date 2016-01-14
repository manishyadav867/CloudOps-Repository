global with sharing class WS_CustomSettingRetrieve {
	
	//constructor
	public WS_CustomSettingRetrieve(){}
	
	global responseWrapper retrieveCustomSetting(List<String> customSettingName){
		System.debug('customSettingName'+customSettingName);
		if(customSettingName.isEmpty()){
			return new responseWrapper(null,'Failed','No custom setting name found');
		}
		
		
		return null;
			
	}
	
	 
	global class customSettingField{
		String fieldName;
		String Value;
	}
	
	global class customSettingRecord{
		List<CustomSettingField> customSettingField;
	}
	
	global class customSettings{
		String customSettingName;
		List<CustomSettingRecord> customSettingRecord;	
	}
	
	
	global class responseWrapper{
		List<customSettings> customSettings;
		String status;
		String errorMsg;
		
		public responseWrapper(List<customSettings> customSettings,String status,string errorMsg){
			this.customSettings = customSettings;
			this.status = status;
			this.errorMsg = errorMsg;
		}
	}
}