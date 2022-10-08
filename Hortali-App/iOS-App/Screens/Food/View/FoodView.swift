/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver todas os alimentos
class FoodView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Controle das views segmentadas para os diferentes tipos de alimentos
    private let foodSegmented: UISegmentedControl = {
        let itensSeg = DataManager.shared.getAllCategories()
        let seg = CustomViews.newSegmentation(with: itensSeg)
        seg.selectedSegmentIndex = 0
        
        return seg
    }()
    
    
    /// Grupo da collection de alimentos
    private let foodGroup: CollectionGroup = {
        let group = CollectionGroup(style: .justCollection)
        group.collection.showsVerticalScrollIndicator = false
        
        return group
    }()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
        
    /// Configurações do layout da collection
    private let collectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .vertical
             
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
    
    
    /* Ações de botões */

    /// Ação da segmentation
    public func setSegAction(target: Any?, action: Selector) -> Void {
        self.foodSegmented.addTarget(target, action: action, for: .valueChanged)
    }
    
    
    
    
    /* Collection */
    
    /// Define o data source da collection de alimentos
    /// - Parameter dataSource: data source
    public func setDataSource(with dataSource: FoodCollectionDataSource) {
        self.foodGroup.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection de alimentos
    /// - Parameter dataSource: delegate
    public func setDelegate(with delegate: FoodCollectionDelegate) {
        self.foodGroup.collection.delegate = delegate
    }
    
    
    public func reloadCollectionData() {
        self.foodGroup.collection.reloadData()
        self.foodGroup.collection.reloadInputViews()
    }
    

    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
          
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.foodGroup.collection.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.identifier)
    }


    /// Define o layout da collection
    private func setupCollectionFlow() {
         self.foodGroup.collection.collectionViewLayout = self.collectionFlow
    }

    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.foodSegmented)
        self.addSubview(self.foodGroup)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.foodBack)
        
        self.collectionFlow.itemSize = CGSize(
            width: self.getEquivalent(170),
            height: self.getEquivalent(192)
        )
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.setTitleText(with: "Hora da sua\ncolheita")
    }
      
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(20)
       
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.foodSegmented.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: lateral),
            self.foodSegmented.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodSegmented.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            
            self.foodGroup.topAnchor.constraint(equalTo: self.foodSegmented.bottomAnchor, constant: between),
            self.foodGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.foodGroup.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
