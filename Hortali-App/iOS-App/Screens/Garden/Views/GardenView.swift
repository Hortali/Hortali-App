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
    
    /// Configurações do layout da collection
    private let collectionFlow = UICollectionViewFlowLayout()
        
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
    
    /// Muda a visualização
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
    
    
    // Search
    
    /// Define o delegate da barra de busca das hortas
    /// - Parameter delegate: delegate da barra de bysca
    public func setSearchDelegate(with delegate: SearchDelegate) {
        self.search.delegate = delegate
    }
    
    
    // Collection
    
    /// Atualiza os dados da collection
    public func reloadCollectionData() {
        self.gardenGroup.collection.reloadData()
        self.gardenGroup.collection.reloadInputViews()
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
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.gardenGroup.collection.collectionViewLayout = self.collectionFlow
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
        let top = search.frame.origin.y + search.frame.height
        let collectionHeight = self.getEquivalent(400)
        let bottom = self.safeAreaInsets.bottom
         
        let totalEmptySpace = (self.frame.height - top - collectionHeight - bottom) / 2
         
        return totalEmptySpace
    }
    
    
    /// Define o tamanho das células da collection
    private func setupCollectionVisualization() {
        self.setupDynamicConstraints()
        
        switch self.visualizationType {
        case .grid:
            self.collectionFlow.scrollDirection = .vertical
            self.collectionFlow.minimumInteritemSpacing = 0
            
            self.collectionFlow.itemSize = CGSize(
                width: self.getEquivalent(175, dimension: .height),
                height: self.getEquivalent(295, dimension: .height)
            )
            
        case .carousel:
            self.collectionFlow.scrollDirection = .horizontal
            self.collectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
            
            self.collectionFlow.itemSize = CGSize(
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
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        // Geral
        self.dynamicConstraints = [
            self.search.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.search.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.search.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.visualizationButton.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.visualizationButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral)
        ]
        
        
        // Collection
        switch self.visualizationType {
        case .grid:
            self.gardenGroup.setPadding(for: 0)
            self.dynamicConstraints += [
                self.gardenGroup.topAnchor.constraint(equalTo: self.search.bottomAnchor, constant: lateral),
                self.gardenGroup.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
                self.gardenGroup.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
                self.gardenGroup.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ]
                
        case .carousel:
            let emptySpace = self.getEmptySpace()
            self.gardenGroup.setPadding(for: lateral)
            
            self.dynamicConstraints += [
                self.gardenGroup.topAnchor.constraint(equalTo: self.search.bottomAnchor, constant: emptySpace),
                self.gardenGroup.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -emptySpace),
                self.gardenGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                self.gardenGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ]
        }
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
