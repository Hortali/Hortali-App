/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver todas os alimentos
class FoodView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    private let foodSegmented: UISegmentedControl = {
        let itensSeg = DataManager.shared.getAllCategories()
        let seg = CustomViews.newSegmentation(with: itensSeg)
        seg.selectedSegmentIndex = 0
        
        return seg
    }()
    
    private let foodGroup = CustomCollection()
    
    
    // Outros
    
    /// Configurações do layout da collection
    private let collectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .vertical
             
        return cvFlow
    }()



    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        self.registerCells()
        self.setupCollectionFlow()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
    
    /* MARK: - Encapsulamento */
    
    /* Ações de botões */

    /// Ação da segmentation
    public func setSegAction(target: Any?, action: Selector) -> Void {
        self.foodSegmented.addTarget(target, action: action, for: .valueChanged)
    }
    
    
    /* Collection */
    
    /// Define o data source da collection de alimentos
    /// - Parameter dataSource: data source
    public func setDataSource(with dataSource: FoodDataSource) {
        self.foodGroup.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection de alimentos
    /// - Parameter dataSource: delegate
    public func setDelegate(with delegate: FoodDelegate) {
        self.foodGroup.collection.delegate = delegate
    }
    
    
    /// Atualiza os dados da collection
    public func reloadCollectionData() {
        self.foodGroup.collection.reloadData()
        self.foodGroup.collection.reloadInputViews()
    }
    
    
    /// Deixa a scroll no início da tela
    public func resetCollectionScroll() {
        self.foodGroup.collection.setContentOffset(.zero, animated: true)
    }
    
    
    
    /* MARK: - Configurações */
    
    // Collection
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.foodGroup.collection.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.identifier)
    }


    /// Define o layout da collection
    private func setupCollectionFlow() {
         self.foodGroup.collection.collectionViewLayout = self.collectionFlow
    }

    
    // View
    
    
    override func setupHierarchy() {
        super.setupHierarchy()
        self.addSubview(self.foodSegmented)
        self.addSubview(self.foodGroup)
    }
    
    
    override func setupView() {
        self.backgroundColor = UIColor(.foodBack)
    }
    
    
    override func setupUI() {
        self.setFoodCollectionItemSize()
    }
    
    
    private func setFoodCollectionItemSize() {
        self.collectionFlow.itemSize = CGSize(
            width: self.getEquivalent(170),
            height: self.getEquivalent(192)
        )
    }
    
    
    override func setupStaticTexts() {
        self.setTitleText(with: "Hora da sua\ncolheita")
    }
      
    
    override func createDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(20)
            
        self.dynamicConstraints = [
            self.foodSegmented.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: lateral),
            self.foodSegmented.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.foodSegmented.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            
            self.foodGroup.topAnchor.constraint(equalTo: self.foodSegmented.bottomAnchor, constant: between),
            self.foodGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.foodGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.foodGroup.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
    }
}
