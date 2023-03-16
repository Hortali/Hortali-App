/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Componentes de toda tela vazia.
class EmptyView: ViewWithViewCode {
    
    /* MARK: - Atributos */
    
    // Views
    
    private var contentView = CustomViews.newView()
    
    private var titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(originalColor: .greyButton)
        
        return lbl
    }()
    
    private var descriptionLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(originalColor: .greyButton)
        
        return lbl
    }()
    
    
    // Outros
    
    public var emptyViewText: EmptyTexts? {
        didSet { self.setupEmptyViewDescription() }
    }
    
    
    
    /* MARK: - Construtor */
    
    init(emptyViewType: EmptyTexts? = nil) {
        super.init()
        self.setupEmptyViewText(emptyViewType)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Configurações */
    
    private func setupEmptyViewText(_ type: EmptyTexts?) {
        self.emptyViewText = type
    }
    
    
    private func setupEmptyViewDescription() {
        self.descriptionLabel.text = self.emptyViewText?.text
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
    
    override func setupHierarchy() {
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
    }
    
    
    override func setupStaticTexts() {
        self.titleLabel.text = "OPS "
        self.descriptionLabel.text = self.emptyViewText?.text
    }
    
    
    override func setupFonts() {
        self.titleLabel.setupFont(with: FontInfo(fontSize: 72, weight: .bold, fontFamily: .graffiti))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        var constraints = self.contentView.strechToBounds(of: self)
        constraints += self.createLabelsConstraints()
        return constraints
    }
    
    
    
    private func createLabelsConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.descriptionLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ]
        return constraints
    }
}
