/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elementos de UI da célula das tags
class TagCell: UICollectionViewCell, CustomCell {
    
    /* MARK: - Atributos */

    /// Identificador da célula
    static let identifier = "IdTagCell"
    

    // Views
    
    /// Texto da célula
    private let label: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
    }()
   
    
    // Override
    
    override var isSelected: Bool {
        didSet {
            guard self.isSelectionAllowed else { return }
            self.setupColors(when: self.isSelected)
        }
    }
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
        self.setupViews()
        self.setupConstraints()
        self.setupColors(when: false)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Estado que define se é permitido que as células possam ser selecionadas ou não
    public var isSelectionAllowed = true {
        didSet {
            self.setupColors(when: !self.isSelectionAllowed)
        }
    }
        
    
    /// Configura a célula a aprtir do texto que vai receber
    /// - Parameter text: texto
    public func setupCell(with text: String) {
        self.label.text = text
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupStaticTexts()
        self.setupUI()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.label.text = nil
    }
        
    
    
    /* MARK: - Configurações */
    
    /// Configura as cores da célula a partir do estado dela
    /// - Parameter isSelected: estado de quando está selecionado ou não
    private func setupColors(when isSelected: Bool) {
        switch isSelected {
        case false:
            self.backgroundColor = UIColor(originalColor: .greenLight)
            self.label.textColor = UIColor(originalColor: .greenMedium)
        case true:
            self.backgroundColor = UIColor(originalColor: .greenMedium)
            self.label.textColor = UIColor(originalColor: .greenLight)
        }
    }
    
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {    
        self.contentView.addSubview(self.label)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.layer.masksToBounds = true
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        let fontSize = self.superview?.getEquivalent(20) ?? 20
        
        self.label.setupText(with: FontInfo(fontSize: fontSize, weight: .regular))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
