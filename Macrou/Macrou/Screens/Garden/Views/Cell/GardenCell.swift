/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class GardenCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    //Views
    
    /// Imagem que aparecerá dentro das células da Collection
    private let gardenImage: UIImageView = CustomViews.newImage()
    
    /// Label de título com largura ajustada
    private let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = UIColor(.viewBack)?.withAlphaComponent(0)
        
        return lbl
    }()
    
    /// Label de endereço com largura ajustada
    private let adressLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = UIColor(.viewBack)?.withAlphaComponent(0)
        
        return lbl
    }()
    
    // Outros
    
    /// Identificador da célula
    static let identifier = "gardenCell"
    
    /// Constraints dinâmicas que mudarão de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
        
        // TODO: Apenas para teste - Remover
        self.INFOS_TESTE()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupStaticText()
        self.setupDynamicConstraints()
        self.setupUI()
        
        self.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.gardenImage)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.adressLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
    }
    
    
    /// Define as propriedades dos textos que aparecerão dentro da célula
    func setupStaticText() {
        let screenReferenceSize =
        SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
        
        let titleSize: CGFloat = self.getEquivalent(18, sizeProporsion: screenReferenceSize, screenReference: screenReferenceSize)
        let subtitleSize: CGFloat = self.getEquivalent(12, sizeProporsion: screenReferenceSize, screenReference: screenReferenceSize)
        
        self.titleLabel.setupText(with: FontInfo(
            fontSize: titleSize,
            weight: .medium))
        
        self.adressLabel.setupText(with: FontInfo(
            fontSize: subtitleSize,
            weight: .regular))
        
        print(titleSize)
        print(subtitleSize)
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
            
        let lateral: CGFloat = self.getEquivalent(10, sizeProporsion: screenReferenceSize, screenReference: screenReferenceSize)
        
        let adressLabelHeight: CGFloat = self.getEquivalent(12, sizeProporsion: screenReferenceSize, screenReference: screenReferenceSize)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.gardenImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.gardenImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.gardenImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.gardenImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            
            self.adressLabel.leadingAnchor.constraint(equalTo: self.gardenImage.leadingAnchor, constant: lateral),
            self.adressLabel.trailingAnchor.constraint(equalTo: self.gardenImage.trailingAnchor, constant: -lateral),
            self.adressLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -lateral),
            self.adressLabel.heightAnchor.constraint(equalToConstant: adressLabelHeight),
            
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.gardenImage.leadingAnchor, constant: lateral),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.adressLabel.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.adressLabel.topAnchor, constant: -lateral / 2),
            self.titleLabel.heightAnchor.constraint(equalToConstant: lateral * 2 )
            
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    private func INFOS_TESTE() {
        let gardenImage = "image.jpg"
        let image = UIImage(named: gardenImage)
        self.gardenImage.image = image
        
        self.titleLabel.text = "Horta comunitária da Saúde"
        self.adressLabel.text = "R. Paracatu, 66 - Parque Imperial, SP"
    }
}
