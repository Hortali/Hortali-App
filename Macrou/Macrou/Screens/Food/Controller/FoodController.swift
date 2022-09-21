/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de alimentos
class FoodController: MenuController {
    
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
    }
    


    /* MARK: - Protocolo */
    
    
    
    /* MARK: - Configurações */
        
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.myView.setDataSource(with: self.foodCollectionDataSource)
    }
}
