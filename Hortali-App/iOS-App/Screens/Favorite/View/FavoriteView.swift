/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver os favoritos
class FavoriteView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Collection de alimentos
    private let foodGroup = CollectionGroup(emptyViewType: .food)
    
    /// Collection das hortas
    private let gardenGroup = CollectionGroup(emptyViewType: .garden)
    
    /// instancia da tela de empty view
    private let emptyView = EmptyView(emptyViewType: .favorite)
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Configurações do layout da collection de Alimentos
    private let foodCollectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .horizontal
        
        return cvFlow
    }()
    
    /// Configuração do layout da collectoin de Hortas
    private let gardenCollectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .horizontal
        
        return cvFlow
    }()
        

    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        self.setupViews()
        self.registerCells()
        self.setupCollectionFlow()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Atualiza os dados da collection
    public func reloadCollectionsData() {
        self.foodGroup.collection.reloadData()
        self.foodGroup.collection.reloadInputViews()
        
        self.gardenGroup.collection.reloadData()
        self.gardenGroup.collection.reloadInputViews()
    }
    
    
    /// Define o data source da collection de alimentos
    /// - Parameter dataSource: data source da collection de alimentos
    public func setFoodDataSource(with dataSource: FoodDataSource) {
        self.foodGroup.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection de alimentos
    /// - Parameter dataSource: data source da collection de alimentos
    public func setFoodDelegate(with delegate: FoodDelegate) {
        self.foodGroup.collection.delegate = delegate
    }
    
    
    /// Define o data source da collection de hortas
    /// - Parameter dataSource: data source da collection de hortas
    public func setGardenDataSource(with dataSource: GardenDataSource) {
        self.gardenGroup.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection de hortas
    /// - Parameter dataSource: data source da collection de hortas
    public func setGardenDelegate(with delegate: GardenDelegate) {
        self.gardenGroup.collection.delegate = delegate
    }
        
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupStaticTexts()
        self.setupDynamicConstraints()
        self.setupUI()
    }
    
    
    
    /* MARK: - Configurações */
    
    // Collection
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.foodGroup.collection.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.identifier)
        self.gardenGroup.collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.foodGroup.collection.collectionViewLayout = self.foodCollectionFlow
        self.gardenGroup.collection.collectionViewLayout = self.gardenCollectionFlow
    }
    
    
    public func checkGardenData(with gardenDataCount: Int) {
        self.gardenGroup.isCollectionEmpty(with: gardenDataCount == 0)
    }
    
    
    public func checkFoodData(with foodDataCount: Int) {
        self.foodGroup.isCollectionEmpty(with: foodDataCount == 0)
    }
    
    
    // Views
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.foodGroup)
        self.contentView.addSubview(self.gardenGroup)
        self.contentView.addSubview(self.emptyView)
    }
    
    
    public func setCollectionView(with value: Bool) {
        self.foodGroup.isHidden = value
        self.gardenGroup.isHidden = value
        self.emptyView.isHidden = !value
    }
    
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.favoriteBack)
        
        // Collection
        let minimumSpace = self.getEquivalent(10)
        
        if self.gardenGroup.collection.bounds.width != 0 {
            let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
            
            self.gardenCollectionFlow.itemSize = CGSize(
                width: self.gardenGroup.collection.getEquivalent(240, screenReference: screenReferenceSize),
                height: self.gardenGroup.collection.bounds.height
            )
            self.gardenCollectionFlow.minimumInteritemSpacing = minimumSpace
        }
        
        
        if self.foodGroup.collection.bounds.width != 0 {
            let cellReferenceSize = SizeInfo(screenSize: CGSize(width: 170, height: 192), dimension: .height)
            
            self.foodCollectionFlow.itemSize = CGSize(
                width: self.foodGroup.collection.getEquivalent(170, screenReference: cellReferenceSize),
                height: self.foodGroup.collection.bounds.height
            )
            self.foodCollectionFlow.minimumInteritemSpacing = minimumSpace
        }
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.setTitleText(with: "Favoritos da sua \nmesa")
        
        let subTitleSize: CGFloat = self.getEquivalent(25, dimension: .height)
        
        self.foodGroup.titleLabel.setupText(with: FontInfo(
            text: "Alimentos", fontSize: subTitleSize, weight: .medium)
        )
        
        self.gardenGroup.titleLabel.setupText(with: FontInfo(
            text: "Hortas", fontSize: subTitleSize, weight: .medium)
        )
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(28, dimension: .height)
        
        
        let foodGpHeight = self.getEquivalent(187, dimension: .height)   // 150+12+25
        
        self.foodGroup.setPadding(for: lateral)
        self.gardenGroup.setPadding(for: lateral)
        
        self.foodGroup.setLabelSpace(for: lateral)
        self.gardenGroup.setLabelSpace(for: lateral)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.foodGroup.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.foodGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.foodGroup.heightAnchor.constraint(equalToConstant: foodGpHeight),
            
            
            self.gardenGroup.topAnchor.constraint(equalTo: self.foodGroup.bottomAnchor, constant: between),
            self.gardenGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.gardenGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.gardenGroup.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -lateral),
            
            
            self.emptyView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.emptyView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.emptyView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.emptyView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
