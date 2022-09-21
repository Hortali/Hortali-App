/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria uma stack view costumizada
class CustomStack: UIStackView {
    
    /* MARK:  Atributos */
    
    /// Deixar os elementos com a mesma largura
    public var isSameWidth: Bool = true {
        didSet {
            self.arrangedSubviews.forEach { element in
                element.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = self.isSameWidth
            }
        }
    }
    
    
    
    /* MARK:  Override */
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        
        view.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = self.isSameWidth
    }
    
    
    
    /* MARK:  Configurações */
    
    /// Pegar o espaçamento entre os elementos
    /// - Parameter space: tamanho dos elmentos adicionados
    /// - Returns: espaço entre os elementos
    ///
    /// Essa função só faz sentido para caso os elementos que foram adicionados na
    /// stack view forem do mesmo tamanho.
    public func getEqualSpace(for space: CGFloat) -> CGFloat {
        var equalSpace: CGFloat = 0
        if let totalHeight = self.superview?.bounds.height {
            let totalViewsInStack = CGFloat(self.arrangedSubviews.count)
            
            let spaceToDivide: CGFloat = space * totalViewsInStack - totalHeight
            
            equalSpace = spaceToDivide / (totalViewsInStack + 1)
        }
        
        self.spacing = equalSpace
        return equalSpace
    }
}
