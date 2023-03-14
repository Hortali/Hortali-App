/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Componentes de UI da tela que mostra os hor;arios de funcionamento
class HourInfoView: ContainerView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Collection principal da tela
    private let hourInfoCollection: CustomCollection = {
        let col = CustomCollection()
        col.collection.backgroundColor = UIColor(originalColor: .greenLight)
        return col
    }()
    
    /// Barra superior
    private let homeIndicatorView: UIView = {
        let view = CustomViews.newView()
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor(originalColor: .white)
        return view
    }()
    
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
        
        self.registerCell()
        self.setupCollectionFlow()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define o data source personalizado da collection
    /// - Parameter dataSource: data source da collection
    public func setDataSource(with dataSource: HourInfoDataSource) {
        self.hourInfoCollection.collection.dataSource = dataSource
    }
    
    
    /// Atualiza os dados da collection
    public func reloadCollectionData() {
        self.hourInfoCollection.collection.reloadData()
        self.hourInfoCollection.collection.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */
    
    private func registerCell() {
        self.hourInfoCollection.collection.register(HourInfoCell.self, forCellWithReuseIdentifier: HourInfoCell.identifier)
    }
    
    
    private func setupCollectionFlow() {
        self.hourInfoCollection.collection.collectionViewLayout = self.collectionFlow
    }

    
    override func setupHierarchy() {
        self.contentView.addSubview(self.hourInfoCollection)
        self.contentView.addSubview(self.homeIndicatorView)
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupView() {
        self.setBackgroundColors()
    }
    
    
    private func setBackgroundColors() {
        self.backgroundColor = UIColor(originalColor: .greenLight)
        self.contentView.backgroundColor = UIColor(originalColor: .greenLight)
        
    }
    
    
    override func setupUI() {
        self.setCollectionItemSize()
    }
    
    
    private func setCollectionItemSize() {
        self.collectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
        self.collectionFlow.itemSize = CGSize(width: self.hourInfoCollection.frame.width, height: 60)
    }
    
    
    override func setupStaticTexts() {
        self.setTitleText(with: "Horário de funcionamento")
        self.titleLabel.textColor = UIColor(originalColor: .greenDark)
    }
    
    
    override func createDynamicConstraints() {
        let lateral = self.getEquivalent(15)
        let width = self.getEquivalent(70)
        let space = self.getEquivalent(5)
        
        self.dynamicConstraints = [
            self.hourInfoCollection.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: lateral),
            self.hourInfoCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.hourInfoCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.hourInfoCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.homeIndicatorView.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            self.homeIndicatorView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.homeIndicatorView.heightAnchor.constraint(equalToConstant: space),
            self.homeIndicatorView.widthAnchor.constraint(equalToConstant: width)
        ]
    }
}
