/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// View que contém o estilo de modal (de acordo com o padrão do projeto), o título
/// da tela e a área em que os elementos vão ser adicionados na tela.
class ContainerView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Título da tela do container
    internal let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(.title)
        return lbl
    }()
    
    /// Espaço para colocar os elemento UI da tela
    internal let contentView: UIView = {
        let view = CustomViews.newView()
        view.backgroundColor = UIColor(.viewBack)
        return view
    }()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
	


    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define o título da tela
    /// - Parameter text: título da tela
    internal func setTitleText(with text: String) {
        self.titleLabel.text = text
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.contentView)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.viewBack)
        self.layer.cornerRadius = self.getEquivalent(30)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        let titleSize: CGFloat = self.getEquivalent(35)
        
        self.titleLabel.setupText(with: FontInfo(
            fontSize: titleSize, weight: .bold
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(15)
        let between: CGFloat = self.getEquivalent(30)
        
        let titleLabelHeight = self.getEquivalent(75)
        
       
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: between),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            self.titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
            
            
            self.contentView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: lateral),
            self.contentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
