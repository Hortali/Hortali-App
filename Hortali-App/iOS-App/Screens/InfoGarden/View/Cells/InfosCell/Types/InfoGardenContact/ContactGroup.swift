/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria a área de visualizar um contato
class ContactGroup: ViewWithViewCode {
    
    /* MARK: - Atributos */

    private let imageView = CustomViews.newImage()
    
    private let contactLabel: UILabel = CustomViews.newLabel()
    
    private let descriptionLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupContactInfo(with info: ManagedContact) {
        self.setIconContact(for: info.type)
        self.setLabelsText(with: info)
        
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setIconContact(for type: String) {
        let prefix = "-contact"
        
        var image = UIImage(named: "General\(prefix)")
        if let contactImage = UIImage(named: "\(type)\(prefix)") {
            image = contactImage
        }
        
        self.imageView.image = image
    }
    
    
    private func setLabelsText(with data: ManagedContact) {
        self.contactLabel.text = data.type
        self.descriptionLabel.text = data.contact
    }

        
    
    /* MARK: - ViewCode */

    override func setupHierarchy() {
        self.addSubview(self.imageView)
        self.addSubview(self.contactLabel)
        self.addSubview(self.descriptionLabel)
    }
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func setupFonts() {
        self.contactLabel.setupFont(with: FontInfo(
            fontSize: self.getConstant(for: 20), weight: .regular, fontFamily: .graffiti
        ))
        
        self.descriptionLabel.setupFont(with: FontInfo(
            fontSize: self.getConstant(for: 15), weight: .regular
        ))
    }
	  
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            self.contactLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.contactLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.contactLabel.leftAnchor),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.contactLabel.rightAnchor),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let between: CGFloat = self.getConstant(for: 10)
        
        let labelHeight: CGFloat = self.getConstant(for: 20)
        let imageHeight: CGFloat = self.bounds.height
       
        self.dynamicConstraints = [
            self.contactLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: between),
            self.contactLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            self.imageView.widthAnchor.constraint(equalToConstant: imageHeight),
            
            self.descriptionLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        ]
    }
    
    
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 163, height: 163),
            dimension: .width
        )
        return self.getEquivalent(space, screenReference: screenReference)
    }
}
