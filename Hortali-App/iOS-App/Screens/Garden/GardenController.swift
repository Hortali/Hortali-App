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
    
    /// Último tipo de visualização das hortas antes de entrar na search bar
    private var lastGardenVisualization: GardenVisualization?
    
    
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
        self.setupButtonsAction()
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
        if self.lastGardenVisualization == nil {
            self.lastGardenVisualization = self.myView.actualGardenVisualization
        }
         
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
        self.myView.actualGardenVisualization = .grid
    }
    
    
    
    /* MARK: - Ações de Botões */
    
    /// Função para retirar o teclado da tela
    @objc
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    /// Função para exibir tela de onboarding
    @objc
    private func onboardingAction() {
        let controller = OnboardingViewController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    /// Ação do botão de mudar a visualização da collection
    @objc
    private func visualizationAction() {
        self.myView.changeVisualization()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Lida com o toque na tela para retirar o teclado
    private func setupKeyboardHandler() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setVisualizationButtonAction(target: self, action: #selector(self.visualizationAction))
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
            self.myView.checkData(with: data.count)
            self.myView.reloadCollectionData()

            return
        }
        
        let gardenData = DataManager.shared.getGardenData()
        
        self.gardenDataSource.data = gardenData
        self.myView.checkData(with: gardenData.count)
        self.myView.reloadCollectionData()
        
        if self.gardenData.isEmpty {
            self.gardenData = gardenData
        }

        if let visu = self.lastGardenVisualization {
            self.myView.actualGardenVisualization = visu
            self.lastGardenVisualization = nil
        }
    }
}
