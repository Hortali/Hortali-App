/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Grupo que lida com a label e um botão que faz com que a label se expanda
class ExpansiveLabel: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    /// Label de referencia para pegar o tamanho quando tiver texto grande
    private let invisibleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.sizeToFit()
        lbl.isHidden = true
        return lbl
    }()
    
    /// Label para colocar o texto expandivel
    private let paragraphLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.paragraph)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    /// Botão para expandir a label
    private let expansiveButton: CustomButton = {
        let but: CustomButton = CustomViews.newButton()
        but.backgroundColor = UIColor(originalColor: .greenLight)
        but.tintColor = UIColor(originalColor: .greenDark)
        return but
    }()
    
    
    // Constraints
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Constraints dinâmicas que mudam de acordo com a altura da view
    private var heightConstraints: [NSLayoutConstraint] = []
    
    
    // Tamanhos
    
    /// Tamanho do botão
    private let btNormalSize: CGFloat = 30
    
    /// Tamanho da label quando não está expandida
    private let lblNormalSize: CGFloat = 65
    
    /// Tamanho da expansão da label
    private var expandedSize: CGFloat = 0
    
    /// Tamanho do texto que fica aparecendo sem expandir
    private let textCountFit: Int = 75
    
    /// Estado se está expandida
    private var status = false
    
        
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.setupExtension(extended: false)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /* Variáveis Computáveis */
    
    /// Tamanho atual da label
    public var actualLabelSize: CGFloat {
        return self.lblNormalSize + self.expandedSize
    }
    
    /// Tamanho da expansão da label
    public var expandedLabelSize: CGFloat {
        return self.expandedSize
    }
    
    /// Estado se está ou não expandida
    public var isExtended: Bool {
        return self.status
    }
    
    
    /* Gerais */
    
    /// Define o texto que a label vai receber
    /// - Parameter text: texto que vai ser definido
    public func setInfoText(for text: String) {
        self.paragraphLabel.text = text
        self.invisibleLabel.text = text
        
        if text.count < self.textCountFit {
            self.expansiveButton.isHidden = true
        }
    }
        
    
    /// Configurações para expandir ou reduzir o tamanho da label
    /// - Parameter isExtended: se está ou não expandida
    public func setupExtension(extended: Bool) {
        self.status = extended
        
        var size = self.btNormalSize + self.lblNormalSize
        if self.isExtended {
            size += round(self.invisibleLabel.bounds.height)
        }
        
        self.setLabelSize(for: size)
    }
    
    
    /// Configura a constraint de altura
    public func setupHeight() {
        let expLabelHeight = self.superview?.self.getEquivalent(self.actualLabelSize) ?? 0
        
        NSLayoutConstraint.deactivate(self.heightConstraints)
    
        self.heightConstraints = [
            self.heightAnchor.constraint(equalToConstant: expLabelHeight),
        ]
        
        NSLayoutConstraint.activate(self.heightConstraints)
    }
    
    
    /// Configura o icone do botão de acordo com o estado de extensão
    public func setupButtonIcon() {
        var icon: AppIcons = .showMore
        
        if self.isExtended {
            icon = .showLess
        }
        
        self.expansiveButton.setupIcon(with: IconInfo(
            icon: icon, size: 15, weight: .medium, scale: .default
        ))
    }
    
    
    /* Ações de botões */

    /// Ação do botão  de expansão
    public func setExpansiveButtonAction(target: Any?, action: Selector) -> Void {
        self.expansiveButton.addTarget(target, action: action, for: .touchDown)
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Geral */
    
    /// Define o tamanho da label
    /// - Parameter size: tamanho que a label vai ter
    private func setLabelSize(for size: CGFloat) {
        if size > self.lblNormalSize {
            self.expandedSize = size - self.lblNormalSize
        }
    }
    
    
    /// Retorna a quantidade de caracteres do texto
    /// - Returns: quantidade de caracteres do texto
    private func getTextCount() -> Int {
        return self.paragraphLabel.text?.count ?? 0
    }
    
    
    /* View */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.invisibleLabel)
        self.addSubview(self.paragraphLabel)
        self.addSubview(self.expansiveButton)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {		
        /* Labels */
        let fontInfo = FontInfo(fontSize: 20, weight: .regular)
        
        self.paragraphLabel.setupText(with: fontInfo)
        self.invisibleLabel.setupText(with: fontInfo)
        
        /* Botões */
        self.setupButtonIcon()
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        self.expansiveButton.circleSize = self.getEquivalent(self.btNormalSize)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.paragraphLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.paragraphLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.paragraphLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.paragraphLabel.bottomAnchor.constraint(equalTo: self.expansiveButton.topAnchor),
            
            
            self.invisibleLabel.topAnchor.constraint(equalTo: self.paragraphLabel.topAnchor),
            self.invisibleLabel.leadingAnchor.constraint(equalTo: self.paragraphLabel.leadingAnchor),
            self.invisibleLabel.trailingAnchor.constraint(equalTo: self.paragraphLabel.trailingAnchor),
        
            
            self.expansiveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.expansiveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
