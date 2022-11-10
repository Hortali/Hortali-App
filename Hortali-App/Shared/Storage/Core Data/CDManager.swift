/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import CoreData

import class UIKit.UIAlertAction
import class UIKit.UIAlertController


/// Core Data Manager: classe principal que lida com o core data
class CDManager: NSObject, CoreDataProperties {
    
    /* MARK: - Atributos */
    
    /// Singleton para uso
    static let shared = CDManager()
    
    
    /* Managers */
    
    
    
    
    /* MARK: - Construtor */
    
    /// Restringe o uso da classe para o singleton
    override private init() {
        super.init()
        
        self.setupProtocols()
    }
    
    
    
    /* MARK: - Protocol */
    
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
        if self.mainContext.hasChanges {
            do {
                try self.mainContext.save()
            } catch {
                throw ErrorCDHandler.saveError
            }
        }
        return nil
    }
    
    
    /* MARK: - Encapsulamento */
    
    /* MARK: Ajustes */
    
    
    
    /* MARK: Dias trabalhados */
    
//    /// Retorna os dados do dia
//    /// - Parameter completionHandler: em caso de sucesso retorna o dado do dia
//    ///
//    /// Caso não encontre o dado do dia vai ser gerado um erro de `dataNotFound`.
//    public func getTodayDayWorkData(_ completionHandler: @escaping (Result<ManagedDayWork, ErrorCDHandler>) -> Void) {
//        self.mainContext.perform {
//            let today = Date().getDateFormatted(with: .dma)
//            self.dayWorkManager.getData(for: today) { result in
//                switch result {
//                case .success(let success):
//                    completionHandler(.success(success))
//                case .failure(let failure):
//                    completionHandler(.failure(failure))
//                }
//            }
//        }
//    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura os protocolos dos atributos
    private func setupProtocols() {
        
    }
    
    
    
    /* MARK: - Errors */
    
    /// Cria um popup de aviso com o erro que aconteceu
    /// - Parameter error: erro
    /// - Returns: pop up com a mensagem do erro
    ///
    /// O pop up não é apresentado, apenas criado.
    static func createPopUpError(error: ErrorCDHandler) -> UIAlertController {
        let alert = UIAlertController(
            title: "Eita!",
            message: error.userWarning,
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        return alert
    }
}
