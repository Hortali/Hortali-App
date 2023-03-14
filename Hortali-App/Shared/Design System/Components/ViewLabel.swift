/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Uma view que possui uma label dentro
///
/// Esse componente é usado principalemente pra cliar uma label que não fique grudada na borda dela
class ViewLabel: ViewCode {
    
    /* MARK: - Atributos */

    public lazy var label: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.label)
    }
    
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let space: CGFloat = 5
        
        let constraints = [
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space)
        ]
        return constraints
    }
}
