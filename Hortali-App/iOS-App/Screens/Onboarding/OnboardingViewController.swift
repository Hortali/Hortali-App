/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de onboarding
class OnboardingViewController: UIViewController, OnboardingProtocol{
    
    /* MARK: - Atributos */
    
    /// Muda a cor da status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if UserDefaults.getValue(for: .onBoardingPresented) {
            return .lightContent
        }
        return .darkContent
    }
    
    
    /* View */

    /// View principal que a classe vai controlar
    private let myView = OnboardingView()
    
    
    /* Delegate & Data Sources */
    
    /// Data Source da collection de onboarding
    private let onboardingDataSource = OnboardingDataSource()
    
    /// Delegate da collection de onboarding
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.myView.setupToInitialState()
    }
    


    /* MARK: - Protocolo */
    
    internal func updateCurrentPage(to index: Int) {
        self.myView.updateCurrentPage(for: index)
    }
    

    
    /* MARK: - Ações de botões */
    
    /// Ação de fechar a tela de onboarding
    @objc
    private func closeAction() {
        UserDefaults.setValue(true, forKey: .onBoardingPresented)
        
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true)
        self.dismiss(animated: true)
    }
    
    
    /// Ação de voltar uma célula
    @objc
    private func backAction() {
        let currentPage = self.myView.currentPage - 1
        
        self.myView.updateCurrentCell(for: currentPage)
        self.myView.updateCurrentPage(for: currentPage)
    }
    
    
    /// Ação de ir para a próxima célula
    @objc
    private func nextAction() {
        let currentPage = self.myView.currentPage + 1
        
        if currentPage == self.onboardingDataSource.totalPages {
            self.closeAction()
        } else {
            self.myView.updateCurrentCell(for: currentPage)
            self.myView.updateCurrentPage(for: currentPage)
        }
    }
    
    
    /// Ação de quando muda a célula pela page control
    /// - Parameter sender: page control que foi alterada
    @objc
    private func pageControlAction(sender: UIPageControl) {
        self.myView.updateCurrentCell(for: sender.currentPage)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setCloseButtonAction(target: self, action: #selector(self.closeAction))
        self.myView.setPageControlAction(target: self, action: #selector(self.pageControlAction(sender:)))
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
        self.myView.setNextButtonAction(target: self, action: #selector(self.nextAction))
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.onboardingDelegate.setProtocol(with: self)
        
        self.myView.setDataSource(with: self.onboardingDataSource)
        self.myView.setDelegate(with: self.onboardingDelegate)
    }
}
