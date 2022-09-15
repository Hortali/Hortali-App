/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class FoodCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
        /// Identificador da célula
    static let identifier = "FoodCellIdentifier"
    private let foodLabel: UILabel = CustomViews.newLabel()
    private let foodImage: UIImageView = CustomViews.newImage()
    
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
        /*
         
                    Aqui vão adicionar os elementos na tela (.addSubViews())
                */
    }
    
    
    /// Personalização da UI
    private func setupUI() {
//        self.backgroundColor = .yellow
        foodImage.layer.cornerRadius = 20
        /*
                    Aqui vão definidos as bordas, cor de fundo da view
                */
                
                // Define o tamanho que a célula vai ter
                // self.collectionFlow.itemSize = CGSize(width: 100, height: 100)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /*
                    Aqui vão ser configurados os textos estáticos, ícones dos botões
                    tamanho das fontes, peso das fontes.. (para botões e labels ou até
                    mesmo para putrp elemento caso tenha)
                */
                
                /* Labels */
        self.foodLabel.setupText(with: FontInfo(text: "Alimento", fontSize: 15, weight: .regular))

                /* Botões */
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
//            self.foodLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//            self.foodLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            //self.foodLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
