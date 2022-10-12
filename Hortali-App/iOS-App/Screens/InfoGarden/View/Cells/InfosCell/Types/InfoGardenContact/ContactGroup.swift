/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria a área de visualizar um contato
class ContactGroup: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    /// Imagem da rede social
    private let imageView = CustomViews.newImage()
    
    /// O contato em si
    private let contactLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(.contactCellBack)
        return lbl
    }()
    
    /// Descrição do tipo do contato
    private let descriptionLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(.contactCellBack)
        return lbl
    }()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
		
    

    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura as informações de contato a partir das informações passadas
    /// - Parameter contactInfo: conjunto de informações de contato
    public func setupContactInfo(with info: ManagedContact) {
        var image = UIImage(named: "general-contact")
        if let contactImage = UIImage(named: "\(info.type)-contact") {
            image = contactImage
        }
        self.imageView.image = image
        self.contactLabel.text = info.contact
        self.descriptionLabel.text = info.description
    }

        

    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.imageView)
        self.addSubview(self.contactLabel)
        self.addSubview(self.descriptionLabel)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        let fontSize: CGFloat = self.getConstant(for: 15)
        
        self.contactLabel.setupText(with: FontInfo(
            fontSize: fontSize, weight: .semibold
        ))
        
        self.descriptionLabel.setupText(with: FontInfo(
            fontSize: fontSize, weight: .regular
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
        let between: CGFloat = self.getConstant(for: 10)
        
        let labelHeight: CGFloat = self.getConstant(for: 20)
        let imageHeight: CGFloat = self.bounds.height
       
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: imageHeight),
            
            
            self.contactLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: between),
            self.contactLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.contactLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            self.contactLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.contactLabel.leftAnchor),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.contactLabel.rightAnchor),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
            self.descriptionLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    /// Responsável por pegar o valor referente à célula
    /// - Parameter space: valor para ser convertido
    /// - Returns: valor em relação à tela
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 350, height: 160),
            dimension: .width
        )
        
        return self.getEquivalent(space, screenReference: screenReference)
    }
}
