/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller principal usada para a criação da tab bar
class MainController: UITabBarController {
    
    /* MARK: - Atributos */
    
    /// Controller da tela 01: Ver todas as hortas
    private let gardenController = GardenController()
    
    /// Controller da tela 02: Ver todas os alimentos
    private let foodController = FoodController()
    
    /// Controller da tela 03: Ver os favoritos
    private let favoriteController = FavoriteViewController()
    
    /// Controller da tela 04: Configurações
    private let settingsController = SettingsController()
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTab()
        self.setupTabBarItens()
        self.setupControllers()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configurações iniciais da Navigation Controller
    private func getNavigation(for controller: UIViewController) -> CustomNavigationController {
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
    
    
    /// Define as controllers que vão aparecer na Tab Bar
    private func setupControllers() {
        self.viewControllers = [
            self.getNavigation(for: self.gardenController),
            self.getNavigation(for: self.foodController),
            self.getNavigation(for: self.favoriteController),
            self.getNavigation(for: self.settingsController),
        ]
    }
    
    
    /// Configura os ícones e títulos de cada item da tab bar
    private func setupTabBarItens() {
        self.gardenController.setupTab(text: "Hortas", icon: .gardenTab)
        self.foodController.setupTab(text: "Alimentos", icon: .foodTab)
        self.favoriteController.setupTab(text: "Favoritos", icon: .favoriteTab)
        self.settingsController.setupTab(text: "Configurações", icon: .settingsTab)
    }
}
