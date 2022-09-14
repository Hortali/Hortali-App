/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver todas as hortas
class GardenView: MainView {
    
    /* MARK: - Atributos */

    // Views
    let search: UISearchBar = CustomViews.newSearch()
    let collectionView = CollectionGroup(style: .justCollection)
    let referenceView: UIView = CustomViews.newView()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
		
		
    /// Configurações do layout da collection
    private let collectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
//        cvFlow.scrollDirection = .horizontal
		     
        return cvFlow
    }()



    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        self.setupViews()
        self.registerCells()
        self.setupCollectionFlow()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */

    /* Ações de botões */

    /// Ação do botão X
//    public func setButtonAction(target: Any?, action: Selector) -> Void {
//        self.someButton.addTarget(target, action: action, for: .touchDown)
//    }
    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCells() {
        
    }


    /// Define o layout da collection
    private func setupCollectionFlow() {
        // self.collection.collectionViewLayout = self.collectionFlow
    }


    /* Geral */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {

        self.addSubview(self.search)
        self.contentView.addSubview(self.collectionView)
        self.contentView.addSubview(self.referenceView)
        
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        // self.collectionFlow.itemSize = CGSize(width: 100, height: 100)
        self.backgroundColor = UIColor(.gardenBack)
        self.collectionView.collection.backgroundColor = .red
        self.contentView.backgroundColor = .green
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {		
        /* Labels */
        self.setTitleText(with: "Descubra novas \nhortas")
        

        /* Botões */
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
//        let lateral: CGFloat =
//        let between: CGFloat =
        
        let heightCollection = self.getEquivalent(400)
       
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            search.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            search.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            search.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            search.heightAnchor.constraint(equalToConstant: 36),
            
            referenceView.topAnchor.constraint(equalTo: self.search.bottomAnchor),
            referenceView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            referenceView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            referenceView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: heightCollection),
            collectionView.centerYAnchor.constraint(equalTo: self.referenceView.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            
            
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
