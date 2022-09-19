/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class InfoGardenView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Scroll View da tela
    private let scrollView = CustomScroll()
    
    /// Botão de voltar para a página anterior
    private let backButton = CustomViews.newButton()
    
    /// Botão de favoritar a hora
    private let favoriteButton = CustomViews.newButton()
    
    /// Conjunto de imagens da horta
    private let imagesCollectionGp: CollectionGroup = {
        let colGp = CollectionGroup(style: .justCollection)
        colGp.collection.isPagingEnabled = true
        return colGp
    }()

    /// Controle de páginas
    private let imagesPageControl = CustomViews.newPageControl()
    
    /// Grupo de UI para colocar os elementos de informação sobre a horta
    private let container = ContainerView()
    
    /// Label expandível
    private let expansiveLabel = ExpansiveLabel()
    
    /// Collection de informações sobre a horta
    private let infosCollectionGp = CollectionGroup(style: .justCollection)
        
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Configurações do layout da collection de informações
    private let infosCollectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .horizontal
        return cvFlow
    }()
    
    /// Configurações do layout da collection de imagens
    private let imagesCollectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .horizontal
        cvFlow.minimumLineSpacing = 0
        return cvFlow
    }()



    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
        self.registerCell()
        self.setupCollectionFlow()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    
    /// Atualiza a pa'gina no Page Control
    /// - Parameter index: index (número) da página
    public func updateCurrentPage(for index: Int) {
        self.imagesPageControl.currentPage = index
    }
    

    /* Ações de botões */
    
    /// Ação do botão de voltar
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Ação do botão de favorito
    public func setFavoriteButtonAction(target: Any?, action: Selector) -> Void {
        self.favoriteButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /* Collection */
    
    public func setInfoDataSource(for dataSource: InfoGardenInfosDataSource) {
        self.infosCollectionGp.collection.dataSource = dataSource
    }
    
    
    public func setInfoDelegate(for delegate: InfoGardenInfosDelegate) {
        self.infosCollectionGp.collection.delegate = delegate
    }
    
    
    public func setImagesDataSource(for dataSource: InfoGardenImagesDataSource) {
        self.imagesCollectionGp.collection.dataSource = dataSource
        self.imagesPageControl.numberOfPages = dataSource.getDataCount()
    }
    
    public func setImagesDelegate(for delegate: InfoGardenImagesDelegate) {
        self.imagesCollectionGp.collection.delegate = delegate
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
    private func registerCell() {
        self.infosCollectionGp.collection.register(InfoGardenInfosCell.self, forCellWithReuseIdentifier: InfoGardenInfosCell.identifier)
        
        self.imagesCollectionGp.collection.register(InfoGardenImagesCell.self, forCellWithReuseIdentifier: InfoGardenImagesCell.identifier)
    }


    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.infosCollectionGp.collection.collectionViewLayout = self.infosCollectionFlow
        self.imagesCollectionGp.collection.collectionViewLayout = self.imagesCollectionFlow
    }


    /* Geral */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.scrollView)
                
        self.scrollView.contentView.addSubview(self.imagesCollectionGp)
        self.scrollView.contentView.addSubview(self.imagesPageControl)
        self.scrollView.contentView.addSubview(self.backButton)
        self.scrollView.contentView.addSubview(self.favoriteButton)
        self.scrollView.contentView.addSubview(self.container)
        
        self.container.contentView.addSubview(self.expansiveLabel)
        self.scrollView.contentView.addSubview(self.infosCollectionGp)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.imagesPageControl.layer.cornerRadius = self.imagesPageControl.bounds.height/2
        
        self.scrollView.scrollContentSize = CGSize(
            width: self.getEquivalent(self.bounds.width),
            height: self.getEquivalent(870)
        )
        
        
        self.infosCollectionFlow.itemSize = CGSize(
            width: self.getEquivalent(350),
            height: self.getEquivalent(200)
        )
        self.infosCollectionFlow.minimumLineSpacing = self.getEquivalent(10)
        
        
        self.imagesCollectionFlow.itemSize = CGSize(
            width: self.getEquivalent(390),
            height: self.getEquivalent(510)
        )
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /* Labels */
        self.container.setTitleText(with: "Horta Comunitária da Saúde")
        
        
        /* Botões */
        let btSize: CGFloat = self.getEquivalent(22)
        
        self.backButton.setupIcon(with: IconInfo(
            icon: .back, size: btSize, weight: .regular, scale: .default
        ))
        
        self.favoriteButton.setupIcon(with: IconInfo(
            icon: .favorite, size: btSize, weight: .regular, scale: .default
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        // Espaçamentos
        let lateral = self.getEquivalent(15)
        let between = self.getEquivalent(20)
        let gap = self.getEquivalent(25)
        
        let safeAreaGap = self.scrollView.scroll.safeAreaInsets.top
        
        
        // Altura dos botões
        self.backButton.circleSize = self.getEquivalent(45)
        self.favoriteButton.circleSize = self.getEquivalent(45)
        
        
        // Altura dos elementos
        let segHeight = self.getEquivalent(510)
        
        let containerHeight = self.getEquivalent(435)
        let expLabelHeight = self.getEquivalent(85)
        let collectionHeight = self.getEquivalent(200)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.imagesCollectionGp.topAnchor.constraint(equalTo: self.scrollView.contentView.topAnchor),
            self.imagesCollectionGp.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.imagesCollectionGp.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.imagesCollectionGp.heightAnchor.constraint(equalToConstant: segHeight),
            
            
            self.imagesPageControl.bottomAnchor.constraint(equalTo: self.container.topAnchor, constant: -between / 2),
            self.imagesPageControl.centerXAnchor.constraint(equalTo: self.imagesCollectionGp.centerXAnchor),
            
            
            self.backButton.topAnchor.constraint(equalTo: self.scrollView.contentView.topAnchor, constant: safeAreaGap),
            self.backButton.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor, constant: lateral),


            self.favoriteButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor, constant: -lateral),
            
            
            /* Container */
            
            self.container.topAnchor.constraint(equalTo: self.imagesCollectionGp.bottomAnchor, constant: -gap),
            self.container.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.container.heightAnchor.constraint(equalToConstant: containerHeight),
            

            self.expansiveLabel.topAnchor.constraint(equalTo: self.container.contentView.topAnchor),
            self.expansiveLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.expansiveLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            self.expansiveLabel.heightAnchor.constraint(equalToConstant: expLabelHeight),
            
            
            self.infosCollectionGp.topAnchor.constraint(equalTo: self.expansiveLabel.bottomAnchor, constant: between),
            self.infosCollectionGp.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.infosCollectionGp.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.infosCollectionGp.heightAnchor.constraint(equalToConstant: collectionHeight)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}