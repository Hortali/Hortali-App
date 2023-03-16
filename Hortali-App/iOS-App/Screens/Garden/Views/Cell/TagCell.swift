/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elementos de UI da célula das tags
class TagCell: CollectionCellWithViewCode, CustomCell {
    
    /* MARK: - Atributos */

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
        didSet { self.updateUIWhenSelection(is: self.isSelected) }
    }
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUIWhenIsNotSelected()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    public var isSelectionAllowed = true {
        didSet { self.updateUIWhenSelection(is: !self.isSelectionAllowed) }
    }
    
    public func setupCell(with text: String) {
        self.label.text = text
    }
    
    
    

    /* MARK: - Ciclo de Vida */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.label.text = nil
    }
        
    
    
    /* MARK: - Configurações */
    
    private func updateUIWhenSelection(is status: Bool) {
        if status {
            return self.setUIWhenIsSelected()
        }
        self.setUIWhenIsNotSelected()
    }
    
    
    private func setUIWhenIsNotSelected() {
        self.backgroundColor = UIColor(originalColor: .greenLight)
        self.label.textColor = UIColor(originalColor: .greenMedium)
    }
    
    
    private func setUIWhenIsSelected() {
        self.backgroundColor = UIColor(originalColor: .greenMedium)
        self.label.textColor = UIColor(originalColor: .greenLight)
    }
    
    

    /* MARK: - ViewCode */

    override func setupHierarchy() {
        self.addViewInContent(self.label)
    }
    
    
    override func setupView() {
        self.layer.masksToBounds = true
    }
    
    
    override func setupFonts() {
        let fontSize = self.superview?.getEquivalent(20) ?? 20
        self.label.setupText(with: FontInfo(fontSize: fontSize, weight: .regular))
    }
	  
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = self.label.strechToBounds(of: self.contentView)
        return constraints
    }
}
