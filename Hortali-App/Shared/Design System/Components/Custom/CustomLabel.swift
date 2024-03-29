/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Botão costumizado podendo deixar redondo (por padrão é redondo)
class CustomLabel: UILabel {
    
    /* MARK: - Atributos */
    
    /// Estado de quando a label é circular ou não. (Padrão: true)
    internal var isCircular = false {
        didSet { self.setupCorner() }
    }
    
    /// Tamanho da label quando for circular (Padrão: 35)
    internal var circleSize: CGFloat = 35 {
        didSet { self.setupCorner() }
    }
    
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    override var bounds: CGRect {
        didSet { self.setupCorner() }
    }
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLabel()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

    
    /* MARK: - Configurações */
    
    /// Faz as configurações iniciais de um botão
    private func setupLabel() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
    }
    
    
    /// Configura a borda para quando o botão for redondo (ou não)
    private func setupCorner() {
        if isCircular {
            self.setupRoundedConstraints()
            self.setupRoundedCorner()
        } else {
            self.removeRoundedConstraints()
        }
    }
    
    
    /// Define as contraints de altura e largura pra quando o botão for arredondado
    private func setupRoundedConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.heightAnchor.constraint(equalToConstant: self.circleSize),
            self.widthAnchor.constraint(equalToConstant: self.circleSize),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    private func setupRoundedCorner() {
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    
    private func removeRoundedConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    }
}
