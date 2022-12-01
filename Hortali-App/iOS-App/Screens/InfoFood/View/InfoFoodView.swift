/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elemento de UI da tela de ver informações dos aliementos
class InfoFoodView: UIView, FavoriteHandler {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Scroll View da tela
    private let scrollView = CustomScroll()
    
    /// Botão de voltar para a página anterior
    private let backButton: CustomButton = {
        let but = CustomViews.newButton()
        but.tintColor = UIColor(.favoriteNotSelectedIcon)
        return but
    }()
    
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
    
    /// Tipos de vitaminas (views para a Stack)
    private var vitaminsTypesButtons: [CustomButton] = []
    
    /// Label de informações das vitaminas
    private let mineralsLabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 3
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(AppColors.paragraph)
        lbl.lineBreakMode = .byWordWrapping
        lbl.sizeToFit()
        return lbl
    }()
    
    /// Collection  "Como plantar"
    private let howToCollection = CollectionGroup()
    
    /// Botão de sasonaliade
    private var seasonalityButton: CustomButton?
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Configurações do layout da collection
    private let collectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .horizontal
        
        return cvFlow
    }()
    
    
    
    /* MARK: - Protocol */
    
    internal var isFavorite = false
    
    internal var favoriteButton: CustomButton = CustomViews.newButton()
    
    
    internal func favoriteHandler(for fav: Bool? = nil) -> Bool {
        if let fav {
            self.isFavorite = fav
        } else {
            self.isFavorite.toggle()
        }
        
        let infos = self.favoriteInfos
        
        self.favoriteButton.backgroundColor = infos.backColor
        self.favoriteButton.tintColor = infos.iconColor
        self.setupStaticTexts()
        
        return self.isFavorite
    }
    
    
    
    /* MARK: - Construtor */
    
    init(data: ManagedFood) {
        super.init(frame: .zero)
        
        self.registerCells()
        self.setupCollectionFlow()
        
        self.hideCollection()
        
        self.setupViewFor(data: data)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

    
    /* MARK: - Encapsulamento */
    
    /// Configurações para expandir a label
    public func expandLabel() {
        self.expansiveLabel.setupExtension()
        self.scrollView.updateScrollSize()
    }
    
    
    /* Ações de botões */
    
    /// Define a ação do botão de voltar
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Define a ação do botão de expandir a label
    public func setExpLabelButtonAction(target: Any?, action: Selector) -> Void {
        self.expansiveLabel.setExpansiveButtonAction(target: target, action: action)
    }
    
    
    /// Define a ação do botão de sasonalidade
    public func setSeasonalityButtonAction(target: Any?, action: Selector) -> Void {
        self.seasonalityButton?.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Define a ação do botão das vitaminas
    public func setVitaminsButtonAction(target: Any?, action: Selector) -> Void {
        for but in self.vitaminsTypesButtons {
            but.addTarget(target, action: action, for: .touchDown)
        }
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
        self.mineralsLabel.text = data.minerals
        
        self.seasonalityButton = self.getVitaminButton(for: "S")
    }

        
    /// Cria e adiciona as views que vão ser colocadas na stack
    private func setupVitaminsStackViews(for vitamins: [ManagedVitamins]) {
        for ind in 0..<vitamins.count {
            let vitName = vitamins[ind].name
            let vitBut = self.getVitaminButton(for: vitName)
            vitBut.tag = ind
            
            self.vitaminsTypesButtons.append(vitBut)
            self.vitaminsStack.addArrangedSubview(vitBut)
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
        
        self.scrollView.addViewInScroll(self.coverImage)
        self.scrollView.addViewInScroll(self.container)
        
        self.container.contentView.addSubview(self.benefitsLabel)
        self.container.contentView.addSubview(self.expansiveLabel)
        self.container.contentView.addSubview(self.vitaminsLabel)
        self.container.contentView.addSubview(self.vitaminsStack)
        self.container.contentView.addSubview(self.mineralsLabel)
        
        self.scrollView.addViewInScroll(self.mineralsLabel)
        self.container.contentView.addSubview(self.howToCollection)
        
        if let seasonalityButton = self.seasonalityButton {
            self.addSubview(seasonalityButton)
        }
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.scrollView.updateScrollSize()
        
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
        
        self.mineralsLabel.setupText(with: FontInfo(fontSize: 20, weight: .regular))
        
        
        /* Botões */
        
        let btSize: CGFloat = self.getEquivalent(22)
        
        self.backButton.setupIcon(with: IconInfo(
            icon: .back, size: btSize, weight: .regular, scale: .default
        ))
        
        self.favoriteButton.setupIcon(with: IconInfo(
            icon: self.favoriteIcon, size: btSize, weight: .regular, scale: .default
        ))
        
        self.seasonalityButton?.setupText(with: FontInfo(
            fontSize: self.getEquivalent(45), weight: .regular, fontFamily: .graffiti
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
        
        // Botões circulares (stack)
        for but in self.vitaminsTypesButtons {
            but.circleSize = stackHeight
            but.setupText(with: FontInfo(fontSize: stackHeight, weight: .medium))
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
            self.container.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            self.benefitsLabel.topAnchor.constraint(equalTo: self.container.contentView.topAnchor),
            self.benefitsLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor, constant: lateral),
            self.benefitsLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            self.benefitsLabel.heightAnchor.constraint(equalToConstant: titlesLabelHeight),
            
            
            self.expansiveLabel.topAnchor.constraint(equalTo: self.benefitsLabel.bottomAnchor, constant: lateral),
            self.expansiveLabel.leadingAnchor.constraint(equalTo: self.benefitsLabel.leadingAnchor),
            self.expansiveLabel.trailingAnchor.constraint(equalTo: self.benefitsLabel.trailingAnchor),
            
            
            self.vitaminsLabel.topAnchor.constraint(equalTo: self.expansiveLabel.bottomAnchor, constant: between),
            self.vitaminsLabel.leadingAnchor.constraint(equalTo: self.benefitsLabel.leadingAnchor),
            self.vitaminsLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.vitaminsLabel.heightAnchor.constraint(equalToConstant: titlesLabelHeight),
            
            
            self.vitaminsStack.topAnchor.constraint(equalTo: self.vitaminsLabel.bottomAnchor, constant: lateral),
            self.vitaminsStack.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: stackSpace),
            self.vitaminsStack.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -stackSpace),
            self.vitaminsStack.heightAnchor.constraint(equalToConstant: stackHeight),
            
            
            self.mineralsLabel.topAnchor.constraint(equalTo: self.vitaminsStack.bottomAnchor, constant: lateral),
            self.mineralsLabel.leadingAnchor.constraint(equalTo: self.benefitsLabel.leadingAnchor),
            self.mineralsLabel.trailingAnchor.constraint(equalTo: self.benefitsLabel.trailingAnchor),
            
            
            self.howToCollection.topAnchor.constraint(equalTo: self.mineralsLabel.bottomAnchor, constant: between),
            self.howToCollection.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.howToCollection.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.howToCollection.heightAnchor.constraint(equalToConstant: collectionHeight),
        ]
        
        
        if let seasonalityButton = self.seasonalityButton {
            seasonalityButton.circleSize = self.getEquivalent(40)
            
            self.dynamicConstraints += [
                seasonalityButton.centerYAnchor.constraint(equalTo: self.container.titleLabel.centerYAnchor),
                seasonalityButton.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            ]
        }
        
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
        
        self.setupExpansiveLabelHeight()
    }
    
    
    /* MARK: - Outros */
    
    /// Configura a altura da label expandível
    private func setupExpansiveLabelHeight() {
        self.expansiveLabel.setupHeight()
    }
    
    
    /// Cria os botões da stack view
    private func getVitaminButton(for letter: String) -> CustomButton {
        let but = CustomViews.newButton()
        but.backgroundColor = UIColor(originalColor: .orange)
        but.setTitleColor(UIColor(originalColor: .white), for: .normal)
        
        but.isCircular = true
        but.setTitle(" \(letter) ", for: .normal)
        return but
    }
    
    
    /// Esconde a collection de como plantar (MVP)
    private func hideCollection() {
        self.howToCollection.isHidden = true
    }
}
