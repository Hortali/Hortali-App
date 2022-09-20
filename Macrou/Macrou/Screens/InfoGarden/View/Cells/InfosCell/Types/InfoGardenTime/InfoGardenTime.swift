/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class InfoGardenTime: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    private let todayLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(originalColor: .greenLight)
        return lbl
    }()
    
    
    private let todayWeekLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(originalColor: .greenLight)
        return lbl
    }()
    
    
    private let todayTimeGroup: TimeGroup = {
        let group = TimeGroup()
        group.setTintColor(for: UIColor(.subTitle))
        return group
    }()
    
    
    private let daysAfterStack: UIStackView = CustomViews.newStackView()
    
    
    private let daysAfter: [TimeGroup] = [TimeGroup(), TimeGroup(), TimeGroup()]

    
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
        self.addSubview(self.todayLabel)
        self.addSubview(self.todayWeekLabel)
        self.addSubview(self.todayTimeGroup)
        
        self.addSubview(self.daysAfterStack)
        self.daysAfterStack.addArrangedSubview(self.daysAfter[0])
        self.daysAfterStack.addArrangedSubview(self.daysAfter[1])
        self.daysAfterStack.addArrangedSubview(self.daysAfter[2])
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(originalColor: .greenLight)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {		
        self.todayLabel.setupText(with: FontInfo(
            text: "Hoje", fontSize: 25, weight: .medium
        ))
        
        
        self.todayWeekLabel.setupText(with: FontInfo(
            fontSize: 20, weight: .regular
        ))
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
        let lateral: CGFloat = 15
        
        let timeGroupHeight: CGFloat = 35
        
        let spaceToDivide: CGFloat = CGFloat(35 * self.daysAfter.count) - self.bounds.height
        let spaceStack: CGFloat = spaceToDivide / CGFloat(self.daysAfter.count + 1)
       
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.todayWeekLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.todayWeekLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.todayWeekLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.todayWeekLabel.heightAnchor.constraint(equalToConstant: 25),
            
            
            self.todayLabel.bottomAnchor.constraint(equalTo: self.todayWeekLabel.topAnchor),
            self.todayLabel.leadingAnchor.constraint(equalTo: self.todayWeekLabel.leadingAnchor),
            self.todayLabel.trailingAnchor.constraint(equalTo: self.todayWeekLabel.trailingAnchor),
            self.todayLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            self.todayTimeGroup.topAnchor.constraint(equalTo: self.todayWeekLabel.bottomAnchor),
            self.todayTimeGroup.leadingAnchor.constraint(equalTo: self.todayWeekLabel.leadingAnchor),
            self.todayTimeGroup.trailingAnchor.constraint(equalTo: self.todayWeekLabel.trailingAnchor),
            self.todayTimeGroup.heightAnchor.constraint(equalToConstant: timeGroupHeight),
            
            
            // Stack
            
            self.daysAfterStack.topAnchor.constraint(equalTo: self.topAnchor, constant: -spaceStack),
            self.daysAfterStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spaceStack),
            self.daysAfterStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.daysAfterStack.widthAnchor.constraint(equalToConstant: 120),
            
            
            self.daysAfter[0].widthAnchor.constraint(equalTo: self.daysAfterStack.widthAnchor),
            self.daysAfter[0].heightAnchor.constraint(equalToConstant: timeGroupHeight),
            
            
            self.daysAfter[1].widthAnchor.constraint(equalTo: self.daysAfterStack.widthAnchor),
            self.daysAfter[1].heightAnchor.constraint(equalToConstant: timeGroupHeight),
            
            
            self.daysAfter[2].widthAnchor.constraint(equalTo: self.daysAfterStack.widthAnchor),
            self.daysAfter[2].heightAnchor.constraint(equalToConstant: timeGroupHeight),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    private func DADOS_TESTE() {
        self.todayWeekLabel.text = "Sexta - Feira"
    }
}
