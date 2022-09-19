/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável POR
class HourInfoViewController: UIViewController {
    
    /* MARK: - Atributos */

    /// View principal que a classe vai controlar
    private let myView = HourInfoView()
    
    /* Delegate & Data Sources */
    private let collectionDataSource = HourInfoDataSource()

    
        
    /* MARK: - Ciclo de Vida */
    
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigation()
        self.setupDelegates()
        self.setupButtonsAction()
    }
    


    /* MARK: - Protocolo */
    /*
        Implementação das funções do protocolo que a controller está herdando.

        AVISO: Apague esse campo de comentário.
    */
    
    

    /* MARK: - Ações de botões */
    /*
        Implementação das funções de ações dos botões. Todas as funções que estão
        nessa área do mark devem ter o @objc apenas.

        AVISO: Apague esse campo de comentário.
    */
    
    
    
    /* MARK: - Configurações */
    
    
    /// Configurções da navigation
    private func setupNavigation() {
    
    }

    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
      
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.myView.setDataSource(with: collectionDataSource)
    }
}
