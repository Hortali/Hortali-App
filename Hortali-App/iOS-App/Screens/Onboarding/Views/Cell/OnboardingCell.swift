/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elementos de UI das c;elulas de onboarding
class OnboardingCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Identificador da célula
    static let identifier = "IdOnboardingCell"
    
    
    // Views
    
    /// Título da celula da tela de onboarding
    private var primaryTitle: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.secondaryTitle)
        
        return lbl
    }()
    
    /// Título da celula da tela de onboarding com fonte diferente
    private var secondaryTitle: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.secondaryTitle)
        
        return lbl
    }()
    
    /// Texto explicativo da tela de onboarding
    private var primaryDescription: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.secondaryTitle)
        
        return lbl
    }()
    
    /// Texto explicativo da tela de onboarding com fonte diferente
    private var secondaryDescription: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.secondaryTitle)
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    /// Imagem usada nas telas de onboarding
    private let mainImage = CustomViews.newImage()
    
    /// View usada para referencia para posicionamento
    private let referenceView = CustomViews.newView()
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura a célula a partir das informações passadas
    /// - Parameter infos: informações do on boarding
    public func setupCell(for infos: OnBoardingInfos) {
        self.primaryTitle.text = infos.primaryTitleText
        self.secondaryTitle.text = infos.secondaryTitleText
        
        self.primaryDescription.text = infos.primaryDescriptionText
        self.secondaryDescription.text = infos.secondaryDescriptionText
        
        self.mainImage.image = infos.image
        self.backgroundColor = infos.color
        
        self.layoutSubviews()
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupDynamicConstraints()
        self.setupStaticTexts()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.primaryTitle)
        self.contentView.addSubview(self.secondaryTitle)
        self.contentView.addSubview(self.mainImage)
        self.contentView.addSubview(self.primaryDescription)
        self.contentView.addSubview(self.secondaryDescription)
        self.contentView.addSubview(self.referenceView)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.primaryTitle.setupText(with: FontInfo(fontSize: 32, weight: .semibold))
        self.secondaryTitle.setupText(with: FontInfo(fontSize: 52, weight: .bold, fontFamily: .graffiti))
        
        self.primaryDescription.setupText(with: FontInfo(fontSize: 20, weight: .semibold))
        self.secondaryDescription.setupText(with: FontInfo(fontSize: 20, weight: .regular))
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getConstant(for: 15)
        
        let safeAreaTop: CGFloat = self.getConstant(for: 25)
        let safeAreaBottom: CGFloat = self.getConstant(for: 40)
        let gap = self.getConstant(for: 10)
        
        let imageHeight: CGFloat = self.contentView.bounds.width * 0.9
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.primaryTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: safeAreaTop),
            self.primaryTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.primaryTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            
            self.secondaryTitle.topAnchor.constraint(equalTo: self.primaryTitle.bottomAnchor, constant: -gap),
            self.secondaryTitle.leadingAnchor.constraint(equalTo: self.primaryTitle.leadingAnchor),
            self.secondaryTitle.trailingAnchor.constraint(equalTo: self.primaryTitle.trailingAnchor),

            
            self.secondaryDescription.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -safeAreaBottom),
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
            self.mainImage.widthAnchor.constraint(equalToConstant: imageHeight),
            self.mainImage.heightAnchor.constraint(equalToConstant: imageHeight),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    /// Responsável por pegar o valor referente à célula
    /// - Parameter space: valor para ser convertido
    /// - Returns: valor em relação à tela
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 240, height: 400),
            dimension: .height
        )
        
        return self.getEquivalent(space, screenReference: screenReference)
    }
}
