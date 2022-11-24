/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Grupo que lida com a label e um botão que faz com que a label se expanda
class ExpansiveLabel: UIView {
    
    /* MARK: - Atributos */

    // Views
        
    /// Label para colocar o texto expandivel
    private let paragraphLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.paragraph)
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    /// Botão para expandir a label
    private let expansiveButton: CustomButton = {
        let but: CustomButton = CustomViews.newButton()
        but.backgroundColor = UIColor(originalColor: .greenLight)
        but.tintColor = UIColor(originalColor: .greenMedium)
        return but
    }()
    
    
    // Constraints
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Constraints dinâmicas que mudam de acordo com a altura da view
    private var heightConstraints: [NSLayoutConstraint] = []
    
    
    // Tamanhos
    
    /// Tamanho do texto que fica aparecendo sem expandir
    private let textCountFit: Int = 120
    
    /// Estado se está expandida
    private var isExtended = false
    
        
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.setupExtension(extended: false)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */

    /// Define o texto que a label vai receber
    /// - Parameter text: texto que vai ser definido
    public func setInfoText(for text: String) {
        self.paragraphLabel.text = text
        
        if text.count < self.textCountFit {
            self.hideButton()
        }
    }
    
    
    /// Configurações para expandir ou reduzir o tamanho da label
    /// - Parameter isExtended: se está ou não expandida
    public func setupExtension(extended: Bool? = nil) {
        if let extended {
            self.isExtended = extended
        } else {
            self.isExtended.toggle()
        }
        
        if self.isExtended {
            self.paragraphLabel.sizeToFit()
            self.paragraphLabel.numberOfLines = 0
            self.paragraphLabel.adjustsFontSizeToFitWidth = false
        } else {
            self.paragraphLabel.numberOfLines = 3
            self.paragraphLabel.adjustsFontSizeToFitWidth = true
        }
        
        self.setupHeight()
    }
    
    
    /// Configura a constraint de altura
    public func setupHeight() {
        if !self.heightConstraints.isEmpty {
            NSLayoutConstraint.deactivate(self.heightConstraints)
            self.heightConstraints.removeAll()
        }
        
        if !self.expansiveButton.isHidden && !self.isExtended {
            let minimunLabelSize: CGFloat = self.superview?.getEquivalent(100) ?? 00
            
            self.heightConstraints = [
                self.heightAnchor.constraint(equalToConstant: minimunLabelSize),
            ]
        }
        
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
        self.setupGradient()
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Geral */
    
    /// Esconde o botão de expandir
    private func hideButton() {
        self.expansiveButton.isHidden = true
        self.paragraphLabel.sizeToFit()
    }
    
    
    /* View */
    
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
        let btSize: CGFloat = self.getEquivalent(30)
        self.expansiveButton.circleSize = btSize
        
        var between: CGFloat = self.getEquivalent(20)
        if self.isExtended || self.expansiveButton.isHidden {
            between = 0
        }
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.paragraphLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.paragraphLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.paragraphLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            self.expansiveButton.topAnchor.constraint(equalTo: self.paragraphLabel.bottomAnchor, constant: -between),
            self.expansiveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        
        if self.isExtended {
            self.dynamicConstraints += [
                self.expansiveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ]
        }
        
        if self.expansiveButton.isHidden {
            self.dynamicConstraints += [
                self.expansiveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: btSize),
            ]
        }
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    /// Cria o gradiente transparente
    private func setupGradient() {
        if self.isExtended {
            self.paragraphLabel.layer.mask = nil
            return
        }
        
        if !self.expansiveButton.isHidden {
            let color = UIColor(originalColor: .white) ?? .white
            
            let layer = CAGradientLayer()
            layer.startPoint = CGPoint(x: 0, y: 0.3)
            layer.endPoint = CGPoint(x: 0, y: 1)
            layer.locations = [0, 0.3, 0.6, 1]
            layer.colors = [
                color.withAlphaComponent(0.9).cgColor,
                color.withAlphaComponent(0.6).cgColor,
                color.withAlphaComponent(0.3).cgColor
            ]
            
            layer.frame = self.paragraphLabel.frame
            
            self.paragraphLabel.layer.mask = layer
        }
    }
}

