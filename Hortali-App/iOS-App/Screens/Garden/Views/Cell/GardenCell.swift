/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Elementos de UI da célula das hortas
class GardenCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Identificador da célula
    static let identifier = "gardenCell"
    
    
    // Views
    
    /// Imagem de capa das hortas
    private let gardenImage: UIImageView = CustomViews.newImage()
    
    /// Nome da horta
    private lazy var titleLabel = UILabel()
    
    /// Endereço da horta
    private lazy var adressLabel = UILabel()
    
    
    // Constraints
    
    /// Constraints dinâmicas que mudarão de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel = self.createCustomLabel()
        self.adressLabel = self.createCustomLabel()
        self.adressLabel.numberOfLines = 2
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupStaticText()
        self.setupDynamicConstraints()
        self.setupUI()
    }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura a célula a partir dos dados recebidos
    /// - Parameter data: dados recebidos
    public func setupCell(for data: ManagedGarden) {
        self.gardenImage.image = UIImage(named: data.coverImage.name)
        
        self.titleLabel.text = data.name
        self.adressLabel.text = data.address
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Cria a label customizada para a tela
    /// - Returns: label customizada
    private func createCustomLabel() -> UILabel {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.secondaryTitle)
        
        return lbl
    }
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.gardenImage)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.adressLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.getEquivalent(20)
    }
    
    
    /// Define as propriedades dos textos que aparecerão dentro da célula
    private func setupStaticText() {
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
        
        let titleSize: CGFloat = self.getEquivalent(25, screenReference: screenReferenceSize)
        let subtitleSize: CGFloat = self.getEquivalent(20, screenReference: screenReferenceSize)
        
        self.titleLabel.setupText(with: FontInfo(
            fontSize: titleSize, weight: .semibold
        ))
        
        self.adressLabel.setupText(with: FontInfo(
            fontSize: subtitleSize, weight: .medium
        ))
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
            
        let lateral: CGFloat = self.getEquivalent(10, screenReference: screenReferenceSize)
        
        let addressHeight: CGFloat = self.getEquivalent(35, screenReference: screenReferenceSize)
        let titleHeight: CGFloat = self.getEquivalent(28, screenReference: screenReferenceSize)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.gardenImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.gardenImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.gardenImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.gardenImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            
            self.adressLabel.leadingAnchor.constraint(equalTo: self.gardenImage.leadingAnchor, constant: lateral),
            self.adressLabel.trailingAnchor.constraint(equalTo: self.gardenImage.trailingAnchor, constant: -lateral),
            self.adressLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -lateral),
            self.adressLabel.heightAnchor.constraint(equalToConstant: addressHeight),
            
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.adressLabel.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.adressLabel.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.adressLabel.topAnchor, constant: -lateral / 2),
            self.titleLabel.heightAnchor.constraint(equalToConstant: titleHeight)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
