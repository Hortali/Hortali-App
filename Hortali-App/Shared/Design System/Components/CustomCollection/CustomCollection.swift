/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class CustomCollection: ViewWithViewCode, CustomCollectionProtocol, CollectionFlowLayoutAttributes {
    
    /* MARK: - Atributos */
    
    // Views
    
    private lazy var emptyView = EmptyView()
    
    public var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.backgroundColor = UIColor(.viewBack)
        
        col.showsHorizontalScrollIndicator = false
        col.showsVerticalScrollIndicator = false
        
        return col
    }()
    

    // FlowLayout
    
    final var flowLayout = UICollectionViewFlowLayout()
    
    public var cellSize = CGSize() {
        didSet { self.updateCellSize() }
    }
    
    /// Padrão: .zero
    public var spaceBetweenCells: CGFloat = .zero {
        didSet { self.updateSpaceBetweenCells() }
    }
    
    /// Padrão: horizontal
    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal {
        didSet { self.updateScrollDirection() }
    }
    
    
    // Constraints
    
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
        self.setupCollectionFlowLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupLateralPadding(_ space: CGFloat) {
        self.collection.contentInset = .init(top: 0, left: space, bottom: 0, right: space)
    }
    
    
    public func setupTitleLabelLeftSpace(_ space: CGFloat) {
        self.labelSpace = space
    }
    
    
    
    /* MARK: - Configurações */
    
    private func updateCellSize() {
        self.flowLayout.itemSize = self.cellSize
    }
    
    
    private func updateSpaceBetweenCells() {
        self.flowLayout.minimumInteritemSpacing = self.spaceBetweenCells
    }
    
    
    private func updateScrollDirection() {
        self.flowLayout.scrollDirection = self.scrollDirection
    }
    
    
    
    /* MARK: - ViewCode */
    
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
    
    
    public func createEmptyViewConstraints() -> [NSLayoutConstraint] {
        return self.emptyView.strechToBounds(of: self.collection)
    }
    
    
    private func setupEmptyView(with type: EmptyTexts?) {
        self.emptyView.emptyViewText = type
    }
    
    
    private func updateViewsVisibility() {
        self.collection.isHidden = self.collectionHasData
        self.emptyView.isHidden = !self.collectionHasData
    }
}
