/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela principal de ver todas as hortas
class GardenController: UIViewController, GardenProtocol, SearchProtocol {
    
    /* MARK: - Atributos */
    
    /* View */
    
    /// View principal que a classe vai controlar
    private let myView = GardenView()
    
    
    /* Delegate & Data Sources */
    
    /// Data source da collections das hortas
    private let gardenDataSource = GardenDataSource()
    
    /// Delegate da collection das hortas
    private let gardenDelegate = GardenDelegate()
    
    /// Delegate da barra de busca
    private let searchDelegate = SearchDelegate()
    
    
    /* Dados das Hortas */
    
    /// Dados das hortas
    private lazy var gardenData: [ManagedGarden] = []
    
    
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
    
    /* Garden Protocol */
    
    internal func openGardenInfo(for index: Int) {
        let selectedCell = self.gardenDataSource.data[index]
                
        let controller = InfoGardenController(with: selectedCell)
        controller.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    /* Search Protocol */
    
    internal func updateCollection(with textSearch: String) {
        if textSearch.isEmpty {
            self.setupDataSourceData()
            return
        }
        
        var dataFiltered: [ManagedGarden] = []
        
        for data in self.gardenData {
            if data.name.lowercased().contains(textSearch) {
                dataFiltered.append(data)
                continue
            }
            
            if data.address.lowercased().contains(textSearch) {
                dataFiltered.append(data)
                continue
            }
        }
        
        self.setupDataSourceData(with: dataFiltered)
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
        // Collection
        self.gardenDelegate.setProtocol(with: self)
        
        self.myView.setDataSource(with: self.gardenDataSource)
        self.myView.setDelegate(with: self.gardenDelegate)
        
        
        // Search
        self.searchDelegate.setProtocol(with: self)
        
        self.myView.setSearchDelegate(with: self.searchDelegate)
    }
    
    
    /// Define os dados da collection
    private func setupDataSourceData(with data: [ManagedGarden]? = nil) {
        if let data {
            self.gardenDataSource.data = data
            self.myView.reloadCollectionData()
            return
        }
        
        let gardenData = DataManager.shared.getGardenData()
        
        self.gardenDataSource.data = gardenData
        self.myView.reloadCollectionData()
        
        if self.gardenData.isEmpty {
            self.gardenData = gardenData
        }
    }
}
