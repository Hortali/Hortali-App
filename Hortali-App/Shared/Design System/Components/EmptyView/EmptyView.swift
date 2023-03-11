/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Componentes de toda tela vazia.
class EmptyView: UIView, ViewCode {
    
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
    
    final var dynamicConstraints: [NSLayoutConstraint] = []
    
    public var emptyViewText: EmptyTexts? {
        didSet { self.setupEmptyViewDescription() }
    }
    
    
    
    /* MARK: - Construtor */
    
    init(emptyViewType: EmptyTexts? = nil) {
        super.init(frame: .zero)
        
        self.setupEmptyViewText(emptyViewType)
        self.createView()
    }
    
    required init?(coder: NSCoder)  { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateUI()
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupEmptyViewText(_ type: EmptyTexts?) {
        self.emptyViewText = type
    }
    
    
    private func setupEmptyViewDescription() {
        guard let text = self.emptyViewText?.text else { return }
        self.descriptionLabel.text = text
    }
    
    
    
    /* MARK: - Protocolo */
    
    final func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
    
    final func setupHierarchy() {
        self.addSubview(contentView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
    }
    
    
    final func setupStaticTexts() {
        self.titleLabel.text = "OPS "
    }
    
    
    final func setupFonts() {
        self.titleLabel.setupText(with: FontInfo(fontSize: 72, weight: .bold, fontFamily: .graffiti))
    }
    
    
    final func setupStaticConstraints() {
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.descriptionLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])
    }
    
    
    final func setupDynamicConstraints() { }
    
    final func setupUI() { }
}
