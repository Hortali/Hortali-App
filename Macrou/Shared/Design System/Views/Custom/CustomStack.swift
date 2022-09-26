/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria uma stack view costumizada
class CustomStack: UIStackView {
    
    /* MARK:  Atributos */
    
    /// Deixar o valor das views igual a do stack
    public var sameDimensionValue: Dimension = .width
    
    
    
    /* MARK:  Override */
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        
        switch self.sameDimensionValue {
        case .height:
            view.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        case .width:
            view.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
    }
    
    
    
    /* MARK:  Configurações */
    
    /// Pegar o espaçamento entre os elementos
    /// - Parameter space: tamanho dos elmentos adicionados
    /// - Returns: espaço entre os elementos
    ///
    /// Essa função só faz sentido para caso os elementos que foram adicionados na
    /// stack view forem do mesmo tamanho.
    public func getEqualSpace(for space: CGFloat) -> CGFloat {
        var superViewValue: CGFloat? = nil
        
        switch self.axis {
        case .horizontal:
            superViewValue = self.superview?.bounds.width
            
        case .vertical:
            superViewValue = self.superview?.bounds.height
            
        @unknown default: break
        }
        
        if let superViewValue = superViewValue {
            let totalViewsInStack = CGFloat(self.arrangedSubviews.count)
            
            let spaceToDivide: CGFloat = superViewValue - (space * totalViewsInStack)
            
            return spaceToDivide / (totalViewsInStack + 1)
        }
        return 0
    }
}
