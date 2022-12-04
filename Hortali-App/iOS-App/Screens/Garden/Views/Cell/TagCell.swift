/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elementos de UI da célula das tags
class TagCell: UICollectionViewCell {
    
    /* MARK: - Atributos */

    /// Identificador da célula
    static let identifier = "IdTagCell"
    

    // Views
    
    /// Texto da célula
    private let label: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        lbl.sizeToFit()
        lbl.numberOfLines = 0
        return lbl
    }()
   
    

    // Outros

    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura a célula a aprtir do texto que vai receber
    /// - Parameter text: texto
    public func setupCell(with text: String) {
        self.label.text = text
    }
    
    
    /// Pega a fonte usada na célula
    public var fontCell: UIFont? {
        return self.label.font
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupStaticTexts()
        self.setupDynamicConstraints()
        self.setupUI()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.label.text = nil
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {    
        self.contentView.addSubview(self.label)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.getEquivalent(20)
        
        self.backgroundColor = UIColor(originalColor: .greenLight)
        self.label.textColor = UIColor(originalColor: .greenDark)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        let fontSize = self.superview?.getEquivalent(20) ?? 20
        self.label.setupText(with: FontInfo(fontSize: fontSize, weight: .regular))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
//        let lateral: CGFloat =
//        let between: CGFloat =
       
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
