/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class OnboardingCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Identificador da célula
    static let identifier = "OnboardingCell"
    
    // Views
    
    /// Título da celula da tela de onboarding
    private var firstScreenTitle: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        
        return lbl
    }()
    
    /// Título da celula da tela de onboarding com fonte autoral
    private var secondScreenTitle: UILabel = {
        let lbl = CustomViews.newLabel()
        //lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        
        return lbl
    }()
    
    /// Texto explicativo da tela de onboarding
    private var firstScreenText: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        
        return lbl
    }()
    
    /// Texto explicativo da tela de onboarding com fonte autoral
    private var secondScreenText: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    /// Imagem usada nas telas de onboarding
    private let screenImage: UIImageView = {
        let img = CustomViews.newImage()
        
        return img
    }()
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        self.setupDynamicConstraints()
        self.setupUI()
        self.setupStaticTexts()
        
        self.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(firstScreenTitle)
        self.contentView.addSubview(secondScreenTitle)
        self.contentView.addSubview(screenImage)
        self.contentView.addSubview(firstScreenText)
        self.contentView.addSubview(secondScreenText)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.gardenBack)
        self.screenImage.backgroundColor = .white
        self.screenImage.layer.cornerRadius = self.getEquivalent(30)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.firstScreenTitle.setupText(with: FontInfo(text: "Veja as hortas de", fontSize: 32, weight: .bold))
        self.secondScreenTitle.setupText(with: FontInfo(text: "Sao Paulo", fontSize: 32, weight: .bold))
        self.secondScreenTitle.font =  UIFont(name: "AmsterdamGraffiti", size: 52)
        self.firstScreenText.setupText(with: FontInfo(text: "Aqui é o nosso espaço de descoberta,",
                                                 fontSize: 20,
                                                 weight: .semibold))
        self.secondScreenText.setupText(with: FontInfo(text: "onde você pode encontrar as hortas mais próximas ou até buscar por hortas específicas.",
                                                 fontSize: 20,
                                                 weight: .regular))
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
        
        let between: CGFloat = self.getEquivalent(25, screenReference: screenReferenceSize)
                
        let lateral: CGFloat = self.getEquivalent(15, screenReference: screenReferenceSize)
        
        let labelHeight: CGFloat = self.getEquivalent(40, screenReference: screenReferenceSize)
        
        let labelBetween: CGFloat = self.getEquivalent(10, screenReference: screenReferenceSize)
        
        let imageHeight: CGFloat = self.getEquivalent(220, screenReference: screenReferenceSize)
        
        let imageWidth: CGFloat = self.getEquivalent(self.contentView.frame.width / 3 , screenReference: screenReferenceSize)
        
        self.dynamicConstraints = [
            self.firstScreenTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: between),
            self.firstScreenTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.firstScreenTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.firstScreenTitle.heightAnchor.constraint(equalToConstant: labelHeight/2),
            
            
            self.secondScreenTitle.topAnchor.constraint(equalTo: self.firstScreenTitle.bottomAnchor, constant: -getEquivalent(15)),
            self.secondScreenTitle.leadingAnchor.constraint(equalTo: self.firstScreenTitle.leadingAnchor),
            self.secondScreenTitle.trailingAnchor.constraint(equalTo: self.firstScreenTitle.trailingAnchor),

            
            self.screenImage.topAnchor.constraint(equalTo: self.secondScreenTitle.bottomAnchor, constant: labelBetween),
            self.screenImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.screenImage.heightAnchor.constraint(equalToConstant: imageHeight),
            self.screenImage.widthAnchor.constraint(equalToConstant: imageWidth),
            
            
            self.firstScreenText.topAnchor.constraint(equalTo: self.screenImage.bottomAnchor, constant: (labelBetween / 2)),
            self.firstScreenText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.firstScreenText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            
            self.secondScreenText.topAnchor.constraint(equalTo: self.firstScreenText.bottomAnchor),
            self.secondScreenText.leadingAnchor.constraint(equalTo: self.firstScreenText.leadingAnchor),
            self.secondScreenText.trailingAnchor.constraint(equalTo: self.firstScreenText.trailingAnchor),
            self.secondScreenText.heightAnchor.constraint(equalToConstant: labelHeight),
            
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
