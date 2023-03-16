/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class HourInfoCell: CollectionCellWithViewCode, CustomCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "HourInfoCell"
    
    
    // Views
    
    private let dayLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    private let hourLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(originalColor: .greenDark)
        return lbl
    }()
    
    private let barView: UIView = {
        let view = CustomViews.newView()
        view.backgroundColor = UIColor(originalColor: .greenDark)
        return view
    }()
    
    
    // Outros
    
    private var mainData: ManagedHourInfo? {
        didSet { self.setupCellWithData() }
    }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupCell(for data: ManagedHourInfo) {
        self.mainData = data
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupCellWithData() {
        self.setDayName()
        self.checkIfSameWeek()
        self.updateStatus()
    }
    
    
    private func setDayName() {
        self.dayLabel.text = self.mainData?.week ?? ""
    }
    
    
    private func checkIfSameWeek() {
        let isToday = InfoGardenView.todayWeek == self.mainData?.week
        self.layer.masksToBounds = isToday
    }
    
    
    private func updateStatus() {
        if self.mainData?.status == true {
            self.setOpenStatus()
        } else {
            self.setCloseStatus()
        }
    }
    
    
    private func setOpenStatus() {
        self.setOpenTime()
        self.setColorsWhenOpen()
    }
    
    
    private func setOpenTime() {
        let startTime = self.mainData?.startTime ?? ""
        let endTime = self.mainData?.endTime ?? ""
        let timeOpen = "\(startTime) - \(endTime)"
        self.hourLabel.text = timeOpen
    }
    
    
    private func setColorsWhenOpen() {
        let greenColor = UIColor(originalColor: .greenDark)
        self.dayLabel.textColor = greenColor
        self.barView.backgroundColor = greenColor
        self.hourLabel.textColor = UIColor(.openStatus)
    }
    
    
    private func setCloseStatus() {
        self.setCloseLabel()
        self.setColorsWhenClose()
        
    }
    
    
    private func setCloseLabel() {
        self.hourLabel.text = "Fechado"
    }
    
    
    private func setColorsWhenClose() {
        let closeStatus = UIColor(.closeStatus)
        self.dayLabel.textColor = closeStatus
        self.hourLabel.textColor = closeStatus
        self.barView.backgroundColor = closeStatus
    }
    
   
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addViewInContent(self.dayLabel)
        self.addViewInContent(self.barView)
        self.addViewInContent(self.hourLabel)
    }
    
    
    override func setupView() {
        self.layer.cornerRadius = 10
    }
    
    
    override func setupFonts() {
        self.dayLabel.setupFont(with: FontInfo(
            fontSize: self.getEquivalent(35), weight: .regular, fontFamily: .graffiti
        ))
        
        self.hourLabel.setupFont(with: FontInfo(fontSize: 20, weight: .semibold))
    }
    

    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = [
            self.dayLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.dayLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            
            self.barView.topAnchor.constraint(equalTo: self.topAnchor),
            self.barView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.barView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            self.hourLabel.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor),
            self.hourLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.hourLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let lateral = self.getEquivalent(15)
        let width = self.getEquivalent(45)
        let barLine = self.getEquivalent(3)
        
        self.dynamicConstraints = [
            self.dayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
            self.dayLabel.widthAnchor.constraint(equalToConstant: width),
            
            self.barView.widthAnchor.constraint(equalToConstant: barLine),
            
            self.hourLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: lateral),
        ]
    }
}
