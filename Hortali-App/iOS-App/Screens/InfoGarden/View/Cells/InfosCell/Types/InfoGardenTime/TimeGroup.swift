/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria a área de visualizar uma dia da semana e o horário de funcionamento
class TimeGroup: ViewWithViewCode {
    
    /* MARK: - Atributos */
    
    // Views
    
    private let weekLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(originalColor: .greenDark)
        return lbl
    }()
    
    private let hourLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(originalColor: .greenDark)
        return lbl
    }()
    
    private let barView: UIView = {
        let view = CustomViews.newView()
        view.backgroundColor = UIColor(originalColor: .greenDark)
        view.tintColor = UIColor(.paragraph)
        return view
    }()
    
    private let closeLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.tintColor = UIColor(.subTitle)
        lbl.textColor = UIColor(.closeStatus)
        lbl.isHidden = true
        return lbl
    }()
    
    
    // Outros
    
    private var mainData: ManagedHourInfo? {
        didSet { self.setupViewWithData() }
    }
    
    
    
    /* MARK: - Encapsulamento */
    
    public var isTodayComponent = false {
        didSet { self.setupColors() }
    }
    
    
    public func setupInfos(for info: ManagedHourInfo) {
        self.mainData = info
    }
    
    
    /* MARK: - Configurações */
    
    private func setupColors() {
        guard self.isTodayComponent else { return }
        
        let color = UIColor(originalColor: .greenDark)
        self.weekLabel.textColor = color
        self.weekLabel.textColor = color
        self.hourLabel.textColor = color
        self.closeLabel.textColor = color
        self.barView.backgroundColor = color
    }
    
    
    private func setupViewWithData() {
        self.setTimeData()
        if self.isTodayComponent {
            self.setTodayData(); return
        }
        self.setOtherDayData()
    }
    
    
    private func setTimeData() {
        let startTime = self.mainData?.startTime ?? ""
        let endTime = self.mainData?.endTime ?? ""
        self.hourLabel.text = "\(startTime) - \(endTime)"
    }
    
    
    private func setTodayData() {
        if self.isOpen {
            self.setOpenInfoForToday(); return
        }
        self.setCloseInfoForToday()
    }
    
    
    var isOpen: Bool {
        return self.mainData?.status ?? false
    }
    
    
    private func setOpenInfoForToday() {
        self.weekLabel.text = "Aberto"
    }
    
    
    private func setCloseInfoForToday() {
        self.setCloseComponentsColors()
        self.showCloseComponentsOnly()
    }
    
    
    private func setCloseComponentsColors() {
        let color = UIColor(.closeStatus)
        self.closeLabel.textColor = color
        self.barView.backgroundColor = color
    }
    
    
    private func showCloseComponentsOnly() {
        self.weekLabel.isHidden = self.isTodayComponent
        self.hourLabel.isHidden = self.isTodayComponent
        self.closeLabel.isHidden = !self.isTodayComponent
    }
    
    
    private func setOtherDayData() {
        self.setWeekName()
        self.setCloseInfoForOtherDay()
    }
    
    
    private func setWeekName() {
        self.weekLabel.text = self.mainData?.week
    }
    
    
    private func setCloseInfoForOtherDay() {
        guard !self.isOpen else { return }
        self.hourLabel.text = "Fechado"
        
        let color = UIColor(.closeStatus)
        self.hourLabel.textColor = color
        self.weekLabel.textColor = color
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addSubview(self.weekLabel)
        self.addSubview(self.hourLabel)
        self.addSubview(self.closeLabel)
        self.addSubview(self.barView)
    }
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
        
    
    override func setupUI() {
        self.barView.layer.cornerRadius = self.barView.bounds.width / 2
    }
    
    
    override func setupStaticTexts() {
        self.closeLabel.text = "Fechado"
    }
    
    
    override func setupFonts() {
        let bigFont = FontInfo(fontSize: self.getConstant(for: 15), weight: .medium)
        self.closeLabel.setupFont(with: bigFont)
        self.weekLabel.setupFont(with: bigFont)
        
        self.hourLabel.setupFont(with: FontInfo(
            fontSize: self.getConstant(for: 12), weight: .medium
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.barView.topAnchor.constraint(equalTo: self.topAnchor),
            self.barView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.barView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.closeLabel.leftAnchor.constraint(equalTo: self.weekLabel.leftAnchor),
            self.closeLabel.rightAnchor.constraint(equalTo: self.weekLabel.rightAnchor),
            self.closeLabel.centerYAnchor.constraint(equalTo: self.barView.centerYAnchor),
            
            
            self.weekLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.weekLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            
            self.hourLabel.leftAnchor.constraint(equalTo: self.weekLabel.leftAnchor),
            self.hourLabel.rightAnchor.constraint(equalTo: self.weekLabel.rightAnchor),
            self.hourLabel.topAnchor.constraint(equalTo: self.weekLabel.bottomAnchor),
            self.hourLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let between: CGFloat = self.getConstant(for: 7)
       
        let weekLabelHeight: CGFloat = self.getConstant(for: 20)
        let barLine: CGFloat = self.getConstant(for: 2)
        
        
        self.dynamicConstraints = [
            self.barView.widthAnchor.constraint(equalToConstant: barLine),
            
            self.closeLabel.heightAnchor.constraint(equalToConstant: weekLabelHeight),
            
            self.weekLabel.leftAnchor.constraint(equalTo: self.barView.rightAnchor, constant: between),
            self.weekLabel.heightAnchor.constraint(equalToConstant: weekLabelHeight),
        ]
    }
    
    
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 120, height: 35),
            dimension: .width
        )
        return self.getEquivalent(space, screenReference: screenReference)
    }
}
