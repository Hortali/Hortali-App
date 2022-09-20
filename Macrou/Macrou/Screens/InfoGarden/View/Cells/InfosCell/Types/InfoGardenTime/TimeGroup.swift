/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class TimeGroup: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    private let weekLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(originalColor: .greenLight)
        lbl.textColor = UIColor(.paragraph)
        return lbl
    }()
    
    
    private let hourLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(originalColor: .greenLight)
        lbl.textColor = UIColor(.paragraph)
        return lbl
    }()
    
    
    private let barView: UIView = {
        let view = CustomViews.newView()
        view.backgroundColor = UIColor(originalColor: .greyDark)
        view.tintColor = UIColor(.paragraph)
        return view
    }()
    
    
    private let closeLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(originalColor: .greenLight)
        lbl.tintColor = UIColor(.subTitle)
        lbl.isHidden = true
        return lbl
    }()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []

    

    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.DADOS_TESTE()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */

    
    public func setupInfos(for infos: String) {
        
    }
    
    
    public func setTintColor(for color: UIColor?) {
        self.weekLabel.textColor = color
        self.hourLabel.textColor = color
        self.closeLabel.textColor = color
        self.barView.backgroundColor = color
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.weekLabel)
        self.addSubview(self.hourLabel)
        self.addSubview(self.closeLabel)
        self.addSubview(self.barView)
        
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.barView.layer.cornerRadius = self.barView.bounds.width/2
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.closeLabel.setupText(with: FontInfo(
            text: "Fechado", fontSize: 15, weight: .medium
        ))
        
        self.weekLabel.setupText(with: FontInfo(
            fontSize: 15, weight: .medium
        ))
        
        self.hourLabel.setupText(with: FontInfo(
            fontSize: 12, weight: .medium
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let between: CGFloat = 4
       
        let weekLabelHeight: CGFloat = 20
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.barView.topAnchor.constraint(equalTo: self.topAnchor),
            self.barView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.barView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.barView.widthAnchor.constraint(equalToConstant: 2),
            
            
            self.closeLabel.leftAnchor.constraint(equalTo: self.weekLabel.leftAnchor),
            self.closeLabel.rightAnchor.constraint(equalTo: self.weekLabel.rightAnchor),
            self.closeLabel.centerYAnchor.constraint(equalTo: self.barView.centerYAnchor),
            self.closeLabel.heightAnchor.constraint(equalToConstant: weekLabelHeight),
            
            
            self.weekLabel.leftAnchor.constraint(equalTo: self.barView.rightAnchor, constant: between),
            self.weekLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.weekLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.weekLabel.heightAnchor.constraint(equalToConstant: weekLabelHeight),
            
            
            self.hourLabel.leftAnchor.constraint(equalTo: self.weekLabel.leftAnchor),
            self.hourLabel.rightAnchor.constraint(equalTo: self.weekLabel.rightAnchor),
            self.hourLabel.topAnchor.constraint(equalTo: self.weekLabel.bottomAnchor),
            self.hourLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    
    private func DADOS_TESTE() {
        self.weekLabel.text = "Segunda Feira"
        self.hourLabel.text = "10:00 - 18:00"
    }
}
