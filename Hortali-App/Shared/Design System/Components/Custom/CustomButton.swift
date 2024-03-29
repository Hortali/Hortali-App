/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Botão costumizado podendo deixar redondo (por padrão é redondo)
class CustomButton: UIButton {
    
    /* MARK: - Atributos */
    
    /// Estado de quando o botão é circular ou não. (Padrão: true)
    internal var isCircular = true {
        didSet { self.setupCorner() }
    }
    
    /// Tamanho do botão quando for circular (Padrão: 45)
    internal var circleSize: CGFloat = 45 {
        didSet { self.setupCorner() }
    }
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    override var bounds: CGRect {
        didSet { }//self.setupCorner() }
    }
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupButton()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

    
    /* MARK: - Configurações */
    
    /// Faz as configurações iniciais de um botão
    private func setupButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        
        self.backgroundColor = UIColor(.backgroundButton)?.withAlphaComponent(0.85)
    }
    
    
    /// Configura a borda para quando o botão for redondo (ou não)
    private func setupCorner() {
        switch self.isCircular {
        case true:
            self.layer.cornerRadius = self.bounds.height / 2
            self.setupRoundedConstraints()
            
        case false:
            NSLayoutConstraint.deactivate(self.dynamicConstraints)
            self.dynamicConstraints.removeAll()
        }
    }
    
    
    /// Define as contraints de altura e largura pra quando o botão for arredondado
    private func setupRoundedConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        self.dynamicConstraints.removeAll()
        
        self.dynamicConstraints = [
            self.heightAnchor.constraint(equalToConstant: self.circleSize),
            self.widthAnchor.constraint(equalToConstant: self.circleSize),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
