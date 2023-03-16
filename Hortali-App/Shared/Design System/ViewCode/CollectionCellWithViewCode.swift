/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class CollectionCellWithViewCode: UICollectionViewCell, ViewCode {
    
    /* MARK: - Atributos */
    
    var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadView()
    }
    
    
    
    /* MARK: - Configurações */
    
    final func addViewInContent(_ view: UIView) {
        self.contentView.addSubview(view)
    }
    
    
    
    /* MARK: - ViewCode */
    
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
