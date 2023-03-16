/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Componentes das telas iniciais
class MainView: ViewWithViewCode {
    
    /* MARK: - Atributos */
    
    private let container = ContainerView()
    
    public var contentView: UIView
        
    

    /* MARK: - Construtor */
    
    override init() {
        self.contentView = self.container.contentView
        
        super.init()
        self.setupMainViewConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setTitleText(with text: String) {
        self.container.setTitleText(with: text)
    }
    
    
    public var titleLabel: UILabel {
        return self.container.titleLabel
    }

     
        
    /* MARK: - ViewCode */

    override func setupHierarchy() {
        self.addSubview(self.container)
    }
    

    private func setupMainViewConstraints() {
        let constraints = self.createMainViewConstraints()
        self.activateConstraints(for: constraints)
    }
    
    
    private func createMainViewConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.container.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.container.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        return constraints
    }
}
