public with sharing class CustomSettingRetieveUtil {
	public static List<WS_CustomSettingRetrieve.customSettings> returnCustomSetting(List<String> customSettingNames){
		System.debug('CustomSettingRetieveUtil->returnCustomSetting'+customSettingNames);
		if(customSettingNames.isEmpty()){
			return null;
		}		
		return null;	
	}
}