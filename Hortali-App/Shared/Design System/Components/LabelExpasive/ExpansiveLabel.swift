/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class ExpansiveLabel: ViewWithViewCode {
    
    /* MARK: - Atributos */
    
    override var bounds: CGRect {
        didSet { self.updateWhenBoundsChanged() }
    }
    

    // Views
        
    private let paragraphLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.paragraph)
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    
    private let expansiveButton: CustomButton = {
        let but: CustomButton = CustomViews.newButton()
        but.backgroundColor = UIColor(originalColor: .greenLight)
        but.tintColor = UIColor(originalColor: .greenMedium)
        return but
    }()
    
    
    // Constraints
    
    private var heightConstraints: [NSLayoutConstraint] = []
    
    
    // Tamanhos
    
    private let textCountFit: Int = 120
    
    public var defaultHeight: CGFloat = 100
    
    private var isExtended = false
    
    
    // Delegate
    
    private weak var delegate: ExpansiveLabelDelegate?
    
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        self.setupExtension(extended: false)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setExpansiveLabelDelegate(_ delegate: ExpansiveLabelDelegate) {
        self.delegate = delegate
    }
    

    public func setInfoText(for text: String) {
        self.paragraphLabel.text = text
        
        if text.count < self.textCountFit {
            self.hideButton()
        }
    }
    
    
    public func setupExtension(extended: Bool? = nil) {
        self.setExtensionStatus(with: extended)
        self.updateLabelFromExtensio()
        self.setupHeight()
        self.setupButtonIcon()
    }
    
    
    /* Ações de botões */

    public func setExpansiveButtonAction(target: Any?, action: Selector) -> Void {
        self.expansiveButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    
    /* MARK: - Configurações */
    
    private func updateWhenBoundsChanged() {
        guard self.bounds.height >= self.defaultHeight else { return }
        self.delegate?.actionWhenLabelWasExpanded()
    }
    
    
    private func hideButton() {
        self.expansiveButton.isHidden = true
        self.paragraphLabel.sizeToFit()
    }
    
    
    private func setExtensionStatus(with status: Bool?) {
        if let status {
            self.isExtended = status
        } else {
            self.isExtended.toggle()
        }
    }

    
    private func updateLabelFromExtensio() {
        if self.isExtended {
            self.paragraphLabel.sizeToFit()
            self.paragraphLabel.numberOfLines = 0
            self.paragraphLabel.adjustsFontSizeToFitWidth = false
        } else {
            self.paragraphLabel.numberOfLines = 3
            self.paragraphLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    
    public func setupHeight() {
        self.clearHeightConstraints()
        self.createHeightConstraints()
        self.activateConstraints(for: self.heightConstraints)
    }
    
    
    private func clearHeightConstraints() {
        guard !self.heightConstraints.isEmpty else { return }
        NSLayoutConstraint.deactivate(self.heightConstraints)
        self.heightConstraints.removeAll()
    }
    
    
    private func createHeightConstraints() {
        guard !self.expansiveButton.isHidden && !self.isExtended else { return }
        
        self.heightConstraints = [
            self.heightAnchor.constraint(equalToConstant: self.defaultHeight),
        ]
    }
    

    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setupGradient()
    }
    
    
    
    /* MARK: - View Code */
    
    override func setupHierarchy() {
        self.addSubview(self.paragraphLabel)
        self.addSubview(self.expansiveButton)
    }
    
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func setupStaticTexts() {
        self.setupButtonIcon()
    }
    
    
    private func setupButtonIcon() {
        let icon: AppIcons = self.isExtended ? .showLess : .showMore
        
        self.expansiveButton.setupIcon(with: IconInfo(
            icon: icon, size: 15, weight: .medium, scale: .default
        ))
    }
    
    
    override func setupFonts() {
        self.paragraphLabel.setupFont(with: FontInfo(
            fontSize: 20, weight: .regular
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.paragraphLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.paragraphLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.paragraphLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            self.expansiveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        return constraints
    }
	
    
    override func createDynamicConstraints() {
        let btSize = self.setButtonSize()
        let between = self.getBetweenSpaceFromBottom()
        
        self.dynamicConstraints = [
            self.expansiveButton.topAnchor.constraint(equalTo: self.paragraphLabel.bottomAnchor, constant: -between),
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
    }
    
    
    private func getBetweenSpaceFromBottom() -> CGFloat {
        var between: CGFloat = self.getEquivalent(20)
        if self.isExtended || self.expansiveButton.isHidden {
            between = 0
        }
        return between
    }
    
    
    private func setButtonSize() -> CGFloat {
        let btSize: CGFloat = self.getEquivalent(30)
        self.expansiveButton.circleSize = btSize
        return btSize
    }
    
    
    private func setupGradient() {
        if isExtended {
            return self.removeMask()
        }
        
        guard !self.expansiveButton.isHidden else { return }
        self.createGradientMask()
    }
    
    
    private func removeMask() {
        self.paragraphLabel.layer.mask = nil
    }
    
    
    private func createGradientMask() {
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
