/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de favoritos
class FavoriteViewController: UIViewController, GardenProtocol, FoodProtocol {
    
    /* MARK: - Atributos */
    
    /* View */

    /// View principal que a classe vai controlar
    private let myView = FavoriteView()
    
    
    /* Delegate & Data Sources */
    
    /// Data source da collection de alimentos
    private let foodDataSource = FoodDataSource()
    
    /// Delegate da collection de alimentos
    private let foodDelegate = FoodDelegate()
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupDataSourcesData()
    }

    
    
    /* MARK: - Protocolo */
    
    internal func openGardenInfo(for index: Int) {
        let selectedCell = self.gardenDataSource.data[index]
                
        let controller = InfoGardenController(with: selectedCell)
        controller.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
        
    internal func openFoodInfo(for index: Int) {
        let selectedCell = self.foodDataSource.data[index]
        
        let controller = InfoFoodController(with: selectedCell)
        controller.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    /* MARK: - Configurações */

    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.gardenDelegate.setProtocol(with: self)
        self.foodDelegate.setProtocol(with: self)
        
        self.myView.setFoodDataSource(with: self.foodDataSource)
        self.myView.setFoodDelegate(with: self.foodDelegate)
        
        self.myView.setGardenDataSource(with: self.gardenDataSource)
        self.myView.setGardenDelegate(with: self.gardenDelegate)
    }
    
    
    /// Configura os dadso das colelctions
    private func setupDataSourcesData() {
        // Alimentos
        let foodFavorite = DataManager.shared.getFavoriteItens(for: .food)
        if let foodFav = foodFavorite as? [ManagedFood] {
            self.foodDataSource.data = foodFav
        }
        
        // Hortas
        let gardenFavorite = DataManager.shared.getFavoriteItens(for: .garden)
        if let gardenFav = gardenFavorite as? [ManagedGarden] {
            self.gardenDataSource.data = gardenFav
        }
        
        self.setupEmptyView()
        self.myView.reloadCollectionsData()
    }
    
    
    /// Configura a empty view caso precisa
    private func setupEmptyView() {
        let isEmpty = self.foodDataSource.data.isEmpty && self.gardenDataSource.data.isEmpty
        self.myView.setCollectionView(with: isEmpty)
        
        self.myView.checkFoodData(with: self.foodDataSource.data.count)
        self.myView.checkGardenData(with: self.gardenDataSource.data.count)
    }
}
