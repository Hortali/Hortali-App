/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class FoodCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
        /// Identificador da célula
    static let identifier = "FoodCellIdentifier"
    
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
        /*
                    Aqui vão adicionar os elementos na tela (.addSubViews())
                */
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = .yellow
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
                

                /* Botões */
    }
      
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
