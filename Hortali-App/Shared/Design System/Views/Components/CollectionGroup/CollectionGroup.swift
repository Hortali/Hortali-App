/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Responsável pela criação do conjunto que compõe a collection de acordo com
/// o padrão do app.
///
/// É possível definir qual dos dois estilos vai ser criado com `CollectionGroupStyle`:
/// sendo apenas a collection ou acompanhada de um título.
public class CollectionGroup: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Título da collection
    public let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.subTitle)
        return lbl
    }()
    
    /// Collection (relacionada ao título)
    public let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.backgroundColor = UIColor(.viewBack)
        
        col.showsHorizontalScrollIndicator = false
        col.showsVerticalScrollIndicator = false
        
        return col
    }()

    /// Instancia da classe de empty view
    private var emptyView: EmptyView
    
    
    // Outros
    
    /// Estilo do grupo de acordo com o `CollectionGroupStyle`.
    private var style: CollectionGroupStyle = .complete {
        didSet {
            switch self.style {
            case .complete:
                self.titleLabel.isHidden = false
                
            case .justCollection:
                self.titleLabel.isHidden = true
            }
        }
    }
        
    
    // Constraints
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Espaço de diferença que a label vai ter
    private var labelSpace: CGFloat = 0
    
    
    
    /* MARK: - Construtor */
    
    /// Inicializador podendo definir o estilo do grupo
    /// - Parameter style: estilo do grupo (padrão: .complete)
    init(style: CollectionGroupStyle = .complete, emptyViewType: EmptyTexts? = nil) {
        self.emptyView = EmptyView(emptyViewType: emptyViewType ?? .search)
        
        super.init(frame: .zero)
        
        self.style = style
        self.checkData()
        
        self.setupViews()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura o espaço lateral da primeira e última célula
    /// - Parameter space: espaço que vai ser adicionado
    public func setPadding(for space: CGFloat) {
        self.collection.contentInset = .init(top: 0, left: space, bottom: 0, right: space)
    }
    
    
    /// Configura o espaço lateral da label
    /// - Parameter space: espaço que vai ser adicionado
    public func setLabelSpace(for space: CGFloat) {
        self.labelSpace = space
    }
    
    
    /// Apresenta a empty view nas collections vazias
    public func isCollectionEmpty(with value: Bool) {
        self.collection.isHidden = value
        self.emptyView.isHidden = !value
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Verifica a existencia de dados na collection
    private func checkData() {
        self.isCollectionEmpty(with: false)
    }
    
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.collection)
        self.addSubview(self.emptyView)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let between: CGFloat = self.getEquivalent(12)
        let titleLabelHeight: CGFloat = self.superview?.getEquivalent(25) ?? 0
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        switch self.style {
        case .complete:
            self.dynamicConstraints = [
                self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
                self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.labelSpace),
                self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
                
                
                self.collection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: between),
                self.collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                self.collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ]
            
        case .justCollection:
            self.dynamicConstraints = [
                self.collection.topAnchor.constraint(equalTo: self.topAnchor),
                self.collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                self.collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ]
        }
        
        self.dynamicConstraints += [
            self.emptyView.topAnchor.constraint(equalTo: self.collection.topAnchor),
            self.emptyView.bottomAnchor.constraint(equalTo: self.collection.bottomAnchor),
            self.emptyView.leadingAnchor.constraint(equalTo: self.collection.leadingAnchor),
            self.emptyView.trailingAnchor.constraint(equalTo: self.collection.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
