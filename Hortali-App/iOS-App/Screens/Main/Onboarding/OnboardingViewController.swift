/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável POR
class OnboardingViewController: UIViewController{
    
    /* MARK: - Atributos */
    
    /* View */

    /// View principal que a classe vai controlar
     private let myView = OnboardingView()
    
    
    /* Delegate & Data Sources */
    private let onboardingDataSource = OnboardingDataSource()
    

        
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
    
    /// Ação de expandir uma label
    @objc
    private func closeAction() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    @objc
    private func nextAction() {
        
        
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setCloseButtonAction(target: self, action: #selector(self.closeAction))
        self.myView.setNextButtonAction(target: self, action: #selector(self.nextAction))
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.myView.setDataSource(with: self.onboardingDataSource)
    }
}
