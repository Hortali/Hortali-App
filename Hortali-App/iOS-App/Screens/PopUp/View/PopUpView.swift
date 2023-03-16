/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI do pop up de informação
class PopUpView: ViewWithViewCode {
    
    /* MARK: - Atributos */

    // Views
    
    private let container = CustomViews.newView()
    
    private let closeButton: CustomButton = {
        let but = CustomViews.newButton()
        but.backgroundColor = .clear
        but.isCircular = false
        but.sizeToFit()
        return but
    }()
    
    private let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.secondaryTitle)
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.secondaryTitle)
        lbl.numberOfLines = 7
        lbl.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
        return lbl
    }()
    


    /* MARK: - Construtor */
    
    init(info: PopUpInfo) {
        super.init()
        self.setupPopup(for: info)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupPopup(for infos: PopUpInfo) {
        self.setPopupTexts(with: infos)
        self.setPopupColors(with: infos)
    }
    
    
    /* Ações de botões */

    public func setCloseButtonAction(target: Any?, action: Selector) -> Void {
        self.closeButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setPopupTexts(with infos: PopUpInfo) {
        self.titleLabel.text = infos.title
        self.descriptionLabel.text = infos.description
    }
    
    
    private func setPopupColors(with infos: PopUpInfo) {
        self.container.backgroundColor = UIColor(infos.backgroundColor)
        self.closeButton.setTitleColor(UIColor(infos.buttonColor), for: .normal)
    }
    
    
    
    /* MARK: - ViewCode */

    override func setupHierarchy() {
        self.addSubview(self.container)
        self.addViewInContent(self.closeButton)
        self.addViewInContent(self.titleLabel)
        self.addViewInContent(self.descriptionLabel)
    }
    
    
    private func addViewInContent(_ view: UIView) {
        self.container.addSubview(view)
    }
    
    
    override func setupView() {
        self.backgroundColor = UIColor(.popupBackBlur)?.withAlphaComponent(0.8)
        self.container.layer.borderColor = UIColor(.popupBorder)?.cgColor
    }
    
    
    override func setupUI() {
        self.container.layer.borderWidth = self.getEquivalent(5)
        self.container.layer.cornerRadius = self.getEquivalent(20)
    }
    
    
    override func setupStaticTexts() {
        self.closeButton.setTitle("Fechar", for: .normal)
    }
	  
    
    override func setupFonts() {
        self.titleLabel.setupText(with: FontInfo(
            fontSize: self.getEquivalent(45), weight: .bold, fontFamily: .graffiti
        ))
        
        self.descriptionLabel.setupText(with: FontInfo(
            fontSize: self.getEquivalent(20), weight: .regular
        ))
        
        self.closeButton.setupText(with: FontInfo(
            fontSize: self.getEquivalent(25), weight: .semibold, fontFamily: .graffiti
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            self.container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(5)
        
        self.dynamicConstraints = [
            self.closeButton.topAnchor.constraint(equalTo: self.container.topAnchor, constant: between),
            self.closeButton.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -lateral),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: -lateral),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -lateral),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: lateral),
            
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: between),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -lateral),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: lateral),
        ]
    }
}
