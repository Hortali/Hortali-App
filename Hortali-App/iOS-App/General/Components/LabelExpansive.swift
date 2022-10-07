/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Grupo que lida com a label e um botão que faz com que a label se expanda
class ExpansiveLabel: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    private let paragraphLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.paragraph)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let expansiveButton: CustomButton = {
        let but: CustomButton = CustomViews.newButton()
        but.backgroundColor = UIColor(originalColor: .greenLight)
        but.tintColor = UIColor(originalColor: .greenDark)
        return but
    }()
    
    
    // Constraints
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    private var heightConstraints: [NSLayoutConstraint] = []
    
    
    // Views sizes
    
    private let btNormalSize: CGFloat = 30
    
    private let lblNormalSize: CGFloat = 65
    
    private var expandedSize: CGFloat = 0
    
    private var status: Bool = false
    
    
    /* Encapsulamento (Variáveis Computáveis) */
    
    public var actualLabelSize: CGFloat {
        return self.lblNormalSize + self.expandedSize
    }
    
    public var expandedLabelSize: CGFloat {
        return self.expandedSize
    }
    
    public var isExtended: Bool {
        return self.status
    }

    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.setupExtension(extended: false)
        self.DADOS_TESTE()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */

    /// Define o texto que a label vai receber
    /// - Parameter text: texto que vai ser definido
    public func setInfoText(for text: String) {
        self.paragraphLabel.text = text
    }
        
    
    /// Define o tamanho da label
    /// - Parameter size: tamanho que a label vai ter
    public func setLabelSize(for size: CGFloat) {
        if size > self.lblNormalSize {
            self.expandedSize = size - self.lblNormalSize
        }
    }
    
    
    /// Retorna a quantidade de caracteres do texto
    /// - Returns: quantidade de caracteres do texto
    public func getTextCount() -> Int {
        return self.paragraphLabel.text?.count ?? 0
    }
    
    
    /// Configurações para expandir ou reduzir o tamanho da label
    /// - Parameter isExtended: se está ou não expandida
    public func setupExtension(extended: Bool) {
        self.status = extended
        
        var extensionSize: CGFloat = 0
        
        if self.isExtended {
            extensionSize = 35 * CGFloat(self.getTextCount() / 75)
        }
        
        let size = self.btNormalSize + self.lblNormalSize + extensionSize
        
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
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.paragraphLabel)
        self.addSubview(self.expansiveButton)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {		
        /* Labels */
        self.paragraphLabel.setupText(with: FontInfo(
            fontSize: 20, weight: .regular
        ))
        
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
        
            
            self.expansiveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.expansiveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    private func DADOS_TESTE() {
        let text = """
        A hortinha da saúde é muito bem cuidada e sempre tem ótimos alimentos frescos que são plantados e cuidados com muito, A hortinha da saúde é muito bem cuidada e sempre tem ótimos alimentos frescos que são plantados e cuidados com muito
        """
        self.paragraphLabel.text = text
    }
}
