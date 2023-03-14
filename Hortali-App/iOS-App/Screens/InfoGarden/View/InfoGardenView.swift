/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Tela com os elementos de UI da tela de ver informações de uma horta
class InfoGardenView: ViewCode, FavoriteHandler {
    
    /* MARK: - Atributos */
    
    // Views
    
    private let scrollView = CustomScroll()
    
    private let backButton: CustomButton = {
        let but = CustomViews.newButton()
        but.tintColor = UIColor(.favoriteNotSelectedIcon)
        return but
    }()
    
    private let imagesCollectionGp: CustomCollection = {
        let colGp = CustomCollection()
        colGp.collection.isPagingEnabled = true
        return colGp
    }()

    private let imagesPageControl = CustomViews.newPageControl()
    
    private let container = ContainerView()
    
    final let tagsCollection = CustomCollection()
    
    private let expansiveLabel = ExpansiveLabel()
    
    private let infosCollectionGp = CustomCollection()
    
    private let lastUpdateLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(originalColor: .greenLight)
        return lbl
    }()
        
    
    // Outros
    
    /// Fala qual é o dia da semana de hoje
    static var todayWeek: String = ""
    
    
    // Collection
    
    private let infosCollectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .horizontal
        
        return cvFlow
    }()
    
    private let imagesCollectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .horizontal
        cvFlow.minimumLineSpacing = 0
        
        return cvFlow
    }()
    
    private let tagsCollectionFlow: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.estimatedItemSize = .zero
        return flow
    }()
    
    
    
    /* MARK: - Protocol */
    
    internal var isFavorite = false
    
    internal var favoriteButton: CustomButton = CustomViews.newButton()
    
    
    internal func favoriteHandler(for fav: Bool? = nil) -> Bool {
        self.updateFavoriteStatus(for: fav)
        self.updateFavoriteUI()
        self.setFavoriteIcon()
        return self.isFavorite
    }
    
    
    private func updateFavoriteStatus(for fav: Bool? = nil) {
        if let fav {
            self.isFavorite = fav
        } else {
            self.isFavorite.toggle()
        }
    }
    
    
    private func updateFavoriteUI() {
        let infos = self.favoriteInfos
        self.favoriteButton.backgroundColor = infos.backColor
        self.favoriteButton.tintColor = infos.iconColor
    }



    /* MARK: - Construtor */
    
    init(data: ManagedGarden) {
        super.init()
        
        self.registerCell()
        self.setupCollectionFlow()
        
        self.setupViewFor(data: data)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Atualiza a página no Page Control
    /// - Parameter index: index (número) da página
    public func updateCurrentPage(for index: Int) {
        self.imagesPageControl.currentPage = index
    }
    
    
    /// Atualiza  a célula que é mostrada a partir do item do page control selecionado
    /// - Parameter index: index selecionado
    public func updateCurrentCell(for index: Int) {
        self.imagesCollectionGp.collection.scrollToItem(
            at: IndexPath(row: index, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    
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
    
    
    /// Define a ação do botão de favorito
    public func setFavoriteButtonAction(target: Any?, action: Selector) -> Void {
        self.favoriteButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Define a ação do botão de expandir a label
    public func setExpLabelButtonAction(target: Any?, action: Selector) -> Void {
        self.expansiveLabel.setExpansiveButtonAction(target: target, action: action)
    }
    
    
    /// Define a ação do botão de expandir a label
    public func setPageControlAction(target: Any?, action: Selector) -> Void {
        self.imagesPageControl.addTarget(target, action: action, for: .valueChanged)
    }
    
    
    /* Collection */
        
    /// Atualiza os dados das collections
    public func reloadCollectionsData() {
        self.imagesCollectionGp.collection.reloadData()
        self.imagesCollectionGp.collection.reloadInputViews()
        
        self.infosCollectionGp.collection.reloadData()
        self.infosCollectionGp.collection.reloadInputViews()
        
        self.tagsCollection.collection.reloadData()
        self.tagsCollection.collection.reloadInputViews()
    }
        
    
    /// Define o data source da collection de informações da horta
    /// - Parameter dataSource: data source da collection
    public func setInfoDataSource(for dataSource: InfoGardenInfosDataSource) {
        self.infosCollectionGp.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection de informações da horta
    /// - Parameter delegate: delegate da collection
    public func setInfoDelegate(for delegate: InfoGardenInfosDelegate) {
        self.infosCollectionGp.collection.delegate = delegate
    }
    
    
    /// Define o data source da collection das imagens da horta
    /// - Parameter dataSource: data source da collection
    public func setImagesDataSource(for dataSource: InfoGardenImagesDataSource) {
        self.imagesCollectionGp.collection.dataSource = dataSource
        self.imagesPageControl.numberOfPages = dataSource.getDataCount()
    }
    
    
    /// Define o delegate da collection das imagens da horta
    /// - Parameter delegate: delegate da collection
    public func setImagesDelegate(for delegate: InfoGardenImagesDelegate) {
        self.imagesCollectionGp.collection.delegate = delegate
    }


    
    /* MARK: - Configurações */
    
    /* Geral */
    
    /// Configura a view a partir dos dados recebidos
    /// - Parameter data: dados recebidos
    private func setupViewFor(data: ManagedGarden) {
        self.container.setTitleText(with: data.name)
        self.expansiveLabel.setInfoText(for: data.biograph)
        
        let lastUpdateDate = self.getDate(for: data.lastUpdate)
        self.lastUpdateLabel.text = "*Última atualização: \(lastUpdateDate)"
    }
    
    
    /// Pega o mês e ano de uma data em string
    /// - Parameter strDate: data no formato: ano-mes-dia
    /// - Returns: data no formato: 'mes' de 'ano'
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

    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCell() {
        self.infosCollectionGp.collection.register(InfoGardenInfosCell.self, forCellWithReuseIdentifier: InfoGardenInfosCell.identifier)
        
        self.imagesCollectionGp.collection.register(InfoGardenImagesCell.self, forCellWithReuseIdentifier: InfoGardenImagesCell.identifier)
    }


    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.infosCollectionGp.collection.collectionViewLayout = self.infosCollectionFlow
        self.imagesCollectionGp.collection.collectionViewLayout = self.imagesCollectionFlow
        self.tagsCollection.collection.collectionViewLayout = self.tagsCollectionFlow
    }
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.scrollView)
        
        self.addViewInScroll(self.imagesCollectionGp)
        self.addViewInScroll(self.imagesPageControl)
        self.addViewInScroll(self.container)
        
        self.addViewInScroll(self.tagsCollection)
        self.container.contentView.addSubview(self.expansiveLabel)
        self.addViewInScroll(self.infosCollectionGp)
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
        self.infosCollectionFlow.itemSize = CGSize(
            width: self.getEquivalent(165),
            height: self.infosCollectionGp.bounds.height
        )
        self.infosCollectionFlow.minimumLineSpacing = self.getEquivalent(10)
    }
    
    
    private func setImagesCollectionCellSize() {
        self.imagesCollectionFlow.itemSize = CGSize(
            width: self.getEquivalent(390),
            height: self.getEquivalent(510)
        )
    }
    
    
    override func setupFonts() {
        self.setLabelsFont()
        self.setButtonsIconSize()
    }
    
    
    private func setLabelsFont() {
        self.lastUpdateLabel.setupText(with: FontInfo(
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
    
    
    private func setFavoriteIcon() {
        let btSize: CGFloat = self.getEquivalent(22)
        self.favoriteButton.setupIcon(with: IconInfo(
            icon: self.favoriteIcon, size: btSize, weight: .regular, scale: .default
        ))
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
            
            
            self.imagesCollectionGp.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            self.imagesCollectionGp.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            self.imagesCollectionGp.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
        
    
            self.imagesPageControl.centerXAnchor.constraint(equalTo: self.imagesCollectionGp.centerXAnchor),
            
            self.backButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            
            self.favoriteButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            
            
            /* Container */
            
            self.container.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            
            
            self.tagsCollection.topAnchor.constraint(equalTo: self.container.titleLabel.bottomAnchor),
            self.tagsCollection.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.tagsCollection.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            

            self.infosCollectionGp.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.infosCollectionGp.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            
            
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
        self.infosCollectionGp.setupLateralPadding(padding)
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
            self.imagesCollectionGp.heightAnchor.constraint(equalToConstant: imagesHeight),
            
            self.imagesPageControl.bottomAnchor.constraint(equalTo: self.container.topAnchor, constant: -betweenSmaller),
            
            self.backButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: lateral),
            
            self.favoriteButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -lateral),
            
            
            /* Container */
            
            self.container.topAnchor.constraint(equalTo: self.imagesCollectionGp.bottomAnchor, constant: -gap),
            
            self.tagsCollection.heightAnchor.constraint(equalToConstant: tagCollectionHeight),
            

            self.expansiveLabel.topAnchor.constraint(equalTo: self.tagsCollection.bottomAnchor, constant: between),
            self.expansiveLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor, constant: lateral),
            self.expansiveLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            
            
            self.infosCollectionGp.topAnchor.constraint(equalTo: self.expansiveLabel.bottomAnchor, constant: between),
            self.infosCollectionGp.heightAnchor.constraint(equalToConstant: collectionHeight),
            
            
            self.lastUpdateLabel.topAnchor.constraint(equalTo: self.infosCollectionGp.bottomAnchor, constant: betweenSmaller),
        ]
    }
    
    
    private func setupExpansiveLabelHeight() {
        self.expansiveLabel.setupHeight()
    }
}
