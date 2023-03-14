/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de configurações
class SettingsView: MainView {
    
    /* MARK: - Atributos */

    // Views
    
    /// Collection principal da tela
    private let settingsCollection = CustomCollection()
    
    
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
    

    
    /* MARK: - Configurações */

    private func registerCells() {
        self.settingsCollection.collection.register(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.identifier)
    }


    private func setupCollectionFlow() {
        self.settingsCollection.collection.collectionViewLayout = self.collectionFlow
    }
    

    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        super.setupHierarchy()
        self.contentView.addSubview(self.settingsCollection)
    }
    
    
    override func setupView() {
        self.backgroundColor = UIColor(.settingsBack)
    }
    
    
    override func setupUI() {
        self.setSettingsCollectionItemSize()
    }
    
    
    private func setSettingsCollectionItemSize() {
        self.collectionFlow.minimumLineSpacing = self.getEquivalent(15)
        self.collectionFlow.itemSize = CGSize(
            width: self.settingsCollection.bounds.width,
            height: 165
        )
    }
    
    
    override func setupStaticTexts() {
        self.setTitleText(with: "Seu espaço de \nfala")
    }
	  
    
    override func createDynamicConstraints() {
        self.setCollectionPadding()
        self.setDynamicConstraints()
    }
    
    
    private func setCollectionPadding() {
        let padding: CGFloat = self.getEquivalent(10)
        
        self.settingsCollection.collection.contentInset = UIEdgeInsets(
            top: 0, left: 0, bottom: padding, right: 0
        )
    }
    
    
    private func setDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        
        self.dynamicConstraints = [
            self.settingsCollection.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.settingsCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.settingsCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.settingsCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
    }
}
