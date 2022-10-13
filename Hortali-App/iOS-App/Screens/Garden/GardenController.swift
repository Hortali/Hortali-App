/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela principal de ver todas as hortas
class GardenController: MenuController, GardenProtocol {
    
    /* MARK: - Atributos */
    
    /* View */
    
    /// View principal que a classe vai controlar
    private let myView = GardenView()
    
    
    /* Delegate & Data Sources */
    
    /// Data source da collections das hortas
    private let gardenDataSource = GardenDataSource()
    
    /// Delegate da collection das hortas
    private let gardenDelegate = GardenDelegate()
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDataSourceData()
        self.setupDelegates()
        self.setupKeyboardHandler()
    }
    
    
    
    /* MARK: - Protocolo */
    
    internal func openGardenInfo(for index: Int) {
        let selectedCell = self.gardenDataSource.data[index]
        
        let controller = InfoGardenController(with: selectedCell, in: index)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        
        self.tabBarProtocol?.showTabBar(is: false)
        self.present(controller, animated: true)
    }
    
    
    
    /* MARK: - Ações de Botões */
    
    /// Função para retirar o teclado da tela
    @objc
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Lida com o toque na tela para retirar o teclado
    private func setupKeyboardHandler() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.gardenDelegate.setProtocol(with: self)
        
        self.myView.setDataSource(with: self.gardenDataSource)
        self.myView.setDelegate(with: self.gardenDelegate)
    }
    
    
    /// Define os dados da collection
    private func setupDataSourceData() {
        let gardenData = DataManager.shared.getGardenData()
        
        self.gardenDataSource.data = gardenData
        //self.myView.reloadCollectionData()
    }
}
