/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class OnboardingCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Identificador da célula
    static let identifier = "OnboardingCell"
    
    // Views
    
    /// Título da celula da tela de onboarding
    private var screenTitle: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .blue
        lbl.textColor = .white
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    /// Imagem usada nas telas de onboarding
    private let screenImage = CustomViews.newImage()
    
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
        /*
         Aqui vão adicionar os elementos na tela (.addSubViews())
         */
        self.contentView.addSubview(screenTitle)
        self.contentView.addSubview(screenImage)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        /*
         Aqui vão definidos as bordas, cor de fundo da view
         */
        self.backgroundColor = .red
        self.screenImage.backgroundColor = .yellow
        // Define o tamanho que a célula vai ter
        // self.collectionFlow.itemSize = CGSize(width: 100, height: 100)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /*
         Aqui vão ser configurados os textos estáticos, ícones dos botões
         tamanho das fontes, peso das fontes.. (para botões e labels ou até
         mesmo para putrp elemento caso tenha)
         */
        
        /* Labels */
        screenTitle.setupText(with: FontInfo(text: "Veja as hortas de São Paulo", fontSize: 28, weight: .bold))
        /* Botões */
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
        
        let between: CGFloat = self.getEquivalent(30, screenReference: screenReferenceSize)
        
        let lateral: CGFloat = self.getEquivalent(15, screenReference: screenReferenceSize)
        
        let imageHeight: CGFloat = self.getEquivalent(200, screenReference: screenReferenceSize)
        
        let imageWidth: CGFloat = self.getEquivalent(100, screenReference: screenReferenceSize)
        
        self.dynamicConstraints = [
            self.screenTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: between),
            self.screenTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.screenTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            self.screenImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.screenImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.screenImage.heightAnchor.constraint(equalToConstant: imageHeight),
            self.screenImage.widthAnchor.constraint(equalToConstant: imageWidth),
            
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
