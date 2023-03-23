/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elementos de UI da célula das hortas
class GardenCell: CollectionCellWithViewCode, CustomCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "gardenCell"
    
    
    // Views
    
    private final let gardenImage: UIImageView = CustomViews.newImage()
    
    private final let titleLabel: CustomLabel = {
        let lbl = CustomViews.newLabel()
        lbl.isCircular = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.secondaryTitle)
        return lbl
    }()
    
    private final let adressLabel: CustomLabel = {
        let lbl = CustomViews.newLabel()
        lbl.isCircular = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.secondaryTitle)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupCell(for data: ManagedGarden) {
        self.titleLabel.text = data.name
        self.adressLabel.text = data.address
        
        self.gardenImage.image = UIImage(named: data.coverImage.name)
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addViewInContent(self.gardenImage)
        self.addViewInContent(self.titleLabel)
        self.addViewInContent(self.adressLabel)
    }
    
    
    override func setupView() {
        self.layer.masksToBounds = true
    }
    
    
    override func setupUI() {
        self.layer.cornerRadius = self.getEquivalent(20)
    }
    
    
    override func setupFonts() {
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
        
        let titleSize: CGFloat = self.getEquivalent(25, screenReference: screenReferenceSize)
        let subtitleSize: CGFloat = self.getEquivalent(20, screenReference: screenReferenceSize)
        
        self.titleLabel.setupFont(with: FontInfo(
            fontSize: titleSize, weight: .semibold
        ))
        
        self.adressLabel.setupFont(with: FontInfo(
            fontSize: subtitleSize, weight: .medium
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        var constraints = [
            self.titleLabel.leadingAnchor.constraint(equalTo: self.adressLabel.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.adressLabel.trailingAnchor),
        ]
        let gardenImageConstraints = self.gardenImage.strechToBounds(of: self.contentView)
        constraints += gardenImageConstraints
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
        
        // Espaçamentos
        let lateral: CGFloat = self.getEquivalent(10, screenReference: screenReferenceSize)
        let between = lateral / 2
        
        // Alturas
        let addressHeight: CGFloat = self.getEquivalent(35, screenReference: screenReferenceSize)
        let titleHeight: CGFloat = self.getEquivalent(28, screenReference: screenReferenceSize)
        
        
        self.dynamicConstraints = [
            self.adressLabel.leadingAnchor.constraint(equalTo: self.gardenImage.leadingAnchor, constant: lateral),
            self.adressLabel.trailingAnchor.constraint(equalTo: self.gardenImage.trailingAnchor, constant: -lateral),
            self.adressLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -lateral),
            self.adressLabel.heightAnchor.constraint(equalToConstant: addressHeight),
            
            
            self.titleLabel.bottomAnchor.constraint(equalTo: self.adressLabel.topAnchor, constant: -between),
            self.titleLabel.heightAnchor.constraint(equalToConstant: titleHeight)
        ]
    }
}
