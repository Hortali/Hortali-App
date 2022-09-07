/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Criando a tab bar
class MainController: UITabBarController {
    
    /* MARK: - Atributos */
    
    /// Controller da tela 01: Ver todas as hortas
    private let gardenController = GardenController()
    
    /// Controller da tela 02: Ver todas os alimentos
    private let foodController = FoodController()
    
    /// Controller da tela 03: Ver os favoritos
    private let favoriteController = FavoriteViewController()
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTab()
        self.setupTabBarItens()
        self.setupControllers()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura a Tab Bar
    private func setupTab() {
        self.tabBar.backgroundColor = UIColor(.viewBack)
        self.tabBar.tintColor = UIColor(.tabSelected)
        self.tabBar.unselectedItemTintColor = UIColor(.tabNotSelected)
    }
    
    
    /// Define as controllers que vão aparecer na Tab Bar
    private func setupControllers() {
        self.viewControllers = [
            self.gardenController,
            self.foodController,
            self.favoriteController,
        ]
    }
    
    
    /// Configura os ícones e títulos de cada item da tab bar
    private func setupTabBarItens() {
        self.gardenController.setupTab(text: "Garden", icon: .gardenTab)
        self.foodController.setupTab(text: "Food", icon: .foodTab)
        self.favoriteController.setupTab(text: "Favorite", icon: .favoriteTab)
    }
}
