/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de onboarding
class OnboardingView: ViewCode {
    
    /* MARK: - Atributos */
    
    // Views
    
    private let onBoardingGroup: CustomCollection = {
        let col = CustomCollection()
        col.collection.isPagingEnabled = true
        col.backgroundColor = .clear
        
        return col
    }()
    
    private let closeButton = {
        let btn = CustomViews.newButton()
        btn.isCircular = false
        btn.backgroundColor = .clear
        btn.setTitleColor(UIColor(.secondaryTitle), for:.normal)
        return btn
    }()
    
    private let nextButton = {
        let btn = CustomViews.newButton()
        btn.isCircular = false
        btn.backgroundColor = .clear
        btn.setTitleColor(UIColor(.secondaryTitle), for: .normal)
        return btn
    }()
    
    private let backButton = {
        let btn = CustomViews.newButton()
        btn.isCircular = false
        btn.backgroundColor = .clear
        btn.setTitleColor(UIColor(.secondaryTitle), for: .normal)
        return btn
    }()
    
    private let pageControl = {
        let page = CustomViews.newPageControl()
        page.numberOfPages = 3
        page.backgroundStyle = .minimal
        page.backgroundColor = .clear
        
        let color = UIColor(originalColor: .white)
        page.currentPageIndicatorTintColor = color
        page.pageIndicatorTintColor = color?.withAlphaComponent(0.6)
        
        return page
    }()
    
    
    // Collection
    
    private let collectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .horizontal
        cvFlow.minimumLineSpacing = 0
        
        return cvFlow
    }()
    
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        self.registerCells()
        self.setupCollectionFlow()
        self.setupToInitialState()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Mostra em qual página o page control está
    public var currentPage: Int {
        return self.pageControl.currentPage
    }
    
    
    /// Atualiza a página no Page Control
    /// - Parameter index: index (número) da página
    public func updateCurrentPage(for index: Int) {
        self.pageControl.currentPage = index
        self.setupButton(for: index)
    }
    
    
    /// Atualiza  a célula que é mostrada a partir do item do page control selecionado
    /// - Parameter index: index selecionado
    public func updateCurrentCell(for index: Int) {
        self.onBoardingGroup.collection.scrollToItem(
            at: IndexPath(row: index, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
        self.setupButton(for: index)
    }
    
    
    /// Configura a view para o estado inicial
    public func setupToInitialState() {
        self.updateCurrentPage(for: 0)
        self.backgroundColor = .clear
        
        guard onBoardingWasPresented else { return }
        self.closeButton.isHidden = true
        self.backgroundColor = UIColor(originalColor: .white)
    }
    
    
    private var onBoardingWasPresented: Bool {
        return UserDefaults.getValue(for: .onBoardingPresented)
    }
    
    
    /* Ações de botões */
    
    public func setCloseButtonAction(target: Any?, action: Selector) -> Void {
        self.closeButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    public func setNextButtonAction(target: Any?, action: Selector) -> Void {
        self.nextButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    public func setPageControlAction(target: Any?, action: Selector) -> Void {
        self.pageControl.addTarget(target, action: action, for: .valueChanged)
    }
    
    
    /* MARK: - Configurações */
    
    /// Configura os botões a partir da página do page control
    /// - Parameter index: página usada para configuração
    private func setupButton(for index: Int) {
        self.nextButton.setTitle("Proximo", for: .normal)
        
        switch index {
        case 0:
            self.backButton.isHidden = true
            
        case 1:
            self.backButton.isHidden = false
            
        default:
            self.nextButton.setTitle("Finalizar", for: .normal)
            self.closeButton.isHidden = false
        }
    }
    
    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.onBoardingGroup.collection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.onBoardingGroup.collection.collectionViewLayout = self.collectionFlow
    }
    
    
    /// Define o data source da collection de onboarding
    /// - Parameter dataSource: data source da collection de onboarding
    public func setDataSource(with dataSource: OnboardingDataSource) {
        self.onBoardingGroup.collection.dataSource = dataSource
    }
    
    /// Define o delegate da collection de onboarding
    /// - Parameter delegate: delegate da collection de onboarding
    public func setDelegate(with delegate: OnboardingDelegate) {
        self.onBoardingGroup.collection.delegate = delegate
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.onBoardingGroup)
        self.addSubview(self.pageControl)
        self.addSubview(self.closeButton)
        self.addSubview(self.nextButton)
        self.addSubview(self.backButton)
    }
    
    
    override func setupUI() {
        self.setCollectionCorner()
        self.setCollectionCellSize()
    }
    
    
    private func setCollectionCorner() {
        self.onBoardingGroup.collection.layer.cornerRadius = self.getEquivalent(30)
        self.onBoardingGroup.collection.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    private func setCollectionCellSize(){
        let cellHeight = self.onBoardingGroup.collection.frame.height
        let cellWidth = self.frame.width
        self.collectionFlow.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    override func setupStaticTexts() {
        self.closeButton.setTitle("Fechar", for: .normal)
        self.backButton.setTitle("Voltar", for: .normal)
    }
    
    
    override func setupFonts() {
        let fontInfo = FontInfo(fontSize: self.getEquivalent(25), weight: .regular, fontFamily: .graffiti)
        
        self.closeButton.setupText(with: fontInfo)
        self.nextButton.setupText(with: fontInfo)
        self.backButton.setupText(with: fontInfo)
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.onBoardingGroup.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.onBoardingGroup.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.onBoardingGroup.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.onBoardingGroup.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.nextButton.centerYAnchor.constraint(equalTo: self.pageControl.centerYAnchor),
            self.backButton.centerYAnchor.constraint(equalTo: self.pageControl.centerYAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(10)
        
        let safeArea = self.safeAreaLayoutGuide
        
        self.dynamicConstraints = [
            self.pageControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -between),
            
            self.closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            self.closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: lateral),
            
            self.nextButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -lateral),
            self.backButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: lateral),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
