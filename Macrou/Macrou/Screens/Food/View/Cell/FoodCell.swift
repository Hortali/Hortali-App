/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class FoodCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Identificador da célula
    static let identifier = "FoodCellIdentifier"
    
    /// Nome célula de cada alimento
    private let foodLabel: UILabel = CustomViews.newLabel()
    
    /// ImageView da célula de cada alimento
    private let foodImage: UIImageView = CustomViews.newImage()
    
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
        self.contentView.addSubview(foodImage)
        self.contentView.addSubview(foodLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        foodImage.layer.cornerRadius = 20
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.foodLabel.setupText(with: FontInfo(text: "Alimento", fontSize: 15, weight: .regular))
    }
      
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.foodImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.foodImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.foodImage.heightAnchor.constraint(equalToConstant: 170),
            
            
            self.foodLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 2),
            self.foodLabel.heightAnchor.constraint(equalToConstant: 20),
            self.foodLabel.centerXAnchor.constraint(equalTo: foodImage.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
