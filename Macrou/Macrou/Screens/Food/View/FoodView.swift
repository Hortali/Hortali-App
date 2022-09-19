/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver todas os alimentos
class FoodView: MainView {
    
    /* MARK: - Atributos */
    
    /// Controle das views segmentadas para os diferentes tipos de alimentos
    internal let foodSegmented: UISegmentedControl = CustomViews.newSegmentation(with: ["Frutas", "Legumes", "Vegetais", "Ervas"])
    
    /// CollectionView principal da tela de alimentos
    internal let foodCollection: UICollectionView = CustomViews.newCollectionView()
    
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
    
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    
    
    /* MARK: - Encapsulamento */
    
    /// Encapsulamento que define o dataSource da Collection
    /// - Parameter dataSource: Encapsulamento do dataSource costumizado da Collection
    public func setDataSource(with dataSource: FoodCollectionDataSource) {
        self.foodCollection.dataSource = dataSource
    }
    

    /* MARK: - Ciclo de Vida */
    
    
    override internal func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.foodCollection.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.identifier)
    }


    /// Define o layout da collection
    private func setupCollectionFlow() {
         self.foodCollection.collectionViewLayout = self.collectionFlow
    }

    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(foodSegmented)
        self.addSubview(foodCollection)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
         self.collectionFlow.itemSize = CGSize(width: 170, height: 192)
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
            self.foodSegmented.heightAnchor.constraint(equalToConstant: lateral * 2),
            
            
            self.foodCollection.topAnchor.constraint(equalTo: self.foodSegmented.bottomAnchor, constant: between),
            self.foodCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.foodCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
