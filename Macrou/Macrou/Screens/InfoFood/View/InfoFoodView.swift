/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class InfoFoodView: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    /// Scroll View da tela
    private let scrollView = CustomScroll()
    
    /// Botão de voltar para a página anterior
    private let backButton = CustomViews.newButton()
    
    /// Botão de favoritar o alimento
    private let favoriteButton = CustomViews.newButton()
    
    /// Capa do alimento
    private let coverImage = CustomViews.newImage()
    
    /// Grupo de UI para colocar os elementos de informação sobre o alimento
    private let container = ContainerView()
    
    /// Label expandível
    private let expansiveLabel = ExpansiveLabel()
    
    
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
    
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
        self.registerCells()
        self.setupCollectionFlow()
        
        self.coverImage.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */

    /* Ações de botões */
    
    /// Define a ação do botão de voltar
    public func setBackButtonAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Define a ação do botão de favorito
    public func setFavoriteButtonAction(target: Any?, action: Selector) -> Void {
        self.favoriteButton.addTarget(target, action: action, for: .touchDown)
    }
    
    

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
        self.addSubview(self.scrollView)
                
        self.scrollView.contentView.addSubview(self.coverImage)
        self.scrollView.contentView.addSubview(self.backButton)
        self.scrollView.contentView.addSubview(self.favoriteButton)
        self.scrollView.contentView.addSubview(self.container)
        
        self.container.contentView.addSubview(self.expansiveLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.scrollView.scrollContentSize = CGSize(
            width: self.getEquivalent(self.bounds.width),
            height: self.getEquivalent(1340)
        )
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /* Labels */
        self.container.setTitleText(with: "Morango")
        

        /* Botões */
        let btSize: CGFloat = self.getEquivalent(22)
        
        self.backButton.setupIcon(with: IconInfo(
            icon: .back, size: btSize, weight: .regular, scale: .default
        ))
        
        self.favoriteButton.setupIcon(with: IconInfo(
            icon: .favorite, size: btSize, weight: .regular, scale: .default
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
//      // Espaçamentos
        let lateral = self.getEquivalent(15)
        let between = self.getEquivalent(20)
        let gap = self.getEquivalent(25)
        
        let safeAreaGap = self.scrollView.scroll.safeAreaInsets.top
        
        // Altura dos botões
        self.backButton.circleSize = self.getEquivalent(45)
        self.favoriteButton.circleSize = self.getEquivalent(45)
        
        // Altura dos elementos
        let segHeight = self.getEquivalent(510)
        let containerHeight = self.getEquivalent(435)
        let expLabelHeight = self.getEquivalent(85)
        let collectionHeight = self.getEquivalent(400)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.coverImage.topAnchor.constraint(equalTo: self.scrollView.contentView.topAnchor),
            self.coverImage.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.coverImage.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.coverImage.heightAnchor.constraint(equalToConstant: segHeight),
            
            
            self.backButton.topAnchor.constraint(equalTo: self.scrollView.contentView.topAnchor, constant: safeAreaGap),
            self.backButton.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor, constant: lateral),


            self.favoriteButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor, constant: -lateral),
            
            
            /* Container */
            
            self.container.topAnchor.constraint(equalTo: self.coverImage.bottomAnchor, constant: -gap),
            self.container.leadingAnchor.constraint(equalTo: self.scrollView.contentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.scrollView.contentView.trailingAnchor),
            self.container.heightAnchor.constraint(equalToConstant: containerHeight),
            

            self.expansiveLabel.topAnchor.constraint(equalTo: self.container.contentView.topAnchor),
            self.expansiveLabel.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor),
            self.expansiveLabel.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor, constant: -lateral),
            self.expansiveLabel.heightAnchor.constraint(equalToConstant: expLabelHeight),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
