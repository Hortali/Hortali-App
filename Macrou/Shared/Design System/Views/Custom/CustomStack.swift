/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class CustomStack: UIStackView {
    
    /* MARK:  Atributos */
    
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
    
    public func getEqualSpace(for space: CGFloat) -> CGFloat {
        var equalSpace: CGFloat = 0
        if let totalHeight = self.superview?.bounds.height {
            let totalViewsInStack = CGFloat(self.arrangedSubviews.count)
            
            let spaceToDivide: CGFloat = space * totalViewsInStack - totalHeight
            
            equalSpace = spaceToDivide / (totalViewsInStack+1)
        }
        
        self.spacing = equalSpace
        return equalSpace
    }
}
