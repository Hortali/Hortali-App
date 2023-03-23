/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria uma stack view costumizada
class CustomStack: UIStackView {
    
    /* MARK:  Atributos */
    
    /// Deixar o valor das views igual a do stack
    public var sameDimensionValue: Dimension?
    
    
    
    /* MARK:  Override */
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        
        switch self.sameDimensionValue {
        case .height:
            view.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        case .width:
            view.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        default:
            break
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
        let spaceAvaiable = self.getSpaceAvaiableOnSuperview()
        guard let spaceAvaiable else { return 0 }
        
        let equalSpace = self.calculateEqualSpace(spaceAvaiable: spaceAvaiable, spaceUsed: space)
        return equalSpace
    }
    
    
    private func getSpaceAvaiableOnSuperview() -> CGFloat? {
        switch self.axis {
        case .horizontal:
            return self.superview?.bounds.width
            
        case .vertical:
            return self.superview?.bounds.height
            
        @unknown default:
            return nil
        }
    }
    
    
    private func calculateEqualSpace(spaceAvaiable: CGFloat, spaceUsed: CGFloat) -> CGFloat {
        let viewsInStack = CGFloat(self.arrangedSubviews.count)
        let spaceToDivide: CGFloat = spaceAvaiable - (spaceUsed * viewsInStack)
        let equalSpace = spaceToDivide / (viewsInStack + 1)
        return equalSpace
    }
    
}
