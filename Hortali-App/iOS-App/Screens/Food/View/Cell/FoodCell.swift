/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Célula da collection que mostra os alimentos
class FoodCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Identificador da célula
    static let identifier = "FoodCellIdentifier"
    
    // Views
    
    /// Nome célula de cada alimento
    private let foodLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    /// ImageView da célula de cada alimento
    private let foodImage: UIImageView = CustomViews.newImage()
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
      
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupStaticTexts()
        self.setupDynamicConstraints()
        self.setupUI()
        
        self.reloadInputViews()
    }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupCell(for data: ManagedFood) {
        self.foodLabel.text = data.name
        self.foodImage.image = UIImage(named: data.coverImage.name)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.foodImage)
        self.contentView.addSubview(self.foodLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.foodImage.layer.cornerRadius = self.superview?.getEquivalent(20) ?? 0
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.foodLabel.setupText(with: FontInfo(
            fontSize: self.superview?.getEquivalent(16) ?? 0, weight: .regular
        ))
    }
      
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let imageHeight: CGFloat = self.bounds.width
        let between: CGFloat = self.getEquivalent(2)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.foodImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.foodImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.foodImage.heightAnchor.constraint(equalToConstant: imageHeight),
            
            
            self.foodLabel.topAnchor.constraint(equalTo: self.foodImage.bottomAnchor, constant: between),
            self.foodLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.foodLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
