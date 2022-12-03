/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de mostrar as informações dos alimentos
class InfoFoodController: UIViewController {
    
    /* MARK: - Atributos */

    /* View */

    /// View principal que a classe vai controlar
    private var myView: InfoFoodView
        
    
    /* Outros */
    
    /// Configurações para atualizar o estado de favoritos
    private var favUpdate: FavoriteUpdate
    
    /// Dados das vitaminas
    private var vitaminsData: [ManagedVitamins] = []
    
    /// Dados de sazonalidade
    private var seasonalityData: ManagedSeasonality!
    
    
    
    /* MARK: - Construtor */
    
    init(with data: ManagedFood) {
        self.myView = InfoFoodView(data: data)
        
        self.favUpdate = FavoriteUpdate(
            favoriteType: .food,
            id: data.id,
            action: .add
        )
        
        super.init(nibName: nil, bundle: nil)
        
        self.setupFavoriteStatus(for: data)
        self.vitaminsData = data.vitamins
        
        self.seasonalityData = data.seasonality
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupButtonsAction()
    }
    
    
    
    /* MARK: - Ações de botões */

    /// Ação de voltar para a tela anterior
    @objc
    private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /// Ação de favoritar um card
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
    
    
    /// Ação de expandir uma label
    @objc
    private func expandLabelAction() {
        self.myView.expandLabel()
    }
    
    
    /// Ação de voltar para a tela anterior
    /// - Parameter sender: botão que vai receber a ação
    @objc
    private func vitaminsAction(sender: UIButton) {
        let vitaminName = self.vitaminsData[sender.tag].name
        
        let vitaminInfo = DataManager.shared.getVitamin(for: vitaminName)
    
        let popupInfos = PopUpInfo(
            title: "Vitamina \(vitaminInfo?.name ?? "")",
            description: vitaminInfo?.description ?? ""
        )
        self.showPopUp(with: popupInfos)
    }
    
    
    /// Ação de mostrar informações sobre a sazonalidade
    @objc
    private func seasonalityAction() {
        let isSeason = Self.checkSeasonality(for: self.seasonalityData)
        
        var title = "sazonalidade"
        if isSeason {
            title = "ta na epoca!"
        }
        
        let popupInfos = PopUpInfo(
            title: title,
            description: self.seasonalityData.description,
            backgroundColor: .seasonalityBack,
            buttonColor: .seasonalityButton
        )
        self.showPopUp(with: popupInfos)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Mostra um popup a partir dos dados passados
    /// - Parameter info: informações que vão ser passadas
    private func showPopUp(with info: PopUpInfo) {
        let controller = PopUpController(infos: info)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        
        self.present(controller, animated: true)
    }
    

    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
        self.myView.setFavoriteButtonAction(target: self, action: #selector(self.favoriteAction))
        self.myView.setExpLabelButtonAction(target: self, action: #selector(self.expandLabelAction))
        self.myView.setVitaminsButtonAction(target: self, action: #selector(self.vitaminsAction(sender:)))
        self.myView.setSeasonalityButtonAction(target: self, action: #selector(self.seasonalityAction))
    }
    
    
    /// Configura a view pra caso for favorito
    /// - Parameter data: dado
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
    
    /// Verifica se está na época de sazonalidade
    /// - Parameter data: dados de sazonalidade
    /// - Returns: estado que diz se está na época ou não
    static func checkSeasonality(for data: ManagedSeasonality) -> Bool {
        if data.allYear {
            return true
        }
        
        let today = Date()
        let currentMonth = Calendar.current.dateComponents([.month], from: today).month ?? 0
        
        return data.period.contains(currentMonth)
    }
}

