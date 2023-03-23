/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de alimentos
class FoodController: UIViewController, FoodProtocol {
    
    /* MARK: - Atributos */

    private let myView = FoodView()
    

    /* Handler & Delegate */
    
    private let foodCollectionHandler = FoodCollectionHandler()
        
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupDelegates()
        self.setupButtonsAction()
        self.updateFoodData(for: 0)
    }
    


    /* MARK: - Protocolo */
    
    internal func openFoodInfo(for index: Int) {
        let selectedCell = self.foodCollectionHandler.data[index]
        
        let controller = InfoFoodController(with: selectedCell)
        controller.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    /* MARK: - Ações de Botões */
    
    @objc
    func segmentationAction(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        self.updateFoodData(for: index)
        self.myView.resetCollectionScroll()
    }
    
    
    
    /* MARK: - Configurações */
    
    private func updateCollectionData(for data: [ManagedFood]) {
        self.foodCollectionHandler.data = data
        self.reloadCollectionData()
    }
    
    
    private func reloadCollectionData() {
        self.myView.foodCollection.reloadCollectionData()
    }
    
    
    private func updateFoodData(for index: Int) {
        let category = DataManager.shared.getAllCategories()[index]
    
        let foodData = DataManager.shared.getFoodData(for: category)
        self.updateCollectionData(for: foodData)
    }
    
    
    private func setupButtonsAction() {
        self.myView.setSegAction(target: self, action: #selector(self.segmentationAction(sender:)))
    }
     
    
    private func setupDelegates() {
        self.foodCollectionHandler.setProtocol(with: self)
        
        let collection = self.myView.foodCollection
        self.foodCollectionHandler.link(with: collection)
    }
}
