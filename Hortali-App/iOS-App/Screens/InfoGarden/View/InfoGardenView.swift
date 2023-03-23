/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class InfoGardenView: ViewWithViewCode, FavoriteHandler {
    
    /* MARK: - Atributos */
    
    // Views
    
    private let scrollView = CustomScroll()
    
    private let backButton: CustomButton = {
        let but = CustomViews.newButton()
        but.tintColor = UIColor(.favoriteNotSelectedIcon)
        return but
    }()
    
    final let imagesCollection: CustomCollection = {
        let col = CustomCollection()
        col.collection.isPagingEnabled = true
        return col
    }()

    private let imagesPageControl = CustomViews.newPageControl()
    
    private let container = ContainerView()
    
    final let tagsCollection = CustomCollection()
    
    private let expansiveLabel = ExpansiveLabel()
    
    final let infosCollection = CustomCollection()
    
    private let lastUpdateLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(originalColor: .greenLight)
        return lbl
    }()
        
    
    // Outros
    
    /// Fala qual é o dia da semana de hoje
    static var todayWeek: String = ""
    
    
    
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
    
    init(data: ManagedGarden) {
        super.init()
        self.setupViewFor(data: data)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func updateCurrentPage(for index: Int) {
        self.imagesPageControl.currentPage = index
    }
    
    
    public func updateCurrentCell(for index: Int) {
        self.imagesCollection.collection.scrollToItem(
            at: IndexPath(row: index, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    
    public func expandLabel() {
        self.expansiveLabel.setupExtension()
        self.scrollView.updateScrollSize()
    }

    
    /* Ações de botões */
    
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    public func setFavoriteButtonAction(target: Any?, action: Selector) -> Void {
        self.favoriteButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    public func setExpLabelButtonAction(target: Any?, action: Selector) -> Void {
        self.expansiveLabel.setExpansiveButtonAction(target: target, action: action)
    }
    
    
    public func setPageControlAction(target: Any?, action: Selector) -> Void {
        self.imagesPageControl.addTarget(target, action: action, for: .valueChanged)
    }
    
    
    /* Collection */
        
    public func reloadCollectionsData() {
        self.imagesCollection.reloadCollectionData()
        self.infosCollection.reloadCollectionData()
        self.tagsCollection.reloadCollectionData()
    }
        
    
    public func setNumbersOgPagesInPageControl(_ num: Int) {
        self.imagesPageControl.numberOfPages = num
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Geral */
    
    private func setupViewFor(data: ManagedGarden) {
        self.container.setTitleText(with: data.name)
        self.expansiveLabel.setInfoText(for: data.biograph)
        
        let lastUpdateDate = self.getDate(for: data.lastUpdate)
        self.lastUpdateLabel.text = "*Última atualização: \(lastUpdateDate)"
    }
    
    
    private func getDate(for strDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt-br")
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: strDate)
        guard let date else { return "sem informações" }
        
        dateFormatter.dateFormat = "LLLL"
        let monthName = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        
        return "\(monthName) de \(year)"
    }

    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.scrollView)
        
        self.addViewInScroll(self.imagesCollection)
        self.addViewInScroll(self.imagesPageControl)
        self.addViewInScroll(self.container)
        
        self.addViewInScroll(self.tagsCollection)
        self.container.contentView.addSubview(self.expansiveLabel)
        self.addViewInScroll(self.infosCollection)
        self.addViewInScroll(self.lastUpdateLabel)
        
        self.addSubview(self.backButton)
        self.addSubview(self.favoriteButton)
    }
    
    
    private func addViewInScroll(_ view: UIView) {
        self.scrollView.addViewInScroll(view)
    }

    
    override func setupUI() {
        self.setInfosCollectionCellSize()
        self.setImagesCollectionCellSize()
        self.updateScrollSize()
        self.setUICorners()
    }
    
    
    private func setUICorners() {
        self.imagesPageControl.layer.cornerRadius = self.imagesPageControl.bounds.height / 2
    }
    
    
    private func updateScrollSize() {
        self.scrollView.updateScrollSize()
    }
    
    
    private func setInfosCollectionCellSize() {
        self.infosCollection.cellSize = CGSize(
            width: self.getEquivalent(165),
            height: self.infosCollection.bounds.height
        )
        self.infosCollection.spaceBetweenCells = self.getEquivalent(10)
    }
    
    
    private func setImagesCollectionCellSize() {
        self.imagesCollection.cellSize = CGSize(
            width: self.getEquivalent(390),
            height: self.getEquivalent(510)
        )
    }
    
    
    override func setupFonts() {
        self.setLabelsFont()
        self.setButtonsIconSize()
    }
    
    
    private func setLabelsFont() {
        self.lastUpdateLabel.setupFont(with: FontInfo(
            fontSize: self.getEquivalent(17), weight: .medium
        ))
    }
    
    
    private func setButtonsIconSize() {
        let btSize: CGFloat = self.getEquivalent(22)
        
        self.backButton.setupIcon(with: IconInfo(
            icon: .back, size: btSize, weight: .regular, scale: .default
        ))
        
        self.setFavoriteIcon()
    }
    
    
    override func createStaticConstraints () -> [NSLayoutConstraint] {
        let scrollContentView = self.scrollView.contentView
        let safeArea = self.safeAreaLayoutGuide
        
        let constraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.imagesCollection.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            self.imagesCollection.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            self.imagesCollection.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
        
    
            self.imagesPageControl.centerXAnchor.constraint(equalTo: self.imagesCollection.centerXAnchor),
            
            self.backButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            
            self.favoriteButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            
            
            /* Container */
            
            self.container.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            
            
            self.tagsCollection.topAnchor.constraint(equalTo: self.container.titleLabel.bottomAnchor),
            self.tagsCollection.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.tagsCollection.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            

            self.infosCollection.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.infosCollection.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            
            
            self.lastUpdateLabel.leadingAnchor.constraint(equalTo: self.expansiveLabel.leadingAnchor),
            self.lastUpdateLabel.trailingAnchor.constraint(equalTo: self.expansiveLabel.trailingAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        self.setButtonsHeight()
        self.setCollectionsLateralPaddins()
        self.setDynamicConstraints()
        self.setupExpansiveLabelHeight()
    }
    
    
    private func setButtonsHeight() {
        let height = self.getEquivalent(45)
        self.backButton.circleSize = height
        self.favoriteButton.circleSize = height
    }
    
    
    private func setCollectionsLateralPaddins() {
        let padding = self.getEquivalent(15)
        self.infosCollection.setupLateralPadding(padding)
        self.tagsCollection.setupLateralPadding(padding)
    }
    
    
    private func setDynamicConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        // Espaçamentos
        let lateral = self.getEquivalent(15)
        let between = self.getEquivalent(12)
        let gap = self.getEquivalent(25)
        let betweenSmaller = between / 1.5
        
        // Altura dos elementos
        let imagesHeight = self.getEquivalent(510)
        let collectionHeight = self.getEquivalent(200)
        let tagCollectionHeight = self.getEquivalent(25)
        
        
        self.dynamicConstraints = [
            self.imagesCollection.heightAnchor.constraint(equalToConstant: imagesHeight),
            
            self.imagesPageControl.bottomAnchor.constraint(equalTo: self.container.topAnchor, constant: -betweenSmaller),
            
            self.backButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: lateral),
            
            self.favoriteButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -lateral),
            
            
            /* Container */
            
            self.container.topAnchor.constraint(equalTo: self.imagesCollection.bottomAnchor, constant: -gap),
            
            self.tagsCollection.heightAnchor.constraint(equalToConstant: tagCollectionHeight),
            

            self.expansiveLabel.topAnchor.constraint(equalTo: self.tagsCollection.bottomAnchor, constant: between),
            self.expansiveLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor, constant: lateral),
            self.expansiveLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            
            
            self.infosCollection.topAnchor.constraint(equalTo: self.expansiveLabel.bottomAnchor, constant: between),
            self.infosCollection.heightAnchor.constraint(equalToConstant: collectionHeight),
            
            
            self.lastUpdateLabel.topAnchor.constraint(equalTo: self.infosCollection.bottomAnchor, constant: betweenSmaller),
        ]
    }
    
    
    private func setupExpansiveLabelHeight() {
        self.expansiveLabel.setupHeight()
    }
}
