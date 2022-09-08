/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


///
class CustomButton: UIButton {
    
    /* MARK: - Atributos */
    
    /// Estado de quando o botão é circular ou não. (Padrão: true)
    public var isRounded: Bool = true
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    override var bounds: CGRect {
        didSet {
            self.setupCorner()
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
    
    
    /// Configura a borda para quando o botão for redondo ou não
    private func setupCorner() {
        switch self.isRounded {
        case true:
            self.layer.cornerRadius = self.bounds.height/2
            self.setupRoundedCoonstraints()
            
        case false:
            NSLayoutConstraint.deactivate(self.dynamicConstraints)
        }
    }
    
    
    /// Define as pra quando o botào for arredondado
    private func setupRoundedCoonstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        let btSize = self.getEquivalent(45)
        
        self.dynamicConstraints = [
            self.heightAnchor.constraint(equalToConstant: btSize),
            self.widthAnchor.constraint(equalToConstant: btSize),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
