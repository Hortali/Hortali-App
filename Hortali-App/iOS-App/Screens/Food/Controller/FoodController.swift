/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de alimentos
class FoodController: MenuController, FoodProtocol {
    
    /* MARK: - Atributos */

    /// View principal que a classe vai controlar
    private let myView = FoodView()
    
    
    /* Delegate & Data Sources */
    
    /// Data source da collection de alimentos
    let foodCollectionDataSource = FoodCollectionDataSource()
    
    /// Delegate da collection de alimentos
    let foodCollectionDelegate = FoodCollectionDelegate()

        
    
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
        let selectedCell = self.foodCollectionDataSource.data[index]
        
        let controller = InfoFoodController(with: selectedCell, in: index)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        
        self.tabBarProtocol?.showTabBar(is: false)
        self.present(controller, animated: true)
    }
    
    
    
    /* MARK: - Ações de Botões */
    
    /// Ação da segmentation dos alimentos
    /// - Parameter sender: segmentation
    @objc
    func segmentationAction(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        self.updateFoodData(for: index)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Define os dados collection
    /// - Parameter data: dado que a collection vai mostrar
    private func setCollectionData(for data: [ManagedFood]) {
        self.foodCollectionDataSource.data = data
        self.myView.reloadCollectionData()
    }
    
    
    /// Atualiza os alimentos que vão ser exibidos
    /// - Parameter index: index do item selecionado da seg
    private func updateFoodData(for index: Int) {
        let category = DataManager.shared.getAllCategories()[index]
    
        let foodData = DataManager.shared.getFoodData(for: category)
        self.setCollectionData(for: foodData)
    }
    
        
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.foodCollectionDelegate.setProtocol(with: self)
        
        self.myView.setDataSource(with: self.foodCollectionDataSource)
        self.myView.setDelegate(with: self.foodCollectionDelegate)
    }
    
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setSegAction(target: self, action: #selector(self.segmentationAction(sender:)))
    }
}
