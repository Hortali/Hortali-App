/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria a área de visualizar uma dia da semana e o horário de funcionamento
class TimeGroup: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    /// Mostra qual dia da semana
    private let weekLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.paragraph)
        return lbl
    }()
    
    /// Mostra o horário
    private let hourLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.paragraph)
        return lbl
    }()
    
    /// Barra lateral
    private let barView: UIView = {
        let view = CustomViews.newView()
        view.backgroundColor = UIColor(.barHourInfo)
        view.tintColor = UIColor(.paragraph)
        return view
    }()
    
    /// Mostra quando está fechado
    private let closeLabel: UILabel = {
        let lbl = CustomViews.newLabel()
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
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */

    /// Define as informações que vão ser mostradas
    /// - Parameter infos: texto que vai ser definido
    public func setupInfos(for info: ManagedHourInfo) {
        if self.isTodayComponent {
            if info.status {
                self.weekLabel.text = "Aberto"
                self.hourLabel.text = "\(info.startTime) - \(info.endTime)"
            } else {
                self.closeLabel.text = "Fechado"
                
                self.weekLabel.isHidden = true
                self.hourLabel.isHidden = true
                self.closeLabel.isHidden = false
            }
            return
        }
        
        self.weekLabel.text = info.week
        
        if info.status {
            self.hourLabel.text = "\(info.startTime) - \(info.endTime)"
        } else {
            self.hourLabel.text = "Fechado"
        }
        
    }
    
    
    /// Define se o componente mostra os dados do dia
    public var isTodayComponent: Bool = false {
        didSet {
            if self.isTodayComponent {
                let color = UIColor(.subTitle)
                self.weekLabel.textColor = color
                self.hourLabel.textColor = color
                self.closeLabel.textColor = color
                self.barView.backgroundColor = color
            }
        }
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
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
        self.barView.layer.cornerRadius = self.barView.bounds.width / 2
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        let bigFontSize: CGFloat = self.getConstant(for: 15)
        
        self.closeLabel.setupText(with: FontInfo(
            text: "Fechado", fontSize: bigFontSize, weight: .medium
        ))
        
        self.weekLabel.setupText(with: FontInfo(
            fontSize: bigFontSize, weight: .medium
        ))
        
        self.hourLabel.setupText(with: FontInfo(
            fontSize: self.getConstant(for: 12), weight: .medium
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let between: CGFloat = self.getConstant(for: 4)
       
        let weekLabelHeight: CGFloat = self.getConstant(for: 20)
        
        let barLine: CGFloat = self.getConstant(for: 2)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.barView.topAnchor.constraint(equalTo: self.topAnchor),
            self.barView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.barView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.barView.widthAnchor.constraint(equalToConstant: barLine),
            
            
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
    
    
    /// Responsável por pegar o valor referente à célula
    /// - Parameter space: valor para ser convertido
    /// - Returns: valor em relação à tela
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 120, height: 35),
            dimension: .width
        )
        
        return self.getEquivalent(space, screenReference: screenReference)
    }
    
    
    private func DADOS_TESTE() {
        self.weekLabel.text = "Segunda Feira"
        self.hourLabel.text = "10:00 - 18:00"
    }
}
