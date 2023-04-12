/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import CoreData
import UIKit


class CDManager: NSObject, CoreDataProperties {
    
    /* MARK: - Atributos */
    
    static let shared = CDManager()
    
    
    
    /* Managers */
    
    lazy var settingsCDM = SettingsCDM()

    
    
    /* MARK: - Construtor */
    
    override private init() {
        super.init()
        self.setupProtocols()
    }
    
    
    
    /* MARK: - CoreDataProperties */
    
    internal var mainContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    
    internal lazy var container: NSPersistentContainer = {
        let coreDataFileName = "DataBase"
        let container = NSPersistentContainer(name: coreDataFileName)
        container.loadPersistentStores() {_, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    
    internal func saveContext() throws -> ErrorCDHandler? {
        guard self.mainContext.hasChanges else { return nil }
        do {
            try self.mainContext.save()
            return nil
        } catch {
            throw ErrorCDHandler.saveError
        }
    }
    
    
    
    
    /* MARK: - Configurações */
    
    private func setupProtocols() {
        self.settingsCDM.cdProperties = self
    }
    
    
    
    /* MARK: - Errors */
    
    static func createPopUpError(error: ErrorCDHandler) -> UIAlertController {
        let alert = UIAlertController(
            title: "Eita!",
            message: error.userWarning,
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        print(error.developerWarning)
        return alert
    }
}
