/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Responsável pela criação do conjunto que compõe a collection de acordo com
/// o padrão do app.
///
/// É possível definir qual dos dois estilos vai ser criado com `CollectionGroupStyle`:
/// sendo apenas a collection ou acompanhada de um título.
public class CollectionGroup: UIView, ViewCode {
    
    /* MARK: - Atributos */
    
    // Views
    
    public let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.subTitle)
        return lbl
    }()
    
    public let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.backgroundColor = UIColor(.viewBack)
        
        col.showsHorizontalScrollIndicator = false
        col.showsVerticalScrollIndicator = false
        
        return col
    }()

    private lazy var emptyView = EmptyView()
    
    
    // Outros
    
    private var style: CollectionGroupStyle = .complete
    
    var isCollectionEmpty = false {
        didSet { self.updateViewsVisibility() }
    }
    
    
    // Constraints
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    final var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Espaço de diferença que a label vai ter
    private var labelSpace: CGFloat = 0
    
    
    
    /* MARK: - Construtor */
    
    /// Inicializador podendo definir o estilo do grupo
    /// - Parameter style: estilo do grupo (padrão: .complete)
    init(style: CollectionGroupStyle = .complete, emptyViewType: EmptyTexts? = nil) {
        super.init(frame: .zero)
        
        self.setupStyle(with: style)
        self.updateViewsVisibility()
        self.createView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

    
    /* MARK: - Encapsulamento */
    
    /// Configura o espaço lateral da primeira e última célula
    /// - Parameter space: espaço que vai ser adicionado
    public func setupLateralPadding(_ space: CGFloat) {
        self.collection.contentInset = .init(top: 0, left: space, bottom: 0, right: space)
    }
    
    
    /// Configura o espaço lateral da label
    /// - Parameter space: espaço que vai ser adicionado
    public func setupTitleLabelLeftSpace(_ space: CGFloat) {
        self.labelSpace = space
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateUI()
    }
    
    
    
    /* MARK: - Protocolo */
    
    /* ViewCode */
    
    final func setupHierarchy() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.collection)
        self.addSubview(self.emptyView)
    }
    
    
    final func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    final func setupStaticConstraints() {
        var constraints = [
            self.collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        
        switch self.style {
        case .complete:
            constraints += [
                self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
                self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ]
            
        case .justCollection:
            constraints += [
                self.collection.topAnchor.constraint(equalTo: self.topAnchor)
            ]
        }
        
        self.activateConstraints(for: constraints)
    }
    
    
    final func setupDynamicConstraints() {
        self.clearConstraints()
        
        self.createDynamicConstraints()
        self.createEmptyViewConstraints()
        
        self.activateConstraints()
    }
    
    
    final func setupStaticTexts() { }
    
    final func setupUI() { }
    
    final func setupFonts() { }
    
    
    
    /* MARK: - Configurações */
    
    private func setupStyle(with style: CollectionGroupStyle) {
        self.style = style
        self.setupLayoutForSyle()
    }
    
    
    private func setupLayoutForSyle() {
        switch self.style {
        case .complete:
            self.titleLabel.isHidden = false
            
        case .justCollection:
            self.titleLabel.isHidden = true
        }
    }
    
    
    private func updateViewsVisibility() {
        self.collection.isHidden = self.isCollectionEmpty
        self.emptyView.isHidden = !self.isCollectionEmpty
    }
    
    
    private func clearConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        self.dynamicConstraints.removeAll()
    }
    
    
    private func activateConstraints(for constraints: [NSLayoutConstraint]? = nil) {
        if let constraints {
            return NSLayoutConstraint.activate(constraints)
        }
        
        guard !self.dynamicConstraints.isEmpty else { return }
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    private func createDynamicConstraints() {
        guard self.style == .complete else { return }
        
        let between: CGFloat = self.getEquivalent(12)
        let titleLabelHeight: CGFloat = self.superview?.getEquivalent(25) ?? 0
        
        self.dynamicConstraints = [
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.labelSpace),
            self.titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
            
            
            self.collection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: between),
        ]
    }
    
    
    private func createEmptyViewConstraints() {
        guard !self.emptyView.isHidden else { return }
        
        self.dynamicConstraints += [
            self.emptyView.topAnchor.constraint(equalTo: self.collection.topAnchor),
            self.emptyView.bottomAnchor.constraint(equalTo: self.collection.bottomAnchor),
            self.emptyView.leadingAnchor.constraint(equalTo: self.collection.leadingAnchor),
            self.emptyView.trailingAnchor.constraint(equalTo: self.collection.trailingAnchor),
        ]
    }
}




public class CustomCollection: UIView, ViewCode {
    
    /* MARK: - Atributos */
    
    public let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.backgroundColor = UIColor(.viewBack)
        
        col.showsHorizontalScrollIndicator = false
        col.showsVerticalScrollIndicator = false
        
        return col
    }()

    private lazy var emptyView = EmptyView()
    
    
    // Outros
    
    var isCollectionEmpty = false {
        didSet { self.updateViewsVisibility() }
    }
    
    
    // Constraints
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    final var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Espaço de diferença que a label vai ter
    private var labelSpace: CGFloat = 0
    
    
    
    /* MARK: - Construtor */
    
    /// Inicializador podendo definir o estilo do grupo
    /// - Parameter style: estilo do grupo (padrão: .complete)
    init(emptyViewType: EmptyTexts? = nil) {
        super.init(frame: .zero)
        
        self.updateViewsVisibility()
        self.createView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

    
    /* MARK: - Encapsulamento */
    
    /// Configura o espaço lateral da primeira e última célula
    /// - Parameter space: espaço que vai ser adicionado
    public func setupLateralPadding(_ space: CGFloat) {
        self.collection.contentInset = .init(top: 0, left: space, bottom: 0, right: space)
    }
    
    
    /// Configura o espaço lateral da label
    /// - Parameter space: espaço que vai ser adicionado
    public func setupTitleLabelLeftSpace(_ space: CGFloat) {
        self.labelSpace = space
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateUI()
    }
    
    
    
    /* MARK: - Protocolo */
    
    /* ViewCode */
    
    func setupHierarchy() {
        self.addSubview(self.collection)
        self.addSubview(self.emptyView)
    }
    
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setupStaticConstraints() {
        var constraints = self.collection.strechToBounds(of: self)
        constraints += self.createEmptyViewConstraints()
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func createEmptyViewConstraints() -> [NSLayoutConstraint] {
        let constraints = self.emptyView.strechToBounds(of: self.collection)
        return constraints
    }
    
    
    func setupDynamicConstraints() { }
    
    func setupStaticTexts() { }
    
    func setupUI() { }
    
    func setupFonts() { }
    
    
    
    /* MARK: - Configurações */
    
    private func updateViewsVisibility() {
        self.collection.isHidden = self.isCollectionEmpty
        self.emptyView.isHidden = !self.isCollectionEmpty
    }
}




public class CustomCollectionWithTitle: CustomCollection {
    
    /* MARK: - Atributos */
    
    // Views
    
    public let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.subTitle)
        return lbl
    }()
    
    
    /* MARK: - Protocolo */
    
    /* ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.titleLabel)
        super.setupHierarchy()
    }
    
    
    override func setupStaticConstraints() {
        var constraints = [
            self.collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        
        constraints += self.createEmptyViewConstraints()
        NSLayoutConstraint.activate(constraints)
    }
}
