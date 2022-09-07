/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Criando a tab bar
class MainController: UITabBarController {
    
    /* MARK: - Atributos */
    private let favoriteController = FavoriteViewController()
    private let favoriteController2 = FavoriteViewController()
    
    
    
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
            self.favoriteController2,
            self.favoriteController,
        ]
    }
    
    
    /// Configura os ícones e títulos de cada item da tab bar
    private func setupTabBarItens() {
        self.favoriteController2.tabBarItem.title = "Food"
        self.favoriteController2.tabBarItem.image = UIImage(.foodTab)
        
        self.favoriteController.tabBarItem.title = "Favorite"
        self.favoriteController.tabBarItem.image = UIImage(.favoriteTab)
    }
}
