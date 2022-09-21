/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de favoritos
class FavoriteViewController: MenuController, GardenProtocol {
    
    /* MARK: - Atributos */
    
    /* View */

    /// View principal que a classe vai controlar
    private let myView = FavoriteView()
    
    
    /* Delegate & Data Sources */
    
    /// Data source da collection de alimentos
    private let foodDataSource = FoodCollectionDataSource()
    
    /// Delegate da collection de alimentos
    // private let foodDelegate = FoodDelegate()
    
    /// Data source da collection das hortas
    private let gardenDataSource = GardenDataSource()
    
    /// Delegate da collection das hortas
    private let gardenDelegate = GardenDelegate()


		
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupDelegates()
    }
    


    /* MARK: - Protocolo */
    
    internal func openGardenInfo(for index: Int) {
        let controller = InfoGardenController()
        controller.modalPresentationStyle = .fullScreen
        
        self.tabBarProtocol?.showTabBar(is: false)
        self.present(controller, animated: true)
    }
    
    
    
    /* MARK: - Configurações */

    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.gardenDelegate.setProtocol(with: self)
        
        self.myView.setFoodDataSource(with: self.foodDataSource)
        // self.myView.setFoodDelegate(with: self.foodDelegate)
        
        self.myView.setGardenDataSource(with: self.gardenDataSource)
        self.myView.setGardenDelegate(with: self.gardenDelegate)
    }
}
