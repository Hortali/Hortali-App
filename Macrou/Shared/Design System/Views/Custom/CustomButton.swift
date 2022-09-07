/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


///
class CustomButton: UIButton {
    
    /* MARK: - Atributos */
    
    /// Variável que diz se o botão vai ser circular ou não. Por padrão é true
    public var isRounded: Bool = true
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    override var bounds: CGRect {
        didSet {
            switch self.isRounded {
            case true:
                self.layer.cornerRadius = self.bounds.height/2
                self.setupRoundedCoonstraints()
                
            case false:
                NSLayoutConstraint.deactivate(self.dynamicConstraints)
            }
        }
    }
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupButton()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Configurações */
    
    /// Faz as configurações iniciais de um botão
    private func setupButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        
        self.backgroundColor = UIColor(.backgroundButton)
    }
    
    
    /// Define as pra quando o botào for arredondado
    private func setupRoundedCoonstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.heightAnchor.constraint(equalToConstant: 45),
            self.widthAnchor.constraint(equalToConstant: 45),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
}
