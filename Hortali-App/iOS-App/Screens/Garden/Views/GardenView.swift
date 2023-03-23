/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class GardenView: MainView {
    
    /* MARK: - Atributos */
    
    // Views
    
    private let search = CustomViews.newSearch()
    
    final let gardenCollection = CustomCollection(emptyViewType: .garden)
    
    final let tagCollection = CustomCollection()
    
    private let visualizationButton: CustomButton = {
        let btn = CustomViews.newButton()
        btn.tintColor = UIColor(.visualizationButton)
        btn.backgroundColor = .clear
        
        return btn
    }()
    
    
    /* MARK: - Encapsulamento */
    
    public func checkData(with dataCount: Int) {
        self.gardenCollection.collectionHasData = dataCount == 0
    }
    
    
    // Search
    
    public func setSearchDelegate(with delegate: SearchDelegate) {
        self.search.delegate = delegate
    }
    
    
    // Collection
    
    public func reloadCollectionData() {
        self.gardenCollection.reloadCollectionData()
    }
    
    
    public func reloadTagData() {
        self.tagCollection.reloadCollectionData()
    }
    
    
    public func deselectTag(at indexPath: IndexPath) {
        self.tagCollection.collection.deselectItem(at: indexPath, animated: true)
    }
    
    
    /* Ações de botões */
    
    public func setVisualizationButtonAction(target: Any?, action: Selector) -> Void {
        self.visualizationButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        super.setupHierarchy()
        self.addSubview(self.search)
        self.addSubview(self.visualizationButton)
        self.addSubview(self.tagCollection)
        self.contentView.addSubview(self.gardenCollection)
    }
    
    
    override func setupView() {
        self.backgroundColor = UIColor(.gardenBack)
    }
    
    
    override func setupUI() {
        self.setColllectionCellSize()
    }
    
    
    private func setColllectionCellSize() {
        self.gardenCollection.cellSize = CGSize(
            width: self.getEquivalent(175, dimension: .height),
            height: self.getEquivalent(295, dimension: .height)
        )
    }
    
    
    override func setupStaticTexts() {
        self.setTitleText(with: "Descubra novas \nhortas")
    }
    
    
    override func setupFonts() {
        super.setupFonts()
        self.setInfoButtonIcon()
    }
    
    
    private func setInfoButtonIcon() {
        self.visualizationButton.setupIcon(with: IconInfo(
            icon: .moreInfos, size: self.getEquivalent(25), weight: .medium, scale: .default
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.search.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.search.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.search.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.tagCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tagCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.visualizationButton.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        self.setCollectionLateralPadding()
        self.setDynamicConstraints()
    }
    
    
    private func setCollectionLateralPadding() {
        let padding = self.getEquivalent(15)
        self.tagCollection.setupLateralPadding(padding)
    }
    
    
    private func setDynamicConstraints() {
        let lateral = self.getEquivalent(15)
        let between = self.getEquivalent(5)
        
        let tagCollectionHeight = self.getEquivalent(25)
        
        self.dynamicConstraints = [
            self.gardenCollection.topAnchor.constraint(equalTo: self.tagCollection.bottomAnchor, constant: lateral),
            self.gardenCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.gardenCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            self.gardenCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            self.visualizationButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            self.tagCollection.topAnchor.constraint(equalTo: self.search.bottomAnchor, constant: between),
            self.tagCollection.heightAnchor.constraint(equalToConstant: tagCollectionHeight)
        ]
    }
}
