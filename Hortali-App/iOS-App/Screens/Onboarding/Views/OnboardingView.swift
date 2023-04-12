/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class OnboardingView: ViewWithViewCode {
    
    /* MARK: - Atributos */
    
    final let onBoardingCollection: CustomCollection = {
        let col = CustomCollection()
        col.collection.isPagingEnabled = true
        col.backgroundColor = .clear
        
        return col
    }()
    
    private let closeButton = {
        let btn = CustomViews.newButton()
        btn.isCircular = false
        btn.backgroundColor = .clear
        btn.isHidden = true
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
        page.currentPage = 0
        page.backgroundStyle = .minimal
        page.backgroundColor = .clear
        
        let color = UIColor(originalColor: .white)
        page.currentPageIndicatorTintColor = color
        page.pageIndicatorTintColor = color?.withAlphaComponent(0.6)
        
        return page
    }()
    
    
    // Outros
    
    private var onBoardingWasPresented: Bool {
        return !CDManager.shared.checkIsFirstTime()
    }
    
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        self.setupInitialState()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /*
     Essa variável passa a ser necessária para saber quando que é possível fazer a mudança
     do page control.
     BUG: Por algum motivo o delegate da collection está sendo ativado automaticamente
     fazendo com que mude o page control e alterando a os elementos da view.
     */
    public var viewHasAppeared = false
    
    
    public var currentPage: Int {
        return self.pageControl.currentPage
    }
    
    
    public func updateCurrentPage(for index: Int) {
        guard self.viewHasAppeared else { return }
        self.pageControl.currentPage = index
        self.setupButton(for: index)
    }
    
    
    public func updateCurrentCell(for index: Int) {
        self.onBoardingCollection.collection.scrollToItem(
            at: IndexPath(row: index, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
        self.setupButton(for: index)
    }
    
    
    public func setupInitialState() {
        self.setupButton(for: 0)
        self.closeButton.isHidden = true
        
        guard self.onBoardingWasPresented else { return }
        self.closeButton.isHidden = false
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
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.onBoardingCollection)
        self.addSubview(self.pageControl)
        self.addSubview(self.closeButton)
        self.addSubview(self.nextButton)
        self.addSubview(self.backButton)
    }
    
    
    override func setupView() {
        self.setViewBackgroundColor()
    }
    
    
    private func setViewBackgroundColor() {
        self.backgroundColor = UIColor(.viewBack)
    }
    
    
    override func setupUI() {
        self.setCollectionCorner()
        self.setCollectionCellSize()
    }
    
    
    private func setCollectionCorner() {
        guard !self.onBoardingWasPresented else { return }
        self.onBoardingCollection.collection.layer.cornerRadius = self.getEquivalent(30)
        self.onBoardingCollection.collection.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    private func setCollectionCellSize() {
        guard self.onBoardingCollection.bounds.height != 0 else { return }
        let cellHeight = self.onBoardingCollection.collection.bounds.height
        let cellWidth = self.onBoardingCollection.collection.bounds.width
        self.onBoardingCollection.cellSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    override func setupStaticTexts() {
        self.closeButton.setTitle("Fechar", for: .normal)
        self.backButton.setTitle("Voltar", for: .normal)
    }
    
    
    override func setupFonts() {
        let fontInfo = FontInfo(fontSize: self.getEquivalent(25), weight: .regular, fontFamily: .graffiti)
        
        self.closeButton.setupFont(with: fontInfo)
        self.nextButton.setupFont(with: fontInfo)
        self.backButton.setupFont(with: fontInfo)
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.onBoardingCollection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.onBoardingCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.onBoardingCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.onBoardingCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
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
    }
}
