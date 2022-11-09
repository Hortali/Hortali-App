/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de onboarding
class OnboardingViewController: UIViewController, OnboardingProtocol{
    
    /* MARK: - Atributos */
    
    /* View */

    /// View principal que a classe vai controlar
     private let myView = OnboardingView()
    
    
    /* Delegate & Data Sources */
    private let onboardingDataSource = OnboardingDataSource()
    
    private let onboardingDelegate = OnboardingDelegate()
    

        
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
    
    internal func updateCurrentPage(to index: Int) {
        self.myView.updateCurrentPage(for: index)
    }
    

    /* MARK: - Ações de botões */
    
    /// Ação de fechar a tela de onboarding
    @objc
    private func closeAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextAction() {
        self.navigationController?.viewControllers.count
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setCloseButtonAction(target: self, action: #selector(self.closeAction))
        self.myView.setNextButtonAction(target: self, action: #selector(self.nextAction))
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.onboardingDelegate.setProtocol(with: self)
        
        self.myView.setDataSource(with: self.onboardingDataSource)
        self.myView.setDelegate(with: self.onboardingDelegate)
    }
}
