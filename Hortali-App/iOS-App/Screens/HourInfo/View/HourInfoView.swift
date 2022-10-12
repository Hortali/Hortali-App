/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class HourInfoView: ContainerView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Collection principal da tela
    private let hourInfoGp = CollectionGroup(style: .justCollection)
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
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
        self.registerCell()
        self.setupCollectionFlow()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define o data source personalizado da collection
    /// - Parameter dataSource: data source da collection
    public func setDataSource(with dataSource: HourInfoDataSource) {
        self.hourInfoGp.collection.dataSource = dataSource
    }
    
    
    /// Atualiza os dados da collection
    public func reloadCollectionData() {
        self.hourInfoGp.collection.reloadData()
        self.hourInfoGp.collection.reloadInputViews()
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
    private func registerCell() {
        self.hourInfoGp.collection.register(HourInfoCell.self, forCellWithReuseIdentifier: HourInfoCell.identifier)
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.hourInfoGp.collection.collectionViewLayout = self.collectionFlow
    }

    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(hourInfoGp)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        // Define o tamanho que a célula vai ter
        self.collectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
        self.collectionFlow.itemSize = CGSize(width: hourInfoGp.frame.width, height: 60)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.setTitleText(with: "Horário de funcionamento")
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.hourInfoGp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: lateral),
            self.hourInfoGp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.hourInfoGp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -lateral),
            self.hourInfoGp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
