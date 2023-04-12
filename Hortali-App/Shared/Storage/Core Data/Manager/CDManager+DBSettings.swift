/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData
import UIKit


extension CDManager {
    
    public func getCacheVersion() -> String? {
        let settingsData = self.getSettingsData()
        return settingsData?.version
    }
    
    
    public func updateCacheVersion(_ version: String) {
        self.settingsCDM.updateVersion(version)
    }
    
    
    public func getCacheLastUpdate() -> String? {
        let settingsData = self.getSettingsData()
        return settingsData?.lastUpdate
    }
    
    
    public func updateCacheLastUpdate() {
        let today = ""
        self.settingsCDM.updateLastUpdate(today)
    }
    
    
    public func checkIsFirstTime() -> Bool {
        let settingsData = self.getSettingsData()
        return settingsData?.isFirstTime ?? true
    }
    
    
    public func confirmOnBoardingHasShowed() {
        self.settingsCDM.updateOnBoardingViewed(isFirstTime: false)
    }
    
    
    
    /*  */
    
    private func getSettingsData() -> DBSettings? {
        let (settingsData, error) = self.settingsCDM.getSettingsData()
        
        if let error { print(error.developerWarning); return nil }
        return settingsData
    }
}
