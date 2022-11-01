/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class OnboardingCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Identificador da célula
    static let identifier = "OnboardingCell"
    
    // Views
    
    /// Título da celula da tela de onboarding
    private var screenTitle = UILabel()
    
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
        
        self.setupStaticTexts()
        self.setupDynamicConstraints()
        self.setupUI()
        
        self.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        /*
         Aqui vão adicionar os elementos na tela (.addSubViews())
         */
        self.contentView.addSubview(screenTitle)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        /*
         Aqui vão definidos as bordas, cor de fundo da view
         */
        screenTitle.backgroundColor = .blue
        self.backgroundColor = .red
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
        
        screenTitle.text = "UUUUUAAAAA"
        /* Botões */
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
        
        let between: CGFloat = self.getEquivalent(10, screenReference: screenReferenceSize)
        
        let lateral: CGFloat = self.getEquivalent(15, screenReference: screenReferenceSize)
        
        self.dynamicConstraints = [
            self.screenTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: between),
            self.screenTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.screenTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
