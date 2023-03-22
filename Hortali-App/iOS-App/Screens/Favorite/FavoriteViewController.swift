/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de favoritos
class FavoriteViewController: UIViewController, GardenProtocol, FoodProtocol {
    
    /* MARK: - Atributos */
    
    private let myView = FavoriteView()
    
    
    /* Handler & Delegate */
    
    private let foodCollectionHandler = FoodCollectionHandler()
    
    private let gardenCollectionHandler = GardenCollectionHandler()


        
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
        self.setupCollectionsData()
    }

    
    
    /* MARK: - Protocolo */
    
    internal func openGardenInfo(for index: Int) {
        let selectedCell = self.gardenCollectionHandler.data[index]
                
        let controller = InfoGardenController(with: selectedCell)
        self.showController(controller)
    }
    
        
    internal func openFoodInfo(for index: Int) {
        let selectedCell = self.foodCollectionHandler.data[index]
        
        let controller = InfoFoodController(with: selectedCell)
        self.showController(controller)
    }
    
    
    private func showController(_ controller: UIViewController) {
        controller.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    /* MARK: - Configurações */

    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.setGardenCollectionHandler()
        self.setFoodCollectionHandler()
    }
    
    private func setGardenCollectionHandler() {
        self.gardenCollectionHandler.setProtocol(with: self)
        
        let collection = self.myView.gardenCollection
        self.gardenCollectionHandler.link(with: collection)
    }
    
    
    private func setFoodCollectionHandler() {
        self.foodCollectionHandler.setProtocol(with: self)
        
        let collection = self.myView.foodCollection
        self.foodCollectionHandler.link(with: collection)
    }
    
    
    private func setupCollectionsData() {
        self.setFoodCollectionData()
        self.setGardenCollectionData()
        self.setupEmptyView()
        self.myView.reloadCollectionsData()
    }
    
    
    private func setFoodCollectionData() {
        let foodFavorite = DataManager.shared.getFavoriteItens(for: .food)
        if let foodFav = foodFavorite as? [ManagedFood] {
            self.foodCollectionHandler.data = foodFav
        }
    }
    
    
    private func setGardenCollectionData() {
        let gardenFavorite = DataManager.shared.getFavoriteItens(for: .garden)
        if let gardenFav = gardenFavorite as? [ManagedGarden] {
            self.gardenCollectionHandler.data = gardenFav
        }
    }
    
    
    private func setupEmptyView() {
        let isEmpty = self.foodCollectionHandler.data.isEmpty && self.gardenCollectionHandler.data.isEmpty
        self.myView.setCollectionView(with: isEmpty)
        
        self.myView.checkFoodData(with: self.foodCollectionHandler.data.count)
        self.myView.checkGardenData(with: self.gardenCollectionHandler.data.count)
    }
}
