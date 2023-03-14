/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver todas as hortas
class GardenView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    private let search = CustomViews.newSearch()
    
    private let gardenCollection = CustomCollection(emptyViewType: .garden)
    
    final let tagCollection = CustomCollection()
    
    
    /// Botão de mudar a visualização das hortas
    private let visualizationButton: CustomButton = {
        let btn = CustomViews.newButton()
        btn.tintColor = UIColor(.visualizationButton)
        btn.backgroundColor = .clear
        
        return btn
    }()
    
    
    // Collection
    
    /// Configurações do layout da collection de hortas
    private let gardenFlow = UICollectionViewFlowLayout()
    
    /// Configurações do layout da collection das tags
    private let tagFlow: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.estimatedItemSize = .zero
        return flow
    }()
        
    
    private var visualizationType: GardenVisualization = .carousel
    
   
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        self.registerCells()
        self.setupCollectionFlow()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Verifica a existencia de dados na collection
    public func checkData(with dataCount: Int) {
        self.gardenCollection.collectionHasData = dataCount == 0
    }
    
    
    // Search
    
    /// Define o delegate da barra de busca das hortas
    /// - Parameter delegate: delegate da barra de bysca
    public func setSearchDelegate(with delegate: SearchDelegate) {
        self.search.delegate = delegate
    }
    
    
    // Collection
    
    /// Muda a visualização
    /// - Parameter visu: visualização desejada
    ///
    /// Caso não passe um valor por parâmetro ele vai fazer a troca para a outra visualização.
    public func changeVisualization(to visu: GardenVisualization? = nil) {
        if let visu {
            self.visualizationType = visu
        } else {
            switch self.visualizationType {
            case .grid: self.visualizationType = .carousel
            case .carousel: self.visualizationType = .grid
            }
        }
        
        self.setupCollectionVisualization()
    }
    
    
    /// Pega a visualização atual
    public var actualGardenVisualization: GardenVisualization {
        set (value) { self.changeVisualization(to: value) }
        get { return self.visualizationType }
    }
    
    
    /// Atualiza os dados da collection
    public func reloadCollectionData() {
        self.gardenCollection.collection.reloadData()
        self.gardenCollection.collection.reloadInputViews()
    }
    
    
    /// Atualiza os dados da collection de tags
    public func reloadTagData() {
        self.tagCollection.collection.reloadData()
        self.tagCollection.collection.reloadInputViews()
    }
    
    
    /// 
    public func deselectTag(at indexPath: IndexPath) {
        self.tagCollection.collection.deselectItem(at: indexPath, animated: true)
    }
    
    
    /// Define o data source da collection das hortas
    /// - Parameter dataSource: data source da collection das hortas
    public func setDataSource(with dataSource: GardenDataSource) {
        self.gardenCollection.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection das hortas
    /// - Parameter delegate: delegate da collection das hortas
    public func setDelegate(with delegate: GardenDelegate) {
        self.gardenCollection.collection.delegate = delegate
    }
    
        
    
    /* Ações de botões */
    
    /// Define a ação do botão de ajuda
    public func setVisualizationButtonAction(target: Any?, action: Selector) -> Void {
        self.visualizationButton.addTarget(target, action: action, for: .touchDown)
    }
    

    
    /* MARK: - Configurações */
    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.gardenCollection.collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.gardenCollection.collection.collectionViewLayout = self.gardenFlow
        self.tagCollection.collection.collectionViewLayout = self.tagFlow
    }
    
    
    /* Geral */
    
    /// Define o tamanho das células da collection a partir do tipo de visualização
    private func setupCollectionVisualization() {
        self.setupDynamicConstraints()
        self.updateButtonIcon()
        
        switch self.visualizationType {
        case .grid:
            self.setItemSizeForGrid()
            
        case .carousel:
            self.setItemSizeForCarousel()
        }
    }
    
    
    private func updateButtonIcon() {
        self.visualizationButton.setupIcon(with: IconInfo(
            icon: self.visualizationType.iconToggle,
            size: self.getEquivalent(25), weight: .medium, scale: .default
        ))
    }
    
    
    private func setItemSizeForGrid() {
        self.gardenFlow.scrollDirection = .vertical
        self.gardenFlow.minimumInteritemSpacing = 0
        
        self.gardenFlow.itemSize = CGSize(
            width: self.getEquivalent(175, dimension: .height),
            height: self.getEquivalent(295, dimension: .height)
        )
    }
    
    
    private func setItemSizeForCarousel() {
        self.gardenFlow.scrollDirection = .horizontal
        self.gardenFlow.minimumInteritemSpacing = self.getEquivalent(10)
        
        self.gardenFlow.itemSize = CGSize(
            width: self.getEquivalent(240, dimension: .height),
            height: self.getEquivalent(400, dimension: .height)
        )
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        print("Criando hirarquia")
        super.setupHierarchy()
        self.addSubview(self.search)
        self.addSubview(self.visualizationButton)
        self.addSubview(self.tagCollection)
        self.contentView.addSubview(self.gardenCollection)
    }
    
    
    override func setupView() {
        self.backgroundColor = UIColor(.gardenBack)
    }
    
    
    override func setupUI() {
        self.setupCollectionVisualization()
    }
    
        
    override func setupStaticTexts() {
        self.setTitleText(with: "Descubra novas \nhortas")
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.search.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.search.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.search.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.tagCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tagCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.visualizationButton.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        self.setCollectionsLateralPadding()
        self.createGeneralDynamicConstraints()
        
        
        switch self.visualizationType {
        case .grid:
            self.createConstraintsForGrid()
                
        case .carousel:
            self.createConstraintsForCarrousel()
        }
    }
    
    
    private func setCollectionsLateralPadding() {
        let padding = self.getEquivalent(15)
        let gardenPadding = self.visualizationType == .carousel ? padding : 0
        
        self.tagCollection.setupLateralPadding(padding)
        self.gardenCollection.setupLateralPadding(gardenPadding)
    }
    
    
    private func createGeneralDynamicConstraints() {
        let lateral = self.getEquivalent(15)
        let between = self.getEquivalent(5)
        let tagCollectionHeight = self.getEquivalent(25)
        
        
        self.dynamicConstraints = [
            self.visualizationButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            
            self.tagCollection.topAnchor.constraint(equalTo: self.search.bottomAnchor, constant: between),
            self.tagCollection.heightAnchor.constraint(equalToConstant: tagCollectionHeight)
        ]
    }
    
    
    private func createConstraintsForCarrousel() {
        let space = self.getTopBottomSpace()
        
        self.dynamicConstraints += [
            self.gardenCollection.topAnchor.constraint(equalTo: self.tagCollection.bottomAnchor, constant: space),
            self.gardenCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -space),
            self.gardenCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.gardenCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
    }
    
    
    /// Essa função calcula o espaço disponível que tem para a collection das hortas ser colocada no centro.
    private func getTopBottomSpace() -> CGFloat {
        let top = self.tagCollection.frame.origin.y + self.tagCollection.frame.height
        let collectionHeight = self.getEquivalent(400)
        let bottom = self.safeAreaInsets.bottom
         
        let totalEmptySpace = (self.frame.height - top - collectionHeight - bottom) / 2
         
        return totalEmptySpace
    }
    
    
    private func createConstraintsForGrid() {
        let lateral = self.getEquivalent(15)
        
        self.dynamicConstraints += [
            self.gardenCollection.topAnchor.constraint(equalTo: self.tagCollection.bottomAnchor, constant: lateral),
            self.gardenCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.gardenCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            self.gardenCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ]
    }
}
