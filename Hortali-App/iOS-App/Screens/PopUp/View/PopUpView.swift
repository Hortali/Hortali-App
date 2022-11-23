/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI do pop up de infirmação
class PopUpView: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    private let container = CustomViews.newView()
    
    private let closeButton = CustomViews.newButton()
    
    private let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.secondaryTitle)
        lbl.backgroundColor = .yellow
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 6
        lbl.textColor = UIColor(.secondaryTitle)
        lbl.backgroundColor = .orange
        lbl.sizeToFit()
        return lbl
    }()
    
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []



    /* MARK: - Construtor */
    
    init(info: PopUpInfo) {
        super.init(frame: .zero)
        
        self.setupViews()
        self.setupPopup(for: info)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */

    /* Ações de botões */

    /// Ação do botão de fechar a tela
    public func setCloseButtonAction(target: Any?, action: Selector) -> Void {
        self.closeButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Configura o popUp a aprtir das informações passadas
    /// - Parameter infos: cpnjunto de informações
    public func setupPopup(for infos: PopUpInfo) {
        self.titleLabel.text = infos.title
        self.descriptionLabel.text = infos.description
        
        self.container.backgroundColor = UIColor(infos.backgroundColor)
        self.closeButton.backgroundColor = UIColor(infos.buttonColor)
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
        self.addSubview(self.container)
        self.container.addSubview(self.closeButton)
        self.container.addSubview(self.titleLabel)
        self.container.addSubview(self.descriptionLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.popupBackBlur)?.withAlphaComponent(0.7)
        self.container.layer.borderWidth = self.getEquivalent(5)
        self.container.layer.borderColor = UIColor(.popupBorder)?.cgColor
        self.container.layer.cornerRadius = self.getEquivalent(20)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {		
        /* Labels */
        self.titleLabel.setupText(with: FontInfo(
            fontSize: self.getEquivalent(45), weight: .bold
        ))
        
        self.titleLabel.setupText(with: FontInfo(
            fontSize: self.getEquivalent(20), weight: .regular
        ))
        

        /* Botões */
        
        self.closeButton.setupText(with: FontInfo(
            text: "fechar", fontSize: self.getEquivalent(25), weight: .semibold
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
        let lateral: CGFloat = self.getEquivalent(10)
        let between: CGFloat = self.getEquivalent(15)
        
        let btHeight: CGFloat = self.getEquivalent(25)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            self.container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            
            
            self.closeButton.topAnchor.constraint(equalTo: self.container.topAnchor, constant: lateral),
            self.closeButton.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -lateral),
            self.closeButton.heightAnchor.constraint(equalToConstant: btHeight),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: between),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -lateral),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: lateral),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -lateral),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: lateral),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
