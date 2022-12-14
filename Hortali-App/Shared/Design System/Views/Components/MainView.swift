/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Componentes de toda tela inicial.
 class MainView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Tela de acordo com o padrão da tela
    private let container = ContainerView()
    
    /// Espaço para colocar os componentes da tela
    public var contentView: UIView
        
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraintsMain: [NSLayoutConstraint] = []
        
    

    /* MARK: - Construtor */
    
    init() {
        self.contentView = self.container.contentView
        super.init(frame: .zero)
        
        self.setupViewsMain()
    }
    
     required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define o título da tela
    /// - Parameter text: título da tela
    public func setTitleText(with text: String) {
        self.container.setTitleText(with: text)
    }
    
    /// Label de título
    public var titleLabel: UILabel {
        return self.container.titleLabel
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
          
        self.setupDynamicConstraintsMain()
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViewsMain() {
        self.addSubview(self.container)
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraintsMain() {
        NSLayoutConstraint.deactivate(self.dynamicConstraintsMain)
    
        self.dynamicConstraintsMain = [
            self.container.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.container.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraintsMain)
    }
}
