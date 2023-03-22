/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class InfoGardenInfosCell: CollectionCellWithViewCode {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdInfoGardenCell"
    
    
    // Views
    
    private let titleLabel = CustomViews.newLabel()
    
    private let customContentView: UIView = {
        let view = CustomViews.newView()
        view.layer.masksToBounds = true
        return view
    }()
    
    private var cellView = UIView()
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupCell(for cellType: InfoGardenCellType, with data: ManagedGarden) {
        let view = cellType.view
        
        self.setupView(view, with: data)
        self.setCellTitle(cellType.title)
        self.reCreateCellView(with: view)
        self.setupDynamicConstraints()
    }
    
    
    private func setCellTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    
    private func setupView(_ view: UIView, with data: ManagedGarden) {
        guard let viewProtocol = view as? InfoGardenCellProtocol else { return }
        viewProtocol.setupView(for: data)
    }
    
    
    private func reCreateCellView(with view: UIView) {
        self.clearDynamicConstraints()
        self.cellView.removeFromSuperview()
        
        self.cellView = view
        self.customContentView.addSubview(self.cellView)
    }
    
    
    
    /* MARK: - Configurações */

    override func setupHierarchy() {
        self.addViewInContent(self.titleLabel)
        self.addViewInContent(self.customContentView)
        self.customContentView.addSubview(self.cellView)
    }
    
    
    override func setupUI() {
        self.customContentView.layer.cornerRadius = self.getConstant(for: 15)
    }
    
    
    override func setupFonts() {
        self.titleLabel.setupFont(with: FontInfo(
            fontSize: self.getConstant(for: 22), weight: .medium
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            self.customContentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.customContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.customContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let squareSize = self.bounds.width
        
        self.dynamicConstraints = [
            self.customContentView.heightAnchor.constraint(equalToConstant: squareSize),
        ]
        let cellViewConstraints = self.cellView.strechToBounds(of: self.customContentView)
        self.dynamicConstraints += cellViewConstraints
    }
    
    
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 163, height: 200),
            dimension: .width
        )
        
        return self.getEquivalent(space, screenReference: screenReference)
    }
}
