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
    
    
    private let daysAfterStack: CustomStack = CustomViews.newStackView()
    
    
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
    
    override public func layoutSubviews() {
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
            text: "Hoje", fontSize: self.getConstant(for: 25), weight: .medium
        ))
        
        
        self.todayWeekLabel.setupText(with: FontInfo(
            fontSize: self.getConstant(for: 20), weight: .regular
        ))
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        // Espçamentos
        let lateral: CGFloat = self.getConstant(for: 15)
        
        let timeGroupHeight: CGFloat = self.getConstant(for: 35)
        let todayWeekHeight: CGFloat = self.getConstant(for: 25)
        let todayLabelHeight: CGFloat = self.getConstant(for: 30)
        
        let widthStack: CGFloat = self.getConstant(for: 120)
        let spaceStack = self.daysAfterStack.getEqualSpace(for: timeGroupHeight)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.todayWeekLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.todayWeekLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.todayWeekLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.todayWeekLabel.heightAnchor.constraint(equalToConstant: todayWeekHeight),
            
            
            self.todayLabel.bottomAnchor.constraint(equalTo: self.todayWeekLabel.topAnchor),
            self.todayLabel.leadingAnchor.constraint(equalTo: self.todayWeekLabel.leadingAnchor),
            self.todayLabel.trailingAnchor.constraint(equalTo: self.todayWeekLabel.trailingAnchor),
            self.todayLabel.heightAnchor.constraint(equalToConstant: todayLabelHeight),
            
            
            self.todayTimeGroup.topAnchor.constraint(equalTo: self.todayWeekLabel.bottomAnchor),
            self.todayTimeGroup.leadingAnchor.constraint(equalTo: self.todayWeekLabel.leadingAnchor),
            self.todayTimeGroup.heightAnchor.constraint(equalToConstant: timeGroupHeight),
            self.todayTimeGroup.widthAnchor.constraint(equalToConstant: widthStack),
            
            
            // Stack
            
            self.daysAfterStack.topAnchor.constraint(equalTo: self.topAnchor, constant: -spaceStack),
            self.daysAfterStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spaceStack),
            self.daysAfterStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.daysAfterStack.widthAnchor.constraint(equalToConstant: widthStack),
            
            
            self.daysAfter[0].heightAnchor.constraint(equalToConstant: timeGroupHeight),
            self.daysAfter[1].heightAnchor.constraint(equalToConstant: timeGroupHeight),
            self.daysAfter[2].heightAnchor.constraint(equalToConstant: timeGroupHeight),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    private func getConstant(for space: CGFloat) -> CGFloat{
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 350, height: 160),
            dimension: .width
        )
        
        return self.getEquivalent(space, screenReference: screenReference)
    }
    
    
    
    private func DADOS_TESTE() {
        self.todayWeekLabel.text = "Sexta - Feira"
        
        self.todayTimeGroup.setupInfos(for: "Aberto")
    }
}
