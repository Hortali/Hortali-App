/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela principal de ver todas as hortas
class GardenController: UIViewController, GardenProtocol, SearchProtocol {
    
    /* MARK: - Atributos */
    
    /* View */
    
    private let myView = GardenView()
    
    
    /* Handlers & Delegates */
    
    private let gardenCollectionHandler = GardenCollectionHandler()
    
    private let tagCollectionHandler = TagCollectionHandler()
    
    private let searchDelegate = SearchDelegate()
    
    
    /* Dados */
    
    private lazy var gardenData: [ManagedGarden] = []
    
    
    /* Outros */
    
    private var lastGardenVisualization: GardenVisualization?
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGardenCollectionData()
        self.setupTagCollectionData()
        self.setupDelegates()
        self.setupKeyboardHandler()
        self.setupButtonsAction()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showOnBoarding()
        self.reloadTagCollection()
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
        self.deselectTagIfNeeded()
        self.filterData(by: textSearch, isTag: false)
    }
    
    
    private func deselectTagIfNeeded() {
        guard let tagIndex = self.tagCollectionHandler.tagSelected else { return }
        self.myView.deselectTag(at: tagIndex)
    }
    
    
    internal func updateCollection(tag: String) {
        self.filterData(by: tag, isTag: true)
    }
    
    
    
    /* MARK: - Ações de Botões */
    
    @objc
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    @objc
    private func onboardingAction() {
        let controller = OnboardingViewController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
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
    
    
    /* Collection */
    
    private func reloadGardenCollection() {
        self.myView.reloadCollectionData()
    }
    
    
    private func reloadTagCollection() {
        self.myView.reloadTagData()
    }
    
    
    private func setupGardenCollectionData(with data: [ManagedGarden]? = nil) {
        if let data {
            self.updateGardenData(data)
        } else {
            let gardenData = self.getGardenDataFromStorage()
            self.updateGardenData(gardenData)
        }
        self.updateGardenVisualization()
    }
    
    
    private func updateGardenData(_ data: [ManagedGarden]) {
        self.gardenCollectionHandler.data = data
        self.myView.checkData(with: data.count)
        self.reloadGardenCollection()
    }
    
    
    private func getGardenDataFromStorage() -> [ManagedGarden] {
        let gardenData = DataManager.shared.getGardenData()
        if self.gardenData.isEmpty {
            self.gardenData = gardenData
        }
        return gardenData
    }
    
    
    private func updateGardenVisualization() {
        guard let visu = self.lastGardenVisualization else { return }
        self.myView.actualGardenVisualization = visu
        self.lastGardenVisualization = nil
    }
    
    
    private func setupTagCollectionData() {
        let tags = DataManager.shared.getAllTags()
        self.tagCollectionHandler.data = tags ?? []
        self.reloadTagCollection()
    }
    
    
    /* Filtro */
    
    private func filterData(by text: String, isTag: Bool) {
        self.setGardenVisualizationIfNeeded()
        
        guard !text.isEmpty else { self.setupGardenCollectionData(); return }
        
        let dataFiltered = self.getDataFiltered(text: text, isFromTag: isTag)
        self.setupGardenCollectionData(with: dataFiltered)
        self.myView.actualGardenVisualization = .grid
    }
    
    
    private func setGardenVisualizationIfNeeded() {
        guard self.lastGardenVisualization.isNil else { return }
        self.lastGardenVisualization = self.myView.actualGardenVisualization
    }
    
    
    private func getDataFiltered(text: String, isFromTag: Bool) -> [ManagedGarden] {
        if isFromTag { return self.getFilteredDataFromTag(text) }
        return self.getFilteredDataFromSearch(text)
    }
    
    
    private func getFilteredDataFromTag(_ tagText: String) -> [ManagedGarden] {
        return self.gardenData.filter() {
            return checkIfGardenHasSelectedTag(tagText, garden: $0)
        }
    }
    
    
    private func checkIfGardenHasSelectedTag(_ tagName: String, garden: ManagedGarden) -> Bool {
        let gardenWithTag = garden.tags.filter() { $0.name == tagName }
        return !gardenWithTag.isEmpty
    }
    
    
    private func getFilteredDataFromSearch(_ searchText: String) -> [ManagedGarden] {
        return self.gardenData.filter() {
            let hasName = checkIfHasSameName(in: $0, searchText)
            let hasAddress = checkIfHasSameAddress(in: $0, searchText)
            return hasName || hasAddress
        }
    }
    
    
    private func checkIfHasSameName(in data: ManagedGarden, _ text: String) -> Bool {
        return data.name.lowercased().contains(text)
    }
    
    
    private func checkIfHasSameAddress(in data: ManagedGarden, _ text: String) -> Bool {
        return data.address.lowercased().contains(text)
    }
}
