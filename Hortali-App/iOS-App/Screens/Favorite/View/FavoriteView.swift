/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver os favoritos
class FavoriteView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    private let foodGroup = CustomCollectionWithTitle(emptyViewType: .food)
    
    private let gardenGroup = CustomCollectionWithTitle(emptyViewType: .garden)
    
    private let emptyView = EmptyView(emptyViewType: .favorite)
    
    
    // Collections
    
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
        
        self.registerCells()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    // Empty View
    
    /// Verifica a quantidade de dados das hortas
    /// - Parameter gardenDataCount: quantidade de dados das hortas
    public func checkGardenData(with gardenDataCount: Int) {
        self.gardenGroup.collectionHasData = gardenDataCount == 0
    }
    
    
    /// Verifica a quantidade de dados das hortas
    /// - Parameter foodDataCount: quantidade de dados dos alimentos
    public func checkFoodData(with foodDataCount: Int) {
        self.foodGroup.collectionHasData = foodDataCount == 0
    }
    
    
    /// Configura a empty view caso precise
    /// - Parameter value: estado que define a visualização da empty view
    public func setCollectionView(with value: Bool) {
        self.foodGroup.isHidden = value
        self.gardenGroup.isHidden = value
        self.emptyView.isHidden = !value
    }
    
    
    // Collection
    
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

        
    
    /* MARK: - Configurações */
    
    private func registerCells() {
        self.foodGroup.collection.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.identifier)
        self.gardenGroup.collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)
    }
    
    
    private func setupCollectionFlow() {
        self.foodGroup.collection.collectionViewLayout = self.foodCollectionFlow
        self.gardenGroup.collection.collectionViewLayout = self.gardenCollectionFlow
    }
        
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        super.setupHierarchy()
        self.contentView.addSubview(self.foodGroup)
        self.contentView.addSubview(self.gardenGroup)
        self.contentView.addSubview(self.emptyView)
    }
    
    
    override func setupView() {
        self.backgroundColor = UIColor(.favoriteBack)
    }
    
    
    override func setupUI() {
        self.setFoodCollectionItemSize()
        self.setGardenCollectionItemSize()
    }

    
    private func setGardenCollectionItemSize() {
        guard self.gardenGroup.collection.bounds.width != 0 else { return }
        let minimumSpace = self.getEquivalent(10)
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
        
        self.gardenCollectionFlow.itemSize = CGSize(
            width: self.gardenGroup.collection.getEquivalent(240, screenReference: screenReferenceSize),
            height: self.gardenGroup.collection.bounds.height
        )
        self.gardenCollectionFlow.minimumInteritemSpacing = minimumSpace
    }
    
    
    private func setFoodCollectionItemSize() {
        guard self.foodGroup.collection.bounds.width != 0 else { return }
        let minimumSpace = self.getEquivalent(10)
        let cellReferenceSize = SizeInfo(screenSize: CGSize(width: 170, height: 192), dimension: .height)
        
        self.foodCollectionFlow.itemSize = CGSize(
            width: self.foodGroup.collection.getEquivalent(170, screenReference: cellReferenceSize),
            height: self.foodGroup.collection.bounds.height
        )
        self.foodCollectionFlow.minimumInteritemSpacing = minimumSpace
        
    }
    
    
    override func setupStaticTexts() {
        self.setTitleText(with: "Favoritos da sua \nmesa")
        self.foodGroup.titleLabel.text = "Alimentos"
        self.gardenGroup.titleLabel.text = "Hortas"
    }
    
    
    override func setupFonts() {
        let subTitleSize: CGFloat = self.getEquivalent(25, dimension: .height)
        let font = FontInfo(fontSize: subTitleSize, weight: .medium)
        
        self.foodGroup.titleLabel.setupText(with: font)
        self.gardenGroup.titleLabel.setupText(with: font)
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let emptyView = self.emptyView.strechToBounds(of: self.contentView)
        var constrains = [
            self.foodGroup.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.foodGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        
            
            self.gardenGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.gardenGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        constrains += emptyView
        return constrains
    }
    
    
    override func createDynamicConstraints() {
        self.setDynamicConstraints()
        self.setCollectionsPadding()
        self.setCollectionsTitleLabelPadding()
    }
    
    
    private func setDynamicConstraints() {
        let bottom: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(28, dimension: .height)
        let foodCollectionHeight = self.getEquivalent(187, dimension: .height)   // 150+12+25
        
        self.dynamicConstraints = [
            self.gardenGroup.topAnchor.constraint(equalTo: self.foodGroup.bottomAnchor, constant: between),
            self.gardenGroup.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -bottom),
            
            
            self.foodGroup.heightAnchor.constraint(equalToConstant: foodCollectionHeight),
        ]
    }
    
    
    private func setCollectionsPadding() {
        let padding: CGFloat = self.getEquivalent(15)
        self.foodGroup.setupLateralPadding(padding)
        self.gardenGroup.setupLateralPadding(padding)
    }
    
    
    private func setCollectionsTitleLabelPadding() {
        let padding: CGFloat = self.getEquivalent(15)
        self.foodGroup.setupTitleLabelLeftSpace(padding)
        self.gardenGroup.setupTitleLabelLeftSpace(padding)
    }
}
