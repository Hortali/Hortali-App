/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver todas as hortas
class GardenView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Bara de busca das hortas
    private let search: UISearchBar = CustomViews.newSearch()
    
    /// Collection das hortas
    private let gardenGroup = CollectionGroup(style: .justCollection)
    
    /// View de referência para centralizar as células da Collection
    private let referenceView: UIView = CustomViews.newView()
    
    /// Botão que leva à tela de onboarding
    private let onboardingButton: UIButton = {
        let btn = CustomViews.newButton()
        btn.setupText(with: FontInfo(text: "?",fontSize: 25, weight: .semibold))
        btn.circleSize = 30
        btn.backgroundColor = UIColor(originalColor: .greenLight)
        btn.setTitleColor(UIColor(.title), for:.normal)
        
        return btn
    }()
    
    
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
    
    override init() {
        super.init()
        
        self.setupViews()
        self.registerCells()
        self.setupCollectionFlow()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    // Search
    
    /// Define o delegate da barra de busca das hortas
    /// - Parameter delegate: delegate da barra de bysca
    public func setSearchDelegate(with delegate: SearchDelegate) {
        self.search.delegate = delegate
    }
    
    
    // Collection
    
    /// Atualiza os dados da collection
    public func reloadCollectionData() {
        self.gardenGroup.collection.reloadData()
        self.gardenGroup.collection.reloadInputViews()
    }
    
    
    /// Define o data source da collection das hortas
    /// - Parameter dataSource: data source da collection das hortas
    public func setDataSource(with dataSource: GardenDataSource) {
        self.gardenGroup.collection.dataSource = dataSource
    }
    
    
    /// Define o delegate da collection das hortas
    /// - Parameter delegate: delegate da collection das hortas
    public func setDelegate(with delegate: GardenDelegate) {
        self.gardenGroup.collection.delegate = delegate
    }
    
    
    /* Ações de botões */
    
    /// Define a ação do botão de voltar
    public func setOnboardingButtonAction(target: Any?, action: Selector) -> Void {
        self.onboardingButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        self.gardenGroup.collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.gardenGroup.collection.collectionViewLayout = self.collectionFlow
    }
    
    
    /* Geral */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.search)
        self.addSubview(self.onboardingButton)
        self.contentView.addSubview(self.referenceView)
        self.contentView.addSubview(self.gardenGroup)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.gardenBack)
        
        self.collectionFlow.minimumInteritemSpacing = self.getEquivalent(10)
        self.collectionFlow.itemSize = CGSize(
            width: self.getEquivalent(240, dimension: .height),
            height: self.gardenGroup.collection.bounds.height
        )
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.setTitleText(with: "Descubra novas \nhortas")
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let collectionHeight = self.getEquivalent(400, dimension: .height)
        let lateral = self.getEquivalent(25)
        let between = self.getEquivalent(34)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.search.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.search.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.search.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.referenceView.topAnchor.constraint(equalTo: self.search.bottomAnchor),
            self.referenceView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.referenceView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.referenceView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
            self.gardenGroup.heightAnchor.constraint(equalToConstant: getEquivalent(collectionHeight)),
            self.gardenGroup.centerYAnchor.constraint(equalTo: self.referenceView.centerYAnchor),
            self.gardenGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.gardenGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            self.onboardingButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: between),
            self.onboardingButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -lateral),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
