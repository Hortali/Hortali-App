/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class GardenCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    let gardenImage: UIImageView = CustomViews.newImage()
    let titleLabel: UILabel = CustomViews.newLabel()
    let adressLabel: UILabel = CustomViews.newLabel()
    
    /// Identificador da célula
    static let identifier = "gardenCell"
    
    // Views
    
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.setText()
        self.setupDynamicConstraints()
        self.setupUI()
        
        self.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        /*
         Aqui vão adicionar os elementos na tela (.addSubViews())
         */
        self.contentView.addSubview(gardenImage)
        
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        /*
         Aqui vão definidos as bordas, cor de fundo da view
         */
        
        self.gardenImage.sizeToFit()
        self.backgroundColor = .yellow
        
        // Define o tamanho que a célula vai ter
        // self.collectionFlow.itemSize = CGSize(width: 100, height: 100)
        
    }
    
    /// Define as propriedades dos textos que aparecerão dentro da célula
    func setText() {
        
        let titleSize: CGFloat = self.getEquivalent(18)
        let subtitleSize: CGFloat = self.getEquivalent(12)
        
        self.titleLabel.setupText(with: FontInfo(
            fontSize: titleSize,
            weight: .medium))
        self.adressLabel.setupText(with: FontInfo(
            fontSize: subtitleSize,
            weight: .regular))
        
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        
        let lateral: CGFloat = getEquivalent(10)
        let between: CGFloat = getEquivalent(5)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            gardenImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            gardenImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            gardenImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            gardenImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.gardenImage.leadingAnchor, constant: lateral),
            titleLabel.trailingAnchor.constraint(equalTo: self.gardenImage.trailingAnchor, constant: lateral),
            titleLabel.bottomAnchor.constraint(equalTo: self.gardenImage.bottomAnchor, constant: lateral),
            
            adressLabel.leadingAnchor.constraint(equalTo: self.gardenImage.leadingAnchor, constant: lateral),
            adressLabel.trailingAnchor.constraint(equalTo: self.gardenImage.trailingAnchor, constant: lateral),
            adressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: between)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
