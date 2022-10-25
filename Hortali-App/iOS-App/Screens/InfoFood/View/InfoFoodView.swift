/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elemento de UI da tela de ver informações dos aliementos
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
    
    /// Label de título dos benefícios
    private let benefitsLabel = CustomViews.newLabel()
    
    /// Label expandível
    private let expansiveLabel = ExpansiveLabel()
    
    /// Label seção vitaminas
    private let vitaminsLabel = CustomViews.newLabel()
    
    /// Stack das labels de vitamina
    private let vitaminsStack: CustomStack = {
        let stack = CustomViews.newStackView()
        stack.sameDimensionValue = .height
        stack.axis = .horizontal
        return stack
    }()
    
    /// Label dos tipos de vitaminas (views para a Stack)
    private var vitaminsTypesLabels: [CustomLabel] = []
    
    /// Label de informações das vitaminas
    private let vitaminsInfoLabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 3
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(AppColors.paragraph)
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    /// Collection  "Como plantar"
    private let howToCollection = CollectionGroup()
    
    
    // Views
    
    /// Estado de favorito da view
    private var ifFavorite: Bool = false
    
    
    
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
    
    init(data: ManagedFood) {
        super.init(frame: .zero)
        
        self.setupViews()
        self.registerCells()
        self.setupCollectionFlow()
        
        self.hideCollection()
        
        self.setupViewFor(data: data)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

    
    /* MARK: - Encapsulamento */
    
    /// Configura a view para quando for favoritado ou desfavoritado
    /// - Parameter fav: estado do favorito
    /// - Returns: se está ou não favoritado
    public func isFavorited(is fav: Bool? = nil) -> Bool {
        if let fav {
            self.ifFavorite = fav
        } else {
            self.ifFavorite.toggle()
        }
        
        var favColor: AppColors = .favoriteNotSelected
        if self.ifFavorite {
            favColor = .favoriteSelected
        }
        
        self.favoriteButton.backgroundColor = UIColor(favColor)
        
        return self.ifFavorite
    }
    
        
    /// Configurações para expandir a label
    public func expandLabel() {
        var status = self.expansiveLabel.isExtended
        status.toggle()
        
        self.expansiveLabel.setupExtension(extended: status)
        self.expansiveLabel.setupButtonIcon()
        self.setupExpansiveLabelHeight()
        self.updateScrollSize()
    }
    
    
    /* Ações de botões */
    
    /// Define a ação do botão de voltar
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Define a ação do botão de favorito
    public func setFavoriteButtonAction(target: Any?, action: Selector) -> Void {
        self.favoriteButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Define a ação do botão de expandir a label
    public func setExpLabelButtonAction(target: Any?, action: Selector) -> Void {
        self.expansiveLabel.setExpansiveButtonAction(target: target, action: action)
    }
    
    
    /* Collection */
    
    /// Define o data source da collection de como plantar
    /// - Parameter dataSource: data source da collection de como plantar
    public func setDataSource(with dataSource: GardenDataSource) {
        self.howToCollection.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection de como plantar
    /// - Parameter delegate: delegate da collection de como plantar
    public func setDelegate(with delegate: GardenDelegate) {
        self.howToCollection.collection.delegate = delegate
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Geral */
    
    /// Configura a view a partir dos dados recebidos
    /// - Parameter data: dados recebidos
    private func setupViewFor(data: ManagedFood) {
        self.coverImage.image = UIImage(named: data.pageImage.name)
        
        self.container.setTitleText(with: data.name)
        self.expansiveLabel.setInfoText(for: data.benefits)
        
        self.setupVitaminsStackViews(for: data.vitamins)
        self.vitaminsInfoLabel.text = data.minerals
    }
    
    
    /// Define o tamanho que a scroll vai ter
    private func updateScrollSize() {
        var scrollHeight: CGFloat = 1350 - (465) // Collection escondida
        
        if self.expansiveLabel.isExtended {
            scrollHeight += self.expansiveLabel.expandedLabelSize
        }
        
        self.scrollView.scrollContentSize = CGSize(
            width: self.getEquivalent(self.bounds.width),
            height: scrollHeight
        )
    }
    
    
    /// Cria e adiciona as views que vão ser colocadas na stack
    private func setupVitaminsStackViews(for vitamins: [ManagedVitamins]) {
        for vitamin in vitamins {
            let vitLabel = self.getVitaminLabel(for: vitamin)
            
            self.vitaminsTypesLabels.append(vitLabel)
            self.vitaminsStack.addArrangedSubview(vitLabel)
        }
    }
    
    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.howToCollection.collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)

    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.howToCollection.collection.collectionViewLayout = self.collectionFlow
    }
    
    
    /* View */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.scrollView)
        
        self.addSubview(self.backButton)
        self.addSubview(self.favoriteButton)
        
        self.scrollView.contentView.addSubview(self.coverImage)
        self.scrollView.contentView.addSubview(self.container)
        
        self.container.contentView.addSubview(self.benefitsLabel)
        self.container.contentView.addSubview(self.expansiveLabel)
        self.container.contentView.addSubview(self.vitaminsLabel)
        self.container.addSubview(self.vitaminsStack)
        self.container.contentView.addSubview(self.vitaminsInfoLabel)
        self.container.contentView.addSubview(self.howToCollection)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.updateScrollSize()
        
        // Collection
        self.collectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
        
        self.collectionFlow.itemSize = CGSize(
            width: self.getEquivalent(250),
            height: self.howToCollection.collection.bounds.height
        )
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /* Labels */
        let titleFontSize = self.getEquivalent(25)
        
        self.benefitsLabel.setupText(with: FontInfo(
            text: "Benefícios", fontSize: titleFontSize, weight: .medium
        ))
        
        self.vitaminsLabel.setupText(with: FontInfo(
            text: "Vitaminas", fontSize: titleFontSize, weight: .medium
        ))
        
        self.howToCollection.titleLabel.setupText(with: FontInfo(
            text: "Como Plantar", fontSize: titleFontSize, weight: .medium
        ))
        
        self.vitaminsInfoLabel.setupText(with: FontInfo(fontSize: 20, weight: .regular))
        
        
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

        
        // Altura dos botões
        self.backButton.circleSize = self.getEquivalent(45)
        self.favoriteButton.circleSize = self.getEquivalent(45)
        
        // Altura dos elementos
        let imageHeight = self.getEquivalent(510)
        let titlesLabelHeight = self.getEquivalent(25)
        let collectionHeight = self.getEquivalent(400)
        
        // Stack
        let stackHeight = self.getEquivalent(35)
        let stackSpace = self.vitaminsStack.getEqualSpace(for: stackHeight)
        
        // Labels circulares (stack)
        for label in self.vitaminsTypesLabels {
            label.circleSize = stackHeight
        }
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.coverImage.topAnchor.constraint(equalTo: self.scrollView.contentView.topAnchor),
            self.coverImage.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.coverImage.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.coverImage.heightAnchor.constraint(equalToConstant: imageHeight),
            
            
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: lateral),
            
            
            self.favoriteButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -lateral),
            
            
            /* Container */
            
            self.container.topAnchor.constraint(equalTo: self.coverImage.bottomAnchor, constant: -gap),
            self.container.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.scrollView.contentView.bottomAnchor),
            
            
            self.benefitsLabel.topAnchor.constraint(equalTo: self.container.contentView.topAnchor),
            self.benefitsLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.benefitsLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            self.benefitsLabel.heightAnchor.constraint(equalToConstant: titlesLabelHeight),
            
            
            self.expansiveLabel.topAnchor.constraint(equalTo: self.benefitsLabel.bottomAnchor, constant: lateral),
            self.expansiveLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.expansiveLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            
            
            self.vitaminsLabel.topAnchor.constraint(equalTo: self.expansiveLabel.bottomAnchor, constant: between),
            self.vitaminsLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.vitaminsLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.vitaminsLabel.heightAnchor.constraint(equalToConstant: titlesLabelHeight),
            
            
            self.vitaminsStack.topAnchor.constraint(equalTo: self.vitaminsLabel.bottomAnchor, constant: lateral),
            self.vitaminsStack.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: stackSpace),
            self.vitaminsStack.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -stackSpace),
            self.vitaminsStack.heightAnchor.constraint(equalToConstant: stackHeight),
            
            
            self.vitaminsInfoLabel.topAnchor.constraint(equalTo: self.vitaminsStack.bottomAnchor, constant: lateral),
            self.vitaminsInfoLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.vitaminsInfoLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            self.vitaminsInfoLabel.heightAnchor.constraint(equalToConstant: self.getEquivalent(65)),
            
            
            self.howToCollection.topAnchor.constraint(equalTo: self.vitaminsInfoLabel.bottomAnchor, constant: between),
            self.howToCollection.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.howToCollection.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.howToCollection.heightAnchor.constraint(equalToConstant: collectionHeight),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
        
        self.setupExpansiveLabelHeight()
    }
    
    
    /* MARK: - Outros */
    
    /// Configura a altura da label expandível
    private func setupExpansiveLabelHeight() {
        self.expansiveLabel.setupHeight()
    }
    
    
    /// Cria as labels da stack view
    private func getVitaminLabel(for vitamins: ManagedVitamins) -> CustomLabel {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(originalColor: .orange)
        lbl.textColor = UIColor(originalColor: .white)
        lbl.textAlignment = .center
        
        lbl.isCircular = true
        
        lbl.text = vitamins.name
        return lbl
    }
    
    
    /// Esconde a collection de como plantar (MVP)
    private func hideCollection() {
        self.howToCollection.isHidden = true
    }
}
