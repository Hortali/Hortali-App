/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável POR
class InfoFoodController: UIViewController {
    
    /* MARK: - Atributos */

    /* View */

    /// View principal que a classe vai controlar
    private var myView: InfoFoodView
    
    
    /* Outros */
    
    /// Configuraçòes para atualizar o estado de favoritos
    private var favUpdate: FavoriteUpdate
    
    
    
    /* MARK: - Construtor */
    
    init(with data: ManagedFood, in index: Int) {
        self.myView = InfoFoodView(data: data)
        
        self.favUpdate = FavoriteUpdate(
            favoriteType: .food,
            id: data.id, cellId: index,
            action: .add
        )
        
        super.init(nibName: nil, bundle: nil)
        
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
    }
    
    
    
    /* MARK: - Ações de botões */

    /// Ação de voltar para a tela anterior
    @objc
    private func backAction() {
        self.dismiss(animated: true)
    }
    
    
    /// Ação de favoritar um card
    @objc
    private func favoriteAction(sender: UIButton) {
        switch self.myView.isFavorited() {
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
    
    
    
    /* MARK: - Configurações */

    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
        self.myView.setFavoriteButtonAction(target: self, action: #selector(self.favoriteAction))
        self.myView.setExpLabelButtonAction(target: self, action: #selector(self.expandLabelAction))
    }
    
    
    private func setupFavoriteStatus(for data: ManagedFood) {
        for id in DataManager.shared.getFavoriteIds(for: .food) {
            if data.id == id {
                let _ = self.myView.isFavorited(is: true)
                break
            }
        }
    }
}
