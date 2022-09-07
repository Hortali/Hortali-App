/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class FavoriteView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    
    private let container = ContainerView()
    
    private let foodGroup = CollectionGroup()
    
    private let gardenGroup = CollectionGroup()
    
    private let favoriteButton: UIButton = CustomViews.newButton()
    
    private let searchBar: UISearchBar = CustomViews.newSearch()
    
    private let viewArea: UIView
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
		
		
    /// Configurações do layout da collection
    private let collectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        // cvFlow.scrollDirection = .vertical
		     
        return cvFlow
    }()



    /* MARK: - Construtor */
    
    init() {
        self.viewArea = self.container.contentView
        
        super.init(frame: .zero)
        
        self.setupViews()
        // self.container.isHidden = true
        self.favoriteButton.isHidden = true
        self.searchBar.isHidden = true
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    /*
        Implementação das funções que outras classes vão ter acesso.

        AVISO: Apague esse campo de comentário
    */
    
    

    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()

        self.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViews() {    
        self.addSubview(self.container)
        self.addSubview(self.favoriteButton)
        self.addSubview(self.searchBar)
        self.container.contentView.addSubview(self.foodGroup)
        self.container.contentView.addSubview(self.gardenGroup)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.favoriteBack)
        
        self.foodGroup.titleLabel.backgroundColor = .red
        self.foodGroup.collection.backgroundColor = .blue
        
        self.gardenGroup.titleLabel.backgroundColor = .red
        self.gardenGroup.collection.backgroundColor = .blue
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /* Labels */
        self.container.setTitleText(with: "Favoritos da sua \nmesa")
        
        self.foodGroup.titleLabel.setupText(with: FontInfo(
            text: "Alimentos", fontSize: 25, weight: .regular)
        )
        
        self.gardenGroup.titleLabel.setupText(with: FontInfo(
            text: "Hortas", fontSize: 25, weight: .regular)
        )
        

        /* Botões */
        self.favoriteButton.setupIcon(with: IconInfo(
            icon: .favorite, size: 23, weight: .semibold, scale: .medium
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
        /*
            Aqui vão ser configuradas as contraints dos componentes. Coloque todas as 
            contraints dentro da lista que está em aberto!

            AVISO: Apague esse campo de comentário.
        */
        let lateral: CGFloat = 15
        let between: CGFloat = 28
       
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.container.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.container.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            self.favoriteButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.favoriteButton.heightAnchor.constraint(equalToConstant: 45),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: 45),
            
            self.searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            self.foodGroup.topAnchor.constraint(equalTo: self.container.contentView.topAnchor),
            self.foodGroup.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor, constant: lateral),
            self.foodGroup.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.foodGroup.heightAnchor.constraint(equalToConstant: 187), // 150+12+25
            
            self.gardenGroup.topAnchor.constraint(equalTo: self.foodGroup.bottomAnchor, constant: between),
            self.gardenGroup.leadingAnchor.constraint(equalTo: self.container.contentView.leadingAnchor, constant: lateral),
            self.gardenGroup.trailingAnchor.constraint(equalTo: self.container.contentView.trailingAnchor),
            self.gardenGroup.bottomAnchor.constraint(equalTo: self.container.contentView.bottomAnchor, constant: -lateral),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
