/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class SettingsView: ViewWithViewCode {
    
    /* MARK: - Atributos */
    
    private let backButton: CustomButton = {
        let but = CustomViews.newButton()
        but.backgroundColor = .clear
        but.setTitleColor(UIColor(originalColor: .greenMedium), for: .normal)
        but.titleLabel?.textAlignment = .left
        but.isCircular = false
        but.sizeToFit()
        return but
    }()
    
    private let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.title)
        return lbl
    }()
    
    private let settingsCollection = CustomCollection()
    
    
    // Outros
    
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
    
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    

    /* Collection */
    
    public func reloadCollectionsData() {
        self.settingsCollection.reloadCollectionData()
    }
    
    
    public func setCollectionDataSource(for dataSource: SettingsDataSource) {
        self.settingsCollection.collection.dataSource = dataSource
    }
    
    
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
        self.addSubview(self.backButton)
        self.addSubview(self.titleLabel)
        self.addSubview(self.settingsCollection)
    }
    
    
    override func setupView() {
        self.backgroundColor = UIColor(.viewBack)
    }
    
    
    override func setupUI() {
        self.setSettingsCollectionItemSize()
    }
    
    
    private func setSettingsCollectionItemSize() {
        guard self.settingsCollection.collection.bounds.width != 0 else { return }
        
        self.collectionFlow.minimumLineSpacing = self.getEquivalent(15)
        self.collectionFlow.itemSize = CGSize(
            width: self.settingsCollection.bounds.width,
            height: 165
        )
    }
    
    
    override func setupStaticTexts() {
        self.titleLabel.text = "Seu espaço de \nfala"
        self.backButton.setTitle("Voltar", for: .normal)
    }
    
    
    override func setupFonts() {
        self.titleLabel.setupFont(with: FontInfo(
            fontSize: self.getEquivalent(35), weight: .bold
        ))
        
        
        self.backButton.setupFont(with: FontInfo(
            fontSize: self.getEquivalent(25), weight: .semibold, fontFamily: .graffiti
        ))
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
        let between: CGFloat = self.getEquivalent(10)
        
        let titleLabelHeight = self.getEquivalent(75)
        
        self.dynamicConstraints = [
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: between),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.backButton.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            self.titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
            
            
            self.settingsCollection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: lateral),
            self.settingsCollection.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.settingsCollection.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.settingsCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ]
    }
}
