/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class HourInfoView: ContainerView {
    
    /* MARK: - Atributos */
    
    final let hourInfoCollection: CustomCollection = {
        let col = CustomCollection()
        col.collection.backgroundColor = UIColor(originalColor: .greenLight)
        return col
    }()
    
    private let homeIndicatorView: UIView = {
        let view = CustomViews.newView()
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor(originalColor: .white)
        return view
    }()
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        super.setupHierarchy()
        self.contentView.addSubview(self.hourInfoCollection)
        self.contentView.addSubview(self.homeIndicatorView)
    }
    
    
    override func setupView() {
        super.setupView()
        self.backgroundColor = UIColor(originalColor: .greenLight)
        self.contentView.backgroundColor = UIColor(originalColor: .greenLight)
    }
    
    
    override func setupStaticTexts() {
        super.setupStaticTexts()
        self.setTitleText(with: "Horário de funcionamento")
        self.titleLabel.textColor = UIColor(originalColor: .greenDark)
    }
    
    
    override func setupUI() {
        super.setupUI()
        self.setCollectionItemSize()
    }
    
    
    private func setCollectionItemSize() {
        guard self.hourInfoCollection.hasSuperview else { return }
        self.hourInfoCollection.spaceBetweenCells = self.getEquivalent(10)
        self.hourInfoCollection.cellSize = CGSize(width: self.hourInfoCollection.frame.width, height: 60)
    }
    
    
    override func createDynamicConstraints() {
        super.createDynamicConstraints()
        
        let lateral = self.getEquivalent(15)
        let width = self.getEquivalent(70)
        let space = self.getEquivalent(10)
        
        let barHeight = self.getEquivalent(5)
        
        self.dynamicConstraints += [
            self.hourInfoCollection.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: lateral),
            self.hourInfoCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.hourInfoCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.hourInfoCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
            self.homeIndicatorView.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            self.homeIndicatorView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.homeIndicatorView.heightAnchor.constraint(equalToConstant: barHeight),
            self.homeIndicatorView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3)
        ]
    }
}
