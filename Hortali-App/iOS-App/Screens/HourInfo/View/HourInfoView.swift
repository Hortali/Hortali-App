/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class HourInfoView: ViewWithViewCode {
    
    /* MARK: - Atributos */
    
    final let hourInfoCollection: CustomCollection = {
        let col = CustomCollection()
        col.collection.backgroundColor = UIColor(originalColor: .greenLight)
        return col
    }()
    
    final let titleLabel: CustomLabel = {
        let lbl = CustomViews.newLabel()
        lbl.isCircular = false
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(originalColor: .greenDark)
        return lbl
    }()
    
    private let homeIndicatorView: UIView = {
        let view = CustomViews.newView()
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor(originalColor: .white)
        return view
    }()
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.homeIndicatorView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.hourInfoCollection)
    }
    
    
    override func setupView() {
        super.setupView()
        self.backgroundColor = UIColor(originalColor: .greenLight)
        self.backgroundColor = UIColor(originalColor: .greenLight)
    }
    
    
    override func setupStaticTexts() {
        self.titleLabel.text = "Horário de funcionamento"
    }
    
    
    override func setupFonts() {
        self.titleLabel.setupFont(with: FontInfo(
            fontSize: self.getEquivalent(35), weight: .bold
        ))
    }
    
    
    override func setupUI() {
        self.setCollectionItemSize()
    }
    
    
    private func setCollectionItemSize() {
        guard self.hourInfoCollection.hasSuperview else { return }
        self.hourInfoCollection.spaceBetweenCells = self.getEquivalent(10)
        self.hourInfoCollection.cellSize = CGSize(width: self.hourInfoCollection.frame.width, height: 60)
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let barHeight: CGFloat = 5
        
        let constraints = [
            self.homeIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.homeIndicatorView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            self.homeIndicatorView.heightAnchor.constraint(equalToConstant: barHeight),
            
            self.hourInfoCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let lateral = self.getEquivalent(15)
        let space = self.getEquivalent(10)
        
        self.dynamicConstraints = [
            self.homeIndicatorView.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: self.homeIndicatorView.bottomAnchor, constant: space),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            
            
            self.hourInfoCollection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: lateral),
            self.hourInfoCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.hourInfoCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
        ]
    }
}
