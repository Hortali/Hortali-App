/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de configurações
class SettingsView: MainView {
    
    /* MARK: - Atributos */

    // Views
    
    /// Collection principal da tela
    private let settingsCollection = CollectionGroup(style: .justCollection)
    
    
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
        self.setupStaticTexts()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */

    /* Collection */
    
    /// Atualiza os dados das collections
    public func reloadCollectionsData() {
        self.settingsCollection.collection.reloadData()
        self.settingsCollection.collection.reloadInputViews()
    }
    
    
    /// Define o data source da collection de configurações
    /// - Parameter dataSource: data source da collection
    public func setCollectionDataSource(for dataSource: SettingsDataSource) {
        self.settingsCollection.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection de configurações
    /// - Parameter delegate: delegate da collection
    public func setCollectionDelegate(for delegate: SettingsDelegate) {
        self.settingsCollection.collection.delegate = delegate
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.settingsCollection.collection.register(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.identifier)
    }


    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.settingsCollection.collection.collectionViewLayout = self.collectionFlow
    }


    /* Geral */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.settingsCollection)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.settingsBack)
        self.collectionFlow.minimumLineSpacing = self.getEquivalent(15)
        self.collectionFlow.itemSize = CGSize(
            width: self.settingsCollection.bounds.width,
            height: 165
        )
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.setTitleText(with: "Seu espaço de \nfala")
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(10)
        
        self.settingsCollection.collection.contentInset = UIEdgeInsets(
            top: 0, left: 0, bottom: between, right: 0
        )
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.settingsCollection.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.settingsCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.settingsCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.settingsCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
