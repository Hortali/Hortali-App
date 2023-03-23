/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elementos de UI das c;elulas de onboarding
class OnboardingCell: CollectionCellWithViewCode {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdOnboardingCell"
    
    
    // Views
    
    private var primaryTitle: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.secondaryTitle)
        return lbl
    }()
    
    private var secondaryTitle: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.secondaryTitle)
        return lbl
    }()
    
    private var primaryDescription: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.secondaryTitle)
        return lbl
    }()
    
    private var secondaryDescription: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.secondaryTitle)
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    private let mainImage = CustomViews.newImage()
    
    private let referenceView = CustomViews.newView()
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupCell(for infos: OnBoardingInfos) {
        self.setCellTexts(infos)
        self.setCellImage(infos.image)
        self.setCellBackColor(infos.color)
        self.reloadView()
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setCellTexts(_ infos: OnBoardingInfos) {
        self.primaryTitle.text = infos.primaryTitleText
        self.secondaryTitle.text = infos.secondaryTitleText
        self.primaryDescription.text = infos.primaryDescriptionText
        self.secondaryDescription.text = infos.secondaryDescriptionText
    }
    
    
    private func setCellImage(_ image: UIImage?) {
        self.mainImage.image = image
    }
    
    
    private func setCellBackColor(_ color: UIColor?) {
        self.backgroundColor = color
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addViewInContent(self.primaryTitle)
        self.addViewInContent(self.secondaryTitle)
        self.addViewInContent(self.mainImage)
        self.addViewInContent(self.primaryDescription)
        self.addViewInContent(self.secondaryDescription)
        self.addViewInContent(self.referenceView)
    }
    
    
    override func setupFonts() {
        self.primaryTitle.setupFont(with: FontInfo(fontSize: 32, weight: .semibold))
        self.secondaryTitle.setupFont(with: FontInfo(fontSize: 52, weight: .bold, fontFamily: .graffiti))
        
        self.primaryDescription.setupFont(with: FontInfo(fontSize: 20, weight: .semibold))
        self.secondaryDescription.setupFont(with: FontInfo(fontSize: 20, weight: .regular))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.secondaryTitle.leadingAnchor.constraint(equalTo: self.primaryTitle.leadingAnchor),
            self.secondaryTitle.trailingAnchor.constraint(equalTo: self.primaryTitle.trailingAnchor),

            
            self.secondaryDescription.leadingAnchor.constraint(equalTo: self.primaryTitle.leadingAnchor),
            self.secondaryDescription.trailingAnchor.constraint(equalTo: self.primaryTitle.trailingAnchor),
            
            
            self.primaryDescription.bottomAnchor.constraint(equalTo: self.secondaryDescription.topAnchor),
            self.primaryDescription.leadingAnchor.constraint(equalTo: self.primaryTitle.leadingAnchor),
            self.primaryDescription.trailingAnchor.constraint(equalTo: self.primaryTitle.trailingAnchor),
            
            
            self.referenceView.topAnchor.constraint(equalTo: self.secondaryTitle.bottomAnchor),
            self.referenceView.bottomAnchor.constraint(equalTo: self.primaryDescription.topAnchor),
            self.referenceView.leadingAnchor.constraint(equalTo: self.primaryTitle.leadingAnchor),
            self.referenceView.trailingAnchor.constraint(equalTo: self.primaryTitle.trailingAnchor),
            
            
            self.mainImage.centerYAnchor.constraint(equalTo: self.referenceView.centerYAnchor),
            self.mainImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        // Espaçamentos
        let lateral = self.getConstant(for: 15)
        let gap = self.getConstant(for: 10)
        let safeAreaTop = self.getConstant(for: 25)
        let safeAreaBottom = self.getConstant(for: 40)
        
        // Altura
        let imageHeight: CGFloat = self.contentView.bounds.width * 0.9
        
        self.dynamicConstraints = [
            self.primaryTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: safeAreaTop),
            self.primaryTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.primaryTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            self.mainImage.widthAnchor.constraint(equalToConstant: imageHeight),
            self.mainImage.heightAnchor.constraint(equalToConstant: imageHeight),
            
            self.secondaryTitle.topAnchor.constraint(equalTo: self.primaryTitle.bottomAnchor, constant: -gap),
            
            self.secondaryDescription.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -safeAreaBottom),
        ]
    }
    
    
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 240, height: 400),
            dimension: .height
        )
        return self.getEquivalent(space, screenReference: screenReference)
    }
}
