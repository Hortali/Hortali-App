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
    
    /// Data source da collections das tags
    private let tagCollectionHandler = TagCollectionHandler()
    
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
        self.setupTagData()
        self.setupDelegates()
        self.setupKeyboardHandler()
        self.setupButtonsAction()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showOnBoarding()
        self.myView.reloadTagData()
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
    
    internal func updateCollection(textSearch: String) {
        if let tagIndex = self.tagCollectionHandler.tagSelected {
            self.myView.deselectTag(at: tagIndex)
        }
        
        self.filterData(by: textSearch, isTag: false)
    }
    
    
    internal func updateCollection(tag: String) {
        self.filterData(by: tag, isTag: true)
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
    
    /// Função para exibir tela de onboarding
    private func showOnBoarding() {
        if !UserDefaults.getValue(for: .onBoardingPresented) {
            let controller = OnboardingViewController()
            controller.hidesBottomBarWhenPushed = true
            controller.modalPresentationStyle = .fullScreen
            
            self.navigationController?.present(controller, animated: true)
        }
    }
    
    
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
        
        
        self.tagCollectionHandler.setProtocol(with: self)
        
        let tagCollection = self.myView.tagCollection
        self.tagCollectionHandler.link(with: tagCollection)
        
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
    
    
    /// Configura os dados das tags
    private func setupTagData() {
        let tags = DataManager.shared.getAllTags()
        self.tagCollectionHandler.data = tags ?? []
    }
    
    
    /// Filtra os dados da collection de hortas
    /// - Parameters:
    ///   - text: dado que vai ser filtrado
    ///   - isTag: caso o filtro seja uma tag
    private func filterData(by text: String, isTag: Bool) {
        if self.lastGardenVisualization == nil {
            self.lastGardenVisualization = self.myView.actualGardenVisualization
        }
         
        if text.isEmpty {
            self.setupDataSourceData()
            return
        }
        
        var dataFiltered: [ManagedGarden] = []
        
        if isTag {
            for data in self.gardenData {
                for tag in data.tags {
                    if tag.name == text {
                        dataFiltered.append(data)
                    }
                }
            }
        } else {
            for data in self.gardenData {
                if data.name.lowercased().contains(text) {
                    dataFiltered.append(data)
                    continue
                }
                
                if data.address.lowercased().contains(text) {
                    dataFiltered.append(data)
                }
            }
            
        }
        
        self.setupDataSourceData(with: dataFiltered)
        self.myView.actualGardenVisualization = .grid
    }
}
