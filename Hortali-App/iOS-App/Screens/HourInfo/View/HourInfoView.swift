/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Componentes de UI da tela que mostra os hor;arios de funcionamento
class HourInfoView: ContainerView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Collection principal da tela
    private let hourInfoGp = CollectionGroup(style: .justCollection)
    
    /// Barra superior
    private let homeIndicatorView: UIView = {
        let view = CustomViews.newView()
        view.backgroundColor = UIColor(originalColor: .white)

        return view
    }()
    
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
        self.setupStaticTexts()
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
        self.contentView.addSubview(self.hourInfoGp)
        self.contentView.addSubview(self.homeIndicatorView)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
       // Define a cor do background
        self.hourInfoGp.collection.backgroundColor = UIColor(originalColor: .greenLight)
        self.contentView.backgroundColor = UIColor(originalColor: .greenLight)
        self.backgroundColor = UIColor(originalColor: .greenLight)
        
        // Define o tamanho que a célula vai ter
        self.collectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
        self.collectionFlow.itemSize = CGSize(width: self.hourInfoGp.frame.width, height: 60)
        
        // Define o aredondamento do indicador de Scroll
        homeIndicatorView.layer.cornerRadius = 3
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.setTitleText(with: "Horário de funcionamento")
        self.titleLabel.textColor = UIColor(originalColor: .greenDark)
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral = self.getEquivalent(15)
        let width = self.getEquivalent(70)
        let space = self.getEquivalent(5)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.hourInfoGp.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: lateral),
            self.hourInfoGp.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.hourInfoGp.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.hourInfoGp.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.homeIndicatorView.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            self.homeIndicatorView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.homeIndicatorView.heightAnchor.constraint(equalToConstant: space),
            self.homeIndicatorView.widthAnchor.constraint(equalToConstant: width)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
