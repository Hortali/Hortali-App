/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Tela com os elementos de UI da tela de ver informações de uma horta
class InfoGardenView: UIView, FavoriteHandler {
    
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
    
    /// Conjunto de imagens da horta
    private let imagesCollectionGp: CustomCollection = {
        let colGp = CustomCollection()
        colGp.collection.isPagingEnabled = true
        return colGp
    }()

    /// Controle de páginas
    private let imagesPageControl = CustomViews.newPageControl()
    
    /// Grupo de UI para colocar os elementos de informação sobre a horta
    private let container = ContainerView()
    
    /// Collection que mostra as tags
    private let tagsCollection = CustomCollection()
    
    /// Label expandível
    private let expansiveLabel = ExpansiveLabel()
    
    /// Collection das informações sobre a horta
    private let infosCollectionGp = CustomCollection()
    
    /// Mostra que um texto foi copiado
    private let copyWarning: ViewLabel = {
        let lbl = ViewLabel()
        lbl.isHidden = true
        lbl.backgroundColor = UIColor(originalColor: .greenLight)
        lbl.label.textColor = UIColor(originalColor: .greenDark)
        return lbl
    }()
    
    /// Data da última atualização dos dados
    private let lastUpdateLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(originalColor: .greenLight)
        return lbl
    }()
        
    
    // Outros
    
    /// Fala qual é o dia da semana de hoje
    static var todayWeek: String = ""
    
    
    // Constraints
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    // Collection
    
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
    
    /// Configurações do layout da collection das tags
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
    
    init(data: ManagedGarden) {
        super.init(frame: .zero)
        
        self.setupViews()
        self.registerCell()
        self.setupCollectionFlow()
        
        self.setupViewFor(data: data)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Mostra com animação o aviso de texto copiado
    public func showCopyWarning() -> Void {
        // Mostra a view
        UIView.transition(
            with: self.copyWarning, duration: 0.5, options: .transitionCrossDissolve,
            animations: {
                self.copyWarning.isHidden = false
            }
        )
        
        let delay: TimeInterval = 3
        
        // Executa a ação depois do delay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.copyWarning.isHidden = true
        }
    }

        
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
    
    /// Collection das tags
    public var tagCollection: UICollectionView {
        return self.tagsCollection.collection
    }
    
    
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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "pt-br")
        
        if let date = dateFormatter.date(from: strDate) {
            dateFormatter.dateFormat = "LLLL"
            let monthName = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: date)
            
            return "\(monthName) de \(year)"
        }
        return "sem informações"
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
    
    
    /* View */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.scrollView)
        
        self.scrollView.addViewInScroll(self.imagesCollectionGp)
        self.scrollView.addViewInScroll(self.imagesPageControl)
        self.scrollView.addViewInScroll(self.container)
        
        self.scrollView.addViewInScroll(self.tagsCollection)
        self.container.contentView.addSubview(self.expansiveLabel)
        self.scrollView.addViewInScroll(self.infosCollectionGp)
        self.scrollView.addViewInScroll(self.lastUpdateLabel)
        
        self.addSubview(self.backButton)
        self.addSubview(self.favoriteButton)

        self.addSubview(self.copyWarning)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.copyWarning.layer.cornerRadius = 5
        self.imagesPageControl.layer.cornerRadius = self.imagesPageControl.bounds.height / 2
        
        // Collections
        
        self.infosCollectionFlow.itemSize = CGSize(
            width: self.getEquivalent(165),
            height: self.infosCollectionGp.bounds.height
        )
        self.infosCollectionFlow.minimumLineSpacing = self.getEquivalent(10)
        
        
        self.imagesCollectionFlow.itemSize = CGSize(
            width: self.getEquivalent(390),
            height: self.getEquivalent(510)
        )
        
        self.scrollView.updateScrollSize()
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        let btSize: CGFloat = self.getEquivalent(22)
        
        self.backButton.setupIcon(with: IconInfo(
            icon: .back, size: btSize, weight: .regular, scale: .default
        ))
        
        self.favoriteButton.setupIcon(with: IconInfo(
            icon: self.favoriteIcon, size: btSize, weight: .regular, scale: .default
        ))
                
        /* Labels */
        
        self.copyWarning.label.setupText(with: FontInfo(
            text: "Texto copiado para área de tranferência", fontSize: self.getEquivalent(15), weight: .medium
        ))
        
        self.lastUpdateLabel.setupText(with: FontInfo(
            fontSize: self.getEquivalent(17), weight: .medium
        ))
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        // Espaçamentos
        let lateral = self.getEquivalent(15)
        let between = self.getEquivalent(12)
        let gap = self.getEquivalent(25)
        let warning = self.getEquivalent(10)
        let betweenSmaller = between / 1.5
        
        // Altura dos botões
        self.backButton.circleSize = self.getEquivalent(45)
        self.favoriteButton.circleSize = self.getEquivalent(45)
        
        // Altura dos elementos
        let imagesHeight = self.getEquivalent(510)
        let collectionHeight = self.getEquivalent(200)
        let tagCollectionHeight = self.getEquivalent(25)
        
        
        self.infosCollectionGp.setupLateralPadding(lateral)
        self.tagsCollection.setupLateralPadding(lateral)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.imagesCollectionGp.topAnchor.constraint(equalTo: self.scrollView.contentView.topAnchor),
            self.imagesCollectionGp.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.imagesCollectionGp.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.imagesCollectionGp.heightAnchor.constraint(equalToConstant: imagesHeight),
            
            
            self.imagesPageControl.bottomAnchor.constraint(equalTo: self.container.topAnchor, constant: -betweenSmaller),
            self.imagesPageControl.centerXAnchor.constraint(equalTo: self.imagesCollectionGp.centerXAnchor),
            
            
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: lateral),


            self.favoriteButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -lateral),
            
            
            /* Container */
            
            self.container.topAnchor.constraint(equalTo: self.imagesCollectionGp.bottomAnchor, constant: -gap),
            self.container.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.scrollView.contentView.bottomAnchor),
            
            
            self.tagsCollection.topAnchor.constraint(equalTo: self.container.titleLabel.bottomAnchor),
            self.tagsCollection.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.tagsCollection.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.tagsCollection.heightAnchor.constraint(equalToConstant: tagCollectionHeight),
            

            self.expansiveLabel.topAnchor.constraint(equalTo: self.tagsCollection.bottomAnchor, constant: between),
            self.expansiveLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor, constant: lateral),
            self.expansiveLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            
            
            self.infosCollectionGp.topAnchor.constraint(equalTo: self.expansiveLabel.bottomAnchor, constant: between),
            self.infosCollectionGp.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.infosCollectionGp.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.infosCollectionGp.heightAnchor.constraint(equalToConstant: collectionHeight),
            
            
            self.lastUpdateLabel.topAnchor.constraint(equalTo: self.infosCollectionGp.bottomAnchor, constant: betweenSmaller),
            self.lastUpdateLabel.leadingAnchor.constraint(equalTo: self.expansiveLabel.leadingAnchor),
            self.lastUpdateLabel.trailingAnchor.constraint(equalTo: self.expansiveLabel.trailingAnchor),
            
            
            self.copyWarning.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -warning),
            self.copyWarning.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.copyWarning.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
        
        self.setupExpansiveLabelHeight()
    }
    
    
    /// Configura a altura da label expandível
    private func setupExpansiveLabelHeight() {
        self.expansiveLabel.setupHeight()
    }
}
