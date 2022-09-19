/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver os favoritos
class FavoriteView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Collection de alimentos
    private let foodGroup = CollectionGroup()
    
    /// Collection das hortas
    private let gardenGroup = CollectionGroup()
    
    
    // Outros
    
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
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    /// Encapsulamento que define o dataSource da Collection
    /// - Parameter dataSource: Encapsulamento do dataSource costumizado da Collection
    public func setDataSource(with dataSource: GardenDataSource) {
        self.gardenGroup.collection.dataSource = dataSource
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /// Registra as células nas collections/table
    private func registerCells() {
        self.gardenGroup.collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)
//        self.foodGroup.collection.register(, forCellWithReuseIdentifier: <#T##String#>)
    }
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.gardenGroup.collection.collectionViewLayout = self.gardenCollectionFlow
        self.foodGroup.collection.collectionViewLayout = self.foodCollectionFlow
    }
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.foodGroup)
        self.contentView.addSubview(self.gardenGroup)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.favoriteBack)
        
        let screenReferenceSize: SizeInfo = SizeInfo(screenSize: CGSize(width: 240,
                                                                        height: 400),
                                                     dimension: .height)
        
        if self.gardenGroup.collection.bounds.width != 0 {
            self.gardenCollectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
            self.gardenCollectionFlow.itemSize = CGSize(
                width: self.gardenGroup.collection.getEquivalent(240, screenReference: screenReferenceSize),
                height: self.gardenGroup.collection.bounds.height
            )
        }
        
        if self.foodGroup.collection.bounds.width != 0 {
            self.foodCollectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
            self.foodCollectionFlow.itemSize = CGSize(
                width: self.foodGroup.collection.getEquivalent(240, screenReference: screenReferenceSize),
                height: self.foodGroup.collection.bounds.height
            )
        }
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /* Labels */
        self.setTitleText(with: "Favoritos da sua \nmesa")
        
        let subTitleSize: CGFloat = self.getEquivalent(25)
        
        self.foodGroup.titleLabel.setupText(with: FontInfo(
            text: "Alimentos", fontSize: subTitleSize, weight: .regular)
        )
        
        self.gardenGroup.titleLabel.setupText(with: FontInfo(
            text: "Hortas", fontSize: subTitleSize, weight: .regular)
        )
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(28)
       
        let foodGpHeight = self.getEquivalent(187)   // 150+12+25
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.foodGroup.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.foodGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.foodGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.foodGroup.heightAnchor.constraint(equalToConstant: foodGpHeight),
            
            
            self.gardenGroup.topAnchor.constraint(equalTo: self.foodGroup.bottomAnchor, constant: between),
            self.gardenGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.gardenGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.gardenGroup.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -lateral),
            
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
