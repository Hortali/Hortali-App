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
    
    /// Label responsável por exibir o status do estabelecimento (aberto ou fechado)
    private let statusLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    /// Label responsável por exibir o horário de funcionamento do estabelecimento
    private let hourLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .clear
        lbl.textAlignment = .right
        
        return lbl
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
        
        switch data.status {
        case true:
            self.statusLabel.text = "Aberto"
            self.statusLabel.textColor = UIColor(.openStatus)
            self.hourLabel.text = "\(data.startTime) - \(data.endTime)"
            
            self.backgroundColor = UIColor(.openBackgroundStatus)?.withAlphaComponent(0.4)
            
        case false:
            self.statusLabel.text = "Fechado"
            self.statusLabel.textColor = UIColor(.closeStatus)
            self.backgroundColor = UIColor(.closeBackgroundStatus)?.withAlphaComponent(0.4)
        }
        
        if InfoGardenView.todayWeek == data.week {
            self.layer.masksToBounds = true
            self.layer.borderWidth = 5
            self.layer.borderColor = self.backgroundColor?.withAlphaComponent(1).cgColor
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
        self.contentView.addSubview(self.statusLabel)
        self.contentView.addSubview(self.hourLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.layer.cornerRadius = 10
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        let fontInfo = FontInfo(fontSize: 20, weight: .regular)
        
        self.dayLabel.setupText(with: fontInfo)
        self.statusLabel.setupText(with: fontInfo)
        self.hourLabel.setupText(with: fontInfo)
    }
      
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral = getEquivalent(15)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.dayLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.dayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.dayLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.dayLabel.bottomAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            
            
            self.statusLabel.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor),
            self.statusLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.statusLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.statusLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
            self.hourLabel.topAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.hourLabel.leadingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor),
            self.hourLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -lateral),
            self.hourLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
