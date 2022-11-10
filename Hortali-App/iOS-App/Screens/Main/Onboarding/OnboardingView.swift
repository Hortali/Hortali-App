/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class OnboardingView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Collection das telas de onboarding
    private let onboardingGroup = CollectionGroup(style: .justCollection)
    
    /// Botão de fechar as telas de onboarding
    private let closeButton = {
        let btn = CustomViews.newButton()
        btn.setupText(with: FontInfo(text: "Fechar",fontSize: 17, weight: .regular))
        btn.isCircular = false
        btn.backgroundColor = .clear
        btn.setTitleColor(UIColor.white, for:.normal)
        
        return btn
    }()
    
    /// Botão que leva a próxima tela de onboarding
    private let nextButton = {
        let btn = CustomViews.newButton()
        btn.setupText(with: FontInfo(text: "Proximo",fontSize: 17, weight: .regular))
        btn.isCircular = false
        btn.backgroundColor = .clear
        btn.setTitleColor(UIColor.white, for:.normal)
        
        return btn
    }()
    
    /// Botão que retorna a tela de onboarding anterior
    private let backButton = {
        let btn = CustomViews.newButton()
        btn.setupText(with: FontInfo(text: "Voltar",fontSize: 17, weight: .regular))
        btn.isCircular = false
        btn.backgroundColor = .clear
        btn.setTitleColor(UIColor.white, for:.normal)
        
        return btn
    }()
    
    /// Controle de páginas
    private let screensPageControl = CustomViews.newPageControl()
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
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
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /* Ações de botões */
    
    /// Define a ação do botão de fechar
    public func setCloseButtonAction(target: Any?, action: Selector) -> Void {
        self.closeButton.addTarget(target, action: action, for: .touchDown)
    }
    
    /// Define ação do botão de voltar
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        
    }
    
    /// Define ação dos botões de próximo
    public func setNextButtonAction(target: Any?, action: Selector) -> Void {
        
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.onboardingGroup.collection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.onboardingGroup.collection.collectionViewLayout = self.collectionFlow
        onboardingGroup.collection.backgroundColor = UIColor.white
        
    }
    
    
    /// Define o data source da collection de onboarding
    /// - Parameter dataSource: data source da collection das hortas
    public func setDataSource(with dataSource: OnboardingDataSource) {
        self.onboardingGroup.collection.dataSource = dataSource
    }
    
    
    //    public func setDelegate(with delegate: OnboardingDelegate) {
    //        self.onboardingGroup.collection.delegate = delegate
    //    }
    
    
    /* Geral */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        
        self.addSubview(self.onboardingGroup)
        self.addSubview(self.screensPageControl)
        self.addSubview(self.closeButton)
        self.addSubview(self.nextButton)
        self.addSubview(self.backButton)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = .gray
        
        self.onboardingGroup.collection.layer.cornerRadius = self.getEquivalent(30)
        self.onboardingGroup.collection.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.screensPageControl.layer.cornerRadius = self.screensPageControl.bounds.height / 2
        self.screensPageControl.numberOfPages = 4
        
        // Define o tamanho que a célula vai ter
        let cellHeight = self.onboardingGroup.collection.frame.height
        let cellWidth = self.frame.width
        self.collectionFlow.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.closeButton.titleLabel?.font = UIFont(name: "AmsterdamGraffiti", size: 24)
        self.nextButton.titleLabel?.font = UIFont(name: "AmsterdamGraffiti", size: 24)
        self.backButton.titleLabel?.font = UIFont(name: "AmsterdamGraffiti", size: 24)
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(10)
        let buttonBetween: CGFloat = self.getEquivalent(40)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.onboardingGroup.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.onboardingGroup.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.onboardingGroup.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.onboardingGroup.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.screensPageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.screensPageControl.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -between),
            
            
            self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: lateral),
            self.closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            
            
            self.nextButton.centerYAnchor.constraint(equalTo: self.screensPageControl.centerYAnchor),
            self.nextButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -lateral),
            self.nextButton.leadingAnchor.constraint(equalTo: self.screensPageControl.trailingAnchor, constant: buttonBetween),
            
            
            self.backButton.centerYAnchor.constraint(equalTo: self.screensPageControl.centerYAnchor),
            self.backButton.trailingAnchor.constraint(equalTo: self.screensPageControl.leadingAnchor, constant: -buttonBetween),
            self.backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: lateral),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
