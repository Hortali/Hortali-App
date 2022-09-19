/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class HourInfoCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    /// Identificador da célula
    static let identifier = "HourInfoCell"
    
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
        lbl.textAlignment = .center
        
        return lbl
    }()
       
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
      
    /* MARK: - Construtor */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    

    
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
        self.contentView.addSubview(dayLabel)
        self.contentView.addSubview(statusLabel)
        self.contentView.addSubview(hourLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = .cyan
        self.layer.cornerRadius = 10
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.dayLabel.setupText(with: FontInfo(text: "Segunda-feira", fontSize: 20, weight: .regular))
        self.statusLabel.setupText(with: FontInfo(text: "Aberto", fontSize: 20, weight: .regular))
        self.hourLabel.setupText(with: FontInfo(text: "09:00 - 17:00", fontSize: 20, weight: .regular))
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
