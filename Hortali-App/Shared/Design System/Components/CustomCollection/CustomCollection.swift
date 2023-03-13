/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class CustomCollection: ViewCode {
    
    /* MARK: - Atributos */
    
    private lazy var emptyView = EmptyView()
    
    public let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.backgroundColor = UIColor(.viewBack)
        
        col.showsHorizontalScrollIndicator = false
        col.showsVerticalScrollIndicator = false
        
        return col
    }()

    
    // Constraints
    
    /// Espaço de diferença que a label vai ter
    final var labelSpace: CGFloat = 0
    
    
    // Outros
    
    public var collectionHasData = false {
        didSet { self.updateViewsVisibility() }
    }
    
    
    
    /* MARK: - Construtor */
    
    init(emptyViewType: EmptyTexts? = nil) {
        super.init()
        
        self.setupEmptyView(with: emptyViewType)
        self.updateViewsVisibility()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupLateralPadding(_ space: CGFloat) {
        self.collection.contentInset = .init(top: 0, left: space, bottom: 0, right: space)
    }
    
    
    public func setupTitleLabelLeftSpace(_ space: CGFloat) {
        self.labelSpace = space
    }
    
    
    
    /* MARK: - Protocolo */
    
    /* ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.collection)
        self.addSubview(self.emptyView)
    }
    
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        var constraints = self.collection.strechToBounds(of: self)
        constraints += self.createEmptyViewConstraints()
        return constraints
    }
    
    
    
    /* MARK: - Configurações */
    
    public func createEmptyViewConstraints() -> [NSLayoutConstraint] {
        let constraints = self.emptyView.strechToBounds(of: self.collection)
        return constraints
    }
    
    
    private func setupEmptyView(with type: EmptyTexts?) {
        self.emptyView.emptyViewText = type
    }
    
    
    private func updateViewsVisibility() {
        self.collection.isHidden = self.collectionHasData
        self.emptyView.isHidden = !self.collectionHasData
    }
}
