/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.UIColor
import class UIKit.UIViewController
import class UIKit.UITabBarController


/// Controller principal usada na criaçào das telas principais do app que participam da tab bar.
class MainController: UITabBarController {
    
    /* MARK: - Ciclo de Vida */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeController()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Inicializa a controller
    private func initializeController() {
        self.setupControllers()
        self.setupTab()
        self.setupTabBarItens()
    }
    
    
    /// Define as controllers que vão aparecer na Tab Bar
    private func setupControllers() {
        self.viewControllers = [
            self.createNavigation(for: GardenController()),
            self.createNavigation(for: FoodController()),
            self.createNavigation(for: FavoriteViewController()),
            self.createNavigation(for: SettingsController()),
        ]
    }
    
    
    /// Cria uma Navigation Controller para uma controller
    /// - Parameter controller: controller inicial
    /// - Returns: navigation controller criada
    private func createNavigation(for controller: UIViewController) -> CustomNavigationController {
        let nav = CustomNavigationController()
        nav.pushViewController(controller, animated: true)
        nav.isNavigationBarHidden = true
        
        return nav
    }
    
    
    /// Configurações iniciais da Tab Bar
    private func setupTab() {
        self.tabBar.backgroundColor = UIColor(.viewBack)
        self.tabBar.tintColor = UIColor(.tabSelected)
        self.tabBar.unselectedItemTintColor = UIColor(.tabNotSelected)
    }
    
    
    /// Configura os ícones e títulos de cada item da tab bar
    private func setupTabBarItens() {
        let controllerCount = self.viewControllers?.count ?? 0
        for ind in 0..<controllerCount { self.setupTabInfos(for: ind) }
    }
    
    
    /// Configura os ícones e títulos para cada controller
    /// - Parameter index: posiçào da controller na tab bar
    private func setupTabInfos(for index: Int) {
        let controller = self.viewControllers?[index]
        switch index {
        case 0:
            controller?.setupTab(text: "Hortas", icon: .gardenTab)
        case 1:
            controller?.setupTab(text: "Alimentos", icon: .foodTab)
        case 2:
            controller?.setupTab(text: "Favoritos", icon: .favoriteTab)
        case 3:
            controller?.setupTab(text: "Configurações", icon: .settingsTab)
        default:
            break
        }
    }
}
