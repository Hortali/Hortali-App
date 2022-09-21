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
    private let foodLabel: UILabel = CustomViews.newLabel()
    
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
    
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupStaticTexts()
        self.setupDynamicConstraints()
        self.setupUI()
        
        self.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.foodImage)
        self.contentView.addSubview(self.foodLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.foodImage.layer.cornerRadius = 20
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.foodLabel.setupText(with: FontInfo(
            text: "Alimento", fontSize: 15, weight: .regular
        ))
    }
      
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 170 , height: 192), dimension: .height)
        let imageHeight: CGFloat = self.bounds.width
        let upside: CGFloat = self.getEquivalent(20, sizeProporsion: screenReferenceSize, screenReference: screenReferenceSize)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.foodImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.foodImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.foodImage.heightAnchor.constraint(equalToConstant: imageHeight),
            
            
            self.foodLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: upside / 10),
            self.foodLabel.heightAnchor.constraint(equalToConstant: upside),
            self.foodLabel.centerXAnchor.constraint(equalTo: foodImage.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
