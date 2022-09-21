/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver todas as hortas
class GardenView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Definindo o elemento que compõe a searchBar
    private let search: UISearchBar = CustomViews.newSearch()
    
    /// Define o estilo da Collection e retira o indicador de scroll
    private let collectionView: CollectionGroup = {
        let collGroup = CollectionGroup(style: .justCollection)
        collGroup.collection.showsHorizontalScrollIndicator = false
        
        return collGroup
    }()
    
    /// View de referência que serva para centralizar as células da Collection
    private let referenceView: UIView = CustomViews.newView()
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    /// Configurações do layout da collection
    private let collectionFlow: UICollectionViewFlowLayout = {
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
        self.collectionView.collection.dataSource = dataSource
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.collectionView.collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.collectionView.collection.collectionViewLayout = self.collectionFlow
    }
    
    
    /* Geral */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.search)
        self.contentView.addSubview(self.referenceView)
        self.contentView.addSubview(self.collectionView)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.gardenBack)
        
        self.collectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
        self.collectionFlow.itemSize = CGSize(width: self.getEquivalent(240),
                                              height: self.getEquivalent(400))
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.setTitleText(with: "Descubra novas \nhortas")
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let collectionHeight = self.getEquivalent(400)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.search.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.search.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.search.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.referenceView.topAnchor.constraint(equalTo: self.search.bottomAnchor),
            self.referenceView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.referenceView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.referenceView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
            self.collectionView.heightAnchor.constraint(equalToConstant: collectionHeight),
            self.collectionView.centerYAnchor.constraint(equalTo: self.referenceView.centerYAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
