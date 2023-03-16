/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Célula que mostra as configurações disponíveis na tela de configurações
class SettingsCell: CollectionCellWithViewCode, CustomCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdSettingsCell"
    
    
    // Views
    
    private let titleLabel = CustomViews.newLabel()
    
    private let container: UIView = {
        let view = CustomViews.newView()
        view.layer.masksToBounds = true
        return view
    }()
    
    private var iconImage: UIImageView = {
        let imgV = CustomViews.newImage()
        imgV.tintColor = UIColor(.secondaryTitle)
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    private var subTitleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.secondaryTitle)
        return lbl
    }()
    
    private var descriptionLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.secondaryTitle)
        return lbl
    }()
    
    // View usada para referência de espaço para o ícone
    private let referenceView = CustomViews.newView()
        
    
    
    /* MARK: - Encapsulamento */
    
    public func setupCell(with data: SettingsData) {
        self.titleLabel.text = data.title
        self.subTitleLabel.text = data.subTitle
        self.descriptionLabel.text = data.description
        
        self.container.backgroundColor = UIColor(data.color)
        self.iconImage.image = UIImage(data.icon)
    }
    
    

    /* MARK: - Configurações */

    override func setupHierarchy() {
        self.addViewInContent(self.titleLabel)
        self.addViewInContent(self.container)
        
        self.addViewInContainer(self.referenceView)
        self.addViewInContainer(self.iconImage)
        self.addViewInContainer(self.subTitleLabel)
        self.addViewInContainer(self.descriptionLabel)
    }
    
    
    private func addViewInContainer(_ view: UIView) {
        self.container.addSubview(view)
    }
    
    
    override func setupUI() {
        self.container.layer.cornerRadius = self.getConstant(for: 15)
    }
    
    
    override func setupFonts() {
        self.titleLabel.setupText(with: FontInfo(
            fontSize: self.getConstant(for: 25), weight: .semibold
        ))
        
        let secondaryFontSize: CGFloat = self.getConstant(for: 15)
        
        self.subTitleLabel.setupText(with: FontInfo(
            fontSize: secondaryFontSize, weight: .bold
        ))
        
        self.descriptionLabel.setupText(with: FontInfo(
            fontSize: secondaryFontSize, weight: .medium
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            self.container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
            self.subTitleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.descriptionLabel.leadingAnchor),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.descriptionLabel.trailingAnchor),
            
            
            self.referenceView.topAnchor.constraint(equalTo: self.container.topAnchor),
            self.referenceView.bottomAnchor.constraint(equalTo: self.subTitleLabel.topAnchor),
            self.referenceView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            self.iconImage.centerYAnchor.constraint(equalTo: self.referenceView.centerYAnchor),
            self.iconImage.centerXAnchor.constraint(equalTo: self.referenceView.centerXAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let lateral: CGFloat = self.getConstant(for: 15)
        let between: CGFloat = self.getConstant(for: 5)
        
        let iconHeight: CGFloat = self.getConstant(for: 50)
        
        self.dynamicConstraints = [
            self.container.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: between),
            
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -between),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: lateral),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -lateral),
            
            
            self.iconImage.heightAnchor.constraint(equalToConstant: iconHeight),
            self.iconImage.widthAnchor.constraint(equalToConstant: iconHeight),
        ]
    }
    
    
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 360, height: 165),
            dimension: .width
        )
        return self.getEquivalent(space, screenReference: screenReference)
    }
}
