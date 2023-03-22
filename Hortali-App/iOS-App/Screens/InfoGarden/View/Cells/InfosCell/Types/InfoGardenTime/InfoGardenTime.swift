/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class InfoGardenTime: ViewWithViewCode, InfoGardenCellProtocol {
    
    /* MARK: - Atributos */

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
        group.isTodayComponent = true
        return group
    }()
    
    
    // Outros
    
    private var mainData: ManagedHourInfo? {
        didSet { self.setupViewFromData() }
    }
    

    
    /* MARK: - Protocol */
    
    internal func setupView(for data: ManagedGarden) {
        self.getTodayWeekDataIfExists(from: data.hourInfo)
    }

    
    
    /* MARK: - Configurações */
    
    private func getTodayWeekDataIfExists(from data: [ManagedHourInfo]) {
        let todayWeekNumber = self.getWeekNumberIfExists()
        guard let todayWeekNumber else { return }
        self.mainData = data[todayWeekNumber]
    }
    
    
    private func getWeekNumberIfExists() -> Int? {
        let today = self.getWeekNumberFromToday()
        guard let today else { return nil }
        let todayWeek = self.getEquivalentWeekNumber(from: today)
        return todayWeek
    }
    
    
    private func getWeekNumberFromToday() -> Int? {
        let today = Date()
        let currentData = Calendar.current.dateComponents([.weekday], from: today)
        let weekNumber = currentData.weekday
        return weekNumber // sunday 1 - 7 saturday
    }
    
    
    private func getEquivalentWeekNumber(from number: Int) -> Int {
        let todayWeek = number - 2  // seg = 0 | dom = 6
        if todayWeek < 0 {          // Domingo
            return 6
        }
        return todayWeek
    }
    
    
    private func setupViewFromData() {
        self.saveTodayWeekNumberIfNeeded()
        self.setTodayInfo()
    }
    
    
    private func saveTodayWeekNumberIfNeeded() {
        guard InfoGardenView.todayWeek.isEmpty,
            let todayWeekData = self.mainData?.week
        else { return }
        InfoGardenView.todayWeek = todayWeekData
    }
    
    
    private func setTodayInfo() {
        guard let todayData = self.mainData else { return }
        self.todayTimeGroup.setupInfos(for: todayData)
        self.todayWeekLabel.text = todayData.week
    }
    
    
    
    /* MARK: - Configurações */
    
    override func setupHierarchy() {
        self.addSubview(self.todayLabel)
        self.addSubview(self.todayWeekLabel)
        self.addSubview(self.todayTimeGroup)
    }
    
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(originalColor: .greenLight)
    }
    
    
    override func setupStaticTexts() {
        self.todayLabel.text = "Hoje"
    }
    
    
    override func setupFonts() {
        self.todayLabel.setupFont(with: FontInfo(
            fontSize: self.getConstant(for: 30), weight: .semibold
        ))
        
        self.todayWeekLabel.setupFont(with: FontInfo(
            fontSize: self.getConstant(for: 27), weight: .regular, fontFamily: .graffiti
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.todayWeekLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.todayLabel.bottomAnchor.constraint(equalTo: self.todayWeekLabel.topAnchor),
            self.todayLabel.leadingAnchor.constraint(equalTo: self.todayWeekLabel.leadingAnchor),
            self.todayLabel.trailingAnchor.constraint(equalTo: self.todayWeekLabel.trailingAnchor),
            
            self.todayTimeGroup.leadingAnchor.constraint(equalTo: self.todayWeekLabel.leadingAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let lateral: CGFloat = self.getConstant(for: 15)
        let between: CGFloat = self.getConstant(for: 5)
        
        let timeGroupHeight: CGFloat = self.getConstant(for: 35)
        let widthStack: CGFloat = self.getConstant(for: 120)
    
    
        self.dynamicConstraints = [
            self.todayWeekLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.todayWeekLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            
            self.todayTimeGroup.topAnchor.constraint(equalTo: self.todayWeekLabel.bottomAnchor, constant: between),
            
            self.todayTimeGroup.heightAnchor.constraint(equalToConstant: timeGroupHeight),
            self.todayTimeGroup.widthAnchor.constraint(equalToConstant: widthStack),
        ]
    }
    
    
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 163, height: 163),
            dimension: .width
        )
        return self.getEquivalent(space, screenReference: screenReference)
    }
}
