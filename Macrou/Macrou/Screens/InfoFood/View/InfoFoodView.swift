/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class InfoFoodView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Scroll View da tela
    private let scrollView = CustomScroll()
    
    /// Botão de voltar para a página anterior
    private let backButton = CustomViews.newButton()
    
    /// Botão de favoritar o alimento
    private let favoriteButton = CustomViews.newButton()
    
    /// Capa do alimento
    private let coverImage = CustomViews.newImage()
    
    /// Grupo de UI para colocar os elementos de informação sobre o alimento
    private let container = ContainerView()
    
    /// Label expandível
    private let expansiveLabel = ExpansiveLabel()
    
    /// Label seção vitaminas
    private let vitaminsLabel = CustomViews.newLabel()
    
    /// Label primeira vitmaina
    private let firstVitaminLabel = CustomViews.newLabel()
    
    /// Label segunda vitmaina
    private let secondVitaminLabel = CustomViews.newLabel()
    
    /// Label terceira vitmaina
    private let thirdVitaminLabel = CustomViews.newLabel()
    
    /// Collection  "Como plantar"
    private let howToCollection = CollectionGroup()
    
    /// Label de informações das vitaminas
    private let vitaminsInfoLabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 3
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(AppColors.paragraph)
        return lbl
    }()
    
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
    
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
        self.registerCells()
        self.setupCollectionFlow()
        
        self.coverImage.backgroundColor = .red
       // self.howToCollection.collection.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /* Ações de botões */
    
    /// Define a ação do botão de voltar
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Define a ação do botão de favorito
    public func setFavoriteButtonAction(target: Any?, action: Selector) -> Void {
        self.favoriteButton.addTarget(target, action: action, for: .touchDown)
    }
    
    public func setDataSource(with dataSource: GardenDataSource) {
        self.howToCollection.collection.dataSource = dataSource
    }
    
    /// Define o delegate da collection das hortas
    /// - Parameter delegate: delegate da collection das hortas
    public func setDelegate(with delegate: GardenDelegate) {
        self.howToCollection.collection.delegate = delegate
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.howToCollection.collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)

    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.howToCollection.collection.collectionViewLayout = self.collectionFlow
    }
    
    
    /* Geral */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.scrollView)
        
        self.scrollView.contentView.addSubview(self.coverImage)
        self.scrollView.contentView.addSubview(self.backButton)
        self.scrollView.contentView.addSubview(self.favoriteButton)
        self.scrollView.contentView.addSubview(self.container)
        
        self.container.contentView.addSubview(self.expansiveLabel)
        self.container.contentView.addSubview(self.vitaminsLabel)
        self.container.contentView.addSubview(self.firstVitaminLabel)
        self.container.contentView.addSubview(self.secondVitaminLabel)
        self.container.contentView.addSubview(self.thirdVitaminLabel)
        self.container.contentView.addSubview(self.vitaminsInfoLabel)
        self.container.contentView.addSubview(self.howToCollection)
        
        self.firstVitaminLabel.backgroundColor = .red
        self.secondVitaminLabel.backgroundColor = .blue
        self.thirdVitaminLabel.backgroundColor = .green
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.scrollView.scrollContentSize = CGSize(
            width: self.getEquivalent(self.bounds.width),
            height: self.getEquivalent(1340)
        )
        self.collectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
        self.collectionFlow.itemSize = CGSize(width: self.getEquivalent(250),
                                              height: self.getEquivalent(400))
        print("Print da collection: \(howToCollection)")
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /* Labels */
        self.container.setTitleText(with: "Morango")
        self.vitaminsLabel.setupText(with: FontInfo(text: "Vitaminas", fontSize: 25, weight: .medium))
        self.vitaminsInfoLabel.setupText(with: FontInfo(text: "E minerais como AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA agscyaiBVCYavcbkasjbuicgvaeYI", fontSize: 20, weight: .regular))
        self.howToCollection.titleLabel.setupText(with: FontInfo(text: "Como Plantar", fontSize: 25, weight: .medium))
        
        
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
        //      // Espaçamentos
        let lateral = self.getEquivalent(15)
        let between = self.getEquivalent(20)
        let gap = self.getEquivalent(25)
        //let vitaminsGap = self.getEquivalent(72)
        let howToGap = self.getEquivalent(12)
        
        let safeAreaGap = self.scrollView.scroll.safeAreaInsets.top
        
        // Altura dos botões
        self.backButton.circleSize = self.getEquivalent(45)
        self.favoriteButton.circleSize = self.getEquivalent(45)
        
        // Altura dos elementos
        let segHeight = self.getEquivalent(510)
        let containerHeight = self.getEquivalent(435)
        let expLabelHeight = self.getEquivalent(85)
        let collectionHeight = self.getEquivalent(400)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.coverImage.topAnchor.constraint(equalTo: self.scrollView.contentView.topAnchor),
            self.coverImage.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.coverImage.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.coverImage.heightAnchor.constraint(equalToConstant: segHeight),
            
            
            self.backButton.topAnchor.constraint(equalTo: self.scrollView.contentView.topAnchor, constant: safeAreaGap),
            self.backButton.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor, constant: lateral),
            
            
            self.favoriteButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor, constant: -lateral),
            
            
            /* Container */
            
            self.container.topAnchor.constraint(equalTo: self.coverImage.bottomAnchor, constant: -gap),
            self.container.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.container.heightAnchor.constraint(equalToConstant: containerHeight),
            
            
            self.expansiveLabel.topAnchor.constraint(equalTo: self.container.contentView.topAnchor),
            self.expansiveLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.expansiveLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            self.expansiveLabel.heightAnchor.constraint(equalToConstant: expLabelHeight),
            
            
            self.vitaminsLabel.topAnchor.constraint(equalTo: self.expansiveLabel.bottomAnchor, constant: between),
            self.vitaminsLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.vitaminsLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.vitaminsLabel.heightAnchor.constraint(equalToConstant: gap),
            
            /// Label das vitaminas presentes em cada alimento
            self.firstVitaminLabel.topAnchor.constraint(equalTo: self.vitaminsLabel.bottomAnchor, constant: lateral),
            self.firstVitaminLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor, constant: getEquivalent(55)),
            self.firstVitaminLabel.widthAnchor.constraint(equalToConstant: gap),
            self.firstVitaminLabel.heightAnchor.constraint(equalToConstant: gap),
            
            
            self.secondVitaminLabel.topAnchor.constraint(equalTo: firstVitaminLabel.topAnchor),
            self.secondVitaminLabel.centerXAnchor.constraint(equalTo: self.container.contentView.centerXAnchor),
            self.secondVitaminLabel.widthAnchor.constraint(equalToConstant: gap),
            self.secondVitaminLabel.heightAnchor.constraint(equalToConstant: gap),
            
            
            self.thirdVitaminLabel.topAnchor.constraint(equalTo: firstVitaminLabel.topAnchor),
            self.thirdVitaminLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: getEquivalent(-55)),
            self.thirdVitaminLabel.widthAnchor.constraint(equalToConstant: gap),
            self.thirdVitaminLabel.heightAnchor.constraint(equalToConstant: gap),
            
            
            /// Informações sobre as vitaminas
            self.vitaminsInfoLabel.topAnchor.constraint(equalTo: firstVitaminLabel.bottomAnchor, constant: lateral),
            self.vitaminsInfoLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.vitaminsInfoLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.vitaminsInfoLabel.heightAnchor.constraint(equalToConstant: getEquivalent(65)),
            
            
            self.howToCollection.topAnchor.constraint(equalTo: vitaminsInfoLabel.bottomAnchor, constant: between),
            self.howToCollection.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.howToCollection.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.howToCollection.bottomAnchor.constraint(equalTo: self.container.contentView.bottomAnchor),
            
            
            
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
