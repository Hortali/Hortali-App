/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela principal de ver todas as hortas
class GardenController: UIViewController, GardenProtocol, SearchProtocol {
    
    /* MARK: - Atributos */
    
    /* View */
    
    /// View principal que a classe vai controlar
    private let myView = GardenView()
    
    
    /* Handlers & Delegates */
    
    private let gardenCollectionHandler = GardenCollectionHandler()
    
    private let tagCollectionHandler = TagCollectionHandler()
    
    private let searchDelegate = SearchDelegate()
    
    
    /* Dados das Hortas */
    
    private lazy var gardenData: [ManagedGarden] = []
    
    
    /* Outros */
    
    private var lastGardenVisualization: GardenVisualization?
    
    
    
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
        let selectedCell = self.gardenCollectionHandler.data[index]
                
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
    
    private func showOnBoarding() {
        guard !self.onBoardingHasPresented else { return }
        
        let controller = OnboardingViewController()
        controller.hidesBottomBarWhenPushed = true
        controller.modalPresentationStyle = .fullScreen
            
        self.navigationController?.present(controller, animated: true)
    }
    
    
    private var onBoardingHasPresented: Bool {
        return UserDefaults.getValue(for: .onBoardingPresented)
    }
    
    
    private func setupKeyboardHandler() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    
    private func setupButtonsAction() {
        self.myView.setVisualizationButtonAction(target: self, action: #selector(self.visualizationAction))
    }
    
    
    private func setupDelegates() {
        self.setupGardenCollectionHandler()
        self.setupTagCollectionHandler()
        self.setupSearchDelegate()
    }
    
    
    private func setupGardenCollectionHandler() {
        self.gardenCollectionHandler.setProtocol(with: self)
        
        let gardenCollection = self.myView.gardenCollection
        self.gardenCollectionHandler.link(with: gardenCollection)
    }
    
    
    private func setupTagCollectionHandler() {
        self.tagCollectionHandler.setProtocol(with: self)
        
        let tagCollection = self.myView.tagCollection
        self.tagCollectionHandler.link(with: tagCollection)
    }
    
    
    private func setupSearchDelegate() {
        self.searchDelegate.setProtocol(with: self)
        self.myView.setSearchDelegate(with: self.searchDelegate)
    }
    
    
    /// Define os dados da collection
    private func setupDataSourceData(with data: [ManagedGarden]? = nil) {
        if let data {
            self.gardenCollectionHandler.data = data
            self.myView.checkData(with: data.count)
            self.myView.reloadCollectionData()
            return
        }
        
        let gardenData = DataManager.shared.getGardenData()
        
        self.gardenCollectionHandler.data = gardenData
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
                for tag in data.tags where tag.name == text {
                    dataFiltered.append(data)
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
