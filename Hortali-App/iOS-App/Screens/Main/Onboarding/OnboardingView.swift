/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class OnboardingView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
            
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Collection das telas de onboarding
    private let onboardingGroup = CollectionGroup(style: .justCollection)
        
    /// Botão de fechar as telas de onboarding
    private let closeButton = {
        let btn = CustomViews.newButton()
        btn.setupText(with: FontInfo(text: "Fechar",fontSize: 17, weight: .regular))
        btn.isCircular = false
        btn.backgroundColor = .clear
        
        return btn
    }()
    
    /// Botão que leva a próxima tela de onboarding
    private let nextButton = {
        let btn = CustomViews.newButton()
        btn.setupText(with: FontInfo(text: "Próximo",fontSize: 17, weight: .regular))
        btn.isCircular = false
        btn.backgroundColor = .clear

        
        return btn
    }()
    
    /// Botão que retorna a tela de onboarding anterior
    private let backButton = {
        let btn = CustomViews.newButton()
        btn.setupText(with: FontInfo(text: "Voltar",fontSize: 17, weight: .regular))
        btn.isCircular = false
        btn.backgroundColor = .clear

        
        return btn
    }()
    
    /// Controle de páginas
    private let screensPageControl = CustomViews.newPageControl()

    /// Configurações do layout da collection
    private let collectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .vertical
        
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
    
    /* Ações dos Botões */
    
    /// Define a ação do botão
    public func setAction(target: Any?, action: Selector) -> Void {
        // self. .addTarget(target, action: action, for: .touchDown)
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
        onboardingGroup.collection.backgroundColor = UIColor(.gardenBack)

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
        
        onboardingGroup.collection.layer.cornerRadius = self.getEquivalent(30)
        
        self.screensPageControl.layer.cornerRadius = self.screensPageControl.bounds.height / 2
        screensPageControl.numberOfPages = 4
        // Define o tamanho que a célula vai ter
         self.collectionFlow.itemSize = CGSize(width: 200, height: 200)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /*
         Aqui vão ser configurados os textos estáticos, ícones dos botões
         tamanho das fontes, peso das fontes.. (para botões e labels ou até
         mesmo para putrp elemento caso tenha)
         */
        
        /* Labels */

        /* Botões */
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(25)
        let buttonBetween: CGFloat = self.getEquivalent(40)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.onboardingGroup.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.onboardingGroup.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.onboardingGroup.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.onboardingGroup.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.screensPageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.screensPageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -between),
            
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
