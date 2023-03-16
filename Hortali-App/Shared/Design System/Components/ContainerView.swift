/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// View que contém o estilo de modal (de acordo com o padrão do projeto), o título
/// da tela e a área em que os elementos vão ser adicionados na tela.
class ContainerView: ViewWithViewCode {
    
    /* MARK: - Atributos */
    
    final let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.title)
        return lbl
    }()
    
    
    final let contentView: UIView = {
        let view = CustomViews.newView()
        view.backgroundColor = UIColor(.viewBack)
        return view
    }()
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setTitleText(with text: String) {
        self.titleLabel.text = text
    }
    
    
    
    /* MARK: - ViewCode */

    override func setupHierarchy() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.contentView)
    }
    
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(.viewBack)
    }
    
    
    override func setupUI() {
        self.layer.cornerRadius = self.getEquivalent(30)
    }
    
    
    override func setupFonts() {
        self.titleLabel.setupText(with: FontInfo(
            fontSize: self.getEquivalent(35), weight: .bold
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let consntrains = [
            self.contentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ]
        return consntrains
    }
    
    
    override func createDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(20)
        
        let titleLabelHeight = self.getEquivalent(75)
        
        self.dynamicConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: between),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            self.titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
            
            
            self.contentView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: lateral),
        ]
    }
}
