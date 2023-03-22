/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


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
    
    
    private func setupControllers() {
        self.viewControllers = [
            self.createNavigation(for: GardenController()),
            self.createNavigation(for: FoodController()),
            self.createNavigation(for: FavoriteViewController()),
            self.createNavigation(for: SettingsController()),
        ]
    }
    
    
    private func createNavigation(for controller: UIViewController) -> CustomNavigationController {
        let nav = CustomNavigationController()
        nav.pushViewController(controller, animated: true)
        nav.isNavigationBarHidden = true
        return nav
    }
    
    
    private func setupTab() {
        self.tabBar.backgroundColor = UIColor(.viewBack)
        self.tabBar.tintColor = UIColor(.tabSelected)
        self.tabBar.unselectedItemTintColor = UIColor(.tabNotSelected)
    }
    
    
    private func setupTabBarItens() {
        let controllerCount = self.viewControllers?.count ?? 0
        for ind in 0..<controllerCount { self.setupTabInfos(for: ind) }
    }
    
    
    private func setupTabInfos(for index: Int) {
        let controller = self.viewControllers?[index]
        switch index {
        case 0: controller?.setupTab(text: "Hortas", icon: .gardenTab)
        case 1: controller?.setupTab(text: "Alimentos", icon: .foodTab)
        case 2: controller?.setupTab(text: "Favoritos", icon: .favoriteTab)
        case 3: controller?.setupTab(text: "Configurações", icon: .settingsTab)
        default: break
        }
    }
}
