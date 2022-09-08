/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class FavoriteView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Collection de alimentos
    private let foodGroup = CollectionGroup()
    
    /// Collection das hortas
    private let gardenGroup = CollectionGroup()
        
    
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
    
    override init() {
        super.init()
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    
    

    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.foodGroup)
        self.contentView.addSubview(self.gardenGroup)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.favoriteBack)
        
        // self.foodGroup.titleLabel.backgroundColor = .red
        // self.foodGroup.collection.backgroundColor = .blue
        
        // self.gardenGroup.titleLabel.backgroundColor = .red
        // self.gardenGroup.collection.backgroundColor = .blue
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /* Labels */
        self.setTitleText(with: "Favoritos da sua \nmesa")
        
        let subTitleSize: CGFloat = self.getEquivalent(25)
        
        self.foodGroup.titleLabel.setupText(with: FontInfo(
            text: "Alimentos", fontSize: subTitleSize, weight: .regular)
        )
        
        self.gardenGroup.titleLabel.setupText(with: FontInfo(
            text: "Hortas", fontSize: subTitleSize, weight: .regular)
        )
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(28)
       
        let foodGpHeight = self.getEquivalent(187)   // 150+12+25
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.foodGroup.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.foodGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.foodGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.foodGroup.heightAnchor.constraint(equalToConstant: foodGpHeight),
            
            
            self.gardenGroup.topAnchor.constraint(equalTo: self.foodGroup.bottomAnchor, constant: between),
            self.gardenGroup.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.gardenGroup.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.gardenGroup.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -lateral),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
