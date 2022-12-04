/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver todas as hortas
class GardenView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Bara de busca das hortas
    private let search = CustomViews.newSearch()
    
    /// Collection das hortas
    private let gardenGroup = CollectionGroup(style: .justCollection)
    
    /// Collection das tags
    private let tagGroup = CollectionGroup(style: .justCollection)
    
    
    /// Botão de mudar a visualização das hortas
    private let visualizationButton: CustomButton = {
        let btn = CustomViews.newButton()
        btn.tintColor = UIColor(.visualizationButton)
        btn.backgroundColor = .clear
        
        return btn
    }()
    
    
    // Constraints
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
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
        
    /// Tipo de visualização
    private var visualizationType: GardenVisualization = .carousel
    
   
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        self.setupViews()
        self.registerCells()
        self.setupCollectionFlow()
        self.setupStaticTexts()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Verifica a existencia de dados na collection
    public func checkData(with dataCount: Int) {
        self.gardenGroup.isCollectionEmpty(with: dataCount == 0)
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
        self.gardenGroup.collection.reloadData()
        self.gardenGroup.collection.reloadInputViews()
        
        self.tagGroup.collection.reloadData()
        self.tagGroup.collection.reloadInputViews()
    }
    
    
    /// Define o data source da collection das hortas
    /// - Parameter dataSource: data source da collection das hortas
    public func setDataSource(with dataSource: GardenDataSource) {
        self.gardenGroup.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection das hortas
    /// - Parameter delegate: delegate da collection das hortas
    public func setDelegate(with delegate: GardenDelegate) {
        self.gardenGroup.collection.delegate = delegate
    }
    
    
    /// Define o data source da collection das hortas
    /// - Parameter dataSource: data source da collection das hortas
    public func setTagDataSource(with dataSource: TagDataSource) {
        self.tagGroup.collection.dataSource = dataSource
        self.tagGroup.collection.delegate = dataSource
    }
    
    
    /* Ações de botões */
    
    /// Define a ação do botão de ajuda
    public func setVisualizationButtonAction(target: Any?, action: Selector) -> Void {
        self.visualizationButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupUI()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.gardenGroup.collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)
        self.tagGroup.collection.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.gardenGroup.collection.collectionViewLayout = self.gardenFlow
        self.tagGroup.collection.collectionViewLayout = self.tagFlow
    }
    
        
    /* Geral */
    
    /// Espaço entre a collection das hortas
    /// - Returns: distância entre os elemento
    ///
    /// Essa função calcula o espaço disponível que tem para a collection das hortas ser colocada
    /// no centro.
    ///
    /// O valor retornado deve ser usado como espaço (`constant`) na hora de definir as constraints
    /// de _top_ e _bottom_.
    private func getEmptySpace() -> CGFloat {
        let top = self.tagGroup.frame.origin.y + self.tagGroup.frame.height
        let collectionHeight = self.getEquivalent(400)
        let bottom = self.safeAreaInsets.bottom
         
        let totalEmptySpace = (self.frame.height - top - collectionHeight - bottom) / 2
         
        return totalEmptySpace
    }
    
    
    /// Define o tamanho das células da collection a partir do tipo de visualização
    private func setupCollectionVisualization() {
        self.setupDynamicConstraints()
        
        switch self.visualizationType {
        case .grid:
            self.gardenFlow.scrollDirection = .vertical
            self.gardenFlow.minimumInteritemSpacing = 0
            
            self.gardenFlow.itemSize = CGSize(
                width: self.getEquivalent(175, dimension: .height),
                height: self.getEquivalent(295, dimension: .height)
            )
            
        case .carousel:
            self.gardenFlow.scrollDirection = .horizontal
            self.gardenFlow.minimumInteritemSpacing = self.getEquivalent(10)
            
            self.gardenFlow.itemSize = CGSize(
                width: self.getEquivalent(240, dimension: .height),
                height: self.getEquivalent(400, dimension: .height)
            )
        }
        
        self.visualizationButton.setupIcon(with: IconInfo(
            icon: self.visualizationType.iconToggle,
            size: self.getEquivalent(25), weight: .medium, scale: .default
        ))
    }
    
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.search)
        self.addSubview(self.visualizationButton)
        self.addSubview(self.tagGroup)
        self.contentView.addSubview(self.gardenGroup)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.gardenBack)
        self.setupCollectionVisualization()
    }
    
        
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.setTitleText(with: "Descubra novas \nhortas")
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral = self.getEquivalent(15)
        let between = self.getEquivalent(5)
        
        let tagCollectionHeight = self.getEquivalent(25)
        
        self.tagGroup.setPadding(for: lateral)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        // Geral
        self.dynamicConstraints = [
            self.search.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.search.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.search.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.visualizationButton.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.visualizationButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            
            self.tagGroup.topAnchor.constraint(equalTo: self.search.bottomAnchor, constant: between),
            self.tagGroup.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tagGroup.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tagGroup.heightAnchor.constraint(equalToConstant: tagCollectionHeight)
        ]
        
        
        // Collection
        switch self.visualizationType {
        case .grid:
            self.gardenGroup.setPadding(for: 0)
            
            self.dynamicConstraints += [
                self.gardenGroup.topAnchor.constraint(equalTo: self.tagGroup.bottomAnchor, constant: lateral),
                self.gardenGroup.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
                self.gardenGroup.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
                self.gardenGroup.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ]
                
        case .carousel:
            let emptySpace = self.getEmptySpace()
            self.gardenGroup.setPadding(for: lateral)
            
            self.dynamicConstraints += [
                self.gardenGroup.topAnchor.constraint(equalTo: self.tagGroup.bottomAnchor, constant: emptySpace),
                self.gardenGroup.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -emptySpace),
                self.gardenGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                self.gardenGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ]
        }
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
