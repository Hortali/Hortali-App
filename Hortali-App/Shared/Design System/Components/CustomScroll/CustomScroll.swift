/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria uma scroll view e já configura ela de acordo com o tamanho que vai ser definido pra ela
class CustomScroll: ViewCode {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Scrool view padrão do UIKit
    public let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(.viewBack)
        return scroll
    }()
    
    /// Espaço para colocar os elementos na scroll
    public let contentView = CustomViews.newView()
    
    
    // Outros
    
    /// Tamanho da scrollView
    private var scrollContentSize = CGSize() {
        didSet { self.setupScrollSize() }
    }
    
    /// Último componente adicionado na scroll
    private var lastViewAdded: UIView?
    
    
    /* MARK: - Encapsulamento */
    
    /// Adiciona uma view na scroll
    /// - Parameter view: view que vai ser adicionada
    public func addViewInScroll(_ view: UIView) {
        self.contentView.addSubview(view)
        self.lastViewAdded = view
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setupScrollSize()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura o tamanho da scroll e a contentView dela
    private func setupScrollSize() {
        self.scroll.frame = self.bounds
        self.contentView.frame.size = self.scrollContentSize
        
        self.scroll.contentSize = self.scrollContentSize
        self.scroll.contentSize.width = 0
    }
    
    
    /// Atualiza o tamanho da scroll a partir da posição do último elemento adicionado
    public func updateScrollSize() {
        guard !self.lastViewAdded.isNil, !self.superview.isNil else { return }
        
        self.removeAdditionalSpace()
        self.setupNewScrollSize()
    }
    
    
    /// Remove espaço adicional dependendo da altura
    private func removeAdditionalSpace() {
        var height = lastViewAdded!.frame.origin.y + lastViewAdded!.frame.height
        
        if height > self.frame.height {
            let removeSpace = self.superview!.safeAreaInsets.bottom
            
            if (height - removeSpace) > self.superview!.bounds.height {
                height -= removeSpace
            }
        }
    }
    
    
    /// Determina a nova altura da scroll
    private func setupNewScrollSize() {
        let height = lastViewAdded!.frame.origin.y + lastViewAdded!.frame.height
        
        guard height != self.frame.height else { return }
        self.scrollContentSize = CGSize(
            width: self.superview!.bounds.width,
            height: height
        )
    }
    
    
    
    /* MARK: - Protocol */
    
    /* View Code */
    
    override func setupHierarchy() {
        self.addSubview(self.scroll)
        self.scroll.addSubview(self.contentView)
    }
    
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.scroll.topAnchor.constraint(equalTo: self.topAnchor),
            self.scroll.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scroll.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scroll.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scroll.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.contentView.leftAnchor.constraint(equalTo: self.scroll.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.scroll.rightAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scroll.widthAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let safeAreaTop = self.scroll.safeAreaInsets.top
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.contentView.topAnchor.constraint(equalTo: self.scroll.topAnchor, constant: -safeAreaTop),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
