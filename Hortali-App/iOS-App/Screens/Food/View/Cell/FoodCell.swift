/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Célula que mostra os alimentos
class FoodCell: CollectionCellWithViewCode, CustomCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "FoodCellIdentifier"
    
    
    // Views

    private let foodLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let foodImage: UIImageView = CustomViews.newImage()
    
    private let seasonalityLabel: CustomLabel = {
        let lbl = CustomViews.newLabel()
        lbl.isCircular = true
        lbl.text = "S "
        lbl.textAlignment = .center
        
        let white = UIColor(originalColor: .white)
        lbl.backgroundColor = UIColor(originalColor: .orange)
        lbl.textColor = white
        lbl.layer.borderColor = white?.cgColor
        return lbl
    }()
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupCell(for data: ManagedFood) {
        self.foodLabel.text = data.name
        self.foodImage.image = UIImage(named: data.coverImage.name)
        
        let isSeason = InfoFoodController.checkSeasonality(for: data.seasonality)
        self.seasonalityLabel.isHidden = !isSeason
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addViewInContent(self.foodImage)
        self.addViewInContent(self.foodLabel)
        self.addViewInContent(self.seasonalityLabel)
    }
    

    override func setupUI() {
        self.foodImage.layer.cornerRadius = self.superview?.getEquivalent(20) ?? 0
        self.seasonalityLabel.layer.borderWidth = self.getEquivalent(5)
    }
    
    
    override func setupFonts() {
        self.foodLabel.setupText(with: FontInfo(
            fontSize: self.superview?.getEquivalent(16) ?? 0, weight: .regular
        ))
        
        self.seasonalityLabel.setupText(with: FontInfo(
            fontSize: self.superview?.getEquivalent(37) ?? 0, weight: .regular, fontFamily: .graffiti
        ))
    }
     
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.foodImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.foodImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            self.foodLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.foodLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        self.setIconCicleSize()
        self.setDynamicConstraints()
    }
    
    
    private func setIconCicleSize() {
        self.seasonalityLabel.circleSize = self.superview?.self.getEquivalent(35) ?? 0
    }
    
    
    private func setDynamicConstraints() {
        let imageHeight: CGFloat = self.bounds.width
        
        let between: CGFloat = self.getEquivalent(2)
        let space = self.getEquivalent(10)
    
        self.dynamicConstraints = [
            self.foodImage.heightAnchor.constraint(equalToConstant: imageHeight),
            
            self.foodLabel.topAnchor.constraint(equalTo: self.foodImage.bottomAnchor, constant: between),
            
            self.seasonalityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
            self.seasonalityLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -space)
        ]
    }
}
