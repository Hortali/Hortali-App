/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Conteúdo da célula para mostrar os horários de funcionamento
class InfoGardenTime: UIView, InfoGardenCellProtocol {
    
    /* MARK: - Atributos */

    // Views
    
    /// Mostra o "Hoje"
    private let todayLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(originalColor: .greenLight)
        return lbl
    }()
    
    /// Mostra o dia da semana que é
    private let todayWeekLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.backgroundColor = UIColor(originalColor: .greenLight)
        return lbl
    }()
    
    /// Mostra as informações do dia da semana
    private let todayTimeGroup: TimeGroup = {
        let group = TimeGroup()
        group.isTodayComponent = true
        return group
    }()
    
    /// Stack para colocar as informações dos próximos dias
    private let daysAfterStack: CustomStack = CustomViews.newStackView()
    
    
    /// Grupos de informações dos próximos dias
    private let daysAfter: [TimeGroup] = [TimeGroup(), TimeGroup(), TimeGroup()]
    
    
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
    
    
    
    /* MARK: - Protocol */
    
    internal func setupView(for data: ManagedGarden) {
        self.setupDates(for: data.hourInfo)
    }
    

    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    // Geral
    
    /// Configura as datas que são mostradas na célula
    /// - Parameter data: Horários de funcionamento
    private func setupDates(for data: [ManagedHourInfo]) {
        let today = Date()
        
        // sunday 1 - 7 saturday
        if let week = Calendar.current.dateComponents([.weekday], from: today).weekday {
            var todayWeek = week - 2 // seg = 0 | dom = 6
            if todayWeek < 0 {       // Domingo
                todayWeek = 6
            }
            
            if InfoGardenView.todayWeek == "" {
                InfoGardenView.todayWeek = data[todayWeek].week
            }
            
            // Hoje
            let todayData = data[todayWeek]
            self.todayTimeGroup.setupInfos(for: todayData)
            self.todayWeekLabel.text = todayData.week
            self.todayWeekLabel.font = UIFont(name: "AmsterdamGraffiti", size: 10)

            
            // Feriado
            let holiday = 7
            let holidayData = data[holiday]
            self.self.daysAfter[2].setupInfos(for: holidayData)
        }
    }
    
    
    // Views
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.todayLabel)
        self.addSubview(self.todayWeekLabel)
        self.addSubview(self.todayTimeGroup)
        
        self.addSubview(self.daysAfterStack)
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
        
        self.todayWeekLabel.font = UIFont(name: "AmsterdamGraffiti", size: self.getConstant(for: 20))
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        // Espaçamentos
        let lateral: CGFloat = self.getConstant(for: 15)
        
        let timeGroupHeight: CGFloat = self.getConstant(for: 35)
        let todayWeekHeight: CGFloat = self.getConstant(for: 25)
        
        let widthStack: CGFloat = self.getConstant(for: 120)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.todayWeekLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.todayWeekLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.todayWeekLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: todayWeekHeight*2),
            self.todayWeekLabel.heightAnchor.constraint(equalToConstant: todayWeekHeight),
            
            
            self.todayLabel.bottomAnchor.constraint(equalTo: self.todayWeekLabel.topAnchor),
            self.todayLabel.leadingAnchor.constraint(equalTo: self.todayWeekLabel.leadingAnchor),
            self.todayLabel.trailingAnchor.constraint(equalTo: self.todayWeekLabel.trailingAnchor),
            self.todayLabel.heightAnchor.constraint(equalToConstant: todayWeekHeight),
            
            
            self.todayTimeGroup.topAnchor.constraint(equalTo: self.todayWeekLabel.bottomAnchor),
            self.todayTimeGroup.leadingAnchor.constraint(equalTo: self.todayWeekLabel.leadingAnchor),
            self.todayTimeGroup.heightAnchor.constraint(equalToConstant: timeGroupHeight),
            self.todayTimeGroup.widthAnchor.constraint(equalToConstant: widthStack),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    /// Responsável por pegar o valor referente à célula
    /// - Parameter space: valor para ser convertido
    /// - Returns: valor em relação à tela
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 163, height: 163),
            dimension: .width
        )

        return self.getEquivalent(space, screenReference: screenReference)
    }
}
