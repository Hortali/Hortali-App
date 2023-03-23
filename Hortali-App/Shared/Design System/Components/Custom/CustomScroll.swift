/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria uma scroll view e já configura ela de acordo com o tamanho que vai ser definido pra ela
class CustomScroll: ViewWithViewCode {
    
    /* MARK: - Atributos */
        
    public let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(.viewBack)
        return scroll
    }()
    
    /// Espaço para colocar os elementos na scroll
    public let contentView = CustomViews.newView()
    
    
    // Outros
    
    private var scrollContentSize = CGSize() {
        didSet { self.setupScrollSize() }
    }
    
    private var lastViewAdded: UIView?
    
    
    
    /* MARK: - Encapsulamento */
    
    public func addViewInScroll(_ view: UIView) {
        self.contentView.addSubview(view)
        self.lastViewAdded = view
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupScrollSize() {
        self.scroll.frame = self.bounds
        self.contentView.frame.size = self.scrollContentSize
        
        self.scroll.contentSize = self.scrollContentSize
        self.scroll.contentSize.width = 0
    }
    
    
    final func updateScrollSize() {
        guard !self.lastViewAdded.isNil, !self.superview.isNil else { return }
        
        let space = self.removeAdditionalSpace()
        self.setupNewScrollSize(space)
    }
    
    
    private func removeAdditionalSpace() -> CGFloat {
        var height = lastViewAdded!.frame.origin.y + lastViewAdded!.frame.height
        
        guard height > self.frame.height else { return height }
        
        let removeSpace = self.superview!.safeAreaInsets.bottom
        
        if (height - removeSpace) > self.superview!.bounds.height {
            height -= removeSpace
        }
        return height
    }
    
    
    private func setupNewScrollSize(_ space: CGFloat) {
        let height = space
        
        guard height != self.frame.height else { return }
        self.scrollContentSize = CGSize(
            width: self.superview!.bounds.width,
            height: height
        )
    }
    
    
    
    /* MARK: - View Code */
    
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
                
        self.dynamicConstraints = [
            self.contentView.topAnchor.constraint(equalTo: self.scroll.topAnchor, constant: -safeAreaTop),
        ]
    }
}
