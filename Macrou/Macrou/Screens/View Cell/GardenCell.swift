/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class GardenCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Imagem que aparecerá dentro das células da Collection
    private let gardenImage: UIImageView = CustomViews.newImage()
    
    /// Labels de título com largura ajustada
    private let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = UIColor(.viewBack)?.withAlphaComponent(0)
        
        return lbl
    }()
    
    /// Labels de endereço com largura ajustada
    private let adressLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = UIColor(.viewBack)?.withAlphaComponent(0)
        
        return lbl
    }()
    
    /// Identificador da célula
    static let identifier = "gardenCell"
    
    
    // Views
    /// Constraints dinâmicas que mudarão de acordo com o tamanho da tela
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
        
        self.contentView.addSubview(gardenImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(adressLabel)
        
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        
        //        self.gardenImage.sizeToFit()
        
        let gardenImage = "image.jpg"
        
        let image = UIImage(named: gardenImage)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.gardenImage.image = image
        
    }
    
    /// Define as propriedades dos textos que aparecerão dentro da célula
    func setText() {
        
        let titleSize: CGFloat = 18 //self.getEquivalent(18)
        let subtitleSize: CGFloat = 12 //self.getEquivalent(12)
        
        self.titleLabel.setupText(with: FontInfo(
            text: "Horta comunitária da Saúde",
            fontSize: titleSize,
            weight: .medium))
        self.adressLabel.setupText(with: FontInfo(
            text: "R. Paracatu, 66 - Parque Imperial, SP",
            fontSize: subtitleSize,
            weight: .regular))
        
    }
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        
        let lateral: CGFloat = 10
        let between: CGFloat = 5
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            gardenImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            gardenImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            gardenImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            gardenImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            adressLabel.leadingAnchor.constraint(equalTo: self.gardenImage.leadingAnchor, constant: lateral),
            adressLabel.trailingAnchor.constraint(equalTo: self.gardenImage.trailingAnchor, constant: -lateral),
            adressLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -lateral),
            adressLabel.heightAnchor.constraint(equalToConstant: 12),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.gardenImage.leadingAnchor, constant: lateral),
            titleLabel.trailingAnchor.constraint(equalTo: self.adressLabel.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.adressLabel.topAnchor, constant: -between),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
        
    }
}
