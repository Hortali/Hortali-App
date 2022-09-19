/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Célula que mostra as informações da tela de ver as inforações das hortas
class InfoGardenInfosCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Título da célula
    private let titleLabel = CustomViews.newLabel()
    
    /// Espaço para colocar as informações da célula
    private let customContentView: UIView = {
        let view = CustomViews.newView()
        view.layer.masksToBounds = true
        return view
    }()
    
    /// View que vai estar dentro da contentView
    private var cellView = UIView()
        
    
    // Outros
    
    /// Identificador da célula
    static let identifier = "IdInfoGardenCell"
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define o tipo da célula
    public func setupCell(for cellType: InfoGardenCellType) {
        self.titleLabel.text = cellType.title
        
        self.cellView = cellType.view
        self.cellView.removeFromSuperview()
        self.customContentView.addSubview(self.cellView)

        self.setupDynamicConstraints()
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.customContentView)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.customContentView.layer.cornerRadius = 15
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {		
        self.titleLabel.setupText(with: FontInfo(
            fontSize: 25, weight: .medium
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let between: CGFloat = 12
        
        let labelHeight: CGFloat = 25
       
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            
            self.customContentView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: between),
            self.customContentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.customContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.customContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
            self.cellView.topAnchor.constraint(equalTo: self.customContentView.topAnchor),
            self.cellView.leadingAnchor.constraint(equalTo: self.customContentView.leadingAnchor),
            self.cellView.trailingAnchor.constraint(equalTo: self.customContentView.trailingAnchor),
            self.cellView.bottomAnchor.constraint(equalTo: self.customContentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
