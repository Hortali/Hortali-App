/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Componentes de UI da tela que mostra os hor;arios de funcionamento
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
    
    
    
    /* MARK: - Configurações */
    
    override func setupHierarchy() {
        super.setupHierarchy()
        self.contentView.addSubview(self.hourInfoCollection)
        self.contentView.addSubview(self.homeIndicatorView)
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupView() {
        self.backgroundColor = UIColor(originalColor: .greenLight)
        self.contentView.backgroundColor = UIColor(originalColor: .greenLight)
    }
    
    
    override func setupStaticTexts() {
        self.setTitleText(with: "Horário de funcionamento")
        self.titleLabel.textColor = UIColor(originalColor: .greenDark)
    }
    
    
    override func setupUI() {
        self.setCollectionItemSize()
    }
    
    
    private func setCollectionItemSize() {
        self.hourInfoCollection.spaceBetweenCells = self.getEquivalent(10)
        self.hourInfoCollection.cellSize = CGSize(width: self.hourInfoCollection.frame.width, height: 60)
    }
    
    
    override func createDynamicConstraints() {
        let lateral = self.getEquivalent(15)
        let width = self.getEquivalent(70)
        let space = self.getEquivalent(5)
        
        self.dynamicConstraints = [
            self.hourInfoCollection.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: lateral),
            self.hourInfoCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.hourInfoCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.hourInfoCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.homeIndicatorView.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            self.homeIndicatorView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.homeIndicatorView.heightAnchor.constraint(equalToConstant: space),
            self.homeIndicatorView.widthAnchor.constraint(equalToConstant: width)
        ]
    }
}
