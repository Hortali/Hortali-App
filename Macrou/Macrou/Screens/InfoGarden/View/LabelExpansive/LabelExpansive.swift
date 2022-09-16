/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class ExpansiveLabel: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    private let paragraphLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.paragraph)
        return lbl
    }()
    
    
    private let expansiveButton: CustomButton = {
        let but: CustomButton = CustomViews.newButton()
        but.backgroundColor = UIColor(originalColor: .greenLight)
        but.tintColor = UIColor(originalColor: .greenDark)
        return but
    }()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []



    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */

    /// Define o texto que a label vai receber
    public func setInfoText(for text: String) {
        self.paragraphLabel.text = text
    }
    
    
    /* Ações de botões */

    /// Ação do botão  de expansão
    public func setExpansiveButtonAction(target: Any?, action: Selector) -> Void {
        self.expansiveButton.addTarget(target, action: action, for: .touchDown)
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.paragraphLabel)
        self.addSubview(self.expansiveButton)
    }
    
    
    /// Personalização da UI
    private func setupUI() {

    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {		
        /* Labels */
        self.paragraphLabel.text = """
        A hortinha da saúde é muito bem cuidada e sempre tem ótimos alimentos frescos que são plantados e cuidados com muito
        """
        self.paragraphLabel.numberOfLines = 0
        self.paragraphLabel.setupText(with: FontInfo(
            fontSize: 20, weight: .regular
        ))
        

        /* Botões */
        self.expansiveButton.setupIcon(with: IconInfo(
            icon: .showMore, size: 12, weight: .medium, scale: .default
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        self.expansiveButton.circleSize = self.getEquivalent(20)
        
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
}
