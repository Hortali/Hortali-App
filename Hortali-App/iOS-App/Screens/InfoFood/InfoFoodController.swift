/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class InfoFoodController: UIViewController, ExpansiveLabelDelegate {
    
    /* MARK: - Atributos */

    private var myView: InfoFoodView!
        
    
    /* Outros */
    
    private var favUpdate: FavoriteUpdate!
    
    private var foodData: ManagedFood!
    
    
    
    /* MARK: - Construtor */
    
    init(with data: ManagedFood) {
        self.foodData = data
        super.init(nibName: nil, bundle: nil)
        
        self.createView(for: data)
        self.setFavoriteConfigurations(id: data.id)
        self.setupFavoriteStatus(for: data)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupButtonsAction()
        self.setupDelegates()
    }
    
    
    
    /* MARK: - ExpansiveLabelDelegate */
    
    internal func actionWhenLabelWasExpanded() {
        self.myView.updateScrollSize()
    }
    
    
    
    /* MARK: - Ações de botões */

    @objc
    private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    private func favoriteAction() {
        switch self.myView.favoriteHandler() {
        case true:
            self.favUpdate.action = .add
        case false:
            self.favUpdate.action = .remove
        }
        
        DataManager.shared.updateFavoriteList(for: self.favUpdate)
    }
    
    
    @objc
    private func expandLabelAction() {
        self.myView.expandLabel()
    }
    
    
    @objc
    private func vitaminsAction(sender: UIButton) {
        let vitaminName = self.foodData.vitamins[sender.tag].name
        
        let vitaminInfo = DataManager.shared.getVitamin(for: vitaminName)
    
        let popupInfos = PopUpInfo(
            title: "Vitamina \(vitaminInfo?.name ?? "")",
            description: vitaminInfo?.description ?? ""
        )
        self.showPopUp(with: popupInfos)
    }
    
    
    @objc
    private func seasonalityAction() {
        let seasonalityData = self.foodData.seasonality
        let isSeason = Self.checkSeasonality(for: seasonalityData)
        
        var title = "sazonalidade"
        if isSeason {
            title = "ta na epoca!"
        }
        
        let popupInfos = PopUpInfo(
            title: title,
            description: seasonalityData.description,
            backgroundColor: .seasonalityBack,
            buttonColor: .seasonalityButton
        )
        self.showPopUp(with: popupInfos)
    }
    
    
    
    /* MARK: - Configurações */
    
    private func createView(for data: ManagedFood) {
        self.myView = InfoFoodView(data: data)
    }
    
    
    private func setFavoriteConfigurations(id: Int) {
        self.favUpdate = FavoriteUpdate(
            favoriteType: .food,
            id: id,
            action: .add
        )
    }
    
    
    private func showPopUp(with info: PopUpInfo) {
        let controller = PopUpController(infos: info)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        
        self.present(controller, animated: true)
    }
    

    private func setupButtonsAction() {
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
        self.myView.setFavoriteButtonAction(target: self, action: #selector(self.favoriteAction))
        self.myView.setExpLabelButtonAction(target: self, action: #selector(self.expandLabelAction))
        self.myView.setVitaminsButtonAction(target: self, action: #selector(self.vitaminsAction(sender:)))
        self.myView.setSeasonalityButtonAction(target: self, action: #selector(self.seasonalityAction))
    }
    
    
    private func setupDelegates() {
        self.myView.setExpansiveLabelDelegate(self)
    }
    
    
    private func setupFavoriteStatus(for data: ManagedFood) {
        var status = false
        for id in DataManager.shared.getFavoriteIds(for: .food) {
            if data.id == id {
                status = true
                break
            }
        }
        let _ = self.myView.favoriteHandler(for: status)
    }
    
    
    
    /* MARK: - Singleton */
    
    static func checkSeasonality(for data: ManagedSeasonality) -> Bool {
        if data.allYear { return true }
        
        let today = Date()
        let currentMonth = Calendar.current.dateComponents([.month], from: today).month ?? 0
        return data.period.contains(currentMonth)
    }
}

