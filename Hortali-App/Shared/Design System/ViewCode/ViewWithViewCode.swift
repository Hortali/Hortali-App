/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Classe genérica para ser usada como herança nas Views
class ViewWithViewCode: UIView, ViewCode {
    
    /* MARK: - Atributos */
    
    var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.createView()
    }
    
    required init?(coder: NSCoder)  { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadView()
    }
    
    
    
    /* MARK: - Protocolo */
    
    /* ViewCodeProtocol */
    
    func setupHierarchy() { }
    
    func setupView() { }
    
    func setupStaticTexts() { }
    
    func setupUI() { }
    
    func setupFonts() { }
    
    func createStaticConstraints() -> [NSLayoutConstraint] {
        return []
    }
    
    func createDynamicConstraints() { }
    
    func clearDynamicConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        self.dynamicConstraints.removeAll()
    }
}
