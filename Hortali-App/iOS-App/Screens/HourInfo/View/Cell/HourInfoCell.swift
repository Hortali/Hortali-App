/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class HourInfoCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Identificador da célula
    static let identifier = "HourInfoCell"
    
    
    // Views
    
    /// Label responsável por exibir o dia da semana
    private let dayLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .clear
        
        return lbl
    }()
    
    /// Label responsável por exibir o horário de funcionamento do estabelecimento
    private let hourLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(originalColor: .greenDark)
        
        return lbl
    }()
    
    /// Barra lateral
    private let barView: UIView = {
        let view = CustomViews.newView()
        view.backgroundColor = UIColor(originalColor: .greenDark)
        return view
    }()
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
      
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura a célula a partir do dado
    /// - Parameter data: dado
    public func setupCell(for data: ManagedHourInfo) {
        self.dayLabel.text = data.week
        
        let greenColor = UIColor(originalColor: .greenDark)
        let closeStatus = UIColor(.closeStatus)
        
        switch data.status {
        case true:
            self.hourLabel.textColor = UIColor(.openStatus)
            self.hourLabel.text = "\(data.startTime) - \(data.endTime)"
            self.dayLabel.textColor = greenColor
            self.barView.backgroundColor = greenColor
            
        case false:
            self.hourLabel.text = "Fechado"
            self.dayLabel.textColor = closeStatus
            self.hourLabel.textColor = closeStatus
            self.barView.backgroundColor = closeStatus
        }
        
        if InfoGardenView.todayWeek == data.week {
            self.layer.masksToBounds = true
        }
    }
    
   
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupStaticTexts()
        self.setupDynamicConstraints()
        self.setupUI()
        
        self.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.dayLabel)
        self.contentView.addSubview(self.barView)
        self.contentView.addSubview(self.hourLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.layer.cornerRadius = 10
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.dayLabel.setupText(with: FontInfo(
            fontSize: self.getEquivalent(35), weight: .regular, fontFamily: .graffiti
        ))
        
        self.hourLabel.setupText(with: FontInfo(fontSize: 20, weight: .semibold))
    }
      
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral = getEquivalent(15)
        let width = getEquivalent(45)
        let barLine = getEquivalent(3)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.dayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.dayLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.dayLabel.bottomAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            self.dayLabel.widthAnchor.constraint(equalToConstant: width),
            
            
            self.barView.topAnchor.constraint(equalTo: self.topAnchor),
            self.barView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.barView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.barView.widthAnchor.constraint(equalToConstant: barLine),
            
            
            self.hourLabel.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor),
            self.hourLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.hourLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.hourLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
