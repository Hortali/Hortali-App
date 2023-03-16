/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver os favoritos
class FavoriteView: MainView {
    
    /* MARK: - Atributos */
    
    final let foodCollection: CustomCollectionWithTitle = {
        let col = CustomCollectionWithTitle(emptyViewType: .food)
        col.scrollDirection = .horizontal
        return col
    }()

    
    final let gardenCollection: CustomCollectionWithTitle = {
        let col = CustomCollectionWithTitle(emptyViewType: .garden)
        col.scrollDirection = .horizontal
        return col
    }()
    
    
    private let emptyView = EmptyView(emptyViewType: .favorite)
    
    
    
    /* MARK: - Encapsulamento */
    
    // Empty View
    
    public func checkGardenData(with gardenDataCount: Int) {
        self.gardenCollection.collectionHasData = gardenDataCount == 0
    }
    
    
    public func checkFoodData(with foodDataCount: Int) {
        self.foodCollection.collectionHasData = foodDataCount == 0
    }
    
    
    public func setCollectionView(with value: Bool) {
        self.foodCollection.isHidden = value
        self.gardenCollection.isHidden = value
        self.emptyView.isHidden = !value
    }
    
    
    // Collection
    
    public func reloadCollectionsData() {
        self.foodCollection.reloadCollectionData()
        self.gardenCollection.reloadCollectionData()
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        super.setupHierarchy()
        self.contentView.addSubview(self.foodCollection)
        self.contentView.addSubview(self.gardenCollection)
        self.contentView.addSubview(self.emptyView)
    }
    
    
    override func setupView() {
        self.backgroundColor = UIColor(.favoriteBack)
    }
    
    
    override func setupUI() {
        self.setFoodCollectionItemSize()
        self.setGardenCollectionItemSize()
    }

    
    private func setGardenCollectionItemSize() {
        let collection = self.gardenCollection.collection
        guard collection.bounds.width != 0 else { return }
        
        let minimumSpace = self.getEquivalent(10)
        self.gardenCollection.spaceBetweenCells = minimumSpace
        
        let screenReferenceSize = SizeInfo(screenSize: CGSize(width: 240, height: 400), dimension: .height)
        self.gardenCollection.cellSize = CGSize(
            width: collection.getEquivalent(240, screenReference: screenReferenceSize),
            height: collection.bounds.height
        )
    }
    
    
    private func setFoodCollectionItemSize() {
        let collection = self.foodCollection.collection
        guard collection.bounds.width != 0 else { return }
        
        let minimumSpace = self.getEquivalent(10)
        self.foodCollection.spaceBetweenCells = minimumSpace
        
        let cellReferenceSize = SizeInfo(screenSize: CGSize(width: 170, height: 192), dimension: .height)
        self.foodCollection.cellSize = CGSize(
            width: collection.getEquivalent(170, screenReference: cellReferenceSize),
            height: collection.bounds.height
        )
    }
    
    
    override func setupStaticTexts() {
        self.setTitleText(with: "Favoritos da sua \nmesa")
        self.foodCollection.titleLabel.text = "Alimentos"
        self.gardenCollection.titleLabel.text = "Hortas"
    }
    
    
    override func setupFonts() {
        let subTitleSize: CGFloat = self.getEquivalent(25, dimension: .height)
        let font = FontInfo(fontSize: subTitleSize, weight: .medium)
        
        self.foodCollection.titleLabel.setupText(with: font)
        self.gardenCollection.titleLabel.setupText(with: font)
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let emptyView = self.emptyView.strechToBounds(of: self.contentView)
        var constrains = [
            self.foodCollection.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.foodCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.foodCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        
            
            self.gardenCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.gardenCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        constrains += emptyView
        return constrains
    }
    
    
    override func createDynamicConstraints() {
        self.setDynamicConstraints()
        self.setCollectionsPadding()
        self.setCollectionsTitleLabelPadding()
    }
    
    
    private func setDynamicConstraints() {
        let bottom: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(28, dimension: .height)
        let foodCollectionHeight = self.getEquivalent(187, dimension: .height)   // 150+12+25
        
        self.dynamicConstraints = [
            self.gardenCollection.topAnchor.constraint(equalTo: self.foodCollection.bottomAnchor, constant: between),
            self.gardenCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -bottom),
            
            
            self.foodCollection.heightAnchor.constraint(equalToConstant: foodCollectionHeight),
        ]
    }
    
    
    private func setCollectionsPadding() {
        let padding: CGFloat = self.getEquivalent(15)
        self.foodCollection.setupLateralPadding(padding)
        self.gardenCollection.setupLateralPadding(padding)
    }
    
    
    private func setCollectionsTitleLabelPadding() {
        let padding: CGFloat = self.getEquivalent(15)
        self.foodCollection.setupTitleLabelLeftSpace(padding)
        self.gardenCollection.setupTitleLabelLeftSpace(padding)
    }
}
