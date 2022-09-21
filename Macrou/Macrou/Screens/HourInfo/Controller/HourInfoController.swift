/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável POR
class HourInfoController: UIViewController {
    
    /* MARK: - Atributos */

    /// View principal que a classe vai controlar
    private let myView = HourInfoView()
    
    /* Delegate & Data Sources */
    
    /// Data source da collection de horários de funcionamento
    private let collectionDataSource = HourInfoDataSource()

    
        
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupDelegates()
        self.setupButtonsAction()
    }
    


    /* MARK: - Protocolo */
    
    

    /* MARK: - Ações de botões */

    
    
    /* MARK: - Configurações */
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.myView.setDataSource(with: self.collectionDataSource)
    }
}
