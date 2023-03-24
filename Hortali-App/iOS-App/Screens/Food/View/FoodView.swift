/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// UI da tela de ver todas os alimentos
class FoodView: MainView {
    
    /* MARK: - Atributos */
    
    private let foodSegmented: UISegmentedControl = {
        let itensSeg = DataManager.shared.getAllCategories()
        let seg = CustomViews.newSegmentation(with: itensSeg)
        seg.selectedSegmentIndex = 0
        
        return seg
    }()
    
    final let foodCollection = CustomCollection()

    
    
    /* MARK: - Encapsulamento */

    public func resetCollectionScroll() {
        self.foodCollection.resetCollectionScroll()
    }

    
    /* Ações de botões */

    public func setSegAction(target: Any?, action: Selector) -> Void {
        self.foodSegmented.addTarget(target, action: action, for: .valueChanged)
    }

    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        super.setupHierarchy()
        self.addSubview(self.foodSegmented)
        self.addSubview(self.foodCollection)
    }
    
    
    override func setupView() {
        self.backgroundColor = UIColor(.foodBack)
    }
    
    
    override func setupUI() {
        self.setFoodCollectionItemSize()
    }
    
    
    private func setFoodCollectionItemSize() {
        self.foodCollection.cellSize = CGSize(
            width: self.getEquivalent(170),
            height: self.getEquivalent(192)
        )
    }
    
    
    override func setupStaticTexts() {
        self.setTitleText(with: "Hora da sua\ncolheita")
    }
      
    
    override func createDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(20)
            
        self.dynamicConstraints = [
            self.foodSegmented.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: lateral),
            self.foodSegmented.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.foodSegmented.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            
            
            self.foodCollection.topAnchor.constraint(equalTo: self.foodSegmented.bottomAnchor, constant: between),
            self.foodCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.foodCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.foodCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
    }
}
