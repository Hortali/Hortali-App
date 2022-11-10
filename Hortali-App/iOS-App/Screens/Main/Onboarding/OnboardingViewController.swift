/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável POR
class OnboardingViewController: UIViewController, OnboardingProtocol {
    
    /* MARK: - Atributos */
    
    /* View */

    /// View principal que a classe vai controlar
     private let myView = OnboardingView()
    
    
    /* Delegate & Data Sources */
    
    /// Data Source da collection de Onboarding
    private let onboardingDataSource = OnboardingDataSource()
    
    /// Delegate da collection de Onboarding
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
    
    /// Protocolo de atualização de página do Page Control
   internal func updateCurrentPage(to index: Int) {
        self.myView.updateCurrentPage(for: index)
       self.myView.reloadCollectionData()
    }

    

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
    
    
    /// Ação que observa quando altera a page control é alterada
    /// - Parameter sender: page control que foi alterada
    @objc
    private func pageControlAction(sender: UIPageControl) {
        self.myView.updateCurrentPage(for: sender.currentPage)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setCloseButtonAction(target: self, action: #selector(self.closeAction))
        self.myView.setNextButtonAction(target: self, action: #selector(self.nextAction))
        self.myView.setPageControlAction(target: self, action: #selector(self.pageControlAction(sender:)))
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.onboardingDelegate.setProtocol(with: self)
        
        self.myView.setDataSource(with: self.onboardingDataSource)
        self.myView.setDelegate(with: self.onboardingDelegate)
    }
}
