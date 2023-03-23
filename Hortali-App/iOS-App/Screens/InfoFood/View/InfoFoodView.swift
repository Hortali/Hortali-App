/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elemento de UI da tela de ver informações dos aliementos
class InfoFoodView: ViewWithViewCode, FavoriteHandler {
    
    /* MARK: - Atributos */
    
    private let scrollView = CustomScroll()
    
    private let backButton: CustomButton = {
        let but = CustomViews.newButton()
        but.tintColor = UIColor(.favoriteNotSelectedIcon)
        return but
    }()
    
    private let coverImage = CustomViews.newImage()
    
    private let container = ContainerView()
    
    private let benefitsLabel = CustomViews.newLabel()
    
    private let expansiveLabel = ExpansiveLabel()
    
    private let vitaminsLabel = CustomViews.newLabel()
    
    private let vitaminsStack: CustomStack = {
        let stack = CustomViews.newStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private var vitaminsTypesButtons: [CustomButton] = []
    
    private let mineralsLabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 3
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(AppColors.paragraph)
        lbl.lineBreakMode = .byWordWrapping
        lbl.sizeToFit()
        return lbl
    }()
        
    private var seasonalityButton: CustomButton?
    
    
    
    /* MARK: - Protocol */
    
    internal var isFavorite = false
    
    internal var favoriteButton: CustomButton = CustomViews.newButton()
    
    internal func setFavoriteIcon() {
        let btSize: CGFloat = self.getEquivalent(22)
        self.favoriteButton.setupIcon(with: IconInfo(
            icon: self.favoriteIcon, size: btSize, weight: .regular, scale: .default
        ))
    }
    
    
    
    /* MARK: - Construtor */
    
    init(data: ManagedFood) {
        super.init()
        self.setupViewFor(data: data)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

    
    /* MARK: - Encapsulamento */
    
    public func setExpansiveLabelDelegate(_ delegate: ExpansiveLabelDelegate) {
        self.expansiveLabel.setExpansiveLabelDelegate(delegate)
    }
    
    
    public func expandLabel() {
        self.expansiveLabel.setupExtension()
    }
    
    
    /* Ações de botões */
    
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    public func setExpLabelButtonAction(target: Any?, action: Selector) -> Void {
        self.expansiveLabel.setExpansiveButtonAction(target: target, action: action)
    }
    
    
    public func setSeasonalityButtonAction(target: Any?, action: Selector) -> Void {
        self.seasonalityButton?.addTarget(target, action: action, for: .touchDown)
    }
    
    
    public func setVitaminsButtonAction(target: Any?, action: Selector) -> Void {
        for but in self.vitaminsTypesButtons {
            but.addTarget(target, action: action, for: .touchDown)
        }
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupViewFor(data: ManagedFood) {
        self.coverImage.image = UIImage(named: data.pageImage.name)
        self.container.setTitleText(with: data.name)
        self.expansiveLabel.setInfoText(for: data.benefits)
        
        self.setupVitaminsStackViews(for: data.vitamins)
        self.mineralsLabel.text = data.minerals
        
        self.createSeasonalityButton()
    }
    
    
    private func createSeasonalityButton() {
        self.seasonalityButton = self.createDefaultCircularButton(letter: "S")
        self.addSubview(self.seasonalityButton!)
    }

        
    private func setupVitaminsStackViews(for vitamins: [ManagedVitamins]) {
        for ind in 0..<vitamins.count {
            let vitName = vitamins[ind].name
            let vitBut = self.createDefaultCircularButton(letter: vitName)
            vitBut.tag = ind
            
            self.vitaminsTypesButtons.append(vitBut)
            self.vitaminsStack.addArrangedSubview(vitBut)
        }
    }
    
    
    private func createDefaultCircularButton(letter: String) -> CustomButton {
        let but = CustomViews.newButton()
        but.backgroundColor = UIColor(originalColor: .orange)
        but.setTitleColor(UIColor(originalColor: .white), for: .normal)
        
        but.isCircular = true
        but.setTitle(" \(letter) ", for: .normal)
        return but
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.scrollView)
        
        self.addSubview(self.backButton)
        self.addSubview(self.favoriteButton)
        
        self.addViewInScroll(self.coverImage)
        self.addViewInScroll(self.container)
        
        self.addViewInContent(self.benefitsLabel)
        self.addViewInContent(self.expansiveLabel)
        self.addViewInContent(self.vitaminsLabel)
        self.addViewInContent(self.vitaminsStack)
        self.addViewInContent(self.mineralsLabel)
        
        self.addViewInScroll(self.mineralsLabel)
    }
    
    
    private func addViewInScroll(_ view: UIView) {
        self.scrollView.addViewInScroll(view)
    }
    
    
    private func addViewInContent(_ view: UIView) {
        self.container.contentView.addSubview(view)
    }
    
    
    override func setupUI() {
        self.updateScrollSize()
    }
    
    
    public func updateScrollSize() {
        self.scrollView.updateScrollSize()
    }
    
    
    override func setupStaticTexts() {
        self.benefitsLabel.text = "Benefícios"
        self.vitaminsLabel.text = "Vitaminas"
    }
    
    
    override func setupFonts() {
        self.setupLabelsFont()
        self.setupButtonsIcon()
    }
    
    
    private func setupLabelsFont() {
        let titleFont = FontInfo(fontSize: self.getEquivalent(25), weight: .medium)
        self.benefitsLabel.setupFont(with: titleFont)
        self.vitaminsLabel.setupFont(with: titleFont)
        
        let descriptionFont = FontInfo(fontSize: 20, weight: .regular)
        self.mineralsLabel.setupFont(with: descriptionFont)
        
        let seasonalityFont = FontInfo(fontSize: self.getEquivalent(45), weight: .regular, fontFamily: .graffiti)
        self.seasonalityButton?.setupFont(with: seasonalityFont)
    }
    
    
    private func setupButtonsIcon() {
        let btSize: CGFloat = self.getEquivalent(22)
        
        self.backButton.setupIcon(with: IconInfo(
            icon: .back, size: btSize, weight: .regular, scale: .default
        ))
        
        self.setFavoriteIcon()
    }
    
        
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.coverImage.topAnchor.constraint(equalTo: self.scrollView.contentView.topAnchor),
            self.coverImage.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.coverImage.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            
            
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            self.favoriteButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            
            
            /* Container */
            
            self.container.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            self.benefitsLabel.topAnchor.constraint(equalTo: self.container.contentView.topAnchor),
            
            self.expansiveLabel.leadingAnchor.constraint(equalTo: self.benefitsLabel.leadingAnchor),
            self.expansiveLabel.trailingAnchor.constraint(equalTo: self.benefitsLabel.trailingAnchor),
            
    
            self.vitaminsLabel.leadingAnchor.constraint(equalTo: self.benefitsLabel.leadingAnchor),
            self.vitaminsLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            
            self.mineralsLabel.leadingAnchor.constraint(equalTo: self.benefitsLabel.leadingAnchor),
            self.mineralsLabel.trailingAnchor.constraint(equalTo: self.benefitsLabel.trailingAnchor),
        
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        self.setButtonsHeight()
        self.setDynamicConstraints()
        self.createVitaminsStackContraints()
        self.createSeasonalityButtonConstraints()
        self.setupExpansiveLabelHeight()
    }
    
    
    private func setButtonsHeight() {
        let height = self.getEquivalent(45)
        self.backButton.circleSize = height
        self.favoriteButton.circleSize = height
    }
    
    
    private func setDynamicConstraints() {
        // Espaçamentos
        let lateral = self.getEquivalent(15)
        let between = self.getEquivalent(20)
        let gap = self.getEquivalent(25)
        
        // Altura dos elementos
        let imageHeight = self.getEquivalent(510)
        let titlesLabelHeight = self.getEquivalent(25)
        
        
        self.dynamicConstraints = [
            self.coverImage.heightAnchor.constraint(equalToConstant: imageHeight),
            
            self.backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: lateral),
            
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -lateral),
            
            
            /* Container */
            
            self.container.topAnchor.constraint(equalTo: self.coverImage.bottomAnchor, constant: -gap),
            
            
            self.benefitsLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor, constant: lateral),
            self.benefitsLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
    
            
            self.expansiveLabel.topAnchor.constraint(equalTo: self.benefitsLabel.bottomAnchor, constant: lateral),
            
            
            self.vitaminsLabel.topAnchor.constraint(equalTo: self.expansiveLabel.bottomAnchor, constant: between),
            self.vitaminsLabel.heightAnchor.constraint(equalToConstant: titlesLabelHeight),
            
            
            self.mineralsLabel.topAnchor.constraint(equalTo: self.vitaminsStack.bottomAnchor, constant: lateral),
        ]
    }
    
    
    private func createVitaminsStackContraints() {
        self.setButtonsHeightFromVitaminsStack()
        self.setVitaminsStackContraints()
    }
    
    
    private func setButtonsHeightFromVitaminsStack() {
        let height = self.vitaminsStack.bounds.height
        self.vitaminsTypesButtons.forEach() {
            $0.circleSize = height
            $0.setupFont(with: FontInfo(fontSize: height, weight: .medium))
        }
    }
    
    
    private func setVitaminsStackContraints() {
        let between = self.getEquivalent(15)
        let height = self.getEquivalent(35)
        let lateral = self.getLateralPaddingForStack(stackHeight: height)
        
        self.dynamicConstraints += [
            self.vitaminsStack.topAnchor.constraint(equalTo: self.vitaminsLabel.bottomAnchor, constant: between),
            self.vitaminsStack.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: lateral),
            self.vitaminsStack.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -lateral),
            self.vitaminsStack.heightAnchor.constraint(equalToConstant: height),
        ]
    }
    
    
    private func getLateralPaddingForStack(stackHeight: CGFloat) -> CGFloat {
        return self.vitaminsStack.getEqualSpace(for: stackHeight)
    }
    
    
    private func createSeasonalityButtonConstraints() {
        guard let seasonalityButton else { return }
        
        let lateral = self.getEquivalent(15)
        let btHeight = self.getEquivalent(40)
        
        seasonalityButton.circleSize = btHeight
        
        self.dynamicConstraints += [
            seasonalityButton.centerYAnchor.constraint(equalTo: self.container.titleLabel.centerYAnchor),
            seasonalityButton.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
        ]
    }
    

    private func setupExpansiveLabelHeight() {
        self.expansiveLabel.setupHeight()
    }
}
